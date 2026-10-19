using System;
using System.Threading;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
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

public class CharacterSkinViewScene : BaseUIScene, IPointerDownHandler, IEventSystemHandler, IDragHandler, IScrollHandler, IPointerUpHandler
{
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
	private Quaternion modelDecorationRotation;

	private Vector3 modelPosition;

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

	private SkinSubType _curType;

	private int m_stack;

	private ACTLoadStation<GameObject> _characterLoadStation;

	private ACTLoadStation<GameObject> _commonLoadStation;

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

	private bool _gamepadModelControlEnabled;

	private const float GamepadRotateSpeed = 120f;

	private const float GamepadVerticalSpeed = 1.2f;

	private readonly EffectDressRuntimeState _effectDressState = new EffectDressRuntimeState();

	private MonoEntity _effectDressMonoEntity;

	private int _previewEffectDressId;

	private bool _hasPreviewEffectDress;

	private bool _effectDressEventRegistered;

	private CharacterSkinEffectDressCueReceiver _effectDressCueReceiver;

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

	public static CharacterSkinViewScene Default => Singleton<UISceneManager>.instance.GetScene<CharacterSkinViewScene>();

	public override void OnLoadComplete()
	{
		RegisterEffectDressEvents();
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
		EffectDressRuntimeUtility.RecycleModelMotionCueInstances(_effectDressState);
		base.Close();
	}

	public override void OnRelease()
	{
		Release();
		UnregisterEffectDressEvents();
	}

