using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using ACT.World.Asset;
using Bamboo.ECS;
using Bamboo.NumberString;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using Runtime.Model.PowerModel;

namespace ACT.World.Actions;

public class BossChallengeGetRewards : InteractAction
{
	private List<Item> itemTemp = new List<Item>();

	private int bossid;

	private int bossType;

	protected override AbilityAuth auth => AbilityAuth.Server;

	protected override async UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		BossChallengeData bossChallengeData = stateObjectBase.entity.GetCompStateObject().StateWorldAssetData as BossChallengeData;
		WorldBossMonster worldBossMonster = RuntimeConfigs.data.worldBossMonsters[bossChallengeData.bossPoint];
		int count = worldBossMonster.worldBossCost[0].count;
		bossType = worldBossMonster.bossType;
		bossid = bossChallengeData.bossPoint;
		if (Model<PowerModel>.Interface.PowerCount >= RuntimeConfigs.data.worldBossMonsters[bossChallengeData.bossPoint].worldBossCost[0].count)
		{
			await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_TEXTPANEL, new TextPanel.Param
			{
				texts = new string[2]
				{
					count.FastToString(),
					"1"
				},
				OnConfirm = OnConfirm,
				needPause = true,
				commonId = 484,
				titleId = 483
			});
			return;
		}
		List<TextPanel.ButtonInfo> list = ListPool<TextPanel.ButtonInfo>.Get();
		list.Add(new TextPanel.ButtonInfo
		{
			id = 14,
			closeUI = true
		});
		list.Add(new TextPanel.ButtonInfo
		{
			id = 499,
			action = () =>
			{
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ADDPOWER, new TextPanel.Param());
			},
			closeUI = true
		});
		await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_TEXTPANELWITHPOWER, new TextPanel.Param
		{
			texts = new string[1] { count.FastToString() },
			btnInfos = list,
			OnConfirm = OnConfirm,
			needPause = true,
			commonId = 696,
			titleId = 483
		});
	}

	private void OnConfirm()
	{
		G.service.SceneTakeBossChallengeRewards(async (bool success, RepeatedField<Item> items) =>
		{
			if (success)
			{
				itemTemp.Clear();
				foreach (Item item2 in items)
				{
					Item item = new Item
					{
						Id = item2.Id,
						Count = item2.Count
					};
					itemTemp.Add(item);
				}
				GameUtility.OpenPopReward(GameUtility.ToUniversalItems(itemTemp));
			}
		});
	}
}
