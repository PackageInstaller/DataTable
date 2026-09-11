namespace UnityEngine.Windows.Speech;

public enum DictationCompletionCause
{
	Complete,
	AudioQualityFailure,
	Canceled,
	TimeoutExceeded,
	PauseLimitExceeded,
	NetworkFailure,
	MicrophoneUnavailable,
	UnknownError
}
