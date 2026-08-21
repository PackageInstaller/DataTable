using System.Collections.Generic;
using Config;
using UnityEngine;

public class TimelineInfo : ScriptableObject
{
	public int ID;

	public float duration;

	public bool isLoop;

	public float frameCount;

	public float TICK_INTERVAL = 0.033f;

	public float recover;

	public float ActionStartOffsetY;

	public bool UseRootMotionY;

	public bool IsNeedCameraLock;

	public WeaponCategory weaponCategory;

	public bool PandentIsHide;

	public int PandentPlayTimelineID;

	public string ThrownOutRangeEffectPath = string.Empty;

	public string ArrivedEffectPath = string.Empty;

	public float EffectGiveUpRecoveryNormalized = -1f;

	public Vector3 LookAtPoint = Vector3.zero;

	public bool isFinalAbility;

	public bool CloseRigBuiderCom;

	[SerializeField]
	public List<TimelineAnimationClip> clips = new List<TimelineAnimationClip>();

	[SerializeField]
	public List<TimelineCameraClip> cameras = new List<TimelineCameraClip>();

	[SerializeField]
	public List<TimelineEffectClip> effects = new List<TimelineEffectClip>();

	[SerializeField]
	public List<TimelineHitRenderClip> hitEffects = new List<TimelineHitRenderClip>();

	[SerializeField]
	public List<TimelineCameraShakeClip> cameraShakeClips = new List<TimelineCameraShakeClip>();

	[SerializeField]
	public List<TimelineCameraShakeByCurveClip> timelineCameraShakeByCurveClips = new List<TimelineCameraShakeByCurveClip>();

	[SerializeField]
	public List<TimelineHiddenPartsClip> hiddenPartsClips = new List<TimelineHiddenPartsClip>();

	[SerializeField]
	public List<AudioPlayActionClip> audioPlayActionClips = new List<AudioPlayActionClip>();

	[SerializeField]
	public List<FlashActionClip> flashActionClips = new List<FlashActionClip>();

	[SerializeField]
	public List<CharacterDissolveEffectActionClip> characterDissolveEffectActionClips = new List<CharacterDissolveEffectActionClip>();

	[SerializeField]
	public List<CharacterDissolveBossEffectActionClip> characterDissolveBossEffectActionClips = new List<CharacterDissolveBossEffectActionClip>();

	[SerializeField]
	public List<CharacterEmissionLightEffectClip> characterEmissionLightEffectClips = new List<CharacterEmissionLightEffectClip>();

	[SerializeField]
	public List<TimelineLineConnectionClip> lineConnectionClips = new List<TimelineLineConnectionClip>();

	[SerializeField]
	public List<ThrownLockActionClip> thrownLockActionClips = new List<ThrownLockActionClip>();

	[SerializeField]
	public List<ThrownCollisionCheckClip> thrownCollisionCheckClips = new List<ThrownCollisionCheckClip>();

	public bool UseLastHeight;

	[SerializeField]
	public List<TimelineEffectClip> footstepEffectClips = new List<TimelineEffectClip>();

	[SerializeField]
	public List<TimelineCameraClip> footstepCameraShakeClips = new List<TimelineCameraClip>();

	[SerializeField]
	public List<AudioPlayActionClip> footstepAudioClips = new List<AudioPlayActionClip>();

	[SerializeField]
	public List<RadialBlurClip> radialBlurClips = new List<RadialBlurClip>();

	[SerializeField]
	public List<CharacterGhostEffectClip> characterGhostEffectClips = new List<CharacterGhostEffectClip>();

	[SerializeField]
	public List<SceneSettingFogClip> sceneSettingFogClips = new List<SceneSettingFogClip>();

	[SerializeField]
	public List<SceneSettingPostEffectClip> sceneSettingPostEffectClips = new List<SceneSettingPostEffectClip>();

	[SerializeField]
	public List<CharacterSliceEffectClip> characterSliceEffectClips = new List<CharacterSliceEffectClip>();

	[SerializeField]
	public List<CharacterInterferenceEffectClip> characterInterferenceEffectClips = new List<CharacterInterferenceEffectClip>();

	[SerializeField]
	public List<CharacterWeaponLineClip> characterWeaponLineClips = new List<CharacterWeaponLineClip>();

	[SerializeField]
	public List<CameraGlitchClip> cameraGlitchClips = new List<CameraGlitchClip>();

	[SerializeField]
	public List<CameraAbberationClip> cameraAbberationClips = new List<CameraAbberationClip>();

	[SerializeField]
	public List<CameraAnimationFBXClip> cameraAnimationFBXClips = new List<CameraAnimationFBXClip>();

	[SerializeField]
	public List<EarlyWarningClip> earlyWarningClips = new List<EarlyWarningClip>();

	[SerializeField]
	public List<CameraDepthOfFieldClip> cameraDepthOfFieldClips = new List<CameraDepthOfFieldClip>();

	[SerializeField]
	public List<CameraFOVClip> cameraFOVClips = new List<CameraFOVClip>();

	[SerializeField]
	public List<CameraDollyShotClip> CameraDollyShotClips = new List<CameraDollyShotClip>();

	[SerializeField]
	public List<CameraCraneShotClip> CameraCraneShotClips = new List<CameraCraneShotClip>();

	[SerializeField]
	public List<CameraRotateClip> CameraRotateClips = new List<CameraRotateClip>();

	[SerializeField]
	public List<CameraDampingClip> CameraDampingClips = new List<CameraDampingClip>();

	[SerializeField]
	public List<CharacterGrabClip> CharacterGrabClips = new List<CharacterGrabClip>();

	[SerializeField]
	public List<CharacterThrowClip> CharacterThrowClips = new List<CharacterThrowClip>();

	[SerializeField]
	public List<DarkCornerClip> darkCornerClips = new List<DarkCornerClip>();

	public void ResetData()
	{
		EffectGiveUpRecoveryNormalized = -1f;
		clips.Clear();
		cameras.Clear();
		effects.Clear();
		hitEffects.Clear();
		cameraShakeClips.Clear();
		hiddenPartsClips.Clear();
		audioPlayActionClips.Clear();
		flashActionClips.Clear();
		characterDissolveEffectActionClips.Clear();
		lineConnectionClips.Clear();
		thrownLockActionClips.Clear();
		thrownCollisionCheckClips.Clear();
		footstepEffectClips.Clear();
		footstepCameraShakeClips.Clear();
		footstepAudioClips.Clear();
		radialBlurClips.Clear();
		characterGhostEffectClips.Clear();
		sceneSettingFogClips.Clear();
		sceneSettingPostEffectClips.Clear();
		characterSliceEffectClips.Clear();
		characterInterferenceEffectClips.Clear();
		characterWeaponLineClips.Clear();
		cameraGlitchClips.Clear();
		cameraAbberationClips.Clear();
		cameraAnimationFBXClips.Clear();
		earlyWarningClips.Clear();
		cameraDepthOfFieldClips.Clear();
		cameraFOVClips.Clear();
		CameraDollyShotClips.Clear();
		CameraCraneShotClips.Clear();
		CameraRotateClips.Clear();
		CameraDampingClips.Clear();
		CharacterGrabClips.Clear();
		CharacterThrowClips.Clear();
		darkCornerClips.Clear();
	}
}