	private void Release()
	{
		_characterLoadStation.Release();
		_commonLoadStation.Release();
		ReleaseCharacterModel();
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Open_MainLight, null);
	}

	public void ShowCharacterModel(int id, ICharacterSource characterSource, int skinId = 0)
	{
		if (_characterId != id)
		{
			_characterId = id;
			_modelCts.Cancel();
			_modelCts = new CancellationTokenSource();
			ShowCharacterModelImply(id, characterSource, skinId);
		}
	}

	public void ChangeCharacterModel(int id, ICharacterSource characterSource, int SkinId)
	{
		ShowCharacterModelImply(id, characterSource, SkinId);
	}

	public void ResetCharcterAni()
	{
		PlayAnimator(_modelCts.Token, _curType).Forget();
	}

	private void ShowCharacterModelImply(int characterId, ICharacterSource characterSource, int skinId = 0)
	{
		EntityCharacterData data = CoreUtils.GetData(characterId, RuntimeConfigs.data.entityCharacterDatas);
		int skinId2;
		if (skinId != 0)
		{
			skinId2 = skinId;
		}
		else
		{
			skinId2 = ((characterSource == null) ? characterId : CharacterSkinRuntimeUtility.ResolveSkinId(characterId, characterSource));
		}
		ReleaseCharacterModel();
		LoadCharacterModelAsync(characterSource, data, skinId2);
	}

	private void LoadCharacterModelAsync(ICharacterSource characterSource, EntityCharacterData characterData, int skinId)
	{
		string modelPath = CharacterSkinRuntimeUtility.GetModelPath(characterData.id, skinId, CharacterModelUsage.Character);
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
			if (AssetLoadHandleExtensions.IsValid(modelHandle))
			{
				_modelPrefab = modelHandle.AsGameObject();
				string animatorAssetId = CharacterSkinRuntimeUtility.GetAnimatorAssetId(skinId, CharacterModelUsage.Skin);
				if (!string.IsNullOrEmpty(animatorAssetId))
				{
					_animationHandle = AssetStationManager.BattleStation.Load<RuntimeAnimatorController>(animatorAssetId);
					CharacterSkinRuntimeUtility.ApplyAnimatorOverride(_modelPrefab, _animationHandle.As<RuntimeAnimatorController>());
				}
				if (characterSource != null)
				{
					_modelPrefab.GetComponent<MonoDestinyEffect>()?.Binding(characterSource);
				}
				_model = CharacterSkinRuntimeUtility.ResolveDisplayObject(_modelPrefab);
				_model.transform.localPosition = Vector3.zero;
				_modelPrefab.GetComponent<MonoEntityConfig>()?.SetRenderLayerToCharacterUIScene();
				BindEffectDressModel(characterData.id, _modelPrefab);
				SyncEffectDressForCurrentModel();
				_characterHeight = ((characterData.characterHeight < 0.1f) ? 1.5f : (characterData.characterHeight * 0.92f));
				if (m_useHalfBodySetting)
				{
					halfBodyCamera.transform.DOKill();
					halfBodyCamera.transform.DOMoveY(characterData.characterHeight - 0.2f, recoverTime);
				}
				else
				{
					DOTween.To(() => halfBodyCamera.transform.position.y, (float x) =>
					{
						halfBodyCamera.transform.position = new Vector3(halfBodyCamera.transform.position.x, x, halfBodyCamera.transform.position.z);
					}, m_charTopHeight, m_recoverTime);
					halfBodyCamera.transform.DOMoveY(_characterHeight, recoverTime);
				}
				_animator = _model.GetComponentInChildren<Animator>();
				BindEffectDressCueReceiver(_animator);
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
					PlayAnimator(_modelCts.Token, _curType).Forget();
					_modelPrefab.GetComponent<AniPartControl>()?.PlayVisible(AniPartControl.PartType.SystemDither, 0.1f, default, null, reset: true);
				}
			}
		};
	}

	public void PlayAnimator(SkinSubType subType)
	{
		Recover();
		OpenTouch(subType == SkinSubType.Skin);
		PlayAnimator(_modelCts.Token, subType).Forget();
	}

	public void SwitchSub(SkinSubType subType, int id)
	{
		_curType = subType;
		PlayAnimator(subType);
	}

	public void ClearDressRuntime()
	{
		EffectDressRuntimeUtility.ClearAllRuntime(_effectDressState);
	}

	private async UniTaskVoid PlayAnimator(CancellationToken token, SkinSubType to)
	{
		if (_animator != null)
		{
			characterModelRoot.transform.localRotation = ((to == SkinSubType.Skin) ? modelRotation : modelDecorationRotation);
			_animator.CrossFade(GetSkinSubTypeAniName(to), 0f, 0, 0f);
		}
	}

	private string GetSkinSubTypeAniName(SkinSubType subType)
	{
		return subType switch
		{
			SkinSubType.Skin => "idle", 
			SkinSubType.Decoration => "run", 
			_ => "", 
		};
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

	public void ToType(SkinSubType subType)
	{
		Recover();
		_curType = subType;
		characterModelRoot.transform.localPosition = modelPosition;
		characterModelRoot.transform.localRotation = modelRotation;
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
		if (_curType != SkinSubType.Skin || m_isRecover)
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
		if (_curType == SkinSubType.Skin)
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
		if (_curType != SkinSubType.Skin)
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
		ClearEffectDressForCurrentModel();
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
		_curType = SkinSubType.Skin;
		RegisterEffectDressEvents();
		LookAtCamera();
	}

	protected override void OnDestroy()
	{
		ClearEffectDressForCurrentModel();
		UnregisterEffectDressEvents();
		base.OnDestroy();
	}

	private void LateUpdate()
	{
		if (_neckIK != null && _curType == SkinSubType.Skin)
		{
			_neckIK.solver.IKUpdate();
			_eyesIK.solver.IKUpdate();
		}
		UpdateGamepadModelControl();
	}

	private void UpdateGamepadModelControl()
	{
		if (!_gamepadModelControlEnabled || m_isRecover || _curType != SkinSubType.Skin || MonoECS.instance == null || MonoECS.instance.InputMode != DeviceInputMode.Gamepad)
		{
			return;
		}
		CharacterSkinView characterSkinView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_CHARACTERSKIN) as CharacterSkinView;
		if ((characterSkinView.CurrentSubView != SkinSubType.Skin || !characterSkinView.SkinView.IsFocusInText) && Singleton<GameInputActionManager>.instance != null)
		{
			Vector2 vector = Singleton<GameInputActionManager>.instance.ReadActionValue<Vector2>("UI/RightStickNavigate", out var _);
			if (Mathf.Abs(vector.x) > 0.01f)
			{
				GamepadRotate(vector.x);
			}
			if (Mathf.Abs(vector.y) > 0.01f)
			{
				GamepadDragVertical(vector.y);
			}
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

	public void GamepadScroll(float value)
	{
		if (!m_isRecover)
		{
			ScrollScreen(value);
		}
	}

	public void SetGamepadModelControlEnabled(bool enabled)
	{
		_gamepadModelControlEnabled = enabled;
	}

	public void GamepadRotate(float axisX)
	{
		if (!m_isRecover && _curType == SkinSubType.Skin && !(_modelPrefab == null))
		{
			float y = axisX * 120f * Time.deltaTime;
			if (!m_fixHorizontal)
			{
				_modelPrefab.transform.eulerAngles += new Vector3(0f, y, 0f);
			}
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
	}

	public void GamepadDragVertical(float axisY)
	{
		if (!m_isRecover && _curType == SkinSubType.Skin && !m_fixVertical && m_useHalfBodySetting)
		{
			float offset = axisY * 1.2f * Time.deltaTime;
			float y = halfBodyCamera.transform.position.y;
			GetOffset(cameraLowPos, m_charTopHeight, y, ref offset);
			halfBodyCamera.transform.position = new Vector3(halfBodyCamera.transform.position.x, y + offset, halfBodyCamera.transform.position.z);
		}
	}

	public void OnPointerUp(PointerEventData eventData)
	{
	}

	public void PreviewEffectDress(int dressId)
	{
		if (dressId != 0 && _characterId != 0)
		{
			_hasPreviewEffectDress = true;
			_previewEffectDressId = dressId;
			SyncEffectDressForCurrentModel();
		}
	}

	public void ClearEffectDressPreview()
	{
		if (_hasPreviewEffectDress)
		{
			_hasPreviewEffectDress = false;
			_previewEffectDressId = 0;
			SyncEffectDressForCurrentModel();
		}
	}

	public void FireEffectDressCue(string cueKey)
	{
		if (!(_modelPrefab == null) && !(_effectDressMonoEntity == null) && !string.IsNullOrEmpty(cueKey))
		{
			EffectDressRuntimeUtility.FireMotionCueForModel(_modelPrefab, _effectDressMonoEntity, _effectDressState, cueKey);
		}
	}

	private void RegisterEffectDressEvents()
	{
		if (!_effectDressEventRegistered && Singleton<EventManager>.instance != null)
		{
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.SwitchEffectDress, OnSwitchEffectDress);
			_effectDressEventRegistered = true;
		}
	}

	private void UnregisterEffectDressEvents()
	{
		if (_effectDressEventRegistered && Singleton<EventManager>.instance != null)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.SwitchEffectDress, OnSwitchEffectDress);
			_effectDressEventRegistered = false;
		}
	}

	private void BindEffectDressModel(int roleId, GameObject modelPrefab)
	{
		_characterId = roleId;
		_effectDressMonoEntity = EntityPrefabRuntimeUtility.EnsureMonoEntity(modelPrefab);
	}

	private void BindEffectDressCueReceiver(Animator animator)
	{
		if (!(animator == null))
		{
			CharacterSkinEffectDressCueReceiver characterSkinEffectDressCueReceiver = animator.GetComponent<CharacterSkinEffectDressCueReceiver>();
			if (characterSkinEffectDressCueReceiver == null)
			{
				characterSkinEffectDressCueReceiver = animator.gameObject.AddComponent<CharacterSkinEffectDressCueReceiver>();
			}
			_effectDressCueReceiver = characterSkinEffectDressCueReceiver;
			characterSkinEffectDressCueReceiver.Bind(this, animator, _effectDressState);
		}
	}

	private void ClearEffectDressForCurrentModel()
	{
		if (_effectDressCueReceiver != null)
		{
			_effectDressCueReceiver.Bind(null, null, null);
			_effectDressCueReceiver = null;
		}
		EffectDressRuntimeUtility.ClearAll(_effectDressState);
		_effectDressMonoEntity = null;
	}

	private void SyncEffectDressForCurrentModel()
	{
		if ((Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_CHARACTERSKIN) as CharacterSkinView).CurrentSubView != SkinSubType.Skin && !(_modelPrefab == null))
		{
			if (_effectDressMonoEntity == null)
			{
				_effectDressMonoEntity = EntityPrefabRuntimeUtility.EnsureMonoEntity(_modelPrefab);
			}
			if (!(_effectDressMonoEntity == null))
			{
				EffectDressRuntimeUtility.SyncDressForModel(_characterId, ResolveCurrentEffectDressId(), _modelPrefab, _effectDressMonoEntity, _effectDressState);
			}
		}
	}

	private int ResolveCurrentEffectDressId()
	{
		if (_hasPreviewEffectDress)
		{
			return _previewEffectDressId;
		}
		if (_characterId == 0)
		{
			return 0;
		}
		if (CharacterDataHelper.TryGetBagCharacterById(_characterId, out var character))
		{
			return character.EffectDressId;
		}
		return (G.localPlayer?.GetCharacter(_characterId))?.EffectDressId ?? 0;
	}

	private void OnSwitchEffectDress(BaseEventContent content)
	{
		if (content is SwitchEffectDressEvt switchEffectDressEvt && (switchEffectDressEvt.roleId == 0 || switchEffectDressEvt.roleId == _characterId))
		{
			_hasPreviewEffectDress = false;
			_previewEffectDressId = 0;
			SyncEffectDressForCurrentModel();
		}
	}
}
