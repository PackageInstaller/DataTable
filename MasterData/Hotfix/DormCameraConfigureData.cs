using Unity.Mathematics;
using UnityEngine;
using UnityEngine.Serialization;

[CreateAssetMenu(fileName = "Dorm Camera Control Configure Data", menuName = "游戏/摄像机/后宅摄像机控制配置")]
public class DormCameraConfigureData : ScriptableObject
{
	public bool enableCameraFollowSettings;

	[FormerlySerializedAs("cameraFollowDampTimeOnlyPlayer")]
	[Min(0f)]
	public float cameraFollowDampTime = 0.5f;

	[FormerlySerializedAs("cameraFollowDampTimeWithMonsterTime")]
	[Min(0f)]
	public float cameraFollowRngRadius = 1f;

	[Min(0f)]
	public float cameraOffsetRngRadius = 2f;

	[Min(0f)]
	public float cameraViewRngRadius = 15f;

	public bool enableCameraAngleSettings;

	[Range(-90f, 90f)]
	public float cameraAngle = 48f;

	[FormerlySerializedAs("enableCameraViewSettings")]
	public bool enableCameraRotationSettings;

	[Range(-180f, 180f)]
	public float cameraRotationAngle;

	[FormerlySerializedAs("enableCameraViewSettings")]
	public bool enableCameraRotationSpdSetting;

	public float cameraRotationDuration = 2f;

	public bool enableCameraViewportSettings;

	public AnimationCurve cameraFOVCurve = AnimationCurve.Linear(7f, 30f, 12f, 30f);

	public bool enableCameraDepthSettings;

	public AnimationCurve cameraHeightCurve = AnimationCurve.Linear(7f, 8f, 12f, 13f);

	[FormerlySerializedAs("cameraDepthOffset")]
	public float cameraHeightOffset;

	[HideInInspector]
	[FormerlySerializedAs("cameraHorizontalOffset")]
	public float cameraHorizontalOffset;

	public bool enableCameraDepthExtraSettings;

	public Vector2 monsterHeightRng = new Vector2(1f, 6f);

	public Vector2 playerAtkRng = new Vector2(200f, 1500f);

	public bool enableCameraRenderExtraSettings;

	public float overrideCameraRenderDistance = -1f;

	public bool enableCameraDragRngSettings;

	public float2 cameraDragRngVertical = new float2(-10f, 10f);

	public float2 cameraDragRngHorizontal = new float2(-10f, 10f);

	public bool enableCameraFocusSettings;

	public AnimationCurve focusMoveEaseCurve = AnimationCurve.EaseInOut(0f, 0f, 1f, 1f);

	public AnimationCurve focusZoomEaseCurve = AnimationCurve.EaseInOut(0f, 0f, 1f, 1f);

	public AnimationCurve focusMoveDurationCurve = AnimationCurve.Linear(0f, 0f, 20f, 2f);

	private float CurrentFOVPreview
	{
		get
		{
			if (Application.isPlaying && SceneSingleton<DormCameraController>.Instance != null)
			{
				return SceneSingleton<DormCameraController>.Instance.CurrentFOV;
			}
			AnimationCurve animationCurve = cameraFOVCurve;
			if (animationCurve == null || animationCurve.length < 1)
			{
				return 30f;
			}
			float time = (animationCurve.get_Item(0).time + animationCurve.get_Item(animationCurve.length - 1).time) * 0.5f;
			return animationCurve.Evaluate(time);
		}
	}

	public void OnActive()
	{
		if (enableCameraRenderExtraSettings && overrideCameraRenderDistance > 0f)
		{
			MonoSingleton<GameCameraStackManager>.Instance.overrideCameraRenderDistance = overrideCameraRenderDistance;
		}
	}

	public void OnDeactive()
	{
		if (enableCameraRenderExtraSettings && overrideCameraRenderDistance > 0f)
		{
			MonoSingleton<GameCameraStackManager>.Instance.overrideCameraRenderDistance = -1f;
		}
	}
}
