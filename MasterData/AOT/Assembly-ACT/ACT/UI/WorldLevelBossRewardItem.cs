using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.Utility;
using Fundamental;
using Runtime.UI.CommonComponent.CommonScrollBag;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class WorldLevelBossRewardItem : LoopScrollBaseItem
{
	public TextMeshProUGUI title;

	public CommonScrollBagComponent commonScrollBagComponent;

	public GameObject currentLevel;

	public LargeMapBossRewardView view;

	public CanvasGroup canvasGroup;

	private int rewardIndex;

	private int _localizeStringBossLevel = 2723;

	public override void ScrollCellIndex(int idx)
	{
		base.ScrollCellIndex(idx);
		RefreshUI(idx);
	}

	private void RefreshUI(int index)
	{
		List<Item> list = new List<Item>();
		currentLevel.gameObject.SetActive(Model<WorldLevelModel>.Interface.GetCurWorldLevel() == index + 1);
		canvasGroup.alpha = ((Model<WorldLevelModel>.Interface.GetCurWorldLevel() == index + 1) ? 1f : 0.45f);
		EnemySpawn data = CoreUtils.GetData(view.WildBossUseData.monsterID, RuntimeConfigs.data.enemySpawns);
		string localizeString = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, _localizeStringBossLevel);
		title.text = ((index <= 0) ? string.Format(localizeString + "{0}", data.enemyLevelOffset) : string.Format(localizeString + "{0}", data.worldEnemyLevel[index - 1] + data.enemyLevelOffset));
		foreach (ItemKv item2 in CoreUtils.GetData(view.WildBossUseData.rewards[index], RuntimeConfigs.data.collections).certain)
		{
			Item item = new Item
			{
				Id = item2.id,
				Count = item2.count
			};
			list.Add(item);
		}
		List<ItemUnifierProxy> list2 = ListPool<ItemUnifierProxy>.Get();
		ItemUnifierProxy.ItemUnifierPool.GetList(list, list2);
		commonScrollBagComponent.CountShowType = ItemUIComponentBase.ItemCountShowType.OneSide;
		commonScrollBagComponent.ItemSource = list2;
	}
}
