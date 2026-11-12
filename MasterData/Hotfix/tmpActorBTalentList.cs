using System;
using System.Collections.Generic;

[Serializable]
public class tmpActorBTalentList
{
	public List<tempPerkInfo> perkList = new List<tempPerkInfo>();

	public void LoadFrom(tmpActorBTalentList other)
	{
		LoadPerkList(perkList, other.perkList);
	}

	private void LoadPerkList(List<tempPerkInfo> self, List<tempPerkInfo> other)
	{
		self.Clear();
		foreach (tempPerkInfo item2 in other)
		{
			tempPerkInfo item = new tempPerkInfo
			{
				perkId = item2.perkId,
				perkLv = item2.perkLv
			};
			self.Add(item);
		}
	}
}
