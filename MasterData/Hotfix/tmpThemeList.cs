using System;
using System.Collections.Generic;

[Serializable]
public class tmpThemeList
{
	public int themeId;

	public List<tempPerkInfo> perkList = new List<tempPerkInfo>();

	public void LoadFrom(tmpThemeList other)
	{
		themeId = other.themeId;
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
