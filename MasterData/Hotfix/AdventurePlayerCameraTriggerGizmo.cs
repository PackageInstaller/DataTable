using Cinemachine;
using UnityEngine;

[AddComponentMenu("Game/Adventure/Gizmo/Player Camera Configure Gizmo")]
public class AdventurePlayerCameraTriggerGizmo : AdventureTriggerGizmo
{
	public enum CameraControlUpdateMode
	{
		Initialize,
		Stack,
		Override
	}

	public enum CameraControlMode
	{
		Default,
		Custom
	}

	public CameraControlUpdateMode updateMode = CameraControlUpdateMode.Stack;

	[Space]
	public bool deactiveOnExitTriggerIfInitializeMode;

	public CameraControlMode cameraControlMode;

	[Space]
	public AdventureCameraControlConfigureData configureData;

	[Space]
	public AdventureCustomCameraControlHandler.CustomCameraType customCameraType;

	protected AdventureCustomCameraControlHandler[] _customCameraControlHandlers;

	public bool canInterrupt = true;

	public int priority;

	public bool dontDestory;

	private bool isInTrigger;

	public bool isCutStype;

	public AdventureCustomCameraControlHandler[] CustomCameraControlHandlers => _customCameraControlHandlers;

	public bool IsInTrigger => isInTrigger;

	protected override void OnInit()
	{
		base.OnInit();
		if (cameraControlMode == CameraControlMode.Custom)
		{
			_customCameraControlHandlers = GetComponentsInChildren<AdventureCustomCameraControlHandler>();
		}
	}

	public override void Initialize()
	{
		if (isCutStype && customCameraType == AdventureCustomCameraControlHandler.CustomCameraType.VirtualCamera && _customCameraControlHandlers != null && _customCameraControlHandlers.Length != 0)
		{
			CinemachineVirtualCamera virtualCamera = _customCameraControlHandlers[0].virtualCamera;
			if (virtualCamera != null)
			{
				SceneSingleton<AdventurePlayerController>.Instance.RegisterVmBlend(virtualCamera);
			}
		}
		if (updateMode == CameraControlUpdateMode.Initialize)
		{
			Active();
		}
	}

	public void Active()
	{
		if (cameraControlMode == CameraControlMode.Default)
		{
			if (updateMode == CameraControlUpdateMode.Initialize)
			{
				SceneSingleton<AdventurePlayerController>.Instance.defaultConfigureData = configureData;
			}
			else
			{
				if (SceneSingleton<AdventurePlayerController>.Instance.overrideConfigureData != null)
				{
					SceneSingleton<AdventurePlayerController>.Instance.lastOverrideConfigureData = SceneSingleton<AdventurePlayerController>.Instance.overrideConfigureData;
				}
				SceneSingleton<AdventurePlayerController>.Instance.overrideConfigureData = configureData;
			}
			configureData.OnActive();
		}
		else if (cameraControlMode == CameraControlMode.Custom && _customCameraControlHandlers != null && _customCameraControlHandlers.Length != 0)
		{
			for (int i = 0; i < _customCameraControlHandlers.Length; i++)
			{
				_customCameraControlHandlers[i].Active();
			}
		}
		isInTrigger = true;
	}

	public void Deactive()
	{
		if (cameraControlMode == CameraControlMode.Default)
		{
			if (updateMode == CameraControlUpdateMode.Initialize)
			{
				if (SceneSingleton<AdventurePlayerController>.Instance.defaultConfigureData == configureData)
				{
					SceneSingleton<AdventurePlayerController>.Instance.defaultConfigureData = null;
				}
			}
			else
			{
				if (SceneSingleton<AdventurePlayerController>.Instance.overrideConfigureData == configureData)
				{
					SceneSingleton<AdventurePlayerController>.Instance.overrideConfigureData = SceneSingleton<AdventurePlayerController>.Instance.lastOverrideConfigureData;
				}
				SceneSingleton<AdventurePlayerController>.Instance.lastOverrideConfigureData = null;
			}
			configureData.OnDeactive();
		}
		else if (cameraControlMode == CameraControlMode.Custom && _customCameraControlHandlers != null && _customCameraControlHandlers.Length != 0)
		{
			for (int i = 0; i < _customCameraControlHandlers.Length; i++)
			{
				_customCameraControlHandlers[i].DeActive();
			}
		}
		isInTrigger = false;
	}

	protected override void TriggerEnter(GameObject playerAgent)
	{
		if (updateMode == CameraControlUpdateMode.Override || updateMode == CameraControlUpdateMode.Stack)
		{
			Active();
		}
	}

	protected override void TriggerStay(GameObject playerAgent)
	{
	}

	protected override void TriggerExit(GameObject playerAgent)
	{
		if ((updateMode == CameraControlUpdateMode.Initialize && deactiveOnExitTriggerIfInitializeMode) || updateMode == CameraControlUpdateMode.Stack)
		{
			Deactive();
		}
	}
}
