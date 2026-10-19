using System;
using System.Collections.Generic;
using System.Linq;

namespace Unity.VisualScripting;

internal static class XString
{
	internal static string Inject(this string format, params object[] formattingArgs)
	{
		return string.Format(format, formattingArgs);
	}

	internal static string Inject(this string format, params string[] formattingArgs)
	{
		return string.Format(format, ((IEnumerable<string>)formattingArgs).Select((Func<string, object>)((string a) => a)).ToArray());
	}
}
