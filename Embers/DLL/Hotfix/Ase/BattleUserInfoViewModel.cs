#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using Ase.ECS;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class BattleUserInfoViewModel : OptionBase
{
	private Dictionary<int, BattleUserViewModel> battleUsers;

	private InteractionRequest changeHeroRequest;

	private InteractionRequest refreshHeroRequest;

	private bool isSingleGame;

	private bool showRebornTime;

	private int rebornTimes;

	public Dictionary<int, BattleUserViewModel> BattleUsers => battleUsers;

	public IInteractionRequest ChangeHeroRequest => changeHeroRequest;

	public int RebornTimes
	{
		get
		{
			return rebornTimes;
		}
		private set
		{
			Set(ref rebornTimes, value, "RebornTimes");
		}
	}

	public bool ShowRebornTime
	{
		get
		{
			return showRebornTime;
		}
		set
		{
			Set(ref showRebornTime, value, "ShowRebornTime");
		}
	}

	public bool IsSingleGame
	{
		get
		{
			return isSingleGame;
		}
		set
		{
			Set(ref isSingleGame, value, "IsSingleGame");
		}
	}

	public override void ItemOnClick(object obj)
	{
		parent.ItemOnClick(obj);
	}

	public BattleUserInfoViewModel(OptionBase parent)
	{
		base.parent = parent;
		changeHeroRequest = new InteractionRequest(this);
		refreshHeroRequest = new InteractionRequest(this);
		battleUsers = new Dictionary<int, BattleUserViewModel>();
		for (int i = 1; i <= 3; i++)
		{
			battleUsers.Add(i, BattleUserViewModel.Empty(this));
		}
	}

	public void InitHeroData(int index, BattleHeroData heroData)
	{
		heroData.MemberId = index;
		battleUsers.TryGetValue(index, out var value);
		if (value == null)
		{
			Log.Error($"没有找到索引 = {index}的英雄数据");
		}
		else
		{
			value.UpdateHero(heroData);
		}
	}

	public void SetPlayerNames(Dictionary<int, string> playerNames)
	{
		foreach (BattleUserViewModel value in battleUsers.Values)
		{
			if (playerNames.ContainsKey(value.HeroData.MemberId))
			{
				value.HeroData.Name = playerNames[value.HeroData.MemberId];
			}
		}
	}

	public void FixHeroData()
	{
		int num = -1;
		foreach (KeyValuePair<int, BattleUserViewModel> battleUser in battleUsers)
		{
			if (battleUser.Value.HeroData.IsSelf)
			{
				if (battleUser.Value.HeroData.MemberId == battleUser.Key && battleUser.Key == 1)
				{
					return;
				}
				num = battleUser.Key;
			}
		}
		if (num > 1)
		{
			BattleHeroData heroData = battleUsers[1].HeroData;
			battleUsers[1].UpdateHero(battleUsers[num].HeroData);
			battleUsers[num].UpdateHero(heroData);
		}
		changeHeroRequest.Raise();
	}

	public BattleUserViewModel GetBattleUser(int index)
	{
		battleUsers.TryGetValue(index, out var value);
		if (value == null)
		{
			Log.Error($"没有找到索引 = {index}的英雄数据");
			return BattleUserViewModel.Empty(this);
		}
		return value;
	}

	public void SetHeroData(int index, BattleHeroData heroData)
	{
		if (battleUsers.ContainsKey(index))
		{
			battleUsers[index].UpdateHero(heroData);
			return;
		}
		battleUsers.Add(index, BattleUserViewModel.Empty(this));
		battleUsers[index].UpdateHero(heroData);
	}

	public void SetHeroEmpty(int index)
	{
		if (battleUsers.ContainsKey(index))
		{
			battleUsers[index].SetHeroEmpty();
		}
	}

	public BattleHeroData GetHeroDataByEntityId(int entityId)
	{
		foreach (BattleUserViewModel value in battleUsers.Values)
		{
			if (!value.IsEmpty && value.HeroData.Entity.Id == entityId)
			{
				return value.HeroData;
			}
		}
		return null;
	}

	public List<HeroSkinBind> GetHeroList()
	{
		List<HeroSkinBind> list = new List<HeroSkinBind>();
		int num = ((!isSingleGame) ? 1 : 3);
		if (isSingleGame)
		{
			for (int i = 0; i < num; i++)
			{
				if (battleUsers.ContainsKey(i + 1) && !battleUsers[i + 1].IsEmpty)
				{
					list.Add(new HeroSkinBind
					{
						heroId = battleUsers[i + 1].HeroData.HeroModel.Id,
						heroSkinSuffix = battleUsers[i + 1].HeroData.HeroModel.SkinSuffix,
						skinConfigId = battleUsers[i + 1].HeroData.HeroModel.SkinConfigId
					});
				}
			}
		}
		else
		{
			list.Add(new HeroSkinBind
			{
				heroId = battleUsers[1].HeroData.HeroModel.Id,
				heroSkinSuffix = battleUsers[1].HeroData.HeroModel.SkinSuffix,
				skinConfigId = battleUsers[1].HeroData.HeroModel.SkinConfigId
			});
		}
		return list;
	}

	public void RefreshRebornCount(int val)
	{
		RebornTimes = val;
		battleUsers[1].RefreshRebornCount(val);
	}

	public void PlayHpEffect()
	{
		foreach (KeyValuePair<int, BattleUserViewModel> battleUser in battleUsers)
		{
			if (battleUser.Value.HeroData.IsSelf)
			{
				battleUser.Value.PlayHpEffect();
			}
		}
	}

	protected override void Dispose(bool disposing)
	{
		base.Dispose(disposing);
		battleUsers.Clear();
	}

	public void SetPause(bool isPause)
	{
		if (battleUsers != null && battleUsers.ContainsKey(1))
		{
			battleUsers[1].SetPause(isPause);
		}
	}
}
