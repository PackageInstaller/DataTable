using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Rendering;
using ACT.Utility;
using Bamboo.AssetField;
using Cinemachine;
using Cysharp.Threading.Tasks;
using DG.Tweening;
using Fundamental;
using RootMotion.FinalIK;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem;
using UnityEngine.UIElements;

namespace ACT.UI;

public class CharacterViewScene : BaseUIScene, IPointerDownHandler, IEventSystemHandler, IDragHandler, IScrollHandler, IPointerUpHandler
{
	public enum CvSceneType
	{
		None,
		Over,
		Equipment,
		Skill,
		Elite,
		Level,
		Destiny,
		BagShow,
		DisplayModelShow,
		EquipmentSubview
	}

	[Serializable]
	public class SceneTypeSetting
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

	[SerializeField]
	private GameObject characterModelRoot;

	[SerializeField]
	private CinemachineVirtualCamera halfBodyCamera;

	[SerializeField]
	private float recoverTime = 0.15f;

	[SerializeField]
	private Transform lookAtPoint;

	[SerializeField]
	private Transform oriPoint;

	[SerializeField]
	private Dictionary<CvSceneType, SceneTypeSetting> typeSettings;

	[SerializeField]
	private Vector3 modelPosition;

	[SerializeField]
	private Quaternion modelRotation;

	private Visibility m_ModelVisibility;

	private Vector3 DefaultCMPosition = new Vector3(-3.79f, 0.83f, 2.6f);

	private Vector3 DefaultCMRotation = new Vector3(0f, 126.43f, 2.6f);

	private int _setPageToCameraPriority = 310;

	private int _halfBodyCameraPriority = 320;

	public float cameraLowPos = 0.2f;

	private bool m_fixVertical;

	private bool m_fixHorizontal;

	private bool m_useHalfBodySetting;

	private Vector2 m_touchOriPos;

	public GameObject touchObj;

	private float m_charTopHeight;

	private Vector3 lookAtDir;

	private Vector3 targetPos;

	private float m_lastOffset;

	private bool m_isRecover;

	private float m_recoverTime = 0.15f;

	private CvSceneType _curType;

	private int m_stack;

	private ACTLoadStation<GameObject> _characterLoadStation;

	private ACTLoadStation<GameObject> _commonLoadStation;

	private ICharacterSource _characterSource;

	private static int _ref;

	private int _characterId;

	private static CancellationTokenSource _modelCts;

	private AssetLoadHandle _modelHandle;

	private AssetLoadHandle _animationHandle;

	private GameObject _modelPrefab;

	private GameObject _model;

	private LookAtIK _eyesIK;

	private LookAtIK _neckIK;

	private Animator _animator;

	private float _characterHeight;

	private Vector3 _lookAtDir;

	private Vector3 _targetPos;

	private float _lastAngle;

	public Visibility ModelVisibility
	{
		get
		{
			return m_ModelVisibility;
		}
		set
		{
			if (value == Visibility.Hidden)
			{
				m_ModelVisibility = value;
				if ((bool)_model)
				{
					_model.SetActive(value: false);
				}
			}
			else
			{
				m_ModelVisibility = value;
				if ((bool)_model)
				{
					_model.SetActive(value: true);
				}
			}
		}
	}

	public Func<string> OverrideAnimationName { get; set; }

	public static CharacterViewScene Default => Singleton<UISceneManager>.instance.GetScene<CharacterViewScene>();

