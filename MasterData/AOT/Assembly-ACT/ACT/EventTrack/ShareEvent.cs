using System.Collections.Generic;
using Newtonsoft.Json.Linq;

namespace ACT.EventTrack;

public class ShareEvent : TrackBaseEvt<ShareEvent>
{
	public class LootitemData
	{
		public int id;

		public int num;
	}

	public List<LootitemData> lootitem = new List<LootitemData>();

	public int media;

	public int result;

	public override void OnDispatch()
	{
		if (!EventConfigs.EventDictionary.TryGetValue("share_event", out var value))
		{
			return;
		}
		JArray jArray = new JArray();
		foreach (LootitemData item in lootitem)
		{
			jArray.Add(new JObject
			{
				["id"] = item.id,
				["num"] = item.num
			});
		}
		value["lootitem"] = jArray;
		value["media"] = media;
		value["result"] = result;
		Send("share_event", value);
	}

	public override void ReleaseEvt()
	{
		lootitem.Clear();
		base.ReleaseEvt();
	}
}
