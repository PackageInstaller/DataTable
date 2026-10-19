using ACT.Game.Data;
using ACT.Net;

namespace ACT.Error;

public readonly struct ResolvedError
{
	public bool IsValid { get; }

	public CodeType CodeType { get; }

	public CodeModule CodeModule { get; }

	public int SubCode { get; }

	public string Code { get; }

	public string Title { get; }

	public string Message { get; }

	public int Rank { get; }

	public bool TrackingUpload { get; }

	public bool IsConfigured { get; }

	public ErrorParam Param { get; }

	internal ResolvedError(bool isValid, CodeType codeType, CodeModule codeModule, int subCode, string code, string title, string message, int rank, bool trackingUpload, bool isConfigured, ErrorParam param)
	{
		IsValid = isValid;
		CodeType = codeType;
		CodeModule = codeModule;
		SubCode = subCode;
		Code = code;
		Title = title;
		Message = message;
		Rank = rank;
		TrackingUpload = trackingUpload;
		IsConfigured = isConfigured;
		Param = param;
	}

	public bool Is(CodeType codeType, CodeModule codeModule, int subCode)
	{
		if (IsValid && CodeType == codeType && CodeModule == codeModule)
		{
			return SubCode == subCode;
		}
		return false;
	}
}
