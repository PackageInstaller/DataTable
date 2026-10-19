using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Game.Data;
using ACT.LocalizationExtension;
using ACT.Utility;
using Fundamental;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Localization;
using UnityEngine.UI;

namespace ACT.UI;

public class CharacterIconsGrid : MonoBehaviour
{
	public class Block
	{
		public GridLayoutGroup gridLayoutGroup;

		public List<Character> charactersList;
	}

	public LocalizeTMP_Dropdown sortDropdown;

	public Dictionary<int, Block> characterItems = new Dictionary<int, Block>();

	public GameObject gridLayout;

	public ScrollRect rect;

	public GameObject item;

	private Stack<GameObject> m_ItemPool = new Stack<GameObject>();

	private ItemUIComponent m_SelectedItem;

	private Character m_SelectedCharacter;

	private MonoScrollBagComponent.Param m_Param;

	private int m_SortValue;

	private int m_Reverse;

	public void Init(MonoScrollBagComponent.Param param, int selectId = -1, int reverse = 1, int teamIndex = -1)
	{
		m_Param = param;
		if (selectId != -1)
		{
			m_SelectedCharacter = m_Param.allItems.characters[selectId];
		}
		else
		{
			m_SelectedCharacter = null;
		}
		m_Reverse = reverse;
		InitData();
		ShowCharacter(teamIndex);
	}

	private void ShowCharacter(int teamIndex = -1)
	{
		foreach (Block value in characterItems.Values)
		{
			for (int num = value.gridLayoutGroup.transform.childCount - 1; num >= 0; num--)
			{
				ReturnObject(value.gridLayoutGroup.transform.GetChild(num).gameObject);
			}
		}
		foreach (Block value2 in characterItems.Values)
		{
			foreach (Character characters in value2.charactersList)
			{
				GameObject gameObject = GetObject();
				ItemUIComponent itemUIComponent = gameObject.GetComponent<ItemUIComponent>();
				itemUIComponent.BagCharacterInit(characters, m_Param.teamCharacters, teamIndex);
				ItemUIComponent itemUIComponent2 = itemUIComponent;
				itemUIComponent2.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Combine(itemUIComponent2.OnItemClick, (UnityAction<ItemUIComponentBase>)((ItemUIComponentBase l) =>
				{
					OnItemChosen(itemUIComponent);
				}));
				gameObject.transform.SetParent(value2.gridLayoutGroup.transform);
				if (characters.Equals(m_SelectedCharacter) && itemUIComponent.gameObject.activeInHierarchy)
				{
					OnItemChosen(itemUIComponent);
				}
			}
		}
	}

	private GameObject GetObject()
	{
		if (m_ItemPool.Count == 0)
		{
			return UnityEngine.Object.Instantiate(item, rect.content);
		}
		GameObject gameObject = m_ItemPool.Pop();
		gameObject.SetActive(value: true);
		return gameObject;
	}

	private void ReturnObject(GameObject obj)
	{
		obj.SetActive(value: false);
		obj.transform.SetParent(rect.content);
		m_ItemPool.Push(obj);
	}

	private void OnItemChosen(ItemUIComponent item)
	{
		if (m_SelectedItem != null)
		{
			m_SelectedItem.isChosen = false;
		}
		m_SelectedItem = item;
		m_SelectedItem.isChosen = true;
		m_SelectedCharacter = item.character;
		m_Param.onSelectItem?.Invoke(item);
	}

	public void InitSortDropDown()
	{
		if (sortDropdown != null)
		{
			m_SortValue = 0;
			List<LocalizeTMP_Dropdown.OptionData> list = new List<LocalizeTMP_Dropdown.OptionData>();
			sortDropdown.ClearOptions();
			list.Add(new LocalizeTMP_Dropdown.OptionData(new LocalizedString("Common", 40L)));
			list.Add(new LocalizeTMP_Dropdown.OptionData(new LocalizedString("Common", 39L)));
			sortDropdown.AddOptions(list);
		}
	}

	public void OnSortTypeChange()
	{
		m_SortValue = sortDropdown.value;
		SortCharacters();
		ShowCharacter();
	}

	public void SetSelectedCharacter(Character character)
	{
		int key = character.Id / 100;
		for (int i = 0; i < characterItems[key].gridLayoutGroup.transform.childCount; i++)
		{
			ItemUIComponent component = characterItems[key].gridLayoutGroup.transform.GetChild(i).GetComponent<ItemUIComponent>();
			if (component.character.Id == character.Id)
			{
				OnItemChosen(component);
				break;
			}
		}
	}

	public void OnSortClick()
	{
		if (gameObject.activeSelf)
		{
			m_Reverse *= -1;
			SortCharacters();
			ShowCharacter();
		}
	}

	private void SortCharacters()
	{
		Character character = null;
		if (m_SelectedItem != null)
		{
			character = m_SelectedItem.character;
		}
		foreach (Block value in characterItems.Values)
		{
			value.charactersList.Sort(SortCharacter);
		}
		if (character != null)
		{
			SetSelectedCharacter(character);
		}
	}

	private int SortCharacter(Character x, Character y)
	{
		for (int i = 0; i < SortUtility.CompareBaseCharacter[m_SortValue].Length; i++)
		{
			int num = SortUtility.CompareBaseCharacter[m_SortValue][i](x, y);
			if (num != 0)
			{
				return num * m_Reverse;
			}
		}
		return 0;
	}

	private void InitData()
	{
		foreach (Character character in m_Param.allItems.characters)
		{
			int key = character.Id / 100;
			if (characterItems.TryGetValue(key, out var value))
			{
				value.charactersList.Add(character);
				continue;
			}
			Block block = new Block
			{
				charactersList = ListPool<Character>.Get()
			};
			block.charactersList.Add(character);
			characterItems.Add(key, block);
		}
		characterItems = characterItems.OrderBy((KeyValuePair<int, Block> o) => o.Key).ToDictionary((KeyValuePair<int, Block> o) => o.Key, (KeyValuePair<int, Block> p) => p.Value);
		foreach (KeyValuePair<int, Block> characterItem in characterItems)
		{
			if (!(characterItem.Value.gridLayoutGroup != null))
			{
				GameObject gameObject = UnityEngine.Object.Instantiate(gridLayout, rect.content);
				gameObject.name = characterItem.Key.ToString();
				characterItem.Value.gridLayoutGroup = gameObject.GetComponent<GridLayoutGroup>();
			}
		}
		SortCharacters();
	}

	public void UnInit()
	{
		foreach (Block value in characterItems.Values)
		{
			ListPool<Character>.Release(value.charactersList);
			for (int i = 0; i < value.gridLayoutGroup.transform.childCount; i++)
			{
				Transform child = value.gridLayoutGroup.transform.GetChild(i);
				child.GetComponent<ItemUIComponent>().UnLoadSprite();
				UnityEngine.Object.Destroy(child.gameObject);
			}
			UnityEngine.Object.Destroy(value.gridLayoutGroup.gameObject);
		}
		characterItems.Clear();
	}
}
