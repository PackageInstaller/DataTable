using System;
using System.Collections;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Utility;
using ACT.VolumeControl;
using Bamboo.AssetField;
using Cinemachine;
using Cysharp.Threading.Tasks;
using DG.Tweening;
using RootMotion.FinalIK;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem;
using UnityEngine.Serialization;

namespace ACT.UI;

[Obsolete]
public class UICharacterScene : BaseUIScene, IPointerDownHandler, IEventSystemHandler, IDragHandler, IScrollHandler, IPointerUpHandler
{
	[Serializable]
	public struct PageSetting
	{
		public CinemachineVirtualCamera vCamera;

		public bool fixVertical;

		public bool fixHorizontal;

		public List<GameObject> openObjects;

		[Header("后处理")]
		public float forcus;

		[Range(0f, 300f)]
		public float lensDistance;

		[Range(0f, 32f)]
		public float ratio;

		public bool isOpen;
	}

	public enum ModelType
	{
		None,
		Character,
		Weapon,
		Chip,
		Robot
	}

	public static UICharacterScene _instance;

	[FormerlySerializedAs("modelRoot")]
	public GameObject characterModelRoot;

	public GameObject commonModelRoot;

	public Transform constellationRoot;

	public CinemachineVirtualCamera halfBodyCamera;

	public List<PageSetting> pageSettings;

	public List<PageSetting> secondViewPageSettings;

	public DepthOfFieldControl fieldControl;

	public Canvas canvas;

	public GameObject touchObj;

	public YooAssetReference showEffectAssetID;

	public float delayTime = 0.5f;

	public float cameraLowPos = 0.1f;

	public Transform oriPoint;

	public Transform lookAtPoint;

	[SerializeReference]
	private int _setPageToCameraPriority = 200;

	[SerializeReference]
	private int _halfBodyCameraPriority = 210;

	private GameObject m_modle;

	private GameObject m_modlePrefab;

	private GameObject m_commonModel;

	private Animator m_animator;

	private static CancellationTokenSource m_ModelCts;

	private Vector3 DefaultCMPosition = new Vector3(-3.79f, 0.83f, 2.6f);

	private Vector3 DefaultCMRotation = new Vector3(0f, 126.43f, 2.6f);

	private GameObject m_characterEffectObj;

	private ParticleSystem m_characterEffect;

	private float m_charTopHeight;

	private GameObject m_CommonEffectObj;

	private ParticleSystem m_CommonEffect;

	private LookAtIK m_eyesIk;

	private LookAtIK m_neckIk;

	private int m_stack;

	private bool m_isRecover;

	private float m_recoverTime = 0.15f;

	private Vector2 m_touchOriPos;

	private float m_lastOffset;

	private int m_curPageIndex;

	private bool m_useHalfBodySetting;

	private bool m_fixVertical;

	private bool m_fixHorizontal;

	private int m_ModelId = -1;

	private int m_LastModelId = -1;

	[Header("模型切换等待时间")]
	public int ModelLoadWaitFrame;

	private bool m_DIsableAnimatorUpdate;

	public GameObject DNA;

	[ColorUsage(true, true)]
	public Color[] DNAcolors;

	public Canvas CharacterBoard;

	private ACTLoadStation<GameObject> CharacterLoadStation;

	private ACTLoadStation<GameObject> CommonLoadStation;

	private static int s_Ref;

	private Vector3 lookAtDir;

	private Vector3 targetPos;

	private float lastAngle;

	public static UICharacterScene instance => _instance;

	public bool DIsableAnimatorUpdate
	{
		get
		{
			return m_DIsableAnimatorUpdate;
		}
		set
		{
			m_DIsableAnimatorUpdate = value;
		}
	}

	public int ModelId => m_ModelId;