	public override void OnLoadComplete()
	{
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Close_MainLight, null);
	}

	public override void Open()
	{
		GameRenderScene.Set(GameRenderScene.Scene.CharacterTeam);
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Close_MainLight, null);
		base.Open();
	}

	public override void Close()
	{
		GameRenderScene.Set(GameRenderScene.Scene.MainBattle);
		base.Close();
	}

	public override void OnRelease()
	{
		_characterSource = null;
		Release();
	}

	private void Release()
	{
		_characterLoadStation.Release();
		_commonLoadStation.Release();
		ReleaseCharacterModel();
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Open_MainLight, null);
	}

	public void ShowCharacterModel(ICharacterSource characterSource)
	{
		int num = characterSource.Id();
		if (_characterId != num)
		{
			_characterId = num;
			_characterSource = characterSource;
			_modelCts.Cancel();
			_modelCts = new CancellationTokenSource();
			ShowCharacterModelImply(characterSource);
		}
	}

	public void SetCamera(int characterid, SceneTypeSetting to)
	{
		CoreUtils.GetData(characterid, RuntimeConfigs.data.entityCharacterDatas);
	}

	public void ResetCharcterAni()
	{
		ShowCharacterModelImply(_characterSource);
	}

	private void SetCharacterAni()
	{
		if (_curType == CvSceneType.None)
		{
			PlayAnimator(_modelCts.Token).Forget();
		}
		string stateName = _curType.ToString();
		if (_curType == CvSceneType.Skill)
		{
			stateName = CvSceneType.Over.ToString();
		}
		if (_curType == CvSceneType.EquipmentSubview)
		{
			stateName = CvSceneType.Equipment.ToString();
		}
		if (_curType == CvSceneType.Destiny)
		{
			stateName = CvSceneType.Over.ToString();
		}
		_animator.CrossFade(stateName, 0f, 0, 0f);
	}

	private void ShowCharacterModelImply(ICharacterSource characterSource)
	{
		int num = characterSource.Id();
		EntityCharacterData data = CoreUtils.GetData(num, RuntimeConfigs.data.entityCharacterDatas);
		int skinId = CharacterSkinRuntimeUtility.ResolveSkinId(num, characterSource);
		ReleaseCharacterModel();
		LoadCharacterModelAsync(characterSource, data, skinId);
	}

	private void LoadCharacterModelAsync(ICharacterSource characterSource, EntityCharacterData characterData, int skinId)
	{
		string modelPath = CharacterSkinRuntimeUtility.GetModelPath(characterSource.Id(), skinId, CharacterModelUsage.Character);
		if (string.IsNullOrEmpty(modelPath))
		{
			return;
		}
		AssetLoadHandle modelHandle;
		try
		{
			modelHandle = AssetStationManager.BattleStation.InstantiateAsync(modelPath, characterModelRoot.transform);
		}
		catch (OperationCanceledException)
		{
			return;
		}
		if (!AssetLoadHandleExtensions.IsValid(modelHandle))
		{
			return;
		}
		_modelHandle = modelHandle;
		_modelHandle.Completed += (AssetLoadHandle handle) =>
		{
			_modelPrefab = modelHandle.AsGameObject();
			string animatorAssetId = CharacterSkinRuntimeUtility.GetAnimatorAssetId(skinId, CharacterModelUsage.Character);
			if (!string.IsNullOrEmpty(animatorAssetId))
			{
				_animationHandle = AssetStationManager.BattleStation.Load<RuntimeAnimatorController>(animatorAssetId);
				CharacterSkinRuntimeUtility.ApplyAnimatorOverride(_modelPrefab, _animationHandle.As<RuntimeAnimatorController>());
			}
			_modelPrefab.GetComponent<MonoDestinyEffect>()?.Binding(characterSource);
			_model = CharacterSkinRuntimeUtility.ResolveDisplayObject(_modelPrefab);
			_model.transform.localPosition = Vector3.zero;
			_characterHeight = ((characterData.characterHeight < 0.1f) ? 1.5f : (characterData.characterHeight * 0.92f));
			DOTween.To(() => halfBodyCamera.transform.position.y, (float x) =>
			{
				halfBodyCamera.transform.position = new Vector3(halfBodyCamera.transform.position.x, x, halfBodyCamera.transform.position.z);
			}, m_charTopHeight, m_recoverTime);
			halfBodyCamera.transform.DOMoveY(_characterHeight, recoverTime);
			_animator = _model.GetComponentInChildren<Animator>();
			if (ModelVisibility == Visibility.Hidden)
			{
				_model.SetActive(value: false);
			}
			else
			{
				_model.SetActive(value: true);
				LookAtIK[] componentsInChildren = _model.GetComponentsInChildren<LookAtIK>();
				foreach (LookAtIK lookAtIK in componentsInChildren)
				{
					if (lookAtIK.solver.eyes.Length != 0)
					{
						_eyesIK = lookAtIK;
						lookAtIK.solver.target = uiSceneCamera.transform;
					}
					else
					{
						_neckIK = lookAtIK;
						lookAtIK.solver.target = lookAtPoint;
					}
				}
				_animator.applyRootMotion = false;
				oriPoint.position = _model.transform.position + Vector3.up * _characterHeight;
				lookAtPoint.position = halfBodyCamera.transform.position.WithY(_characterHeight);
				_targetPos = lookAtPoint.position;
				_animator.SetBool("ShowModel", value: true);
				PlayAnimator(_modelCts.Token).Forget();
				_modelPrefab.GetComponent<AniPartControl>()?.PlayVisible(AniPartControl.PartType.SystemDither, 0.1f, default, null, reset: true);
				_modelPrefab.GetComponent<AniPartControl>()?.PlayVisible(AniPartControl.PartType.SystemWeaponDither, 0.1f, default, null, reset: true);
				_modelPrefab.GetComponent<MonoEntityConfig>()?.SetRenderLayerToCharacterUIScene();
			}
		};
	}

	private async UniTaskVoid PlayAnimator(CancellationToken token, CvSceneType to = CvSceneType.None)
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("PlayAnimator to :" + to.ToString() + "_curType" + _curType.ToString() + "Id" + _characterId);
		}
		if (!(_animator != null))
		{
			return;
		}
		if (_animator.runtimeAnimatorController.animationClips.Length > 5)
		{
			if (to != CvSceneType.None)
			{
				if (_animator.GetCurrentAnimatorStateInfo(0).IsName("Born"))
				{
					string stateName = to.ToString();
					switch (to)
					{
					case CvSceneType.Skill:
					case CvSceneType.Destiny:
						stateName = CvSceneType.Over.ToString();
						break;
					case CvSceneType.EquipmentSubview:
						stateName = CvSceneType.Equipment.ToString();
						break;
					}
					_animator.CrossFade(stateName, 0f, 0, 0f);
				}
				else
				{
					_animator.SetInteger("state", (int)to);
				}
			}
			else if (_curType != CvSceneType.Over)
			{
				SetCharacterAni();
			}
			else
			{
				_animator.Play("Born");
			}
		}
		else if (_curType == CvSceneType.Over)
		{
			_animator.SetInteger("State", 1);
			await UniTask.WaitUntil(() => _animator.GetCurrentAnimatorStateInfo(0).IsName("Appearance") && _animator.GetCurrentAnimatorStateInfo(0).normalizedTime >= 1f, PlayerLoopTiming.Update, token).SuppressCancellationThrow();
			if (!token.IsCancellationRequested)
			{
				_animator.SetInteger("State", 99);
			}
		}
		else
		{
			_animator.SetInteger("State", 0);
		}
	}

	private async UniTaskVoid PlayNewAnimator(CancellationToken token)
	{
	}

	private async void LookAtCamera()
	{
		while ((bool)this)
		{
			Vector3 vector = lookAtPoint.position - oriPoint.position;
			Vector3 vector2 = _targetPos - oriPoint.position;
			float num = Vector2.SignedAngle(new Vector2(vector2.x, vector2.z), new Vector2(vector.x, vector.z));
			float num2 = Mathf.Abs(num);
			float num3 = num / num2;
			if (num2 > 5f)
			{
				num = Mathf.Lerp(0.1f, 2f, num2 * num2 / 3600f);
				float num4 = Mathf.Min(num / 10f, 0.2f);
				_lastAngle = ((_lastAngle + num4 < num) ? (_lastAngle + num4) : num);
				lookAtPoint.transform.position = Quaternion.Euler(0f, _lastAngle * num3, 0f) * vector + oriPoint.position;
			}
			else
			{
				_lastAngle = 0f;
			}
			await UniTask.Delay(10);
		}
	}

	public void ToType(CvSceneType to)
	{
		bool flag = _curType == CvSceneType.None;
		if (_curType != to)
		{
			Recover();
			typeSettings.TryGetValue(to, out var value);
			if (characterModelRoot.activeSelf && !flag && to != CvSceneType.Destiny)
			{
				PlayAnimator(_modelCts.Token, to).Forget();
			}
			SetPageSetting(value, to, to == CvSceneType.DisplayModelShow);
			OpenTouch(to == CvSceneType.DisplayModelShow);
		}
	}

	private void SetPageSetting(SceneTypeSetting to, CvSceneType totype, bool useCharacterHight = false)
	{
		if (to != null)
		{
			if (useCharacterHight)
			{
				Vector3 position = to.vCamera.transform.position;
				lookAtDir = position - oriPoint.position;
			}
			if (totype != CvSceneType.DisplayModelShow)
			{
				characterModelRoot.transform.localPosition = modelPosition;
				characterModelRoot.transform.localRotation = modelRotation;
			}
			else
			{
				characterModelRoot.transform.localPosition = Vector3.zero;
				characterModelRoot.transform.localRotation = Quaternion.Euler(Vector3.zero);
			}
			if (typeSettings.TryGetValue(_curType, out var value))
			{
				value.vCamera.Priority = 0;
				foreach (GameObject openObject in value.openObjects)
				{
					openObject.SetActive(value: false);
				}
			}
			if (to.vCamera != null)
			{
				to.vCamera.Priority = _setPageToCameraPriority;
				foreach (GameObject openObject2 in to.openObjects)
				{
					openObject2.SetActive(value: true);
				}
			}
			m_fixHorizontal = to.fixHorizontal;
		}
		_curType = totype;
	}

	private void Recover()
	{
		if (!m_isRecover && (bool)_modelPrefab)
		{
			if (m_useHalfBodySetting)
			{
				halfBodyCamera.Priority = 0;
				m_useHalfBodySetting = false;
			}
			m_useHalfBodySetting = false;
			m_isRecover = true;
			m_stack = 2;
			float angle = _modelPrefab.transform.eulerAngles.y;
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
				_modelPrefab.transform.localEulerAngles = Vector3.zero;
			}, 0f, m_recoverTime * 2f).OnComplete(() =>
			{
				PopStack();
			});
		}
	}

	private void PopStack()
	{
		if (--m_stack == 0)
		{
			m_isRecover = false;
		}
	}

	public void OpenTouch(bool open)
	{
		touchObj?.SetActive(open);
	}

	public void OnDrag(PointerEventData eventData)
	{
		if (_curType != CvSceneType.DisplayModelShow || m_isRecover)
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
		if (!m_fixHorizontal && _modelPrefab != null)
		{
			_modelPrefab.transform.eulerAngles += new Vector3(0f, y, 0f);
		}
		if (_curType == CvSceneType.DisplayModelShow)
		{
			float num = ((_modelPrefab.transform.eulerAngles.y > 180f) ? (360f - _modelPrefab.transform.eulerAngles.y) : _modelPrefab.transform.eulerAngles.y);
			lookAtPoint.position = Quaternion.Euler(0f, y, 0f) * (lookAtPoint.position - oriPoint.position) + oriPoint.position;
			if (num < 60f)
			{
				targetPos = oriPoint.position + lookAtDir;
			}
			else
			{
				targetPos = Quaternion.Euler(0f, _modelPrefab.transform.eulerAngles.y, 0f) * lookAtDir + oriPoint.position;
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

	public void TwoFingerTough()
	{
		Vector2 a = Touchscreen.current.touches[0].position.ReadValue();
		Vector2 b = Touchscreen.current.touches[1].position.ReadValue();
		float upDown = Vector2.Distance(a, b) - m_lastOffset;
		ScrollScreen(upDown);
	}

	private void ScrollScreen(float UpDown)
	{
		if (_curType != CvSceneType.DisplayModelShow)
		{
			return;
		}
		if (UpDown > 0f)
		{
			if (!m_useHalfBodySetting)
			{
				EntityCharacterData data = CoreUtils.GetData(_characterId, RuntimeConfigs.data.entityCharacterDatas);
				halfBodyCamera.transform.position = new Vector3(halfBodyCamera.transform.position.x, data.characterHeight - 0.2f, halfBodyCamera.transform.position.z);
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

	private void ReleaseCharacterModel()
	{
		_eyesIK = null;
		_neckIK = null;
		_animator = null;
		_model = null;
		if (AssetLoadHandleExtensions.IsValid(_modelHandle))
		{
			AssetStationManager.BattleStation.ReleaseInstance(_modelHandle);
			_modelHandle = default;
		}
		if (AssetLoadHandleExtensions.IsValid(_animationHandle))
		{
			AssetStationManager.BattleStation.Release(_animationHandle);
			_animationHandle = default;
		}
		_modelPrefab = null;
	}

	private void Awake()
	{
		_characterLoadStation = new ACTLoadStation<GameObject>();
		_commonLoadStation = new ACTLoadStation<GameObject>();
		_modelCts = new CancellationTokenSource();
		m_charTopHeight = 1.65f;
		_curType = CvSceneType.None;
		LookAtCamera();
	}

	private void LateUpdate()
	{
		if (_neckIK != null && _curType == CvSceneType.DisplayModelShow)
		{
			_neckIK.solver.IKUpdate();
			_eyesIK.solver.IKUpdate();
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

	public void OnScroll(PointerEventData eventData)
	{
		if (!m_isRecover)
		{
			ScrollScreen(eventData.scrollDelta.y);
		}
	}

	public void OnPointerUp(PointerEventData eventData)
	{
	}
}
