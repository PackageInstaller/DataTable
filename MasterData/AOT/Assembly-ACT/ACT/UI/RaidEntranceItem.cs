using System.Collections.Generic;
using ACT.Config;
using ACT.Game.Data;
using ACT.UI.DataProxy;
using ACT.Utility;
using Runtime.UI.CommonComponent.CommonScrollBag;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.UI;

namespace ACT.UI;

public class RaidEntranceItem : MonoBehaviour, ISubmitHandler, IEventSystemHandler
{
	public Image Portrait;

	public CommonScrollBagComponent CommonScrollBagComponent;

	public TextMeshProUGUI Name;

	public ActButton BgButton;

	public List<Sprite> Portraits;

	public BetterAnimation betterAnimation;

	public void RefreshUI(RaidEntranceData raidEntranceData, UnityAction<RaidEntranceData> callBack, int index = 0, int raidType = 0)
	{
		if (raidEntranceData == null)
		{
			return;
		}
		BgButton.SetBtnClick(() =>
		{
			callBack?.Invoke(raidEntranceData);
		});
		Name.text = LocalizationUtility.GetLocalizeString("shortcommon", raidEntranceData.entranceName);
		if (raidType == 3 || raidType == 8)
		{
			List<Item> list = new List<Item>();
			for (int num = 0; num < raidEntranceData.rewardItemShow.Count; num++)
			{
				Item item = new Item
				{
					Id = raidEntranceData.rewardItemShow[num].id,
					Count = raidEntranceData.rewardItemShow[num].count
				};
				list.Add(item);
			}
			List<ItemUnifierProxy> list2 = new List<ItemUnifierProxy>();
			ItemUnifierProxy.ItemUnifierPool.GetList(list, list2);
			CommonScrollBagComponent.ItemSource = list2;
			CommonScrollBagComponent.ItemShowType = ItemUIComponentBase.InitType.BagItem;
			CommonScrollBagComponent.CountShowType = ItemUIComponentBase.ItemCountShowType.Hide;
		}
	}

	public void PlayAnimation()
	{
		betterAnimation?.GetSequence("Show").Play();
	}

	public void OnSubmit(BaseEventData eventData)
	{
		BgButton.OnSubmit(eventData);
	}
}
