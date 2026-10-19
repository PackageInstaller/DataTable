using Newtonsoft.Json;

namespace ACT;

public class AnnouncementTimelineCardPoolData : AnnouncementTimelineData
{
	[JsonProperty("pool_name")]
	public string PoolName { get; set; }

	[JsonIgnore]
	public override string Name => PoolName;
}
