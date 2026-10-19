using ACT.Net;

namespace ACT.Error;

public readonly struct ErrorHandleResult
{
	public ResolvedError Error { get; }

	public bool WasReported { get; }

	public bool WasCustomHandled { get; }

	public ErrorPresentation Presentation { get; }

	public bool IsValid => Error.IsValid;

	public string Code => Error.Code;

	public string Message => Error.Message;

	internal ErrorHandleResult(ResolvedError error, bool wasReported, bool wasCustomHandled, ErrorPresentation presentation)
	{
		Error = error;
		WasReported = wasReported;
		WasCustomHandled = wasCustomHandled;
		Presentation = presentation;
	}

	public bool Is(CodeType codeType, CodeModule codeModule, int subCode)
	{
		return Error.Is(codeType, codeModule, subCode);
	}
}
