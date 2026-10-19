using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.UI.Interface;
using ACT.ViewControl;
using UnityEngine;

namespace ACT.UI;

public class BaseCultivateView : BaseTabContent, RaidTabViewInterface
{
	public CultivateTypeTitle cultivateTitleTemplate;

	public CultivateItem cultivateItemTemplate;

	public Transform content;

	private readonly Dictionary<int, CultivateTypeTitle> _cultivateTitles = new Dictionary<int, CultivateTypeTitle>();

	private readonly Dictionary<int, List<CultivateItem>> _cultivateItems = new Dictionary<int, List<CultivateItem>>();

	private readonly Dictionary<int, int> _activeItemCounts = new Dictionary<int, int>();

	private readonly List<CultivateItem> _activeItems = new List<CultivateItem>();

	private RaidTabView _raidTabView;

	private ActButton _activeButton;

	protected override void OnTabActive(ITabItem tabItem)
	{
		base.OnTabActive(tabItem);
		HideCultivateGroups();
		_activeItems.Clear();
		_activeItemCounts.Clear();
		if (!(tabItem is RaidSubTab raidSubTab))
		{
			return;
		}
		if (cultivateTitleTemplate == null || cultivateItemTemplate == null || content == null)
		{
			Debug.LogError("BaseCultivateView 模板或内容节点未绑定。", this);
			return;
		}
		cultivateTitleTemplate.gameObject.SetActive(value: false);
		cultivateItemTemplate.gameObject.SetActive(value: false);
		foreach (KeyValuePair<int, RaidTypeData> raidTypeData in RuntimeConfigs.data.raidTypeDatas)
		{
			int raidType = raidTypeData.Value.raidType;
			if (!raidSubTab.HbContent.raidNewType.Contains(raidType))
			{
				continue;
			}
			CultivateTypeTitle orCreateTitle = GetOrCreateTitle(raidType);
			if (orCreateTitle.childRoot == null)
			{
				Debug.LogError("CultivateTypeTitle 的 childRoot 未绑定。", orCreateTitle);
				continue;
			}
			if (!_activeItemCounts.ContainsKey(raidType))
			{
				orCreateTitle.gameObject.SetActive(value: true);
				orCreateTitle.SetRaidTypeTile(raidType);
				_activeItemCounts.Add(raidType, 0);
			}
			int[] raidEntranceId = raidTypeData.Value.raidEntranceId;
			foreach (int raidEntranceID in raidEntranceId)
			{
				int num = _activeItemCounts[raidType];
				CultivateItem orCreateItem = GetOrCreateItem(raidType, num, orCreateTitle.childRoot);
				orCreateItem.RaidEntranceID = raidEntranceID;
				orCreateItem.OnSelectItem = OnSelectItem;
				orCreateItem.gameObject.SetActive(value: true);
				orCreateItem.transform.SetSiblingIndex(num);
				_activeItemCounts[raidType] = num + 1;
				_activeItems.Add(orCreateItem);
			}
		}
		HideUnusedItems();
		PlayAnimation();
	}

	private CultivateTypeTitle GetOrCreateTitle(int raidType)
	{
		if (_cultivateTitles.TryGetValue(raidType, out var value))
		{
			return value;
		}
		value = Object.Instantiate(cultivateTitleTemplate, content, worldPositionStays: false);
		_cultivateTitles.Add(raidType, value);
		return value;
	}

	private CultivateItem GetOrCreateItem(int raidType, int index, Transform parent)
	{
		if (!_cultivateItems.TryGetValue(raidType, out var value))
		{
			value = new List<CultivateItem>();
			_cultivateItems.Add(raidType, value);
		}
		if (index >= value.Count)
		{
			CultivateItem item = Object.Instantiate(cultivateItemTemplate, parent, worldPositionStays: false);
			value.Add(item);
		}
		CultivateItem cultivateItem = value[index];
		cultivateItem.transform.SetParent(parent, worldPositionStays: false);
		return cultivateItem;
	}

	private void HideCultivateGroups()
	{
		foreach (CultivateTypeTitle value in _cultivateTitles.Values)
		{
			value.gameObject.SetActive(value: false);
		}
		foreach (List<CultivateItem> value2 in _cultivateItems.Values)
		{
			foreach (CultivateItem item in value2)
			{
				item.gameObject.SetActive(value: false);
				item.OnSelectItem = null;
			}
		}
	}

	private void HideUnusedItems()
	{
		foreach (KeyValuePair<int, List<CultivateItem>> cultivateItem in _cultivateItems)
		{
			int value;
			for (int i = (_activeItemCounts.TryGetValue(cultivateItem.Key, out value) ? value : 0); i < cultivateItem.Value.Count; i++)
			{
				cultivateItem.Value[i].gameObject.SetActive(value: false);
				cultivateItem.Value[i].OnSelectItem = null;
			}
		}
	}

	private void PlayAnimation()
	{
		for (int i = 0; i < _activeItems.Count; i++)
		{
			_activeItems[i].PlayAnimation((float)i * 0.05f);
		}
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

	protected override void OnTabDeActive(ITabItem tabItem)
	{
		base.OnTabDeActive(tabItem);
		HideCultivateGroups();
		_activeItems.Clear();
		_activeItemCounts.Clear();
	}

	public void SetParentView(RaidTabView raidTabView)
	{
		_raidTabView = raidTabView;
	}

	public ActButton GetActiveSelectButton()
	{
		return _activeButton;
	}
}
