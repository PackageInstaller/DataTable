using Newtonsoft.Json;

namespace ACT.Command;

public class SendItem
{
	[JsonProperty("id")]
	public int ItemId { get; set; }

	[JsonProperty("count")]
	public int Count { get; set; }
}