	protected void Awake()
	{
		CharacterLoadStation = new ACTLoadStation<GameObject>();
		CommonLoadStation = new ACTLoadStation<GameObject>();
		canvas.worldCamera = GameUtility.uiCamera;
		m_charTopHeight = 1.5f;
		m_ModelCts = new CancellationTokenSource();
		_instance = this;
		LookAtCamera();
	}

	private void LateUpdate()
	{
		if (m_neckIk != null && m_curPageIndex == 4)
		{
			m_neckIk.solver.IKUpdate();
			m_eyesIk.solver.IKUpdate();
		}
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		_instance = null;
		s_Ref = 0;
		m_ModelCts.Cancel();
		CharacterLoadStation.Release();
		CommonLoadStation.Release();
	}

	public static void Push()
	{
		s_Ref++;
		if (s_Ref == 1)
		{
			instance.Open();
		}
		MonoECS.instance.PushPause();
	}

	public static void Pop()
	{
		if (s_Ref <= 0)
		{
			return;
		}
		s_Ref--;
		MonoECS.instance.PopPause();
		if (s_Ref == 0)
		{
			instance.ReleaseCharacterModel();
			instance.ReleaseCommonModel();
			if (_instance != null)
			{
				AssetStationManager.BattleStation.ReleaseInstance(_instance.gameObject);
			}
		}
	}

	public static void ResetScene()
	{
		if (s_Ref > 0)
		{
			for (int i = 0; i < s_Ref; i++)
			{
				MonoECS.instance.PopPause();
			}
			s_Ref = 0;
			instance.ReleaseCharacterModel();
			instance.ReleaseCommonModel();
			if (_instance != null)
			{
				AssetStationManager.BattleStation.ReleaseInstance(_instance.gameObject);
			}
		}
	}

	public void ReleaseCharacterModel()
	{
		m_ModelCts.Cancel();
		m_ModelId = -1;
		if (m_modlePrefab != null)
		{
			UnityEngine.Object.Destroy(m_modlePrefab);
			m_modlePrefab = null;
		}
		if (m_characterEffectObj != null)
		{
			UnityEngine.Object.Destroy(m_characterEffectObj);
			m_characterEffectObj = null;
		}
	}

	public void ReleaseCommonModel()
	{
		m_ModelCts.Cancel();
		if (m_commonModel != null)
		{
			UnityEngine.Object.Destroy(m_commonModel);
			m_commonModel = null;
		}
	}

	private void Recover()
	{
		if (!m_modle)
		{
			return;
		}
		if (m_useHalfBodySetting)
		{
			halfBodyCamera.Priority = 0;
			m_useHalfBodySetting = false;
		}
		m_useHalfBodySetting = false;
		m_isRecover = true;
		m_stack = 2;
		float angle = ((m_commonModel == null) ? m_modle.transform.eulerAngles.y : m_commonModel.transform.eulerAngles.y);
		angle = ((angle > 180f) ? (angle - 360f) : angle);
		DOTween.To(() => halfBodyCamera.transform.position.y, (float x) =>
		{
			halfBodyCamera.transform.position = new Vector3(halfBodyCamera.transform.position.x, x, halfBodyCamera.transform.position.z);
		}, m_charTopHeight, m_recoverTime).OnComplete(() =>
		{
			PopStack();
		});
		DOTween.To(() => angle, (float t) =>
		{
			m_modle.transform.eulerAngles = Vector3.up * t;
			if (m_commonModel != null)
			{
				m_commonModel.transform.eulerAngles = Vector3.up * t;
			}
		}, 0f, m_recoverTime * 2f).OnComplete(() =>
		{
			PopStack();
		});
	}

	private void PopStack()
	{
		if (--m_stack == 0)
		{
			m_isRecover = false;
		}
	}

	public async void PreShowModel(int id, ModelType type)
	{
		if (m_ModelId != id)
		{
			await UniTask.DelayFrame(ModelLoadWaitFrame);
			DoShow(id, type).Forget();
			if (type == ModelType.Character)
			{
				SetCamera(id, pageSettings[0]);
			}
		}
	}

