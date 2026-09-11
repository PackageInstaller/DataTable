namespace UnityEngine.Windows.Speech;

public enum SpeechError
{
	NoError,
	TopicLanguageNotSupported,
	GrammarLanguageMismatch,
	GrammarCompilationFailure,
	AudioQualityFailure,
	PauseLimitExceeded,
	TimeoutExceeded,
	NetworkFailure,
	MicrophoneUnavailable,
	UnknownError
}
