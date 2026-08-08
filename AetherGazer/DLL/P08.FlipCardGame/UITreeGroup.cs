using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Serialization;
using UnityEngine.UI;

public class UITreeGroup : UIBehaviour
{
	[SerializeField]
	private GameObject ItemPrefab;

	[SerializeField]
	private Text title;

	[SerializeField]
	private VerticalLayoutGroup verticalLayoutGroup;

	[SerializeField]
	private RectTransform container;

	[SerializeField]
	public Toggle toggle;

	[SerializeField]
	public int index;

	[SerializeField]
	private ToggleGroup toggleGroup;

	[SerializeField]
	private UITree root;

	[SerializeField]
	private Controller indexController;

	[FormerlySerializedAs("guidList")]
	[SerializeField]
	private List<int> instanceIdList = new List<int>();

	[SerializeField]
	private List<GameObject> itemList = new List<GameObject>();

	[SerializeField]
	public RectTransform noticeContainer;

	[SerializeField]
	private GroupIconControllerType iconType;

	protected override void Awake()
	{
		toggle.onValueChanged.AddListener(delegate(bool isOn)
		{
			if (isOn)
			{
				NotifySelect();
				FoldOut();
			}
			else
			{
				FoldIn();
			}
		});
	}

	public void SetData(UITreeGroupData data)
	{
		instanceIdList.Clear();
		itemList.Clear();
		if (title != null)
		{
			title.text = data.text;
		}
		root.groupRenderer?.Invoke(data.id, base.gameObject);
		if (container != null)
		{
			while (container.childCount > 0)
			{
				Object.Destroy(container.GetChild(0).gameObject);
			}
			if (data.itemDatas != null)
			{
				for (int i = 0; i < data.itemDatas.Count; i++)
				{
					GameObject gameObject = Object.Instantiate(ItemPrefab, container);
					instanceIdList.Add(gameObject.GetInstanceID());
					itemList.Add(gameObject);
					UITreeItem component = gameObject.GetComponent<UITreeItem>();
					component.SetIndex(i);
					component.SetTree(root);
					component.SetGroup(this);
					component.SetIsOn(i == 0);
					component.toggle.group = GetToggleGroup();
					component.SetData(data.itemDatas[i]);
				}
			}
		}
		ForceLayout();
	}

	public GameObject GetItemGameObjectByInstanceId(int id)
	{
		int num = instanceIdList.IndexOf(id);
		if (num >= 0)
		{
			return itemList[num];
		}
		return null;
	}

	private void FoldIn()
	{
		container.gameObject.SetActive(value: false);
		ForceLayout();
	}

	private void FoldOut()
	{
		container.gameObject.SetActive(value: true);
		if (container.childCount > 0)
		{
			UITreeGroupData uITreeGroupData = root.data.groupDatas[index];
			UITreeItem component = container.GetChild(uITreeGroupData.defaultIndex).GetComponent<UITreeItem>();
			bool isOn = component.toggle.isOn;
			SelectItem(uITreeGroupData.defaultIndex);
			if (isOn)
			{
				component.NotifySelect();
			}
		}
		ForceLayout();
	}

	public void SetTree(UITree root)
	{
		this.root = root;
	}

	public void SetDefaultOn(bool value)
	{
		Controller[] components = toggle.GetComponents<Controller>();
		Controller controller = null;
		for (int i = 0; i < components.Length; i++)
		{
			if (components[i].name == "toggle")
			{
				controller = components[i];
				break;
			}
		}
		if (controller != null)
		{
			controller.defaultIndex = (value ? 1 : 0);
		}
	}

	public void SetIsOn(bool value, bool notify = true)
	{
		Controller[] components = toggle.GetComponents<Controller>();
		Controller controller = null;
		for (int i = 0; i < components.Length; i++)
		{
			if (components[i].name == "toggle")
			{
				controller = components[i];
				break;
			}
		}
		if (controller != null)
		{
			controller.SetSelectedState(value ? "on" : "off");
		}
		if (notify)
		{
			toggle.isOn = value;
		}
		else
		{
			toggle.SetIsOnWithoutNotify(value);
		}
		if (value)
		{
			FoldOut();
		}
		else
		{
			FoldIn();
		}
	}

	public void NotifySelect()
	{
		root.NotifyGroupSelect(index);
	}

	public void ForceLayout()
	{
		LayoutRebuilder.ForceRebuildLayoutImmediate((RectTransform)base.transform);
		if ((bool)root)
		{
			root.ForceLayout();
		}
	}

	public ToggleGroup GetToggleGroup()
	{
		if (toggleGroup == null)
		{
			toggleGroup = GetComponent<ToggleGroup>();
		}
		return toggleGroup;
	}

	public void SetIndex(int index)
	{
		this.index = index;
		if (iconType == GroupIconControllerType.Index)
		{
			if (indexController != null && index < indexController.stateValues.Count)
			{
				indexController.defaultIndex = index;
				indexController.SetSelectedIndex(index);
			}
		}
		else if (iconType == GroupIconControllerType.Value && root != null && index < root.data.groupDatas.Count)
		{
			indexController.SetSelectedState(root.data.groupDatas[index].controllerStateValue);
		}
	}

	public void SelectItem(int index)
	{
		root.selectedItem = index;
		bool allowSwitchOff = toggleGroup.allowSwitchOff;
		toggleGroup.allowSwitchOff = true;
		for (int i = 0; i < container.childCount; i++)
		{
			UITreeItem component = container.GetChild(i).GetComponent<UITreeItem>();
			component.toggle.group = null;
			component.SetIsOn(i == index);
			component.toggle.group = toggleGroup;
		}
		toggleGroup.allowSwitchOff = allowSwitchOff;
	}

	public UITreeItem GetSelectedItem()
	{
		if (root.selectedItem < 0)
		{
			return null;
		}
		if (root.selectedItem >= container.childCount)
		{
			return null;
		}
		return container.GetChild(root.selectedItem).GetComponent<UITreeItem>();
	}

	public RectTransform GetContainer()
	{
		return container;
	}

	public void Refresh()
	{
		int id = root.data.groupDatas[index].id;
		root.groupRenderer?.Invoke(id, base.gameObject);
		for (int i = 0; i < container.childCount; i++)
		{
			container.GetChild(i).gameObject.GetComponent<UITreeItem>().Refresh();
		}
	}

	public Text GetTitle()
	{
		return title;
	}
}
