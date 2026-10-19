using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.UI.Interface;
using ACT.ViewControl;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class SkillCultivateView : BaseTabContent, RaidTabViewInterface
{
	public LoopScrollRect scrollRect;

	public Transform content;

	private List<int> _entranceIds;

	private RaidTabView _raidTabView;

	private ActButton _activeButton;

	protected override void OnTabActive(ITabItem tabItem)
	{
		base.OnTabActive(tabItem);
		_entranceIds = ListPool<int>.Get();
		if (!(tabItem is RaidSubTab raidSubTab))
		{
			return;
		}
		foreach (KeyValuePair<int, RaidTypeData> raidTypeData in RuntimeConfigs.data.raidTypeDatas)
		{
			if (raidSubTab.HbContent.raidNewType.Contains(raidTypeData.Value.raidType))
			{
				_entranceIds.AddRange(raidTypeData.Value.raidEntranceId);
			}
		}
		scrollRect.totalCount = _entranceIds.Count;
		scrollRect.OnItemShow.RemoveAllListeners();
		scrollRect.OnItemShow.AddListener((ILoopScrollDataSource x) =>
		{
			if (x is CultivateItem cultivateItem)
			{
				cultivateItem.RaidEntranceID = _entranceIds[cultivateItem.index];
				cultivateItem.OnSelectItem = OnSelectItem;
			}
		});
		scrollRect.RefillCells();
		PlayAnimation();
	}

	protected override void OnTabDeActive(ITabItem tabItem)
	{
		base.OnTabDeActive(tabItem);
		ListPool<int>.Release(_entranceIds);
		_entranceIds = null;
		scrollRect.ClearCellsPool();
	}

	private void PlayAnimation()
	{
		int childCount = scrollRect.content.childCount;
		for (int i = 0; i < childCount; i++)
		{
			CultivateItem component = scrollRect.content.GetChild(i).GetComponent<CultivateItem>();
			if ((bool)component)
			{
				component.PlayAnimation((float)i * 0.05f);
			}
		}
	}

	public void SetParentView(RaidTabView raidTabView)
	{
		_raidTabView = raidTabView;
	}

	private void OnSelectItem(CultivateItem item)
	{
		if (item.rewardBag.ItemSource != null && item.rewardBag.ItemSource.Any())
		{
			_raidTabView.SetParentRewardContent(item.rewardBag.transform.GetComponent<ViewControlLayer>());
		}
		else
		{
			_raidTabView.SetParentRewardContent(null);
		}
		_activeButton = item.confirmButton;
	}

	public ActButton GetActiveSelectButton()
	{
		return _activeButton;
	}
}
