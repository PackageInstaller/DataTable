#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;

namespace Ase;

public class CopyType5Team
{
	private CopyType5TeamConfig config;

	private int teamTag;

	public List<int> HeroList => FixHeroList();

	public List<int> BpList => config.bpList;

	public int CopyType => config.copyType;

	public int TeamTag => teamTag;

	public int BuffId => config.buffId;

	public bool IsBlock => config.isBlock;

	public CopyType5TeamConfig Config => config;

	public static CopyType5Team CreateFromServer(int copyType, List<int> heroList, List<int> bpList, int buffId, bool isBlock, long endTime)
	{
		CopyType5Team copyType5Team = new CopyType5Team();
		CopyType5TeamConfig copyType5TeamConfig = new CopyType5TeamConfig
		{
			copyType = copyType,
			heroList = heroList,
			buffId = buffId,
			isBlock = isBlock,
			bpList = bpList,
			endTime = endTime
		};
		copyType5Team.config = copyType5TeamConfig;
		return copyType5Team;
	}

	public static CopyType5Team CreateEmpty(int copyType, long endTime)
	{
		CopyType5Team copyType5Team = new CopyType5Team();
		CopyType5TeamConfig copyType5TeamConfig = new CopyType5TeamConfig
		{
			copyType = copyType,
			heroList = new List<int>(),
			bpList = new List<int>(),
			endTime = endTime
		};
		copyType5Team.config = copyType5TeamConfig;
		return copyType5Team;
	}

	public void RefreshData(List<int> roleIds, bool isBlock)
	{
		config.heroList = roleIds;
		config.isBlock = isBlock;
	}

	public void SetTeamTag(int index)
	{
		teamTag = index;
	}

	public void SetBlock(bool block)
	{
		config.isBlock = block;
	}

	public void SetBuff(int id)
	{
		config.buffId = id;
	}

	public void SetBpList(List<int> bpList)
	{
		config.bpList = bpList;
	}

	public void SaveCarringBPs(int bpId1, int bpId2)
	{
		if (config.bpList == null)
		{
			config.bpList = new List<int>();
		}
		else
		{
			config.bpList.Clear();
		}
		config.bpList.Add(bpId1);
		config.bpList.Add(bpId2);
	}

	public void Clear()
	{
		config.heroList = null;
		config.bpList = null;
		config.isBlock = false;
	}

	public List<int> FixHeroList()
	{
		if (config.heroList == null)
		{
			return new List<int> { 0, 0, 0 };
		}
		if (config.heroList.Count == 3)
		{
			return config.heroList;
		}
		if (config.heroList.Count > 3)
		{
			for (int num = config.heroList.Count - 1; num >= 3; num--)
			{
				config.heroList.RemoveAt(num);
			}
		}
		if (config.heroList.Count < 3)
		{
			for (int i = config.heroList.Count; i < 3; i++)
			{
				config.heroList.Add(0);
			}
		}
		return config.heroList;
	}

	public CopyBPCarrying GetCopyBPCarrying()
	{
		CopyBPCarrying copyBPCarrying = new CopyBPCarrying();
		copyBPCarrying.copyId = config.copyType;
		if (config.bpList != null)
		{
			copyBPCarrying.bpId1 = ((config.bpList.Count > 0) ? config.bpList[0] : 0);
			copyBPCarrying.bpId2 = ((config.bpList.Count > 1) ? config.bpList[1] : 0);
		}
		return copyBPCarrying;
	}

	public HeroModel GetHeroModel(int index)
	{
		if (config.heroList == null || config.heroList.Count == 0 || config.heroList.Count <= index)
		{
			return null;
		}
		int num = config.heroList[index];
		HeroModel heroById = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(num);
		if (heroById != null)
		{
			return heroById;
		}
		Log.Error($"角色仓库找不到角色 Id：{num}");
		return null;
	}

	public void SetConfig(CopyType5TeamConfig teamConfig)
	{
		config = teamConfig;
	}
}
