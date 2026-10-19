using System;

namespace UnityEngine.Localization.SmartFormat;

public class FormattingErrorEventArgs : EventArgs
{
	public string Placeholder { get; internal set; }

	public int ErrorIndex { get; internal set; }

	public bool IgnoreError { get; internal set; }

	internal FormattingErrorEventArgs(string rawText, int errorIndex, bool ignoreError)
	{
		Placeholder = rawText;
		ErrorIndex = errorIndex;
		IgnoreError = ignoreError;
	}
}
