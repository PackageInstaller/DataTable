using System.Collections.Generic;

namespace Ase;

public class AnnouncementJsonData
{
	public List<AnnouncementJsonItemData> ReadDatas = new List<AnnouncementJsonItemData>();

	public List<long> GetUnReadIds()
	{
		string channel = GameEntry.BuiltinData.Channel;
		List<long> list = new List<long>();
		if (ReadDatas != null)
		{
			foreach (AnnouncementJsonItemData readData in ReadDatas)
			{
				if (!(readData.channel != channel))
				{
					list.Add(readData.id);
				}
			}
		}
		return list;
	}
}
