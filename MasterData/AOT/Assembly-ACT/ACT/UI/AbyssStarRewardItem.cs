using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class AbyssStarRewardItem : LoopScrollBaseItem
{
	public BImage image;

	public TextMeshProUGUI title;

	public GameObject normal;

	public GameObject unfinish;

	public GameObject finish;

	public Button btn;

	public MonoScrollBagComponent scrollBag;

	private MonoAbyssRewardView abyssRewardView;

	private MonoAbyssListView abyssView;

	private StarRewardData abyssRewardData;

	private int starGoal;

	public override void ScrollCellIndex(int idx)
	{
		abyssRewardView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_ABYSSREWARD) as MonoAbyssRewardView;
		abyssView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_ABYSSLIST) as MonoAbyssListView;
		if (abyssRewardView != null)
		{
			SetParam(abyssRewardData.starCollection);
			starGoal = abyssRewardData.starGoal;
			title.SetText("{0:00}", starGoal);
			btn.onClick.RemoveAllListeners();
			btn.onClick.AddListener(() =>
			{
				GetStarReward();
			});
		}
	}

	private void SetParam(int rewardId)
	{
		Collection collection = RuntimeConfigs.data.collections[rewardId];
		MonoScrollBagComponent.Param myParam = new MonoScrollBagComponent.Param
		{
			allItems = 
			{
				items = ListPool<Item>.Get()
			}
		};
		foreach (ItemKv item2 in collection.certain)
		{
			Item item = new Item
			{
				Id = item2.id,
				Count = item2.count
			};
			myParam.allItems.items.Add(item);
		}
		myParam.paramType = MonoScrollBagComponent.ParamType.Item;
		scrollBag.Init(myParam);
	}

	private void GetStarReward()
	{
	}
}
