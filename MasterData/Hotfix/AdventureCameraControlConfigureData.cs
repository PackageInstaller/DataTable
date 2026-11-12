using Unity.Mathematics;
using UnityEngine;
using UnityEngine.Serialization;

[CreateAssetMenu(fileName = "Camera Control Configure Data", menuName = "游戏/摄像机/玩家摄像机控制配置")]
public class AdventureCameraControlConfigureData : ScriptableObject
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

	[Range(1f, 179f)]
	public float cameraFOV = 40f;

	public bool enableCameraDepthSettings;

	public Vector2 cameraDepthRng = new Vector2(11f, 17f);

	[FormerlySerializedAs("cameraDepthOffset")]
	public float cameraHeightOffset;

	[FormerlySerializedAs("cameraHorizontalOffset")]
	public float cameraHorizontalOffset;

	public bool enableCameraDepthExtraSettings;

	public Vector2 monsterHeightRng = new Vector2(1f, 6f);

	public Vector2 playerAtkRng = new Vector2(200f, 1500f);

	public bool enableCameraRenderExtraSettings;

	public float overrideCameraRenderDistance = -1f;

	public bool enableCameraDragRngSettings;

	public float2 cameraDragRngVertical = new float2(-2f, 2f);

	public float2 cameraDragRngHorizontal = new float2(-10f, 10f);

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
