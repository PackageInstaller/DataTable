using UnityEngine;

[CreateAssetMenu(fileName = "Player Feedback Effect Configure Data", menuName = "游戏/特效/玩家反馈效果")]
public class AdventurePlayerFeedbackEffectConfigureData : ScriptableObject
{
	public struct PlayerFeedbackEffectInfo
	{
		public long cameraShakeUniqueId;

		public long racialBlurUniqueId;
	}

	public bool enableCameraShake;

	public float cameraShakeFadeIn;

	public float cameraShakeDuration;

	public float cameraShakeFadeOut;

	[Space]
	public Vector3 cameraShakeStrength;

	public float cameraShakeDepth;

	public float cameraShakeRotate;

	public int cameraShakeVibrato;

	[Range(0f, 180f)]
	public float cameraShakeRandomness;

	public bool enableRacialBlur;

	public float racialBlurFadeIn;

	public float racialBlurDuration;

	public float racialBlurFadeOut;

	[Space]
	[Range(0f, 1f)]
	public float racialBlurStrength = 1f;

	[Range(-1f, 1f)]
	public float racialBlurDirection = 1f;

	[Range(0f, 1f)]
	public float racialBlurInvertScattered;

	[Range(0f, 1f)]
	public float racialBlurRange = 0.5f;

	public PlayerFeedbackEffectInfo Play(Vector3 effectPosition = default(Vector3), GameObject effectTarget = null, int cameraShakeSort = 0)
	{
		PlayerFeedbackEffectInfo result = new PlayerFeedbackEffectInfo
		{
			cameraShakeUniqueId = -1L,
			racialBlurUniqueId = -1L
		};
		AdventurePlayerFeedbackEffectController instance = SceneSingleton<AdventurePlayerFeedbackEffectController>.Instance;
		if (instance != null && cameraShakeSort >= 0)
		{
			ref long cameraShakeUniqueId = ref result.cameraShakeUniqueId;
			ref long racialBlurUniqueId = ref result.racialBlurUniqueId;
			(cameraShakeUniqueId, racialBlurUniqueId) = instance.Play(this, effectPosition, effectTarget, cameraShakeSort);
		}
		return result;
	}

	public void Stop(long cameraShakeUniqueId = -1L, long racialBlurUniqueId = -1L)
	{
		SceneSingleton<AdventurePlayerFeedbackEffectController>.Instance?.Stop(this, cameraShakeUniqueId, racialBlurUniqueId);
	}
}
