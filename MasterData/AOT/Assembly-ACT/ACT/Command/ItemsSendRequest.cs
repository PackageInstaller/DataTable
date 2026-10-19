using System.Collections.Generic;
using Newtonsoft.Json;

namespace ACT.Command;

public class ItemsSendRequest
{
	[JsonProperty("list")]
	public List<SendItem> List { get; set; } = new List<SendItem>();
}
