using Newtonsoft.Json;

namespace ACT;

public class GMReturn<T>
{
	[JsonProperty("code")]
	public int Code { get; set; }

	[JsonProperty("message")]
	public string Message { get; set; }

	[JsonProperty("data")]
	public T Data { get; set; }
}
