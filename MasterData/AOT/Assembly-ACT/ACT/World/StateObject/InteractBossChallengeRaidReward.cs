using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using Bamboo.ECS;
using Bamboo.NumberString;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using Runtime.Model.PowerModel;
using UnityEngine;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/InteractBossChallengeRaidReward")]
public class InteractBossChallengeRaidReward : InteractRaidReward
{
	private int bossPoint;

	public override async void OnInteract(Entity eb)
	{
		if (m_isInInteract)
		{
			return;
		}
		m_isInInteract = true;
		int currentRaidId = Model<RaidModel>.Interface.CurrentRaidId;
		bossPoint = GameUtility.GetRaidBossChallengePoint(currentRaidId);
		int count = RuntimeConfigs.data.worldBossMonsters[bossPoint].worldBossCost[0].count;
		if (currentStateId == 1)
		{
			int value = 0;
			foreach (KeyValuePair<int, RaidEntranceData> raidEntranceData in RuntimeConfigs.data.raidEntranceDatas)
			{
				if (raidEntranceData.Value.raidId.Contains(currentRaidId))
				{
					value = raidEntranceData.Key;
				}
			}
			RaidTypeData raidTypeData = null;
			foreach (KeyValuePair<int, RaidTypeData> raidTypeData2 in RuntimeConfigs.data.raidTypeDatas)
			{
				if (raidTypeData2.Value.raidEntranceId.Contains(value))
				{
					raidTypeData = raidTypeData2.Value;
				}
			}
			if (raidTypeData.rewardType == 1 || raidTypeData.rewardType == 2)
			{
				await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_DOUBLERAIDREWARD);
			}
			else
			{
				TextPanel.Param param = new TextPanel.Param();
				param.texts = new string[2]
				{
					count.FastToString(),
					"1"
				};
				param.OnConfirm = OnConfirm;
				param.needPause = true;
				param.commonId = 484;
				param.titleId = 483;
				TextPanel.Param uiData = param;
				List<TextPanel.ButtonInfo> list = ListPool<TextPanel.ButtonInfo>.Get();
				param = new TextPanel.Param();
				param.texts = new string[1] { count.FastToString() };
				param.btnInfos = list;
				param.OnConfirm = OnConfirm;
				param.needPause = true;
				param.commonId = 696;
				param.titleId = 483;
				TextPanel.Param uiData2 = param;
				if (Model<PowerModel>.Interface.PowerCount >= RuntimeConfigs.data.worldBossMonsters[bossPoint].worldBossCost[0].count)
				{
					await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_TEXTPANELWITHPOWER, uiData);
				}
				else
				{
					list.Add(new TextPanel.ButtonInfo
					{
						id = 14,
						closeUI = true
					});
					list.Add(new TextPanel.ButtonInfo
					{
						id = 486,
						action = () =>
						{
							G.service.LeaveRaid((bool r) =>
							{
								if (r)
								{
									Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Main);
								}
							});
						},
						closeUI = true
					});
					list.Add(new TextPanel.ButtonInfo
					{
						id = 499,
						action = async () =>
						{
							Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ADDPOWER, new TextPanel.Param());
						},
						closeUI = true
					});
					await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_TEXTPANELWITHPOWER, uiData2);
				}
			}
		}
		m_isInInteract = false;
	}

	private void OnConfirm()
	{
		if (m_isOption)
		{
			return;
		}
		m_isOption = true;
		G.service.GetRaidRewardInfo(1, async (bool r, RepeatedField<UniversalItem> ack) =>
		{
			if (r)
			{
				NetEnterState(2).Forget();
				await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_COMMONWORLDSUCCESS, GameUtility.CreateWorldSuccessRewardData(ack));
			}
		});
	}
}