	public async void FireLevelUpEffect()
	{
		if (m_characterEffect == null)
		{
			AssetLoadHandle handle = AssetStationManager.BattleStation.InstantiateAsync(showEffectAssetID, characterModelRoot.transform);
			await handle;
			m_characterEffectObj = handle.As<GameObject>();
			m_characterEffect = m_characterEffectObj.GetComponentInChildren<ParticleSystem>();
		}
		m_characterEffect.Play();
	}

	private async UniTaskVoid DoShow(int id, ModelType type)
	{
		switch (type)
		{
		case ModelType.Character:
		{
			m_ModelCts.Cancel();
			m_ModelCts = new CancellationTokenSource();
			if (m_modlePrefab != null)
			{
				UnityEngine.Object.Destroy(m_modlePrefab);
				m_modlePrefab = null;
			}
			EntityCharacterData characterData = RuntimeConfigs.data.entityCharacterDatas[id];
			string detaileShowModel = characterData.DetaileShowModel;
			CharacterLoadStation.LoadAsset(detaileShowModel, (GameObject result) =>
			{
				m_modlePrefab = UnityEngine.Object.Instantiate(result, characterModelRoot.transform);
				m_modle = m_modlePrefab.GetComponent<ControlDetailShowLight>().idlePrefab;
				Transform transform = m_modle.transform.Find("Bip001/charLight");
				if (transform != null)
				{
					transform.gameObject.SetActive(value: true);
				}
				m_charTopHeight = ((characterData.characterHeight < 0.1f) ? 1.5f : (characterData.characterHeight * 0.92f));
				DOTween.To(() => halfBodyCamera.transform.position.y, (float x) =>
				{
					halfBodyCamera.transform.position = new Vector3(halfBodyCamera.transform.position.x, x, halfBodyCamera.transform.position.z);
				}, m_charTopHeight, m_recoverTime);
				m_modle.transform.localPosition = Vector3.zero;
				m_animator = m_modle.GetComponentInChildren<Animator>();
				LookAtIK[] componentsInChildren = m_modle.GetComponentsInChildren<LookAtIK>();
				foreach (LookAtIK lookAtIK in componentsInChildren)
				{
					if (lookAtIK.solver.eyes.Length != 0)
					{
						m_eyesIk = lookAtIK;
						lookAtIK.solver.target = uiSceneCamera.transform;
					}
					else
					{
						m_neckIk = lookAtIK;
						lookAtIK.solver.target = lookAtPoint;
					}
				}
				m_animator.applyRootMotion = false;
				oriPoint.position = m_modle.transform.position + Vector3.up * m_charTopHeight;
				lookAtPoint.position = new Vector3(halfBodyCamera.transform.position.x, m_charTopHeight, halfBodyCamera.transform.position.z);
				targetPos = lookAtPoint.position;
				if (m_ModelId != id)
				{
					m_ModelId = id;
					PlayAnimator(m_ModelCts.Token).Forget();
				}
			});
			break;
		}
		case ModelType.Weapon:
		{
			if (m_CommonEffect == null)
			{
				AssetLoadHandle handle = AssetStationManager.BattleStation.InstantiateAsync(showEffectAssetID, commonModelRoot.transform);
				await handle;
				m_CommonEffectObj = handle.As<GameObject>();
				m_CommonEffect = m_CommonEffectObj.GetComponentInChildren<ParticleSystem>();
			}
			await UniTask.Delay(TimeSpan.FromSeconds(delayTime), ignoreTimeScale: false, PlayerLoopTiming.Update, m_ModelCts.Token);
			string showModel = CoreUtils.GetData(id, RuntimeConfigs.data.itemWeaponDatas).showModel;
			m_ModelCts.Cancel();
			m_ModelCts = new CancellationTokenSource();
			if (m_commonModel != null)
			{
				UnityEngine.Object.Destroy(m_commonModel);
				m_commonModel = null;
			}
			CommonLoadStation.LoadAsset(showModel, (GameObject result) =>
			{
				m_commonModel = UnityEngine.Object.Instantiate(result, commonModelRoot.transform);
				m_commonModel.transform.localPosition = Vector3.zero;
				m_CommonEffect.Play();
			});
			break;
		}
		}
	}

