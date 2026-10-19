using System;
using System.Collections.Generic;
using System.Globalization;
using Newtonsoft.Json;

namespace ACT;

public class AnnouncementData
{
	[JsonProperty("id")]
	public int Id { get; set; }

	[JsonProperty("content")]
	public string Content { get; set; }

	[JsonProperty("category")]
	public int Category { get; set; }

	[JsonProperty("pic_url")]
	public string PicUrl { get; set; }

	[JsonProperty("title")]
	public string Title { get; set; }

	[JsonProperty("stime")]
	public string StartTime { get; set; }

	[JsonProperty("etime")]
	public string EndTime { get; set; }

	[JsonProperty("ctime")]
	public string CreateTime { get; set; }

	[JsonProperty("mtime")]
	public string ModifyTime { get; set; }

	[JsonProperty("show_num")]
	public int ShowNum { get; set; }

	[JsonProperty("is_open")]
	public int IsOpen { get; set; }

	[JsonProperty("activity_config")]
	public List<AnnouncementTimelineActivityData> ActivityConfig { get; set; }

	[JsonProperty("cardpool_config")]
	public List<AnnouncementTimelineCardPoolData> CardPoolConfig { get; set; }

	[JsonIgnore]
	public DateTime StartDateTime => DateTime.ParseExact(StartTime, "yyyy-MM-dd HH:mm:ss", CultureInfo.InvariantCulture);

	[JsonIgnore]
	public DateTime EndDateTime => DateTime.ParseExact(EndTime, "yyyy-MM-dd HH:mm:ss", CultureInfo.InvariantCulture);
}
