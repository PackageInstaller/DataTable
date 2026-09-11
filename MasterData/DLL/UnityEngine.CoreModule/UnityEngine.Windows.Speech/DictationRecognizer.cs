using System;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using UnityEngine.Scripting;

namespace UnityEngine.Windows.Speech;

public sealed class DictationRecognizer
{
	public delegate void DictationHypothesisDelegate(string text);

	public delegate void DictationResultDelegate(string text, ConfidenceLevel confidence);

	public delegate void DictationCompletedDelegate(DictationCompletionCause cause);

	public delegate void DictationErrorHandler(string error, int hresult);

	private IntPtr m_Recognizer;

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private DictationHypothesisDelegate DictationHypothesis;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private DictationResultDelegate DictationResult;

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private DictationCompletedDelegate DictationComplete;

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private DictationErrorHandler DictationError;

	[RequiredByNativeCode]
	private void DictationRecognizer_InvokeHypothesisGeneratedEvent(string keyword)
	{
		DictationHypothesis?.Invoke(keyword);
	}

	[RequiredByNativeCode]
	private void DictationRecognizer_InvokeResultGeneratedEvent(string keyword, ConfidenceLevel minimumConfidence)
	{
		DictationResult?.Invoke(keyword, minimumConfidence);
	}

	[RequiredByNativeCode]
	private void DictationRecognizer_InvokeCompletedEvent(DictationCompletionCause cause)
	{
		DictationComplete?.Invoke(cause);
	}

	[RequiredByNativeCode]
	private void DictationRecognizer_InvokeErrorEvent(string error, int hresult)
	{
		DictationError?.Invoke(error, hresult);
	}
}
