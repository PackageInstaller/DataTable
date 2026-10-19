using System;
using ACT.Game.Data;
using ACT.Net;

namespace ACT.Error;

public class LuminErrorException : Exception
{
	public CodeType CodeType { get; }

	public CodeModule CodeModule { get; }

	public int SubCode { get; }

	public ErrorParam Param { get; }

	public string TitleOverride { get; }

	public string MessageOverride { get; }

	public bool HideErrorCode { get; }

	public LuminErrorException(CodeType codeType, CodeModule codeModule, int subCode, ErrorParam param = null, string titleOverride = null, string messageOverride = null, Exception innerException = null, bool hideErrorCode = false)
		: base(LuminError.FormatErrorCode(codeType, codeModule, subCode), innerException)
	{
		CodeType = codeType;
		CodeModule = codeModule;
		SubCode = subCode;
		Param = param;
		TitleOverride = titleOverride;
		MessageOverride = messageOverride;
		HideErrorCode = hideErrorCode;
	}

	public LuminErrorException(ErrorAck errorAck, string titleOverride = null, string messageOverride = null, Exception innerException = null, bool hideErrorCode = false)
		: this((CodeType)(errorAck ?? throw new ArgumentNullException("errorAck")).CodeType, (CodeModule)errorAck.CodeModule, errorAck.SubCode, errorAck.Param, titleOverride, messageOverride, innerException, hideErrorCode)
	{
	}

	public bool Is(CodeType codeType, CodeModule codeModule, int subCode)
	{
		if (CodeType == codeType && CodeModule == codeModule)
		{
			return SubCode == subCode;
		}
		return false;
	}
}
