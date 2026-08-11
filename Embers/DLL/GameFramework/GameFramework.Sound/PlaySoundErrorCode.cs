namespace GameFramework.Sound;

public enum PlaySoundErrorCode
{
	Unknown,
	SoundGroupNotExist,
	SoundGroupHasNoAgent,
	LoadAssetFailure,
	IgnoredDueToLowPriority,
	SetSoundAssetFailure
}
