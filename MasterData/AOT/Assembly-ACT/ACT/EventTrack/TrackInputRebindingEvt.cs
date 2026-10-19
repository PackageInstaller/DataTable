using System.Collections.Generic;
using Newtonsoft.Json.Linq;

namespace ACT.EventTrack;

public class TrackInputRebindingEvt : TrackBaseEvt<TrackInputRebindingEvt>
{
	public bool isResetToDefault;

	public List<(string, int, string, string)> records = new List<(string, int, string, string)>();

	public override void OnDispatch()
	{
		if ((!isResetToDefault && records.Count <= 0) || !EventConfigs.EventDictionary.TryGetValue("inputkey_info", out var value))
		{
			return;
		}
		(value["operation_info"] as JArray).Clear();
		value["is_default"] = isResetToDefault;
		foreach (var record in records)
		{
			JObject jObject = new JObject();
			jObject["operation_name"] = record.Item1;
			jObject["solution"] = record.Item2;
			jObject["operation_before"] = record.Item3;
			jObject["operation_after"] = record.Item4;
			(value["operation_info"] as JArray).Add(jObject);
		}
		_ = LuminApplication.LogEnabled;
		Send("inputkey_info", value);
	}

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		isResetToDefault = false;
		records.Clear();
	}
}
