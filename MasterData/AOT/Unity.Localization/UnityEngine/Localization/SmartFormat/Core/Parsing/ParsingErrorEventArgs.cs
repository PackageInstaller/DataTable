using System;

namespace UnityEngine.Localization.SmartFormat.Core.Parsing;

public class ParsingErrorEventArgs : EventArgs
{
	public ParsingErrors Errors { get; internal set; }

	public bool ThrowsException { get; internal set; }

	internal ParsingErrorEventArgs(ParsingErrors errors, bool throwsException)
	{
		Errors = errors;
		ThrowsException = throwsException;
	}
}
