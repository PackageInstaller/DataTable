using System;

namespace Newtonsoft.Json.Linq;

public class JsonSelectSettings
{
	public TimeSpan? RegexMatchTimeout { get; }

	public bool ErrorWhenNoMatch { get; set; }
}
