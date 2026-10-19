using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Game.Data;
using ACT.Utility;
using Fundamental;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class CharacterSelectSidebar : SelectSidebarBase
{
	public enum SortType
	{
		Default,
		Team,
		Temple
	}

	private List<Character> allCharacterList;

	private List<Character> sameIdCharacter;

	public int curTeamIndex = -1;

	public int selectCharacterId;

	public int[] teamCharacters;

	public LocalizeStringEvent title;

	[NonSerialized]
	public List<int> curSeatLimitElements;

	public Action<ItemUIComponent> onSelectItem;

	public ItemUIComponent lastSelectItem;

	public bool isSingleChoose { get; set; }

	public void Init(int localizationStringEvent, SortType sortType)
	{
		if (isHidden)
		{
			initialComplete = false;
			allCharacterList = ListPool<Character>.Get();
			allCharacterList.AddRange(CharacterDataHelper.GetCurAllCharacters());
			title.StringReference.TableEntryReference = localizationStringEvent;
			switch (sortType)
			{
			case SortType.Team:
				allCharacterList.Sort(SortUtility.TeamCharacterSort);
				break;
			case SortType.Temple:
				allCharacterList.Sort(SortUtility.TempleTeamCharacterSort);
				break;
			case SortType.Default:
				allCharacterList.Sort(SortUtility.TeamPanelCharacterSort);
				break;
			}
			loopScrollRect.totalCount = allCharacterList.Count;
			defaultSelectIndex = allCharacterList.FindIndex((Character _) => _.Id == selectCharacterId);
			base.Init();
			if (defaultSelectIndex != -1)
			{
				OnItemChosen(defaultSelectIndex);
			}
		}
	}

	public override void UnInit()
	{
		if (isNormal)
		{
			base.UnInit();
			ListPool<Character>.Release(allCharacterList);
			List<Character> list = sameIdCharacter;
			if (list != null && list.Count > 0)
			{
				ListPool<Character>.Release(sameIdCharacter);
			}
			List<int> list2 = curSeatLimitElements;
			if (list2 != null && list2.Count > 0)
			{
				ListPool<int>.Release(curSeatLimitElements);
			}
		}
	}

	private List<Character> GetSameCharacters()
	{
		return (from chara in allCharacterList
			group chara by chara.Id into @group
			where @group.Count() > 1
			select @group).SelectMany((IGrouping<int, Character> group) => group).ToList();
	}

	public void SetItemContent(ItemUIComponent item, int index)
	{
		item.BagCharacterInit(allCharacterList[index], teamCharacters, curTeamIndex, isSingleChoose);
		List<Character> list = sameIdCharacter;
		if (list != null && list.Count > 0 && sameIdCharacter.Contains(allCharacterList[index]))
		{
			item.blackMask.SetActive(value: true);
			item.OnItemClick = null;
			int tipId = (item.character.IsTrailCharacter ? 1140 : 1141);
			ItemUIComponent itemUIComponent = item;
			itemUIComponent.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Combine(itemUIComponent.OnItemClick, (UnityAction<ItemUIComponentBase>)((ItemUIComponentBase l) =>
			{
				GameUtility.OpenToolTip(tipId);
			}));
		}
		else
		{
			List<int> list2 = curSeatLimitElements;
			if (list2 != null && list2.Count > 0 && !curSeatLimitElements.Contains((int)allCharacterList[index].element))
			{
				item.blackMask.SetActive(value: true);
				item.OnItemClick = null;
			}
			else
			{
				item.OnItemClick = null;
				ItemUIComponent itemUIComponent2 = item;
				itemUIComponent2.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Combine(itemUIComponent2.OnItemClick, (UnityAction<ItemUIComponentBase>)((ItemUIComponentBase l) =>
				{
					OnItemChosen(item);
				}));
			}
		}
		if (lifeCycle != CommonUILifeCycle.Normal)
		{
			item.GetComponent<CanvasGroup>().alpha = 0f;
		}
	}

	public void OnItemChosen(ItemUIComponent item)
	{
		if (lastSelectItem != null)
		{
			lastSelectItem.isChosen = false;
		}
		lastSelectItem = item;
		item.isChosen = true;
		onSelectItem?.Invoke(item);
	}

	public void OnItemChosen(int index)
	{
		ItemUIComponent itemUIComponent = loopScrollRect.GetItem(index) as ItemUIComponent;
		if (itemUIComponent != null)
		{
			OnItemChosen(itemUIComponent);
		}
	}
}