	public async UniTaskVoid PalyAnimatorOnPageChange(CancellationToken token)
	{
		if (!(m_animator != null))
		{
			return;
		}
		if (m_curPageIndex == 0 || m_curPageIndex == 5 || m_curPageIndex == 2)
		{
			m_animator.SetInteger("State", 1);
			await UniTask.WaitUntil(() => m_animator.GetCurrentAnimatorStateInfo(0).IsName("Appearance") && m_animator.GetCurrentAnimatorStateInfo(0).normalizedTime >= 1f, PlayerLoopTiming.Update, token).SuppressCancellationThrow();
			if (!token.IsCancellationRequested)
			{
				m_animator.SetInteger("State", 99);
			}
		}
		else
		{
			m_animator.SetInteger("State", 0);
		}
	}

	private async UniTaskVoid PlayAnimator(CancellationToken token)
	{
		if (m_animator != null)
		{
			m_animator.SetInteger("State", 1);
			await UniTask.WaitUntil(() => m_animator.GetCurrentAnimatorStateInfo(0).IsName("Appearance") && m_animator.GetCurrentAnimatorStateInfo(0).normalizedTime >= 1f, PlayerLoopTiming.Update, token).SuppressCancellationThrow();
			if (!token.IsCancellationRequested)
			{
				m_animator.SetInteger("State", 99);
			}
		}
	}

	public void ChangePage(int index)
	{
		OpenTouch(index == 1 || index == 4);
		Recover();
		SetPageSetting(pageSettings[m_curPageIndex], pageSettings[index], index == 4);
		characterModelRoot.SetActive(index == 0 || index == 4 || index == 5 || index == 2);
		m_curPageIndex = index;
		if (m_DIsableAnimatorUpdate)
		{
			m_DIsableAnimatorUpdate = !m_DIsableAnimatorUpdate;
		}
		else if (characterModelRoot.activeSelf)
		{
			PalyAnimatorOnPageChange(m_ModelCts.Token);
		}
	}

	public void TurnToSecondCamera(bool isSecondView, int index = -1)
	{
		int curPageIndex = m_curPageIndex;
		if (index != -1)
		{
			m_curPageIndex = index;
		}
		Recover();
		OpenTouch(!isSecondView && m_curPageIndex <= 1);
		if (index == 0)
		{
			m_animator.SetInteger("State", 0);
		}
		characterModelRoot.SetActive(index == 0 || index == -1);
		if (isSecondView)
		{
			SetPageSetting(pageSettings[curPageIndex], secondViewPageSettings[m_curPageIndex]);
			if (m_curPageIndex == 4)
			{
				Vector3 position = secondViewPageSettings[m_curPageIndex].vCamera.transform.position;
				lookAtDir = position - oriPoint.position;
				secondViewPageSettings[m_curPageIndex].vCamera.transform.position = new Vector3(position.x, m_charTopHeight - 0.2f, position.z);
			}
		}
		else
		{
			SetPageSetting(secondViewPageSettings[curPageIndex], pageSettings[m_curPageIndex], m_curPageIndex == 0);
			PalyAnimatorOnPageChange(m_ModelCts.Token);
		}
		m_useHalfBodySetting = false;
		halfBodyCamera.Priority = 0;
	}

