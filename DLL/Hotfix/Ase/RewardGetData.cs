using System.Collections.Generic;

namespace Ase;

public class RewardGetData
{
	public List<PropDataBase> PropList = new List<PropDataBase>();

	public List<int> HeroSkinList = new List<int>();

	public List<HeroRewardInfo> HeroRewardInfos = new List<HeroRewardInfo>();

	public void Attach(RewardGetData anotherData)
	{
		if (anotherData == null)
		{
			return;
		}
		foreach (PropDataBase prop in anotherData.PropList)
		{
			if (prop.Uid > 0)
			{
				PropList.Add(prop);
				continue;
			}
			int num = PropList.FindIndex((PropDataBase p) => p.Id == prop.Id);
			if (num < 0)
			{
				PropList.Add(prop);
				continue;
			}
			PropList[num].Amount += prop.Amount;
			if (PropList[num].Amount <= 0)
			{
				PropList.RemoveAt(num);
			}
		}
		foreach (int heroSkin in anotherData.HeroSkinList)
		{
			if (!HeroSkinList.Contains(heroSkin))
			{
				HeroSkinList.Add(heroSkin);
			}
		}
		foreach (HeroRewardInfo heroRewardInfo in anotherData.HeroRewardInfos)
		{
			if (HeroRewardInfos.Find((HeroRewardInfo p) => p.heroId == heroRewardInfo.heroId) == null)
			{
				HeroRewardInfos.Add(heroRewardInfo);
			}
		}
	}

	public RewardThings ConvertToRewardThings()
	{
		return new RewardThings
		{
			propItems = PropList,
			heroRewardInfos = HeroRewardInfos
		};
	}
}
