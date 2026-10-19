using System;
using ACT.Battle;
using ACT.UI;
using ACT.VolumeControl;
using Bamboo.ECS;
using Bamboo.Precache;
using Cinemachine;
using Cysharp.Threading.Tasks;
using Fundamental;
using Sirenix.Serialization;
using UnityEngine;

namespace ACT.NPC.Actions;

[Serializable]
[AsyncAction]
public class ActionOpenUI : NpcInteractAction
{
	private static readonly int OnEnterInteract = Animator.StringToHash("OnEnterInteract");

	private static readonly int OnLoopInteract = Animator.StringToHash("OnEnterInteractLoop");

	private static readonly int OnExitInteract = Animator.StringToHash("OnExitInteract");

	[OdinSerialize]
	[SerializeField]
	private UI_TYPE uiType;

	[Header("参数配置")]
	[OdinSerialize]
	[SerializeField]
	private int idInfo;

	[Header("UI镜头配置")]
	public bool openCameraEffect;

	public CameraEffectConfig cameraEffectConfig;

	private InstanceHandle _handle;

	public const string GENERIC_STATE_1 = "OnEnterInteract";

	public const string GENERIC_STATE_2 = "OnEnterInteractLoop";

	public const string GENERIC_STATE_3 = "OnExitInteract";

	private CinemachineVirtualCamera _virtualCamera;

	public override int ActionId => NpcInteractActionIds.OpenUI;

	protected virtual bool IsUIConfigurationEditable => true;

	protected virtual UI_TYPE UIType => uiType;

	protected virtual object UIData => idInfo;

	protected override async UniTask DoAction()
	{
		await DoActionInternal();
	}

	private async UniTask DoActionInternal()
	{
		if (openCameraEffect)
		{
			CreateCameraEffect();
			PlayInteractEnterAnimation().Forget();
		}
		UIOpenResult uiOpenResult = await Singleton<NewUIManager>.instance.OpenUIAsync(UIType, UIData);
		await UniTask.WaitUntil(() =>
		{
			UIState uIState = Singleton<NewUIManager>.instance.GetUIState(uiOpenResult.Uid);
			return uIState == UIState.Closing || uIState == UIState.Closed || uIState == UIState.None;
		});
		base.DoAction().Forget();
		if (openCameraEffect)
		{
			ClearCameraEffect();
			PlayInteractExitAnimation().Forget();
		}
	}

	private void CreateCameraEffect()
	{
		_handle = PrecacheManager.Instance.GetInstanceHandle(GameLoader.meta.NPCVolumeEffectAssetID.GUID);
		_handle.Completed += (InstanceHandle l) =>
		{
			DepthOfFieldControl component = l.Result.GetComponent<DepthOfFieldControl>();
			component.LensDistance = cameraEffectConfig.lensDistance;
			component.Focus = cameraEffectConfig.focus;
			CinemachineCore.GetBlendOverride = OverrideSwitchInConfig;
			Entity npc = Context.Npc;
			_virtualCamera = Singleton<CameraManager>.instance.NpcUiVCamera;
			_virtualCamera.transform.position = (npc.GetRootTransform()?.position ?? Vector3.zero) + cameraEffectConfig.offset;
			_virtualCamera.transform.rotation = Quaternion.Euler(cameraEffectConfig.rotation);
			_virtualCamera.m_Lens.FieldOfView = cameraEffectConfig.FOV;
			_virtualCamera.Priority = 251;
			_virtualCamera.LookAt = null;
			_virtualCamera.gameObject.SetActive(value: true);
		};
	}

	private void ClearCameraEffect()
	{
		PrecacheManager.Instance.ReleaseInstanceHandle(_handle);
		CinemachineCore.GetBlendOverride = OverrideSwitchOutConfig;
		if ((bool)_virtualCamera)
		{
			_virtualCamera.gameObject.SetActive(value: false);
			_virtualCamera = null;
		}
	}

	private CinemachineBlendDefinition OverrideSwitchInConfig(ICinemachineCamera fromVcam, ICinemachineCamera toVcam, CinemachineBlendDefinition defaultBlend, MonoBehaviour owner)
	{
		defaultBlend.m_Style = CinemachineBlendDefinition.Style.EaseInOut;
		defaultBlend.m_Time = cameraEffectConfig.cameraPushDuration;
		CinemachineCore.GetBlendOverride = null;
		return defaultBlend;
	}

	private CinemachineBlendDefinition OverrideSwitchOutConfig(ICinemachineCamera fromVcam, ICinemachineCamera toVcam, CinemachineBlendDefinition defaultBlend, MonoBehaviour owner)
	{
		defaultBlend.m_Style = CinemachineBlendDefinition.Style.EaseInOut;
		defaultBlend.m_Time = cameraEffectConfig.cameraPullOutDuration;
		CinemachineCore.GetBlendOverride = null;
		return defaultBlend;
	}

	private async UniTaskVoid PlayInteractEnterAnimation()
	{
		Entity npc = Context.Npc;
		Animator animator = npc.GetCompNpc().Animator;
		animator.CrossFade(OnEnterInteract, cameraEffectConfig.cameraPushDuration);
		await UniTask.Delay(TimeSpan.FromSeconds(cameraEffectConfig.cameraPushDuration));
		animator.CrossFade(OnLoopInteract, cameraEffectConfig.cameraPushDuration);
	}

	private async UniTask PlayInteractExitAnimation()
	{
		Context.Npc.GetCompNpc().Animator.CrossFade(OnExitInteract, cameraEffectConfig.cameraPullOutDuration);
		await UniTask.Delay(TimeSpan.FromSeconds(cameraEffectConfig.cameraPullOutDuration));
	}
}
