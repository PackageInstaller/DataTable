using System.Collections.Generic;
using Newtonsoft.Json;

namespace ACT;

public class AnnouncementList
{
	[JsonProperty("list")]
	public List<AnnouncementData> List { get; set; } = new List<AnnouncementData>();
}
