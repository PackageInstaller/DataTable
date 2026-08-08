using System;
using LitJson;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class UITree : UIBehaviour
{
	public Action<int, int, string, string> itemSelectHandler;

	public Action<int, int, string, string> groupSelectHandler;

	public Action<int, GameObject> itemRenderer;

	public Action<int, GameObject> groupRenderer;

	[SerializeField]
	private GameObject GroupPrefab;

	[SerializeField]
	private RectTransform container;

	[HideInInspector]
	[SerializeField]
	public int selectedGroup;

	[HideInInspector]
	[SerializeField]
	public int selectedItem;

	[SerializeField]
	private ToggleGroup toggleGroup;

	[SerializeField]
	public UITreeData data;

	public void SetData(UITreeData data)
	{
		this.data = data;
		UpdateView();
	}

	protected override void Start()
	{
		ForceLayout();
	}

	public bool CLearView()
	{
		if (!container)
		{
			return false;
		}
		ToggleGroup toggleGroup = GetToggleGroup();
		toggleGroup.allowSwitchOff = true;
		bool flag = true;
		while (container.childCount > 0)
		{
			flag = false;
			UnityEngine.Object.DestroyImmediate(container.GetChild(0).gameObject);
		}
		ForceLayout();
		toggleGroup.allowSwitchOff = false;
		return !flag;
	}

	public void UpdateView()
	{
		CLearView();
		if (container != null)
		{
			for (int i = 0; i < data.groupDatas.Count; i++)
			{
				UITreeGroup component = UnityEngine.Object.Instantiate(GroupPrefab, container).GetComponent<UITreeGroup>();
				component.SetTree(this);
				component.SetIndex(i);
				component.SetDefaultOn(i == data.defaultIndex);
				component.SetIsOn(i == data.defaultIndex, notify: false);
				component.toggle.group = GetToggleGroup();
				component.SetData(data.groupDatas[i]);
			}
		}
		ForceLayout();
	}

	public void InitWithJsonData(string jsonData)
	{
		UITreeData uITreeData = JsonMapper.ToObject<UITreeData>(jsonData);
		SetData(uITreeData);
	}

	public void SetGroupSelectHandler(Action<int, int, string, string> handler)
	{
		groupSelectHandler = handler;
	}

	public void SetItemSelectHandler(Action<int, int, string, string> handler)
	{
		itemSelectHandler = handler;
	}

	public void SetItemRenderer(Action<int, GameObject> itemRenderer)
	{
		this.itemRenderer = itemRenderer;
	}

	public void SetGroupRenderer(Action<int, GameObject> groupRenderer)
	{
		this.groupRenderer = groupRenderer;
	}

	public void NotifyGroupSelect(int index)
	{
		if (data != null && data.groupDatas != null && index < data.groupDatas.Count)
		{
			if (index < 0)
			{
				Debug.Log("error.........");
			}
			UITreeGroupData uITreeGroupData = data.groupDatas[index];
			groupSelectHandler?.Invoke(index, uITreeGroupData.id, uITreeGroupData.text, uITreeGroupData.extraData);
		}
	}

	public void NotifyItemSelect(int groupIndex, int itemIndex)
	{
		if (data != null && data.groupDatas != null && groupIndex < data.groupDatas.Count)
		{
			UITreeGroupData uITreeGroupData = data.groupDatas[groupIndex];
			groupSelectHandler?.Invoke(groupIndex, uITreeGroupData.id, uITreeGroupData.text, uITreeGroupData.extraData);
			if (uITreeGroupData.itemDatas != null && itemIndex < uITreeGroupData.itemDatas.Count)
			{
				UITreeItemData uITreeItemData = uITreeGroupData.itemDatas[itemIndex];
				itemSelectHandler?.Invoke(itemIndex, uITreeItemData.id, uITreeItemData.text, uITreeItemData.extraData);
			}
		}
	}

	public void ForceLayout()
	{
		LayoutRebuilder.ForceRebuildLayoutImmediate((RectTransform)container.transform);
		LayoutRebuilder.ForceRebuildLayoutImmediate((RectTransform)base.transform);
	}

	public ToggleGroup GetToggleGroup()
	{
		if (toggleGroup == null)
		{
			toggleGroup = GetComponent<ToggleGroup>();
		}
		return toggleGroup;
	}

	public void SelectGroup(int index, bool notify = true)
	{
		selectedGroup = index;
		bool allowSwitchOff = toggleGroup.allowSwitchOff;
		toggleGroup.allowSwitchOff = true;
		for (int i = 0; i < container.childCount; i++)
		{
			UITreeGroup component = container.GetChild(i).GetComponent<UITreeGroup>();
			component.toggle.group = null;
			component.SetIsOn(i == index, notify);
			component.toggle.group = toggleGroup;
		}
		toggleGroup.allowSwitchOff = allowSwitchOff;
	}

	public void SelectItem(int groupIndex, int itemIndex)
	{
		SelectGroup(groupIndex, notify: false);
		GetSelectedGroup().SelectItem(itemIndex);
	}

	public UITreeGroup GetSelectedGroup()
	{
		if (selectedGroup < 0)
		{
			return null;
		}
		if (selectedGroup >= container.childCount)
		{
			return null;
		}
		return container.GetChild(selectedGroup).GetComponent<UITreeGroup>();
	}

	public GameObject GetGroupGameObjectById(int groupId)
	{
		for (int i = 0; i < container.childCount; i++)
		{
			if (data.groupDatas[i].id == groupId)
			{
				return container.GetChild(i).gameObject;
			}
		}
		return null;
	}

	public GameObject GetItemGameObjectById(int groupId, int itemId)
	{
		GameObject gameObject = null;
		int index = -1;
		for (int i = 0; i < container.childCount; i++)
		{
			if (data.groupDatas[i].id == groupId)
			{
				gameObject = container.GetChild(i).gameObject;
				index = i;
				break;
			}
		}
		if (gameObject != null)
		{
			UITreeGroupData uITreeGroupData = data.groupDatas[index];
			RectTransform rectTransform = gameObject.GetComponent<UITreeGroup>().GetContainer().transform as RectTransform;
			for (int j = 0; j < rectTransform.childCount; j++)
			{
				if (uITreeGroupData.itemDatas[j].id == itemId)
				{
					return rectTransform.GetChild(j).gameObject;
				}
			}
		}
		return null;
	}

	public void Refresh()
	{
		for (int i = 0; i < container.childCount; i++)
		{
			container.GetChild(i).gameObject.GetComponent<UITreeGroup>().Refresh();
		}
	}
}
