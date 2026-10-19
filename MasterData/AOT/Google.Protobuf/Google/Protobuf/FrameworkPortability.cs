using System;
using System.Text.RegularExpressions;

namespace Google.Protobuf;

internal static class FrameworkPortability
{
	internal static readonly RegexOptions CompiledRegexWhereAvailable = (Enum.IsDefined(typeof(RegexOptions), 8) ? RegexOptions.Compiled : RegexOptions.None);
}
