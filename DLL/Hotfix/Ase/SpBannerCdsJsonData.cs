using System;
using System.Collections.Generic;

namespace Ase;

public class SpBannerCdsJsonData
{
	public List<BannerJsonData> Datas = new List<BannerJsonData>();

	public SpBannerCdsJsonData(Dictionary<int, DateTime> cds)
	{
		if (cds == null)
		{
			return;
		}
		foreach (KeyValuePair<int, DateTime> cd in cds)
		{
			Datas.Add(new BannerJsonData
			{
				Id = cd.Key,
				PopupTime = cd.Value
			});
		}
	}

	public Dictionary<int, DateTime> ToDictionary()
	{
		Dictionary<int, DateTime> dictionary = new Dictionary<int, DateTime>();
		if (Datas != null)
		{
			foreach (BannerJsonData data in Datas)
			{
				if (!dictionary.ContainsKey(data.Id))
				{
					dictionary.Add(data.Id, data.PopupTime);
				}
			}
		}
		return dictionary;
	}
}
