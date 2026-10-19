using System;
using System.Collections;
using System.Collections.Generic;
using System.Threading;
using ACT;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Model;
using ACT.Rendering;
using ACT.UI;
using ACT.Utility;
using ACT.VolumeControl;
using Bamboo.AssetField;
using Cinemachine;
using Cysharp.Threading.Tasks;
using DG.Tweening;
using Fundamental;
using Sirenix.Serialization;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem;
using UnityEngine.Playables;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using UnityEngine.SceneManagement;
using XPostProcessing;
using YooAsset;

namespace Lumin.LoungeSystem.UI;

public class LoungeUIScene : LuminSerializedMonoBehaviour, IPointerDownHandler, IEventSystemHandler, IPointerUpHandler
{
	public Camera uiSceneCamera;

	public GameObject modelRoot;

	public CinemachineVirtualCamera normalCamera;

	public CinemachineVirtualCamera nearCamera;

	[OdinSerialize]
	public Dictionary<int, Dictionary<int, Transform>> ModelsPointPosGroup = new Dictionary<int, Dictionary<int, Transform>>();

	public Dictionary<int, CinemachineVirtualCamera> virtualCameras;

	[Header("相机配置")]
	[Tooltip("默认相机优先级")]
	public int defaultCameraPriority = 10;

	[Tooltip("激活相机优先级")]
	public int activeCameraPriority = 20;

	[Tooltip("相机混合时间")]
	public float cameraBlendTime = 0.5f;

	[Tooltip("近距离相机间隔角色距离")]
	public float nearDistance = 1.25f;

	[Header("点击检测配置")]
	[Tooltip("角色模型检测层")]
	public LayerMask characterLayerMask = -1;

	[Tooltip("射线检测最大距离")]
	public float raycastMaxDistance = 100f;

	[Tooltip("点击判定的最大移动距离（防止滑动误触）")]
	public float clickThreshold = 10f;

	[Tooltip("长按判定时间")]
	public float longPressTime = 0.5f;

	[Header("景深配置")]
	[Tooltip("景深Volume（需包含DepthOfField Override）")]
	public Volume dofVolume;

	[Tooltip("景深光圈大小，越小景深越浅")]
	[Range(0.5f, 1.5f)]
	public float dofAperture = 1.5f;

	[Tooltip("景深过渡时间")]
	public float dofTransitionDuration = 0.3f;

	[Header("待机自动镜头")]
	[OdinSerialize]
	[Tooltip("房间ID → 自动镜头Timeline")]
	public Dictionary<int, PlayableDirector> cameraTimelines = new Dictionary<int, PlayableDirector>();

	[Tooltip("无操作进入待机的时间（秒）")]
	public float idleTimeout = 30f;

	[Tooltip("每个区域自动镜头持续时间（秒）")]
	public float perAreaDuration = 10f;

	private Dictionary<int, AssetLoadHandle> m_Handles = new Dictionary<int, AssetLoadHandle>();

	private Dictionary<int, int> m_ModelDic = new Dictionary<int, int>();

	private Dictionary<int, Dictionary<AssetLoadHandle, AssetLoadHandle>> m_SpecialIdle = new Dictionary<int, Dictionary<AssetLoadHandle, AssetLoadHandle>>();

	private Dictionary<int, Dictionary<int, AssetLoadHandle>> m_TriggerGlobalStoryModels = new Dictionary<int, Dictionary<int, AssetLoadHandle>>();

	private ACTLoadStation<GameObject> _furnitureLoadStation;

	private SceneHandle _sceneHandle;

	private CinemachineVirtualCamera m_CurrentCamera;

	private CinemachineBrain m_CurrentCameraBrain;

	private CinemachineVirtualCamera m_PreviousCamera;

	private Dictionary<int, int> _cameraIndexMap = new Dictionary<int, int>();

	private Coroutine _cameraBlendCoroutine;

	private static CancellationTokenSource _modelCts;

	private Vector2 _pointerDownPosition;

	private float _pointerDownTime;

	private bool _isPointerDown;

	private int _pendingClickCharacterId = -1;

	private GameObject _pendingClickObject;

	private int curSelectCharacterId = -1;

	private bool isBlend;

	private DepthOfField _dofComponent;

	private Tween _dofTween;

	private Tween _dofFocusTween;

	private const float DofFocusTransitionDuration = 0.25f;

	private float _lastInputTime;

	private bool _isIdleMode;

	private Coroutine _autoCameraCoroutine;

	private readonly List<int> _areasWithCharacters = new List<int>();

	private int _currentAutoAreaIdx;

	private LoungeMainView _loungeMainView;

	private double _enterRoomTimestamp;

	public const string Role_Lounge_UI_AnimatorPath = "Show/{0}_Lounge";

	private static LoungeUIScene s_Instance;

	private static int s_Ref;

	private bool m_Open;

	private float m_Scale = 1f;

	public bool IsCameraBlending => isBlend;

	public static LoungeUIScene instance => s_Instance;

	public int PendingClickCharacterId
	{
		get
		{
			return curSelectCharacterId;
		}
		set
		{
			curSelectCharacterId = value;
		}
	}

	public bool IsIdleMode => _isIdleMode;

	public event Action<int, int> OnCameraChanged;

	public event Action<int> OnCameraSetIndex;

	public event Action<int> OnCameraBlendFinished;

	public event Action<int> OnCameraBlendStart;

	public event Action<int, int> OnNearCameraBlendFinished;

	public event Action<int, LoungePoint, GameObject> OnCharacterClicked;

	public event Action<int, LoungePoint, GameObject> OnCharacterLongPressed;

	public event Action OnEmptyAreaClicked;

	public event Action OnEnterIdleMode;

	public event Action OnExitIdleMode;

	public void ResetCameraBlendState()
	{
		bool flag = isBlend;
		isBlend = false;
		if (_cameraBlendCoroutine != null)
		{
			StopCoroutine(_cameraBlendCoroutine);
			_cameraBlendCoroutine = null;
		}
		if (m_CurrentCameraBrain != null)
		{
			m_CurrentCameraBrain.m_DefaultBlend.m_Style = CinemachineBlendDefinition.Style.Cut;
		}
		if (flag)
		{
			_loungeMainView?.OnCameraTransitionEnded();
		}
	}

