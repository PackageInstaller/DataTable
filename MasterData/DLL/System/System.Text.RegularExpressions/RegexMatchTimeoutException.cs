using System.Runtime.Serialization;

namespace System.Text.RegularExpressions;

[Serializable]
public class RegexMatchTimeoutException : TimeoutException, ISerializable
{
	public string Input { get; } = string.Empty;

	public string Pattern { get; } = string.Empty;

	public TimeSpan MatchTimeout { get; } = TimeSpan.FromTicks(-1L);

	public RegexMatchTimeoutException(string regexInput, string regexPattern, TimeSpan matchTimeout)
		: base("The RegEx engine has timed out while trying to match a pattern to an input string. This can occur for many reasons, including very large inputs or excessive backtracking caused by nested quantifiers, back-references and other factors.")
	{
		Input = regexInput;
		Pattern = regexPattern;
		MatchTimeout = matchTimeout;
	}

	public RegexMatchTimeoutException()
	{
	}

	protected RegexMatchTimeoutException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
		Input = info.GetString("regexInput");
		Pattern = info.GetString("regexPattern");
		MatchTimeout = new TimeSpan(info.GetInt64("timeoutTicks"));
	}

	void ISerializable.GetObjectData(SerializationInfo info, StreamingContext context)
	{
		base.GetObjectData(info, context);
		info.AddValue("regexInput", Input);
		info.AddValue("regexPattern", Pattern);
		info.AddValue("timeoutTicks", MatchTimeout.Ticks);
	}
}
