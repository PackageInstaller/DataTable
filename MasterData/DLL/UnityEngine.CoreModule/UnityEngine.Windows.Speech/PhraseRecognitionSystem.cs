using System.Diagnostics;
using System.Runtime.CompilerServices;
using UnityEngine.Scripting;

namespace UnityEngine.Windows.Speech;

public static class PhraseRecognitionSystem
{
	public delegate void ErrorDelegate(SpeechError errorCode);

	public delegate void StatusDelegate(SpeechSystemStatus status);

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private static ErrorDelegate OnError;

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private static StatusDelegate OnStatusChanged;

	[RequiredByNativeCode]
	private static void PhraseRecognitionSystem_InvokeErrorEvent(SpeechError errorCode)
	{
		OnError?.Invoke(errorCode);
	}

	[RequiredByNativeCode]
	private static void PhraseRecognitionSystem_InvokeStatusChangedEvent(SpeechSystemStatus status)
	{
		OnStatusChanged?.Invoke(status);
	}
}