	private void Awake()
	{
		_furnitureLoadStation = new ACTLoadStation<GameObject>();
		LoungeMainView loungeMainView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_LOUNGEMAIN) as LoungeMainView;
		if (loungeMainView != null)
		{
			_loungeMainView = loungeMainView;
			OnCameraBlendStart += loungeMainView.OnCameraBlendStart;
			OnNearCameraBlendFinished += loungeMainView.ShowInteractConversation;
			OnEmptyAreaClicked += loungeMainView.HideInteractionUI;
			OnCameraChanged += loungeMainView.RefreshHudsFromModel;
			OnCameraChanged += RecordLiveAreaChange;
			OnEnterIdleMode += loungeMainView.OnEnterIdleMode;
			OnExitIdleMode += loungeMainView.OnExitIdleMode;
			loungeMainView.SetMainCamera(uiSceneCamera);
		}
	}

	protected void OnDestroy()
	{
		ExitIdleMode();
		_dofTween?.Kill();
		_dofTween = null;
		_dofFocusTween?.Kill();
		_dofFocusTween = null;
		OnNearCameraBlendFinished = null;
		OnCameraBlendStart = null;
		OnCharacterClicked = null;
		OnEmptyAreaClicked = null;
		OnCameraChanged = null;
		OnEnterIdleMode = null;
		OnExitIdleMode = null;
	}

	protected void Open()
	{
		if (m_Open)
		{
			return;
		}
		m_Open = true;
		_lastInputTime = Time.time;
		uiSceneCamera.gameObject.SetActive(value: true);
		GameUtility.mainCamera.gameObject.SetActive(value: false);
		m_CurrentCameraBrain = uiSceneCamera.GetComponent<CinemachineBrain>();
		m_CurrentCameraBrain.m_DefaultBlend.m_Style = CinemachineBlendDefinition.Style.Cut;
		uiSceneCamera.GetUniversalAdditionalCameraData().cameraStack.Add(GameUtility.uiCamera);
		GameRenderScene.Set(GameRenderScene.Scene.Room);
		if (cameraTimelines.Count <= 0)
		{
			return;
		}
		foreach (PlayableDirector value in cameraTimelines.Values)
		{
			if (value != null)
			{
				value.gameObject.SetActive(value: false);
			}
		}
	}

	protected void Close()
	{
		if (m_Open)
		{
			GameRenderScene.Set(GameRenderScene.Scene.MainBattle);
			ExitIdleMode();
			DisableDepthOfField();
			m_Open = false;
			uiSceneCamera.gameObject.SetActive(value: false);
			GameUtility.mainCamera?.gameObject.SetActive(value: true);
		}
	}

	private void Update()
	{
		if (m_Open)
		{
			if (HasAnyInput() || !(_loungeMainView != null) || !_loungeMainView.GetController().IsActive || !_loungeMainView.CanEnterIdleMode)
			{
				ResetIdleTimer();
			}
			if (!_isIdleMode && Time.time - _lastInputTime > idleTimeout && cameraTimelines.Count > 0 && _loungeMainView != null && _loungeMainView.CanEnterIdleMode)
			{
				EnterIdleMode();
			}
		}
	}

	private bool HasAnyInput()
	{
		if (Mouse.current != null && Mouse.current.delta.ReadValue().sqrMagnitude > 0.1f)
		{
			return true;
		}
		if (Mouse.current != null && Mouse.current.IsPressed())
		{
			return true;
		}
		if (Keyboard.current != null && Keyboard.current.anyKey.isPressed)
		{
			return true;
		}
		if (Touchscreen.current != null && Touchscreen.current.primaryTouch.press.isPressed)
		{
			return true;
		}
		if (Gamepad.current != null && (Gamepad.current.buttonSouth.wasPressedThisFrame || Gamepad.current.buttonEast.wasPressedThisFrame || Gamepad.current.leftStick.ReadValue().sqrMagnitude > 0.25f || Gamepad.current.rightStick.ReadValue().sqrMagnitude > 0.25f || Gamepad.current.leftTrigger.ReadValue() > 0.2f || Gamepad.current.rightTrigger.ReadValue() > 0.2f))
		{
			return true;
		}
		return false;
	}

	public static void Push()
	{
		s_Ref++;
		if (s_Ref == 1)
		{
			s_Instance.Open();
		}
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
			s_Instance.Close();
			instance.ReleaseCharacterModel();
			instance.ReleaseAll();
			if (s_Instance != null)
			{
				AssetStationManager.BattleStation.ReleaseInstance(s_Instance.gameObject);
			}
		}
	}

	public static async UniTask UnLoadPrefab()
	{
		if (s_Instance != null)
		{
			s_Instance._furnitureLoadStation.Release();
			s_Instance.ReleaseCharacterModel();
			s_Instance.ReleaseAll();
			await s_Instance._sceneHandle.UnloadAsync().Task;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Open_MainLight, null);
			s_Instance = null;
		}
	}

	public static async UniTask Load()
	{
		if (instance == null)
		{
			SceneHandle sceneHandle = YooAssets.LoadSceneAsync("Scenes/SystemScene/Backyard/Backyard", LoadSceneMode.Additive);
			await UniTask.WaitUntil(() => sceneHandle.IsDone);
			GameObject[] rootGameObjects = sceneHandle.SceneObject.GetRootGameObjects();
			foreach (GameObject gameObject in rootGameObjects)
			{
				if (gameObject.GetComponentInChildren<LoungeUIScene>() != null)
				{
					s_Instance = gameObject.GetComponentInChildren<LoungeUIScene>();
					s_Instance.InitializeCameras();
					s_Instance._sceneHandle = sceneHandle;
					break;
				}
			}
		}
		await UniTask.WaitForSeconds(0.5f);
	}

	public void EnableMainLight(bool enable)
	{
		if (dofVolume != null && dofVolume.profile.TryGet<DepthOfField>(out var component))
		{
			component.active = enable;
		}
		if (dofVolume != null && dofVolume.profile.TryGet<ExpHeightFog>(out var component2))
		{
			component2.active = enable;
		}
	}

	public void SetModelPointPosGroup(Dictionary<int, Dictionary<int, Transform>> pointPosGroup)
	{
		ModelsPointPosGroup = pointPosGroup;
	}

	public void SetCamera(int index, bool blend = false)
	{
		if (virtualCameras == null)
		{
			Debug.LogWarning("相机索引无效！");
			return;
		}
		if (index < 0)
		{
			index = virtualCameras.Count - 1;
		}
		if (index >= virtualCameras.Count)
		{
			index = 0;
		}
		CinemachineVirtualCamera cinemachineVirtualCamera = virtualCameras[index];
		if (cinemachineVirtualCamera == null)
		{
			Debug.LogWarning($"相机索引 {index} 的相机为空！");
			return;
		}
		if (m_CurrentCamera == cinemachineVirtualCamera)
		{
			Debug.Log($"相机 {index} 已经是当前激活的相机");
			return;
		}
		int currentCameraIndex = GetCurrentCameraIndex();
		m_PreviousCamera = m_CurrentCamera;
		if (_cameraBlendCoroutine != null)
		{
			StopCoroutine(_cameraBlendCoroutine);
			_cameraBlendCoroutine = null;
			isBlend = false;
		}
		if (m_CurrentCamera != null)
		{
			m_CurrentCamera.Priority = defaultCameraPriority;
		}
		cinemachineVirtualCamera.Priority = activeCameraPriority;
		m_CurrentCamera = cinemachineVirtualCamera;
		nearCamera.transform.position = cinemachineVirtualCamera.transform.position;
		int curRoomIndex = Singleton<LoungeSystemManager>.instance.CurRoomIndex;
		foreach (KeyValuePair<int, int> item in _cameraIndexMap)
		{
			if (item.Value == index)
			{
				int key = item.Key;
				Singleton<LoungeSystemManager>.instance.CurRoomIndex = key;
				OnCameraChanged?.Invoke(curRoomIndex, key);
				Debug.Log($"<color=green>切换相机: {currentCameraIndex} -> {index} ({cinemachineVirtualCamera.name})</color>");
				break;
			}
		}
		if (blend && cameraBlendTime > 0f)
		{
			if (m_CurrentCameraBrain != null)
			{
				m_CurrentCameraBrain.m_DefaultBlend.m_Style = CinemachineBlendDefinition.Style.EaseInOut;
				m_CurrentCameraBrain.m_DefaultBlend.m_Time = cameraBlendTime;
			}
			isBlend = true;
			OnCameraBlendStart?.Invoke(0);
			_cameraBlendCoroutine = StartCoroutine(WaitForCameraBlend(index, cameraBlendTime));
		}
		else
		{
			OnCameraBlendFinished?.Invoke(index);
		}
	}

	public void SetCameraByPosition(int positionId, bool blend = false)
	{
		if (_cameraIndexMap.TryGetValue(positionId, out var value))
		{
			SetCamera(value, blend);
			return;
		}
		ResetCamera();
		Debug.LogWarning($"位置 {positionId} 没有映射的相机");
	}

	public void SetCameraPositionMapping(int positionId, int cameraIndex)
	{
		_cameraIndexMap[positionId] = cameraIndex;
		Debug.Log($"设置位置 {positionId} 映射到相机 {cameraIndex}");
	}

	public void SetNormalCamera()
	{
		if (normalCamera == null)
		{
			Debug.LogWarning("普通相机为空！");
			return;
		}
		if (m_CurrentCamera != null)
		{
			m_CurrentCamera.Priority = defaultCameraPriority;
		}
		normalCamera.Priority = activeCameraPriority;
		m_PreviousCamera = m_CurrentCamera;
		m_CurrentCamera = normalCamera;
		Debug.Log("<color=green>切换到普通相机</color>");
		OnCameraChanged?.Invoke(GetCurrentCameraIndex(), -1);
	}

	public void SetNearCamera()
	{
		if (isBlend)
		{
			return;
		}
		if (nearCamera == null || _pendingClickCharacterId <= 0)
		{
			Debug.LogWarning("近距离相机为空！");
			return;
		}
		if (m_CurrentCamera != null)
		{
			m_CurrentCamera.Priority = defaultCameraPriority;
		}
		isBlend = true;
		OnCameraBlendStart?.Invoke(_pendingClickCharacterId);
		_cameraBlendCoroutine = StartCoroutine(WaitForNearCameraBlend(cameraBlendTime, _pendingClickCharacterId));
	}

	public void SetPreviousCamera()
	{
		if (m_PreviousCamera == null)
		{
			Debug.LogWarning("没有上一个相机！");
			return;
		}
		int num = -1;
		if (virtualCameras != null)
		{
			for (int i = 0; i < virtualCameras.Count; i++)
			{
				if (virtualCameras[i] == m_PreviousCamera)
				{
					num = i;
					break;
				}
			}
		}
		if (num >= 0)
		{
			SetCamera(num);
		}
		else if (m_PreviousCamera == normalCamera)
		{
			SetNormalCamera();
		}
		else if (m_PreviousCamera == nearCamera)
		{
			SetNearCamera();
		}
	}

	public void ResetCamera()
	{
		if (virtualCameras != null && virtualCameras.Count > 0)
		{
			SetCamera(0);
		}
		else
		{
			SetNormalCamera();
		}
	}

	public int GetCurrentCameraIndex()
	{
		if (m_CurrentCamera == null)
		{
			return -1;
		}
		if (virtualCameras != null)
		{
			for (int i = 0; i < virtualCameras.Count; i++)
			{
				if (virtualCameras[i] == m_CurrentCamera)
				{
					return i;
				}
			}
		}
		if (m_CurrentCamera == normalCamera)
		{
			return -1;
		}
		if (m_CurrentCamera == nearCamera)
		{
			return -2;
		}
		return -1;
	}

	public CinemachineVirtualCamera GetCurrentCamera()
	{
		return m_CurrentCamera;
	}

	public void SetCameraFollowTarget(int cameraIndex, Transform target)
	{
		if (virtualCameras == null || cameraIndex < 0 || cameraIndex >= virtualCameras.Count)
		{
			Debug.LogWarning($"相机索引 {cameraIndex} 无效！");
			return;
		}
		CinemachineVirtualCamera cinemachineVirtualCamera = virtualCameras[cameraIndex];
		if (cinemachineVirtualCamera != null)
		{
			cinemachineVirtualCamera.Follow = target;
			cinemachineVirtualCamera.LookAt = target;
			Debug.Log($"设置相机 {cameraIndex} 跟随目标: {target?.name}");
		}
	}

	public void SetCurrentCameraFollowTarget(Transform target)
	{
		if (m_CurrentCamera != null)
		{
			m_CurrentCamera.Follow = target;
			m_CurrentCamera.LookAt = target;
			Debug.Log("设置当前相机跟随目标: " + target?.name);
		}
	}

	public void SetCameraTemporary(int index, float duration)
	{
		SetCamera(index);
		StartCoroutine(ReturnToPreviousCameraAfterDelay(duration));
	}

	public void FocusOnCharacter(int index, bool useNearCamera = false, float distance = 1.5f, float heightOffset = 1.2f)
	{
		if (ModelsPointPosGroup.Count <= 0)
		{
			Debug.LogWarning($"位置 {index} 不存在！");
			return;
		}
		bool flag = false;
		foreach (Dictionary<int, Transform> value in ModelsPointPosGroup.Values)
		{
			if (value.ContainsKey(index))
			{
				flag = true;
				break;
			}
		}
		if (_pendingClickObject == null || !flag)
		{
			Debug.LogWarning("没有可聚焦的角色对象！");
			return;
		}
		Transform transform = _pendingClickObject.transform.Find("Bip001");
		if (transform == null)
		{
			transform = _pendingClickObject.transform;
		}
		if (useNearCamera)
		{
			if (nearCamera != null)
			{
				Transform transform2 = _pendingClickObject.transform;
				Vector3 position = transform2.position;
				Vector3 forward = transform2.forward;
				Vector3 vector = position + forward * distance;
				vector.y = position.y + heightOffset;
				Vector3 vector2 = position + Vector3.up * heightOffset;
				nearCamera.transform.position = vector;
				Vector3 forward2 = vector2 - vector;
				if (forward2.sqrMagnitude > 0.001f)
				{
					nearCamera.transform.rotation = Quaternion.LookRotation(forward2);
				}
				nearCamera.Follow = transform;
				nearCamera.LookAt = transform;
				SetNearCamera();
			}
		}
		else if (_cameraIndexMap.ContainsKey(index))
		{
			int index2 = _cameraIndexMap[index];
			SetCamera(index2);
		}
		else
		{
			SetCurrentCameraFollowTarget(transform);
		}
		Debug.Log($"<color=green>聚焦到位置 {index} 的角色</color>");
	}

	public Transform GetPointInfoByIndex(int pointId)
	{
		foreach (Dictionary<int, Transform> value2 in ModelsPointPosGroup.Values)
		{
			if (value2.TryGetValue(pointId, out var value))
			{
				return value;
			}
		}
		return null;
	}

	public List<Transform> GetPointInfoByIndexs(int[] pointIds)
	{
		List<Transform> list = new List<Transform>();
		foreach (int key in pointIds)
		{
			foreach (Dictionary<int, Transform> value2 in ModelsPointPosGroup.Values)
			{
				if (value2.TryGetValue(key, out var value))
				{
					list.Add(value);
					break;
				}
			}
		}
		return list;
	}

	public Vector3 GetAreaMiddlePointByIndex(int areaIndex = -1)
	{
		if (areaIndex == -1)
		{
			return instance.gameObject.transform.localPosition;
		}
		if (ModelsPointPosGroup.TryGetValue(areaIndex, out var value) && value.Count > 0)
		{
			Vector3 zero = Vector3.zero;
			int num = 0;
			foreach (KeyValuePair<int, Transform> item in value)
			{
				if (item.Value != null)
				{
					zero += item.Value.position;
					num++;
				}
			}
			if (num > 0)
			{
				return zero / num;
			}
		}
		return Vector3.zero;
	}

	public static Vector3 GetCenterPoint(params Transform[] transforms)
	{
		if (transforms == null || transforms.Length == 0)
		{
			return Vector3.zero;
		}
		Vector3 zero = Vector3.zero;
		int num = 0;
		foreach (Transform transform in transforms)
		{
			if (transform != null)
			{
				zero += transform.localPosition;
				num++;
			}
		}
		if (num <= 0)
		{
			return Vector3.zero;
		}
		return zero / num;
	}

	public static Vector3 GetCenterPoint(IEnumerable<Transform> transforms)
	{
		if (transforms == null)
		{
			return Vector3.zero;
		}
		Vector3 zero = Vector3.zero;
		int num = 0;
		foreach (Transform transform in transforms)
		{
			if (transform != null)
			{
				zero += transform.localPosition;
				num++;
			}
		}
		if (num <= 0)
		{
			return Vector3.zero;
		}
		return zero / num;
	}

	public void DoShowRandomModels(Dictionary<int, int> characterToIndexMap)
	{
		Open();
		m_ModelDic.Clear();
		foreach (KeyValuePair<int, int> item in characterToIndexMap)
		{
			if (m_Handles.ContainsKey(item.Value) && AssetLoadHandleExtensions.IsValid(m_Handles[item.Value]))
			{
				AssetStationManager.BattleStation.ReleaseInstance(m_Handles[item.Value]);
			}
			if (item.Key != 0)
			{
				ShowCharacterModel(item.Value, item.Key, irreplaceable: true);
			}
		}
	}

	public void ShowCharacterModel(int index, int id, bool irreplaceable = false)
	{
		if (ModelsPointPosGroup.Count == 0 || m_ModelDic.ContainsKey(index))
		{
			return;
		}
		string modelPath = GetModelPath(id);
		if (!string.IsNullOrEmpty(modelPath))
		{
			foreach (Dictionary<int, Transform> value2 in ModelsPointPosGroup.Values)
			{
				if (value2.TryGetValue(index, out var value))
				{
					m_ModelDic[index] = id;
					AssetLoadHandle handle = AssetStationManager.BattleStation.InstantiateAsync(modelPath, value);
					m_Handles[index] = handle;
					handle.Completed += (AssetLoadHandle result) =>
					{
						if (IsCurrentModelLoad(index, id, handle))
						{
							ModelCompleted(result.AsGameObject(), id, irreplaceable);
						}
					};
				}
			}
			return;
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError($"角色ID{id}在entityCharacterDatas表中的showModel路径为空！");
		}
	}

	public void ShowTempCharacterModel(int index, int id)
	{
		if (ModelsPointPosGroup.Count == 0 || m_ModelDic.ContainsKey(index))
		{
			return;
		}
		string modelPath = GetModelPath(id);
		if (!string.IsNullOrEmpty(modelPath))
		{
			foreach (Dictionary<int, Transform> value2 in ModelsPointPosGroup.Values)
			{
				if (value2.TryGetValue(index, out var value))
				{
					m_ModelDic[index] = id;
					AssetLoadHandle handle = AssetStationManager.BattleStation.InstantiateAsync(modelPath, value);
					m_Handles[index] = handle;
					handle.Completed += (AssetLoadHandle result) =>
					{
						if (IsCurrentModelLoad(index, id, handle))
						{
							TempModelCompleted(result.AsGameObject(), id);
						}
					};
				}
			}
			return;
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError($"角色ID{id}在entityCharacterDatas表中的showModel路径为空！");
		}
	}

	public void ReplaceModel(int index, int id)
	{
		SetCameraByPosition(GetAreaIndexByPointId(index));
		ResetModel(index, id);
	}

	public void ResetModel(int index, int id)
	{
		if (m_ModelDic.TryGetValue(index, out var value))
		{
			if (value != 0)
			{
				m_ModelDic.Remove(index);
				if (AssetLoadHandleExtensions.IsValid(m_Handles[index]))
				{
					AssetStationManager.BattleStation.ReleaseInstance(m_Handles[index]);
				}
			}
			if (id != 0)
			{
				ShowCharacterModel(index, id, irreplaceable: true);
			}
		}
		else if (id != 0)
		{
			ShowCharacterModel(index, id, irreplaceable: true);
		}
	}

	public void ShowTempDimModel(int index, int id)
	{
		if (m_ModelDic.TryGetValue(index, out var value))
		{
			if (value != id)
			{
				m_ModelDic.Remove(index);
				if (AssetLoadHandleExtensions.IsValid(m_Handles[index]))
				{
					AssetStationManager.BattleStation.ReleaseInstance(m_Handles[index]);
				}
				if (id != 0)
				{
					ShowTempCharacterModel(index, id);
				}
			}
		}
		else if (id != 0)
		{
			ShowTempCharacterModel(index, id);
		}
	}

	public void RemoveTempDimModel(int index, int id)
	{
		if (m_ModelDic.TryGetValue(index, out var value) && id == value)
		{
			m_ModelDic.Remove(index);
			if (AssetLoadHandleExtensions.IsValid(m_Handles[index]))
			{
				AssetStationManager.BattleStation.ReleaseInstance(m_Handles[index]);
			}
		}
	}

	public bool TryGetCharacterPointOffset(int characterId, int pointId, out CharacterPointOffset offset)
	{
		offset = CharacterPointOffset.Zero;
		LoungeConfig loungeConfig = Singleton<LoungeSystemManager>.instance?.loungeConfig;
		if (loungeConfig != null)
		{
			return loungeConfig.TryGetCharacterPointOffset(characterId, pointId, out offset);
		}
		return false;
	}

	public void SetCharacterPointOffset(int characterId, int pointId, CharacterPointOffset offset)
	{
		LoungeConfig loungeConfig = Singleton<LoungeSystemManager>.instance?.loungeConfig;
		if (loungeConfig == null)
		{
			Debug.LogWarning("[LoungeUIScene] 未找到 LoungeConfig，无法保存点位偏移");
		}
		else
		{
			loungeConfig.SetCharacterPointOffset(characterId, pointId, offset);
		}
	}

	private void ApplyCharacterPointOffset(GameObject model, int characterId, int pointId)
	{
		if (!(model == null) && TryGetCharacterPointOffset(characterId, pointId, out var offset))
		{
			model.transform.localPosition += offset.positionOffset;
			model.transform.localRotation *= Quaternion.Euler(offset.rotationOffset);
		}
	}

	private bool IsCurrentModelLoad(int index, int characterId, AssetLoadHandle handle)
	{
		if (m_Handles.TryGetValue(index, out var value) && value == handle && m_ModelDic.TryGetValue(index, out var value2))
		{
			return value2 == characterId;
		}
		return false;
	}

	private void ModelCompleted(GameObject obj, int characterId, bool irreplaceable = false)
	{
		int key = Model<LoungeModel>.Interface.CharacterToIndex[characterId];
		LoungePoint loungePoint = Model<LoungeModel>.Interface.IndexToCharacter[key];
		(Dictionary<string, AnimationClip>, CharacterIdel) randomCharcterAnimClip = LoungeUtility.GetRandomCharcterAnimClip(characterId, loungePoint.id);
		Dictionary<string, AnimationClip> item = randomCharcterAnimClip.Item1;
		CharacterIdel item2 = randomCharcterAnimClip.Item2;
		EntityCharacterData data = ACT.Core.CoreUtils.GetData(characterId, RuntimeConfigs.data.entityCharacterDatas);
		AssetLoadHandle assetLoadHandle = AssetStationManager.BattleStation.Load<RuntimeAnimatorController>(GetAnimationPath(characterId));
		if (assetLoadHandle.IsValid && assetLoadHandle.Result is RuntimeAnimatorController runtimeAnimatorController)
		{
			Animator animator = obj.GetComponentInChildren<Animator>();
			animator.runtimeAnimatorController = runtimeAnimatorController;
			if (item2 != null && !string.IsNullOrEmpty(item2.extraClip))
			{
				EntityCharacterData data2 = ACT.Core.CoreUtils.GetData(characterId, RuntimeConfigs.data.entityCharacterDatas);
				string assetID = $"{data2.config}_{item2.extraClip}";
				string clipPath = string.Format("{0}@{1}_{2}", data2.config, item2.address, "Props");
				AssetLoadHandle handle = AssetStationManager.BattleStation.InstantiateAsync(assetID, obj.transform);
				handle.Completed += (AssetLoadHandle result) =>
				{
					GameObject gameObject = result.AsGameObject();
					gameObject.transform.localPosition = Vector3.zero;
					Animator animator2 = gameObject.GetComponent<Animator>();
					if (animator2 == null)
					{
						animator2 = gameObject.AddComponent<Animator>();
					}
					AssetLoadHandle value = AssetStationManager.BattleStation.Load<AnimationClip>(clipPath);
					if (value.IsValid && value.Result is AnimationClip clip)
					{
						gameObject.AddComponent<LoungePlayable>().Bind(animator, animator2, clip);
						if (!m_SpecialIdle.ContainsKey(characterId))
						{
							m_SpecialIdle.Add(characterId, new Dictionary<AssetLoadHandle, AssetLoadHandle>());
							m_SpecialIdle[characterId].Add(handle, value);
						}
					}
				};
			}
			if (item != null && item.Count > 0)
			{
				AnimatorOverrideController animatorOverrideController = new AnimatorOverrideController(runtimeAnimatorController);
				foreach (KeyValuePair<string, AnimationClip> item3 in item)
				{
					int num = Animator.StringToHash(item3.Key);
					if (animator.HasState(0, num))
					{
						animator.Play(num, 0, 0f);
						animator.Update(0f);
						AnimatorClipInfo[] currentAnimatorClipInfo = animator.GetCurrentAnimatorClipInfo(0);
						if (currentAnimatorClipInfo.Length != 0)
						{
							animatorOverrideController[currentAnimatorClipInfo[0].clip] = item3.Value;
						}
					}
				}
				animator.runtimeAnimatorController = animatorOverrideController;
			}
			SetCharacterAnimState(obj, "LoungeIdle");
		}
		obj.name = $"Character_{characterId}";
		obj.layer = LayerMask.NameToLayer("Entity");
		CapsuleCollider capsuleCollider;
		if (obj.transform.GetChild(0) != null && obj.transform.GetChild(0).Find("Bip001") != null)
		{
			capsuleCollider = obj.transform.GetChild(0).Find("Bip001").gameObject.AddComponent<CapsuleCollider>();
			capsuleCollider.direction = 2;
		}
		else
		{
			capsuleCollider = obj.AddComponent<CapsuleCollider>();
			capsuleCollider.center = new Vector3(0f, data.characterHeight / 2f, 0f);
		}
		Renderer[] componentsInChildren = obj.GetComponentsInChildren<Renderer>(includeInactive: true);
		for (int num2 = 0; num2 < componentsInChildren.Length; num2++)
		{
			componentsInChildren[num2].renderingLayerMask |= 161u;
		}
		capsuleCollider.radius = 0.3f;
		capsuleCollider.height = data.characterHeight;
		Singleton<LoungeSystemManager>.instance.CharacterManager.GetCharacterData(characterId).Irreplaceable = irreplaceable;
		Singleton<LoungeSystemManager>.instance.CharacterManager.AddCharacterGo(characterId, obj);
		obj.transform.localPosition = Vector3.zero;
		obj.transform.localRotation = Quaternion.identity;
		ApplyCharacterPointOffset(obj, characterId, loungePoint.id);
		LoungeMainView loungeMainView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_LOUNGEMAIN) as LoungeMainView;
		if (loungeMainView != null)
		{
			loungeMainView.RegisterPointHud(loungePoint, obj.transform);
		}
		Transform transform = obj.transform.Find("Bip001/charLight");
		if (transform != null)
		{
			transform.gameObject.SetActive(value: false);
		}
		obj.GetComponent<AniPartControl>()?.PlayVisible(AniPartControl.PartType.SystemDither, 0f, default, null, reset: true);
		obj.GetComponent<AniPartControl>()?.PlayHidden(AniPartControl.PartType.SystemWeaponDither, 0f, default, null, reset: true);
		obj.GetComponent<MonoEntityConfig>()?.SetRenderLayerToCharacterUIScene();
	}

	private void TempModelCompleted(GameObject obj, int characterId)
	{
		SetCharacterAnimState(obj, "LoungeIdle");
		obj.name = $"Character_{characterId}";
		CapsuleCollider capsuleCollider = obj.AddComponent<CapsuleCollider>();
		EntityCharacterData data = ACT.Core.CoreUtils.GetData(characterId, RuntimeConfigs.data.entityCharacterDatas);
		AssetLoadHandle assetLoadHandle = AssetStationManager.BattleStation.Load<RuntimeAnimatorController>(GetAnimationPath(characterId));
		if (assetLoadHandle.IsValid && assetLoadHandle.Result is RuntimeAnimatorController runtimeAnimatorController)
		{
			obj.GetComponentInChildren<Animator>().runtimeAnimatorController = runtimeAnimatorController;
			SetCharacterAnimState(obj, "LoungeIdle");
		}
		capsuleCollider.radius = 0.25f;
		capsuleCollider.center = new Vector3(0f, data.characterHeight / 2f, 0f);
		capsuleCollider.height = data.characterHeight;
		obj.transform.localPosition = Vector3.zero;
		Dissolve2Control component = obj.GetComponent<Dissolve2Control>();
		if (component != null)
		{
			component._DitherValue = 0.45f;
		}
		_pendingClickObject = obj;
		Renderer[] componentsInChildren = obj.GetComponentsInChildren<Renderer>(includeInactive: true);
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			componentsInChildren[i].renderingLayerMask |= 161u;
		}
		Transform transform = obj.transform.Find("Bip001/charLight");
		if (transform != null)
		{
			transform.gameObject.SetActive(value: false);
		}
		obj.GetComponent<AniPartControl>()?.PlayVisible(AniPartControl.PartType.SystemDither, 0f, default, null, reset: true);
		obj.GetComponent<AniPartControl>()?.PlayHidden(AniPartControl.PartType.SystemWeaponDither, 0f, default, null, reset: true);
	}

	private string GetModelPath(int characterId)
	{
		int skinId = CharacterSkinRuntimeUtility.ResolveSkinId(characterId);
		return CharacterSkinRuntimeUtility.GetModelPath(characterId, skinId, CharacterModelUsage.Lounge);
	}

	private string GetAnimationPath(int characterId)
	{
		return CharacterSkinRuntimeUtility.GetAnimatorAssetId(CharacterSkinRuntimeUtility.ResolveSkinId(characterId), CharacterModelUsage.Lounge);
	}

	private void GlobalStoryModelCompleted(GameObject obj, int characterId, int dramaId)
	{
		SetCharacterAnimState(obj, "LoungeIdle");
		obj.name = $"Character_{characterId}";
		obj.layer = LayerMask.NameToLayer("Entity");
		CapsuleCollider capsuleCollider = obj.AddComponent<CapsuleCollider>();
		EntityCharacterData data = ACT.Core.CoreUtils.GetData(characterId, RuntimeConfigs.data.entityCharacterDatas);
		capsuleCollider.radius = 0.25f;
		capsuleCollider.center = new Vector3(0f, data.characterHeight / 2f, 0f);
		GameObject globalStoryTimelineGo = Singleton<LoungeSystemManager>.instance.InteractionManager.GetGlobalStoryTimelineGo(dramaId);
		var (localPosition, localRotation) = GetTimelineBindingPosAndRot(globalStoryTimelineGo, "Animation Track", obj);
		obj.transform.localPosition = localPosition;
		obj.transform.localRotation = localRotation;
		Singleton<LoungeSystemManager>.instance.CharacterManager.AddCharacterGo(characterId, obj);
		capsuleCollider.height = data.characterHeight;
		Transform transform = obj.transform.Find("Bip001/charLight");
		if (transform != null)
		{
			transform.gameObject.SetActive(value: false);
		}
		GameObject globalStoryTimelineGo2 = Singleton<LoungeSystemManager>.instance.InteractionManager.GetGlobalStoryTimelineGo(dramaId);
		if ((bool)globalStoryTimelineGo2)
		{
			PlayableDirector component = globalStoryTimelineGo2.GetComponent<PlayableDirector>();
			MonoTimelineConfig component2 = globalStoryTimelineGo2.GetComponent<MonoTimelineConfig>();
			if (component2.timelineConfig.useNewAssetsBindings)
			{
				TimelineTrackBinding.SetTrackBinding(component, component2.timelineConfig.newAssetsBindings);
			}
			else
			{
				OldTimelineTrackBinding.SetTrackBinding(component, component2.timelineConfig.assetsBindings);
			}
		}
	}

	public void ShowGlobalStoryCharacterModel(int dramaId, int[] characterIds, Transform characterRoot)
	{
		if (m_TriggerGlobalStoryModels.ContainsKey(dramaId))
		{
			return;
		}
		m_TriggerGlobalStoryModels.Add(dramaId, new Dictionary<int, AssetLoadHandle>());
		foreach (int characterId in characterIds)
		{
			string model = RuntimeConfigs.data.dialogueCharacterDatas[characterId].model;
			m_TriggerGlobalStoryModels[dramaId].Add(characterId, AssetStationManager.BattleStation.InstantiateAsync(model, characterRoot));
			AssetLoadHandle assetLoadHandle = m_TriggerGlobalStoryModels[dramaId][characterId];
			assetLoadHandle.Completed += (AssetLoadHandle result) =>
			{
				GlobalStoryModelCompleted(result.AsGameObject(), characterId, dramaId);
			};
		}
	}

	public void ShowGlobalStoryCharacterModel(int dramaId, int[] characterIds)
	{
		if (m_TriggerGlobalStoryModels.ContainsKey(dramaId) || characterIds.Length == 0)
		{
			return;
		}
		m_TriggerGlobalStoryModels.Add(dramaId, new Dictionary<int, AssetLoadHandle>());
		foreach (int characterId in characterIds)
		{
			string model = RuntimeConfigs.data.dialogueCharacterDatas[characterId].model;
			m_TriggerGlobalStoryModels[dramaId].Add(characterId, AssetStationManager.BattleStation.InstantiateAsync(model, s_Instance.gameObject.transform));
			AssetLoadHandle assetLoadHandle = m_TriggerGlobalStoryModels[dramaId][characterId];
			assetLoadHandle.Completed += (AssetLoadHandle result) =>
			{
				GlobalStoryModelCompleted(result.AsGameObject(), characterId, dramaId);
			};
		}
	}

	public (Vector3, Quaternion) GetTimelineBindingPosAndRot(GameObject timelineGo, string trackName, GameObject characterGo)
	{
		var (vector, item) = LoungeTimelinePositionHelper.GetTrackClipInitialPose(timelineGo.GetComponent<PlayableDirector>(), trackName, characterGo);
		Debug.Log($"角色初始位置: {vector}, 旋转: {item.eulerAngles}");
		return (vector, item);
	}

	public void RemoveGlobalStoryCharacterModel(int dramaId)
	{
		if (!m_TriggerGlobalStoryModels.TryGetValue(dramaId, out var value))
		{
			return;
		}
		foreach (KeyValuePair<int, AssetLoadHandle> item in value)
		{
			if (item.Value.IsValid)
			{
				Singleton<LoungeSystemManager>.instance.CharacterManager.RemoveCharacterGo(item.Key);
				AssetStationManager.BattleStation.ReleaseInstance(item.Value);
			}
		}
		m_TriggerGlobalStoryModels.Remove(dramaId);
	}

	public void RemoveGlobalStoryCharacterModel()
	{
		foreach (Dictionary<int, AssetLoadHandle> value in m_TriggerGlobalStoryModels.Values)
		{
			foreach (AssetLoadHandle value2 in value.Values)
			{
				if (value2.IsValid)
				{
					AssetStationManager.BattleStation.ReleaseInstance(value2);
				}
			}
		}
		m_TriggerGlobalStoryModels.Clear();
	}

	public void RefreshMainViewInfo()
	{
		LoungeMainView loungeMainView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_LOUNGEMAIN) as LoungeMainView;
		if (loungeMainView != null)
		{
			loungeMainView.RefreshRoomAreaInfo(Singleton<LoungeSystemManager>.instance.CurRoomIndex);
			loungeMainView.RefreshHudsFromModel(-1, Singleton<LoungeSystemManager>.instance.CurRoomIndex);
		}
	}

	public void ReleaseModel(int index)
	{
		if (AssetLoadHandleExtensions.IsValid(m_Handles[index]))
		{
			AssetStationManager.BattleStation.ReleaseInstance(m_Handles[index]);
		}
		m_ModelDic.Remove(index);
	}

	public void ReleaseAll()
	{
		foreach (AssetLoadHandle value in m_Handles.Values)
		{
			if (AssetLoadHandleExtensions.IsValid(value))
			{
				AssetStationManager.BattleStation.ReleaseInstance(value);
			}
		}
		foreach (Dictionary<AssetLoadHandle, AssetLoadHandle> value2 in m_SpecialIdle.Values)
		{
			foreach (KeyValuePair<AssetLoadHandle, AssetLoadHandle> item in value2)
			{
				if (AssetLoadHandleExtensions.IsValid(item.Key) && AssetLoadHandleExtensions.IsValid(item.Value))
				{
					AssetStationManager.BattleStation.ReleaseInstance(item.Key);
					AssetStationManager.BattleStation.ReleaseInstance(item.Value);
				}
			}
		}
		RemoveGlobalStoryCharacterModel();
		m_Handles.Clear();
		m_ModelDic.Clear();
	}

	public void ReleaseCharacterModel()
	{
		Singleton<LoungeSystemManager>.instance.CharacterManager.ClearCharacterGo();
	}

	public bool SetSelectedCharacterAnimState(string stateName, float transitionDuration = 0.25f, int layer = 0)
	{
		if (curSelectCharacterId < 0)
		{
			Debug.LogWarning("当前没有选中的角色，无法切换动画状态");
			return false;
		}
		return SetCharacterAnimState(curSelectCharacterId, stateName, transitionDuration, layer);
	}

	public GameObject GetCurSelectModel()
	{
		if (curSelectCharacterId < 0)
		{
			Debug.LogWarning("当前没有选中的角色，无法切换动画状态");
			return null;
		}
		return Singleton<LoungeSystemManager>.instance.CharacterManager.GetCharacterGo(curSelectCharacterId);
	}

	public bool SetCharacterAnimState(int characterId, string stateName, float transitionDuration = 0.25f, int layer = 0)
	{
		GameObject characterGo = Singleton<LoungeSystemManager>.instance.CharacterManager.GetCharacterGo(characterId);
		if (characterGo == null)
		{
			Debug.LogWarning($"角色 {characterId} 的GameObject不存在，无法切换动画状态");
			return false;
		}
		Animator componentInChildren = characterGo.GetComponentInChildren<Animator>();
		if (componentInChildren == null)
		{
			Debug.LogWarning($"角色 {characterId} 没有Animator组件，无法切换动画状态");
			return false;
		}
		int num = Animator.StringToHash(stateName);
		if (!componentInChildren.HasState(layer, num))
		{
			Debug.LogWarning($"角色 {characterId} 的Animator中不存在状态 \"{stateName}\" (Layer={layer})");
			return false;
		}
		if (transitionDuration > 0f)
		{
			componentInChildren.CrossFadeInFixedTime(num, transitionDuration, layer);
		}
		else
		{
			componentInChildren.Play(num, layer);
		}
		Debug.Log($"<color=green>角色 {characterId} 切换动画状态: {stateName} (Layer={layer}, Transition={transitionDuration}s)</color>");
		return true;
	}

	public bool SetCharacterAnimState(GameObject characterGo, string stateName, float transitionDuration = 0.25f, int layer = 0)
	{
		if (characterGo == null)
		{
			Debug.LogWarning("角色 characterGo 的GameObject不存在，无法切换动画状态");
			return false;
		}
		Animator componentInChildren = characterGo.GetComponentInChildren<Animator>();
		if (componentInChildren == null)
		{
			Debug.LogWarning("角色characterGo 没有Animator组件，无法切换动画状态");
			return false;
		}
		int num = Animator.StringToHash(stateName);
		if (!componentInChildren.HasState(layer, num))
		{
			Debug.LogWarning($"角色的Animator中不存在状态 \"{stateName}\" (Layer={layer})");
			return false;
		}
		if (transitionDuration > 0f)
		{
			componentInChildren.CrossFadeInFixedTime(num, transitionDuration, layer);
		}
		else
		{
			componentInChildren.Play(num, layer);
		}
		return true;
	}

	public AnimatorStateInfo? GetCharacterAnimStateInfo(int characterId, int layer = 0)
	{
		GameObject characterGo = Singleton<LoungeSystemManager>.instance.CharacterManager.GetCharacterGo(characterId);
		if (characterGo == null)
		{
			return null;
		}
		Animator componentInChildren = characterGo.GetComponentInChildren<Animator>();
		if (componentInChildren == null)
		{
			return null;
		}
		return componentInChildren.GetCurrentAnimatorStateInfo(layer);
	}

	public float GetCharacterAnimClipLength(int characterId, int layer = 0)
	{
		GameObject characterGo = Singleton<LoungeSystemManager>.instance.CharacterManager.GetCharacterGo(characterId);
		if (characterGo == null)
		{
			return 0f;
		}
		Animator componentInChildren = characterGo.GetComponentInChildren<Animator>();
		if (componentInChildren == null)
		{
			return 0f;
		}
		if (componentInChildren.IsInTransition(layer))
		{
			AnimatorClipInfo[] nextAnimatorClipInfo = componentInChildren.GetNextAnimatorClipInfo(layer);
			if (nextAnimatorClipInfo.Length != 0)
			{
				return nextAnimatorClipInfo[0].clip.length;
			}
		}
		AnimatorClipInfo[] currentAnimatorClipInfo = componentInChildren.GetCurrentAnimatorClipInfo(layer);
		if (currentAnimatorClipInfo.Length != 0)
		{
			return currentAnimatorClipInfo[0].clip.length;
		}
		return 0f;
	}

	public void ShowFurnitureModel(Transform trans, string path)
	{
		_modelCts.Cancel();
		_modelCts = new CancellationTokenSource();
		_furnitureLoadStation.LoadAsset(path, (GameObject result) =>
		{
			UnityEngine.Object.Instantiate(result, trans);
		});
	}

	private void InitializeCameras()
	{
		m_CurrentCamera = ((virtualCameras != null && virtualCameras.Count > 0) ? virtualCameras[0] : normalCamera);
		if (virtualCameras != null)
		{
			for (int i = 0; i < virtualCameras.Count; i++)
			{
				if (virtualCameras[i] != null)
				{
					virtualCameras[i].Priority = ((i == 0) ? activeCameraPriority : defaultCameraPriority);
				}
			}
		}
		if (normalCamera != null)
		{
			normalCamera.Priority = defaultCameraPriority;
		}
		if (nearCamera != null)
		{
			nearCamera.Priority = defaultCameraPriority;
		}
		SetupCameraMapping();
		InitDepthOfField();
		SubscribeEvents();
		ResetCamera();
		Debug.Log("<color=cyan>相机系统初始化完成，当前相机: " + m_CurrentCamera?.name + "</color>");
	}

	private void SetupCameraMapping()
	{
		if (virtualCameras.Count == ModelsPointPosGroup.Count)
		{
			for (int i = 0; i < virtualCameras.Count; i++)
			{
				SetCameraPositionMapping(i + 1, i);
			}
		}
	}

	private void SubscribeEvents()
	{
	}

	private IEnumerator WaitForCameraBlend(int cameraIndex, float blendTime)
	{
		yield return new WaitForSeconds(blendTime);
		isBlend = false;
		_loungeMainView?.OnCameraTransitionEnded();
		OnCameraBlendFinished?.Invoke(cameraIndex);
		Debug.Log($"<color=cyan>相机 {cameraIndex} 混合完成</color>");
		_cameraBlendCoroutine = null;
		if (m_CurrentCameraBrain != null)
		{
			m_CurrentCameraBrain.m_DefaultBlend.m_Style = CinemachineBlendDefinition.Style.Cut;
		}
	}

	private IEnumerator WaitForNearCameraBlend(float blendTime, int characterId)
	{
		SetCharacterAnimState(characterId, "LoungeTurnToInteract", 1f);
		yield return null;
		float num = GetCharacterAnimClipLength(characterId);
		if (num <= 0f)
		{
			num = blendTime;
		}
		m_CurrentCameraBrain.m_DefaultBlend.m_Style = CinemachineBlendDefinition.Style.EaseInOut;
		m_CurrentCameraBrain.m_DefaultBlend.m_Time = num * 0.7f;
		dofTransitionDuration = num * 0.7f;
		EnableDepthOfField(nearDistance);
		nearCamera.Priority = activeCameraPriority;
		m_PreviousCamera = m_CurrentCamera;
		m_CurrentCamera = nearCamera;
		yield return new WaitForSeconds(num);
		int key = Model<LoungeModel>.Interface.CharacterToIndex[characterId];
		int arg = ((Model<LoungeModel>.Interface.IndexToCharacter[key] != null) ? Model<LoungeModel>.Interface.IndexToCharacter[key].id : 0);
		isBlend = false;
		_loungeMainView?.OnCameraTransitionEnded();
		OnNearCameraBlendFinished?.Invoke(characterId, arg);
		SetCharacterAnimState(characterId, "LoungeEnterInteract");
		Debug.Log("<color=green>切换到近距离相机</color>");
		OnCameraChanged?.Invoke(GetCurrentCameraIndex(), -2);
		m_CurrentCameraBrain.m_DefaultBlend.m_Style = CinemachineBlendDefinition.Style.Cut;
		_cameraBlendCoroutine = null;
	}

	private IEnumerator ReturnToPreviousCameraAfterDelay(float delay)
	{
		yield return new WaitForSeconds(delay);
		SetPreviousCamera();
	}

	private void InitDepthOfField()
	{
		if (dofVolume != null && dofVolume.profile.TryGet<DepthOfField>(out var component))
		{
			_dofComponent = component;
			_dofComponent.active = false;
		}
	}

	public void EnableDepthOfField(float distance)
	{
		if (_dofComponent == null || dofVolume == null || _pendingClickCharacterId == 0)
		{
			return;
		}
		_ = distance;
		_dofComponent.active = true;
		_dofComponent.mode.Override(DepthOfFieldMode.Gaussian);
		_dofComponent.gaussianMaxRadius.value = 0.8f;
		_dofComponent.highQualitySampling.Override(x: true);
		_dofComponent.gaussianStart.value = 12.5f;
		_dofComponent.gaussianEnd.value = 30f;
		_dofTween?.Kill();
		_dofTween = DOTween.To(() => 0f, (float x) =>
		{
			_dofComponent.gaussianMaxRadius.value = x;
		}, dofAperture, dofTransitionDuration).SetEase(Ease.OutQuad).OnComplete(() =>
		{
			float endValue = distance;
			float endValue2 = distance * 1.5f;
			_dofFocusTween?.Kill();
			_dofFocusTween = DOTween.Sequence().Join(DOTween.To(() => _dofComponent.gaussianStart.value, (float x) =>
			{
				_dofComponent.gaussianStart.value = x;
			}, endValue, 0.25f)).Join(DOTween.To(() => _dofComponent.gaussianEnd.value, (float x) =>
			{
				_dofComponent.gaussianEnd.value = x;
			}, endValue2, 0.25f))
				.SetEase(Ease.OutQuad);
		});
	}

	public void DisableDepthOfField()
	{
		if (!(_dofComponent == null) && !(dofVolume == null))
		{
			_dofTween?.Kill();
			_dofFocusTween?.Kill();
			if (_dofComponent != null)
			{
				_dofComponent.gaussianMaxRadius.value = 0.5f;
				_dofComponent.gaussianEnd.value = 30f;
				_dofComponent.gaussianStart.value = 12.5f;
				_dofComponent.active = false;
			}
		}
	}

	public void ResetIdleTimer()
	{
		_lastInputTime = Time.time;
		if (_isIdleMode)
		{
			ExitIdleMode();
		}
	}

	private List<int> GetRoomsWithCharacters()
	{
		List<int> list = new List<int>();
		foreach (KeyValuePair<int, Dictionary<int, Transform>> item in ModelsPointPosGroup)
		{
			foreach (KeyValuePair<int, Transform> item2 in item.Value)
			{
				if (m_ModelDic.ContainsKey(item2.Key) && m_ModelDic[item2.Key] != 0)
				{
					list.Add(item.Key);
					break;
				}
			}
		}
		return list;
	}

	private void EnterIdleMode()
	{
		if (_isIdleMode)
		{
			return;
		}
		_isIdleMode = true;
		_areasWithCharacters.Clear();
		foreach (int roomsWithCharacter in GetRoomsWithCharacters())
		{
			if (cameraTimelines != null && cameraTimelines.TryGetValue(roomsWithCharacter, out var value) && value != null)
			{
				_areasWithCharacters.Add(roomsWithCharacter);
			}
		}
		OnEnterIdleMode?.Invoke();
		if (_areasWithCharacters.Count != 0)
		{
			_currentAutoAreaIdx = 0;
			_autoCameraCoroutine = StartCoroutine(AutoCameraCycle());
		}
	}

	private void ExitIdleMode()
	{
		if (_isIdleMode)
		{
			_isIdleMode = false;
			if (m_CurrentCameraBrain != null)
			{
				m_CurrentCameraBrain.enabled = true;
			}
			if (_autoCameraCoroutine != null)
			{
				StopCoroutine(_autoCameraCoroutine);
				_autoCameraCoroutine = null;
			}
			StopAllCameraTimelines();
			OnExitIdleMode?.Invoke();
		}
	}

	private void StopAllCameraTimelines()
	{
		if (cameraTimelines == null)
		{
			return;
		}
		foreach (PlayableDirector value in cameraTimelines.Values)
		{
			if (value != null && value.state == UnityEngine.Playables.PlayState.Playing)
			{
				value.Stop();
				value.gameObject.SetActive(value: false);
			}
		}
	}

	private IEnumerator AutoCameraCycle()
	{
		while (_isIdleMode && _areasWithCharacters.Count > 0)
		{
			int key = _areasWithCharacters[_currentAutoAreaIdx];
			if (cameraTimelines.TryGetValue(key, out var timeline) && timeline != null)
			{
				if (_cameraIndexMap.TryGetValue(key, out var value))
				{
					SetCamera(value);
				}
				timeline.gameObject.SetActive(value: true);
				timeline.time = 0.0;
				timeline.Play();
				float elapsed = 0f;
				while (elapsed < perAreaDuration && _isIdleMode)
				{
					elapsed += Time.deltaTime;
					yield return null;
				}
				timeline.Stop();
				timeline.gameObject.SetActive(value: false);
			}
			else
			{
				yield return null;
			}
			_currentAutoAreaIdx = (_currentAutoAreaIdx + 1) % _areasWithCharacters.Count;
			timeline = null;
		}
		_autoCameraCoroutine = null;
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		ResetIdleTimer();
		_isPointerDown = true;
		_pointerDownPosition = eventData.position;
		_pointerDownTime = Time.time;
		_pendingClickCharacterId = -1;
		_pendingClickObject = null;
		TryRaycastCharacter(eventData.position, out _pendingClickCharacterId, out _pendingClickObject);
		if (curSelectCharacterId == _pendingClickCharacterId)
		{
			_pendingClickCharacterId = -1;
		}
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		if (!_isPointerDown)
		{
			return;
		}
		_isPointerDown = false;
		if (Vector2.Distance(_pointerDownPosition, eventData.position) > clickThreshold)
		{
			ResetClickState();
			return;
		}
		_ = Time.time - _pointerDownTime;
		_ = longPressTime;
		if (_pendingClickCharacterId >= 0 && _pendingClickObject != null)
		{
			curSelectCharacterId = _pendingClickCharacterId;
			if (m_TriggerGlobalStoryModels.Count > 0)
			{
				foreach (KeyValuePair<int, Dictionary<int, AssetLoadHandle>> triggerGlobalStoryModel in m_TriggerGlobalStoryModels)
				{
					if (triggerGlobalStoryModel.Value.ContainsKey(curSelectCharacterId))
					{
						Singleton<LoungeSystemManager>.instance.TriggerCharacterStory(0, Singleton<LoungeSystemManager>.instance.InteractionManager.GetGlobalStoryTimelineIndex(triggerGlobalStoryModel.Key));
						ResetClickState();
						curSelectCharacterId = -1;
						return;
					}
				}
			}
			int key = Model<LoungeModel>.Interface.CharacterToIndex[_pendingClickCharacterId];
			LoungePoint arg = ((Model<LoungeModel>.Interface.IndexToCharacter[key] != null) ? Model<LoungeModel>.Interface.IndexToCharacter[key] : null);
			OnCharacterClicked?.Invoke(_pendingClickCharacterId, arg, _pendingClickObject);
			Debug.Log($"<color=green>点击角色: ID={_pendingClickCharacterId}, Name={_pendingClickObject.name}</color>");
			int characterPositionIndex = GetCharacterPositionIndex(_pendingClickCharacterId);
			if (characterPositionIndex >= 0)
			{
				float heightOffset = ACT.Core.CoreUtils.GetData(_pendingClickCharacterId, RuntimeConfigs.data.entityCharacterDatas).characterHeight * 0.8f;
				FocusOnCharacter(characterPositionIndex, useNearCamera: true, nearDistance, heightOffset);
			}
		}
		else if (_pendingClickObject == null)
		{
			ResetToEmptyState();
			Debug.Log("<color=gray>点击空白区域</color>");
			return;
		}
		ResetClickState();
	}

	public void ResetToEmptyState()
	{
		DisableDepthOfField();
		if (curSelectCharacterId > 0)
		{
			int key = Model<LoungeModel>.Interface.CharacterToIndex[curSelectCharacterId];
			LoungePoint loungePoint = Model<LoungeModel>.Interface.IndexToCharacter[key];
			SetCameraByPosition(GetAreaIndexByPointId(loungePoint.id));
			curSelectCharacterId = -1;
		}
		ResetClickState();
		OnEmptyAreaClicked?.Invoke();
	}

	public void FocusOnCharacter(int characterId)
	{
		int characterPositionIndex = GetCharacterPositionIndex(characterId);
		if (characterPositionIndex >= 0)
		{
			float heightOffset = ACT.Core.CoreUtils.GetData(characterId, RuntimeConfigs.data.entityCharacterDatas).characterHeight * 0.8f;
			FocusOnCharacter(characterPositionIndex, useNearCamera: true, nearDistance, heightOffset);
		}
	}

	public bool TrySelectCharacterForInteraction(int characterId)
	{
		if (isBlend || characterId < 0)
		{
			return false;
		}
		if (m_TriggerGlobalStoryModels.Count > 0)
		{
			foreach (KeyValuePair<int, Dictionary<int, AssetLoadHandle>> triggerGlobalStoryModel in m_TriggerGlobalStoryModels)
			{
				if (triggerGlobalStoryModel.Value.ContainsKey(characterId))
				{
					Singleton<LoungeSystemManager>.instance.TriggerCharacterStory(0, Singleton<LoungeSystemManager>.instance.InteractionManager.GetGlobalStoryTimelineIndex(triggerGlobalStoryModel.Key));
					ResetClickState();
					curSelectCharacterId = -1;
					return true;
				}
			}
		}
		_pendingClickCharacterId = characterId;
		_pendingClickObject = Singleton<LoungeSystemManager>.instance.CharacterManager.GetCharacterGo(characterId);
		if (_pendingClickObject == null)
		{
			Debug.LogWarning($"[LoungeUIScene] 手柄聚焦失败，未找到角色对象: {characterId}");
			return false;
		}
		curSelectCharacterId = characterId;
		int characterPositionIndex = GetCharacterPositionIndex(characterId);
		if (characterPositionIndex < 0)
		{
			return false;
		}
		float heightOffset = ACT.Core.CoreUtils.GetData(characterId, RuntimeConfigs.data.entityCharacterDatas).characterHeight * 0.8f;
		FocusOnCharacter(characterPositionIndex, useNearCamera: true, nearDistance, heightOffset);
		return true;
	}

	private bool TryRaycastCharacter(Vector2 screenPosition, out int characterId, out GameObject hitObject)
	{
		characterId = -1;
		hitObject = null;
		Camera camera = uiSceneCamera;
		if (camera == null)
		{
			return false;
		}
		if (Physics.Raycast(camera.ScreenPointToRay(screenPosition), out var hitInfo, raycastMaxDistance, characterLayerMask))
		{
			hitObject = hitInfo.collider.gameObject;
			characterId = FindCharacterIdFromGameObject(hitObject);
			if (characterId < 0)
			{
				Transform root = hitObject.transform.root;
				characterId = FindCharacterIdFromGameObject(root.gameObject);
			}
			if (characterId >= 0)
			{
				hitObject = Singleton<LoungeSystemManager>.instance.CharacterManager.GetCharacterGo(characterId);
			}
			return characterId >= 0;
		}
		return false;
	}

	private int FindCharacterIdFromGameObject(GameObject obj)
	{
		if (obj == null)
		{
			return -1;
		}
		Dictionary<int, GameObject> characterGoDic = Singleton<LoungeSystemManager>.instance.CharacterManager.GetCharacterGoDic();
		if (characterGoDic != null)
		{
			foreach (KeyValuePair<int, GameObject> item in characterGoDic)
			{
				if (item.Value == obj || IsChildOf(obj.transform, item.Value.transform))
				{
					return item.Key;
				}
			}
		}
		foreach (KeyValuePair<int, int> item2 in m_ModelDic)
		{
			int key = item2.Key;
			int value = item2.Value;
			foreach (Dictionary<int, Transform> value3 in ModelsPointPosGroup.Values)
			{
				if (value3.TryGetValue(key, out var value2) && IsChildOf(obj.transform, value2))
				{
					return value;
				}
			}
		}
		return -1;
	}

	private bool IsChildOf(Transform child, Transform parent)
	{
		if (child == null || parent == null)
		{
			return false;
		}
		Transform transform = child;
		while (transform != null)
		{
			if (transform == parent)
			{
				return true;
			}
			transform = transform.parent;
		}
		return false;
	}

	private int GetCharacterPositionIndex(int characterId)
	{
		foreach (KeyValuePair<int, int> item in m_ModelDic)
		{
			if (item.Value == characterId)
			{
				return item.Key;
			}
		}
		return -1;
	}

	private int GetCharacterIdByPositionIndex(int index)
	{
		foreach (KeyValuePair<int, int> item in m_ModelDic)
		{
			if (item.Key == index)
			{
				return item.Value;
			}
		}
		return -1;
	}

	private int GetAreaIndexByPointId(int pointId)
	{
		foreach (KeyValuePair<int, Dictionary<int, Transform>> item in ModelsPointPosGroup)
		{
			if (item.Value.ContainsKey(pointId))
			{
				return item.Key;
			}
		}
		return -1;
	}

	private void ResetClickState()
	{
		_pendingClickCharacterId = -1;
		_pendingClickObject = null;
	}

	public int CheckCharacterAtScreenPosition(Vector2 screenPosition)
	{
		if (TryRaycastCharacter(screenPosition, out var characterId, out var _))
		{
			return characterId;
		}
		return -1;
	}

	public bool TryGetCharacterAtScreenPosition(Vector2 screenPosition, out int characterId, out CharacterLoungeData characterData, out GameObject characterObject)
	{
		characterData = null;
		if (TryRaycastCharacter(screenPosition, out characterId, out characterObject))
		{
			characterData = Singleton<LoungeSystemManager>.instance.CharacterManager.GetCharacterData(characterId);
			return characterData != null;
		}
		return false;
	}

	public void RecordExitLiveArea()
	{
		RecordLiveAreaChange(Singleton<LoungeSystemManager>.instance.CurRoomIndex, 0);
	}

	private void RecordLiveAreaChange(int preAreaId, int nextAreaId)
	{
		if (preAreaId >= 0 && nextAreaId >= 0)
		{
			LiveareaSceneChangeEvent evt = EventTrackSolver.Instance.GetEvt<LiveareaSceneChangeEvent>();
			long num = DateTimeOffset.UtcNow.ToUnixTimeMilliseconds();
			evt.exitLiveareaId = preAreaId;
			evt.liveareaId = nextAreaId;
			if (_enterRoomTimestamp == 0.0)
			{
				evt.eventDuration = 0f;
			}
			else
			{
				evt.eventDuration = (float)Math.Round(((double)num - _enterRoomTimestamp) / 1000.0, 2);
			}
			EventTrackSolver.Instance.Dispatch(evt);
			_enterRoomTimestamp = num;
		}
	}
}