	private void SetPageSetting(PageSetting from, PageSetting to, bool useCharacterHight = false)
	{
		if (useCharacterHight)
		{
			Vector3 position = to.vCamera.transform.position;
			lookAtDir = position - oriPoint.position;
		}
		from.vCamera.Priority = 0;
		to.vCamera.Priority = _setPageToCameraPriority;
		foreach (GameObject openObject in from.openObjects)
		{
			openObject.SetActive(value: false);
		}
		foreach (GameObject openObject2 in to.openObjects)
		{
			openObject2.SetActive(value: true);
		}
		m_fixHorizontal = to.fixHorizontal;
		m_fixVertical = to.fixVertical;
		fieldControl.Focus = to.forcus;
		fieldControl.LensDistance = to.lensDistance;
		fieldControl.Ratio = to.ratio;
		fieldControl.isOpen = to.isOpen;
	}

	public void SetCamera(int characterid, PageSetting to)
	{
		EntityCharacterData data = CoreUtils.GetData(characterid, RuntimeConfigs.data.entityCharacterDatas);
		if (to.vCamera.name == "CM_Main")
		{
			if (data != null && data.viewPosition.Length > 2)
			{
				to.vCamera.transform.localPosition = new Vector3(data.viewPosition[0], data.viewPosition[1], data.viewPosition[2]);
				to.vCamera.transform.rotation = Quaternion.Euler(new Vector3(data.viewRotation[0], data.viewRotation[1], data.viewRotation[2]));
			}
			else
			{
				to.vCamera.transform.localPosition = DefaultCMPosition;
				to.vCamera.transform.rotation = Quaternion.Euler(DefaultCMRotation);
			}
		}
	}

	private async void LookAtCamera()
	{
		while ((bool)this)
		{
			Vector3 vector = lookAtPoint.position - oriPoint.position;
			Vector3 vector2 = targetPos - oriPoint.position;
			float num = Vector2.SignedAngle(new Vector2(vector2.x, vector2.z), new Vector2(vector.x, vector.z));
			float num2 = Mathf.Abs(num);
			float num3 = num / num2;
			if (num2 > 5f)
			{
				num = Mathf.Lerp(0.1f, 2f, num2 * num2 / 3600f);
				float num4 = Mathf.Min(num / 10f, 0.2f);
				lastAngle = ((lastAngle + num4 < num) ? (lastAngle + num4) : num);
				lookAtPoint.transform.position = Quaternion.Euler(0f, lastAngle * num3, 0f) * vector + oriPoint.position;
			}
			else
			{
				lastAngle = 0f;
			}
			await UniTask.Delay(10);
		}
	}

	public void OpenTouch(bool open)
	{
		touchObj?.SetActive(open);
	}

	public void OnDrag(PointerEventData eventData)
	{
		if (m_isRecover)
		{
			return;
		}
		if (Touchscreen.current != null && Touchscreen.current.touches.Count >= 2 && Touchscreen.current.touches[0].phase.ReadValue() != UnityEngine.InputSystem.TouchPhase.None && Touchscreen.current.touches[1].phase.ReadValue() != UnityEngine.InputSystem.TouchPhase.None && Touchscreen.current.touches[1].phase.ReadValue() != UnityEngine.InputSystem.TouchPhase.Ended)
		{
			TwoFingerTough();
			return;
		}
		Vector2 vector = m_touchOriPos - eventData.position;
		m_touchOriPos = eventData.position;
		if (vector.sqrMagnitude > 10000f)
		{
			vector = vector.normalized * 100f;
		}
		float y = vector.x * 0.4f;
		if (!m_fixHorizontal)
		{
			if (m_commonModel == null)
			{
				m_modle.transform.eulerAngles += new Vector3(0f, y, 0f);
			}
			else
			{
				m_commonModel.transform.eulerAngles += new Vector3(0f, y, 0f);
			}
		}
		if (m_curPageIndex == 4)
		{
			float num = ((m_modle.transform.eulerAngles.y > 180f) ? (360f - m_modle.transform.eulerAngles.y) : m_modle.transform.eulerAngles.y);
			lookAtPoint.position = Quaternion.Euler(0f, y, 0f) * (lookAtPoint.position - oriPoint.position) + oriPoint.position;
			if (num < 60f)
			{
				targetPos = oriPoint.position + lookAtDir;
			}
			else
			{
				targetPos = Quaternion.Euler(0f, m_modle.transform.eulerAngles.y, 0f) * lookAtDir + oriPoint.position;
			}
		}
		if (!m_fixVertical && m_useHalfBodySetting)
		{
			float offset = vector.y * 0.001f;
			float y2 = halfBodyCamera.transform.position.y;
			GetOffset(cameraLowPos, m_charTopHeight, y2, ref offset);
			halfBodyCamera.transform.position = new Vector3(halfBodyCamera.transform.position.x, y2 + offset, halfBodyCamera.transform.position.z);
		}
	}

