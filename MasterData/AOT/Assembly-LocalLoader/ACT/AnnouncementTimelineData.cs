using System;
using System.Globalization;
using Newtonsoft.Json;

namespace ACT;

public class AnnouncementTimelineData
{
	[JsonIgnore]
	private string[] itemQuality;

	[JsonIgnore]
	public virtual string Name { get; set; }

	[JsonProperty("system_id")]
	public int SystemId { get; set; }

	[JsonProperty("stime")]
	public string StartTime { get; set; }

	[JsonProperty("etime")]
	public string EndTime { get; set; }

	[JsonProperty("icon_url")]
	public string[] IconUrl { get; set; }

	[JsonProperty("item_quality")]
	public string ItemQualityOrigin { get; set; }

	[JsonIgnore]
	public string[] ItemQuality
	{
		get
		{
			if (itemQuality == null)
			{
				itemQuality = ItemQualityOrigin?.Split(",");
			}
			return itemQuality;
		}
	}

	[JsonIgnore]
	public DateTime StartDateTime => DateTime.ParseExact(StartTime, "yyyy-MM-dd HH:mm:ss", CultureInfo.InvariantCulture);

	[JsonIgnore]
	public DateTime EndDateTime => DateTime.ParseExact(EndTime, "yyyy-MM-dd HH:mm:ss", CultureInfo.InvariantCulture);
}
