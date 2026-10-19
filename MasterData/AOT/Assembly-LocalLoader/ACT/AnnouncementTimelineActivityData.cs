using Newtonsoft.Json;

namespace ACT;

public class AnnouncementTimelineActivityData : AnnouncementTimelineData
{
	[JsonProperty("activity_type_icon")]
	public string ActivityTypeIcon { get; set; }

	[JsonProperty("activity_name")]
	public string ActivityName { get; set; }

	[JsonIgnore]
	public override string Name => ActivityName;
}
