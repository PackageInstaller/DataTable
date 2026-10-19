using System;
using ACT.Model;
using ACT.ViewControl;
using Com.ForbiddenByte.OSA.Core;
using UnityEngine;

namespace ACT.UI;

public class WorldLevelBreakItemVH : BaseItemViewsHolder
{
	private WorldLevelItem WorldLevelItem;

	private ActButton btn;

	private object _dataContext;

	public void BindClickAction(Action<WorldLevelBreakItemVH> action)
	{
		if (!(btn == null))
		{
			btn.OnClick.RemoveAllListeners();
			btn.OnClick.AddListener(() =>
			{
				action(this);
			});
		}
	}

	public ACT.ViewControl.SelectableEx GetCurrentSelectableEx()
	{
		return WorldLevelItem?.gameObject.GetComponent<ACT.ViewControl.SelectableEx>();
	}

	public override void CollectViews()
	{
		base.CollectViews();
		WorldLevelItem = root.GetComponent<WorldLevelItem>();
		btn = root.GetComponent<ActButton>();
	}

	public void UpdateViews(WorldLevelItemData worldLevelItemData)
	{
		if (worldLevelItemData.IsPlaceholder)
		{
			SetPlaceholderState(isPlaceholder: true);
			return;
		}
		SetPlaceholderState(isPlaceholder: false);
		LevelDisplayItem disPlayItemData = Model<WorldLevelModel>.Interface.GetDisPlayItemData(worldLevelItemData.WorldLevelItemIndex);
		bool isWorldLevelBreakType = disPlayItemData.type == DisplayItemType.WorldLevel;
		bool selectItemCollected = Model<WorldLevelModel>.Interface.GetSelectItemCollected(disPlayItemData.value, disPlayItemData.type);
		bool selectItemCanReceiveAward = Model<WorldLevelModel>.Interface.GetSelectItemCanReceiveAward(disPlayItemData.value, disPlayItemData.type);
		bool active = Model<WorldLevelModel>.Interface.CurrItemIsShowRedDot(disPlayItemData.value, disPlayItemData.type);
		WorldLevelItem.SetActive(worldLevelItemData.IsSelect, isWorldLevelBreakType);
		WorldLevelItem.SetPlayerLevel(disPlayItemData.value.ToString(), isWorldLevelBreakType);
		WorldLevelItem.RefreshCompleteAndLockIcon(selectItemCollected, isWorldLevelBreakType, selectItemCanReceiveAward);
		WorldLevelItem.RefreshRedDotItem(active);
	}

	private void SetPlaceholderState(bool isPlaceholder)
	{
		if (WorldLevelItem != null)
		{
			CanvasGroup canvasGroup = WorldLevelItem.GetComponent<CanvasGroup>();
			if (canvasGroup == null)
			{
				canvasGroup = WorldLevelItem.gameObject.AddComponent<CanvasGroup>();
			}
			canvasGroup.alpha = (isPlaceholder ? 0f : 1f);
			canvasGroup.blocksRaycasts = !isPlaceholder;
			canvasGroup.interactable = !isPlaceholder;
		}
		if (btn != null)
		{
			btn.interactable = !isPlaceholder;
		}
	}

	public void BindDataContext(object dataContext)
	{
		_dataContext = dataContext;
	}

	public void ChangeScale(float scale)
	{
		if (WorldLevelItem != null && WorldLevelItem.transform.childCount > 0)
		{
			scale = Mathf.Clamp(scale, 1f, 1.56f);
			Transform child = WorldLevelItem.transform.GetChild(0);
			if (child != null)
			{
				child.localScale = new Vector3(scale, scale, scale);
			}
		}
	}

	public void RefreshSelect(bool isSelect, int curLevel, int maxLevel)
	{
		if (WorldLevelItem != null && WorldLevelItem.transform.childCount > 0)
		{
			Transform child = WorldLevelItem.transform.GetChild(0);
			if (child != null)
			{
				float num = (isSelect ? 1.56f : 1f);
				child.localScale = new Vector3(num, num, num);
			}
		}
	}
}
