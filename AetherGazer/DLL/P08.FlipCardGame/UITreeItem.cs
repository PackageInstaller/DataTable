using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class UITreeItem : UIBehaviour
{
	[SerializeField]
	private Text title;

	[SerializeField]
	public Toggle toggle;

	[SerializeField]
	private int index;

	[SerializeField]
	private UITree root;

	[SerializeField]
	private UITreeGroup treeGroup;

	[SerializeField]
	public RectTransform noticeContainer;

	protected override void Awake()
	{
		toggle.onValueChanged.AddListener(delegate(bool isOn)
		{
			if (isOn)
			{
				NotifySelect();
			}
		});
	}

	public void SetData(UITreeItemData data)
	{
		if (title != null)
		{
			title.text = data.text;
		}
		root.itemRenderer?.Invoke(data.id, base.gameObject);
	}

	public void SetTree(UITree root)
	{
		this.root = root;
	}

	public void SetGroup(UITreeGroup g)
	{
		treeGroup = g;
	}

	public void SetIsOn(bool value)
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
		toggle.isOn = value;
	}

	public void NotifySelect()
	{
		if (treeGroup != null)
		{
			root.NotifyItemSelect(treeGroup.index, index);
		}
	}

	public void SetIndex(int index)
	{
		this.index = index;
	}

	public void Refresh()
	{
		int id = root.data.groupDatas[treeGroup.index].itemDatas[index].id;
		root.itemRenderer?.Invoke(id, base.gameObject);
	}

	public Text GetTitle()
	{
		return title;
	}
}