	public void TwoFingerTough()
	{
		Vector2 a = Touchscreen.current.touches[0].position.ReadValue();
		Vector2 b = Touchscreen.current.touches[1].position.ReadValue();
		float upDown = Vector2.Distance(a, b) - m_lastOffset;
		ScrollScreen(upDown);
	}

	public void OnScroll(PointerEventData eventData)
	{
		if (!m_isRecover)
		{
			ScrollScreen(eventData.scrollDelta.y);
		}
	}

	private void ScrollScreen(float UpDown)
	{
		if (m_curPageIndex != 4)
		{
			return;
		}
		if (UpDown > 0f)
		{
			if (!m_useHalfBodySetting)
			{
				halfBodyCamera.transform.position = new Vector3(halfBodyCamera.transform.position.x, m_charTopHeight, halfBodyCamera.transform.position.z);
				halfBodyCamera.Priority = _halfBodyCameraPriority;
				m_useHalfBodySetting = true;
			}
		}
		else if (m_useHalfBodySetting)
		{
			halfBodyCamera.Priority = 0;
			m_useHalfBodySetting = false;
		}
	}

	private void GetOffset(float min, float max, float curNum, ref float offset)
	{
		float num = offset + curNum;
		if (num > max)
		{
			offset = max - curNum;
		}
		else if (num < min)
		{
			offset = min - curNum;
		}
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		if (!m_isRecover)
		{
			if (Touchscreen.current != null && Touchscreen.current.touches.Count >= 2 && Touchscreen.current.touches[0].phase.ReadValue() != UnityEngine.InputSystem.TouchPhase.None && Touchscreen.current.touches[1].phase.ReadValue() != UnityEngine.InputSystem.TouchPhase.None && Touchscreen.current.touches[1].phase.ReadValue() != UnityEngine.InputSystem.TouchPhase.Ended)
			{
				m_lastOffset = Vector2.Distance(Touchscreen.current.touches[0].position.ReadValue(), Touchscreen.current.touches[1].position.ReadValue());
			}
			m_touchOriPos = eventData.position;
		}
	}

	public void OnPointerUp(PointerEventData eventData)
	{
	}

	public static IEnumerator LoadPrefab()
	{
		if (_instance == null)
		{
			AssetStationManager.BattleStation.InstantiateAsync(GameLoader.meta.uiCharacterSceneReferenceAssetID, (AssetLoadHandle result) =>
			{
				_instance = result.AsGameObject().GetComponent<UICharacterScene>();
				_instance.uiSceneCamera.gameObject.SetActive(value: false);
			});
			yield return new WaitUntil(() => _instance != null);
		}
	}

	public void ChangeDNAColor(int color)
	{
		MeshRenderer component = DNA.GetComponent<MeshRenderer>();
		MaterialPropertyBlock materialPropertyBlock = new MaterialPropertyBlock();
		_ = component.sharedMaterial;
		materialPropertyBlock = new MaterialPropertyBlock();
		materialPropertyBlock.SetColor("_Color", DNAcolors[color - 1]);
		component.SetPropertyBlock(materialPropertyBlock);
	}
}
