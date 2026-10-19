using System;
using Bamboo.ECS;
using Cinemachine;
using UnityEngine;

namespace ACT.Battle;

[AddComponentMenu("")]
[SaveDuringPlay]
public class CinemachineDynamicFOV : CinemachineExtension
{
	[Header("Aspect Ratio 限制")]
	[Tooltip("启用 Aspect Ratio 限制功能")]
	[SerializeField]
	private bool useAspectRatioLimiter = true;

	[Tooltip("最小宽高比（例如 16:9 = 1.778）")]
	[SerializeField]
	private float minAspect = 1.7777778f;

	[Tooltip("最大宽高比（例如 21:9 = 2.333）")]
	[SerializeField]
	private float maxAspect = 2.3333333f;

	[Tooltip("在运行时显示当前的宽高比信息")]
	[SerializeField]
	private bool showDebugInfo = true;

	[SerializeField]
	[Range(0f, 1f)]
	[Header("默认最小FOV缩放")]
	private float _defaultMinFovScaler = 0.5f;

	private float EffectiveFovScaler
	{
		get
		{
			float currentFovScaler = CinemachineDynamicFOVBrain.Instance.CurrentFovScaler;
			return Mathf.Lerp(_defaultMinFovScaler, 1f, currentFovScaler);
		}
	}

	public float NormalizedZoomFactor
	{
		get
		{
			float num = 1f - _defaultMinFovScaler;
			if (num <= 0f)
			{
				return 0f;
			}
			return Mathf.Clamp01((1f - EffectiveFovScaler) / num);
		}
	}

	public bool EnableAspectRatioLimiter
	{
		get
		{
			return useAspectRatioLimiter;
		}
		set
		{
			useAspectRatioLimiter = value;
		}
	}

	public float MinAspect => minAspect;

	public float MaxAspect => maxAspect;

	public float TargetAspect { get; private set; }

	protected override void PostPipelineStageCallback(CinemachineVirtualCameraBase vcam, CinemachineCore.Stage stage, ref CameraState state, float deltaTime)
	{
		if (!(vcam is CinemachineVirtualCamera cinemachineVirtualCamera) || CinemachineDynamicFOVBrain.Instance == null || !CinemachineDynamicFOVBrain.Instance.enabled)
		{
			return;
		}
		if (stage == CinemachineCore.Stage.Body)
		{
			if (useAspectRatioLimiter)
			{
				ApplyAspectRatioLimiter(vcam, ref state);
			}
			if (cinemachineVirtualCamera.mobileFovScaler)
			{
				state.Lens.FieldOfView *= CinemachineDynamicFOVBrain.FovScaler;
			}
			if (cinemachineVirtualCamera.CustomFovScaler)
			{
				float effectiveFovScaler = EffectiveFovScaler;
				state.Lens.FieldOfView *= effectiveFovScaler;
			}
		}
		if (stage == CinemachineCore.Stage.Finalize && cinemachineVirtualCamera.CustomFovScaler)
		{
			float normalizedZoomFactor = NormalizedZoomFactor;
			if (normalizedZoomFactor > 0f)
			{
				float b = GetCharacterFootY() + GetWeightTypeOffsetY();
				state.RawPosition = new Vector3(state.RawPosition.x, Mathf.Lerp(state.RawPosition.y, b, normalizedZoomFactor), state.RawPosition.z);
				state.PositionCorrection = Vector3.Lerp(state.PositionCorrection, Vector3.zero, normalizedZoomFactor);
			}
		}
	}

	private void ApplyAspectRatioLimiter(CinemachineVirtualCameraBase vcam, ref CameraState state)
	{
		CinemachineVirtualCamera cinemachineVirtualCamera = vcam as CinemachineVirtualCamera;
		if (!(cinemachineVirtualCamera == null))
		{
			float aspectRatio = BattleConsts.windowResolutionWidth / BattleConsts.windowResolutionHeight;
			CameraAspectRatioLimiter component = Camera.main.GetComponent<CameraAspectRatioLimiter>();
			float num = ((!(component != null)) ? Mathf.Clamp((float)Screen.width / (float)Screen.height, minAspect, maxAspect) : component.TargetAspect);
			float fieldOfView = Camera.HorizontalToVerticalFieldOfView(Camera.VerticalToHorizontalFieldOfView(cinemachineVirtualCamera.m_Lens.FieldOfView, aspectRatio), num);
			state.Lens.FieldOfView = fieldOfView;
			TargetAspect = num;
		}
	}

	private static float VerticalToHorizontalFOV(float verticalFov, float aspect)
	{
		return 2f * Mathf.Atan(Mathf.Tan(verticalFov * 0.5f * (MathF.PI / 180f)) * aspect) * 57.29578f;
	}

	private static float HorizontalToVerticalFOV(float horizontalFov, float aspect)
	{
		return 2f * Mathf.Atan(Mathf.Tan(horizontalFov * 0.5f * (MathF.PI / 180f)) / aspect) * 57.29578f;
	}

	private float GetCharacterFootY()
	{
		if (MonoECS.instance == null || GameManager.cameraSystem == null || GameManager.cameraSystem.CameraPlayerWrapper == null)
		{
			return 0f;
		}
		return GameManager.cameraSystem.CameraPlayerWrapper.transform.position.y;
	}

	private float GetWeightTypeOffsetY()
	{
		if (MonoECS.instance == null || GameLoader.meta == null || !MonoECS.instance.mainEntity.IsLogicAvailable())
		{
			return 0f;
		}
		return GameLoader.meta.AdultFovOffsetY;
	}
}
