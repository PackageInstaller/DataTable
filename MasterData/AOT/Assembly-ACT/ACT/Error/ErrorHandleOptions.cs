using System;

namespace ACT.Error;

public readonly struct ErrorHandleOptions
{
	public ErrorPresentation Presentation { get; }

	public object[] Arguments { get; }

	public string TitleOverride { get; }

	public string MessageOverride { get; }

	public Action OnConfirm { get; }

	public Action OnCancel { get; }

	public Func<ResolvedError, bool> TryCustomHandle { get; }

	public bool HideErrorCode { get; }

	public ErrorHandleOptions(ErrorPresentation presentation = ErrorPresentation.Configured, object[] arguments = null, string titleOverride = null, string messageOverride = null, Action onConfirm = null, Action onCancel = null, Func<ResolvedError, bool> tryCustomHandle = null, bool hideErrorCode = false)
	{
		Presentation = presentation;
		Arguments = arguments;
		TitleOverride = titleOverride;
		MessageOverride = messageOverride;
		OnConfirm = onConfirm;
		OnCancel = onCancel;
		TryCustomHandle = tryCustomHandle;
		HideErrorCode = hideErrorCode;
	}
}
