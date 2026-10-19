using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.Utility;
using Fundamental;
using Runtime.UI.CommonComponent.CommonScrollBag;
using UnityEngine;

namespace ACT.UI;

public class MonoRaidRewardView : BaseUIView
{
	public class RaidRewardData : UIViewData
	{
		public MonoScrollBagComponent.Param scrollBagParam;

		public bool noReward;

		public bool bossChallenge;
	}

	public CommonScrollBagComponent scrollBag;

	public GameObject complete;

	private bool m_canReceive;

	private bool m_subReceive;

	private bool m_isOption;

	public RaidRewardData param;

	protected override void Init()
	{
		base.Init();
		m_isOption = false;
		if (uiViewData != null)
		{
			param = (RaidRewardData)uiViewData;
			if (!param.noReward)
			{
				List<ItemUnifierProxy> list = new List<ItemUnifierProxy>();
				ItemUnifierProxy.ItemUnifierPool.GetList(param.scrollBagParam.allItems.items, list);
				scrollBag.gameObject.SetActive(value: true);
				scrollBag.ItemSource = list;
				scrollBag.CountShowType = ItemUIComponentBase.ItemCountShowType.OneSide;
			}
			else
			{
				scrollBag.gameObject.SetActive(value: false);
			}
		}
		m_canReceive = true;
		m_subReceive = true;
		int currentRaidId = Model<RaidModel>.Interface.CurrentRaidId;
		RaidEntranceData raidEntranceData = GameUtility.GetRaidEntranceData(currentRaidId);
		if (param.bossChallenge)
		{
			GameUtility.GetRaidBossChallengePoint(currentRaidId);
			return;
		}
		int num = 0;
		for (int i = 0; i < raidEntranceData.raidId.Length; i++)
		{
			ACT.Game.Data.Raid raidInfo = Model<RaidModel>.Interface.GetRaidInfo(raidEntranceData.raidId[i]);
			if (raidInfo != null)
			{
				num += raidInfo.CleanNum;
			}
		}
		if (!HasLeftTimes())
		{
			m_canReceive = false;
			return;
		}
		ACT.Game.Data.Raid raidInfo2 = Model<RaidModel>.Interface.GetRaidInfo(currentRaidId);
		if (raidInfo2 != null)
		{
			ACT.Config.Raid raid = RuntimeConfigs.data.raids[currentRaidId];
			if (raid.numberOfRewardsReceived <= raidInfo2.CleanNum && raid.numberOfRewardsReceived != 0)
			{
				m_subReceive = false;
				return;
			}
		}
		if (RuntimeConfigs.data.raids.TryGetValue(Model<RaidModel>.Interface.CurrentRaidId, out var value))
		{
			complete.SetActive(!value.cpUse);
		}
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	protected override void PlayOpenAnimation()
	{
		betterAnimation.GetSequence("RewardShow").Play();
	}

	protected override void PlayCloseAnimation()
	{
		betterAnimation.GetSequence("RewardHide").Play();
	}

	public async void LeaveRaid()
	{
		if (m_isOption)
		{
			return;
		}
		m_isOption = true;
		Singleton<NewUIManager>.instance.CloseUI(UI_TYPE.UI_DOUBLERAIDREWARD);
		Singleton<NewUIManager>.instance.NeedPop = false;
		await CloseAsync();
		G.service.LeaveRaid((bool r) =>
		{
			if (r)
			{
				Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Main);
			}
		});
	}

	public void ReopenRaid()
	{
		if (m_isOption)
		{
			return;
		}
		m_isOption = true;
		if (!m_canReceive || !m_subReceive)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, new TextPanel.Param
			{
				OnConfirm = () =>
				{
					Close();
					Singleton<GameManager>.instance.worldManager.ReopenCurrentWorld();
				},
				OnCancel = () =>
				{
					m_isOption = false;
				},
				commonId = ((!m_canReceive) ? 739 : ((!m_subReceive) ? 740 : 0))
			});
			return;
		}
		Singleton<NewUIManager>.instance.NeedPop = false;
		Close();
		int currentRaidId = Model<RaidModel>.Interface.CurrentRaidId;
		TeamUsage teamUsage = new TeamUsage();
		teamUsage.BattleCharacterIdx = 0;
		teamUsage.EquipPotionId = Model<BloodBottleModel>.Interface.curSceneEquipBloodBottleId;
		foreach (Character curTeamCharacter in CharacterDataHelper.GetCurTeamCharacters())
		{
			TeamCharacterUsage teamCharacterUsage = new TeamCharacterUsage();
			teamCharacterUsage.CharacterId = curTeamCharacter.Id;
			teamUsage.CharacterUsage.Add(teamCharacterUsage);
		}
		G.service.RaidEnterInfo(currentRaidId, teamUsage, async (bool r) =>
		{
			if (r)
			{
				await Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Raid);
			}
		});
	}

	private bool HasLeftTimes()
	{
		RaidTypeData raidTypeData = RuntimeConfigs.data.raidTypeDatas[GetTypeId()];
		if (raidTypeData.cycleParm == null || raidTypeData.cycleParm.Length == 0)
		{
			return true;
		}
		if (raidTypeData.cycleParm[0] == 1)
		{
			if (GetLeftTimesByTypeId(raidTypeData.id) <= 0)
			{
				return false;
			}
		}
		else if (raidTypeData.cycleParm[1] - GetUsedTimesByEnteranceId(GetEntranceId()) <= 0)
		{
			return false;
		}
		return true;
	}

	private int GetEntranceId()
	{
		int currentRaidId = Model<RaidModel>.Interface.CurrentRaidId;
		foreach (KeyValuePair<int, RaidEntranceData> raidEntranceData in RuntimeConfigs.data.raidEntranceDatas)
		{
			if (raidEntranceData.Value.raidId.Contains(currentRaidId))
			{
				return raidEntranceData.Key;
			}
		}
		return 0;
	}

	private int GetTypeId()
	{
		foreach (KeyValuePair<int, RaidTypeData> raidTypeData in RuntimeConfigs.data.raidTypeDatas)
		{
			if (raidTypeData.Value.raidEntranceId.Contains(GetEntranceId()))
			{
				return raidTypeData.Key;
			}
		}
		return 0;
	}

	private int GetUsedTimesByEnteranceId(int entranceId)
	{
		RaidEntranceData raidEntranceData = RuntimeConfigs.data.raidEntranceDatas[entranceId];
		int num = 0;
		int[] raidId = raidEntranceData.raidId;
		foreach (int raidId2 in raidId)
		{
			ACT.Game.Data.Raid raidInfo = Model<RaidModel>.Interface.GetRaidInfo(raidId2);
			if (raidInfo != null)
			{
				num += raidInfo.TakeRewardCount;
			}
		}
		return num;
	}

	private int GetLeftTimesByTypeId(int typeId)
	{
		RaidTypeData raidTypeData = RuntimeConfigs.data.raidTypeDatas[typeId];
		int num = 0;
		int[] raidEntranceId = raidTypeData.raidEntranceId;
		foreach (int entranceId in raidEntranceId)
		{
			num += GetUsedTimesByEnteranceId(entranceId);
		}
		return raidTypeData.cycleParm[1] - num;
	}
}
