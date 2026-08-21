using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class GamePropGuideViewModel : OptionBase
{
	public class GameNotePropSort : Comparer<GamePropGuideItemData>
	{
		public override int Compare(GamePropGuideItemData x, GamePropGuideItemData y)
		{
			if (y.SortId.CompareTo(x.SortId) != 0)
			{
				return x.SortId.CompareTo(y.SortId);
			}
			if (y.Rarity.CompareTo(x.Rarity) != 0)
			{
				return x.Rarity.CompareTo(y.Rarity);
			}
			if (y.ID.CompareTo(x.ID) != 0)
			{
				return x.ID.CompareTo(y.ID);
			}
			return 0;
		}
	}

	private List<GamePropGuideItemData> originalPropDataList;

	private List<GamePropGuideItemData> showPropGuideItemDataList;

	private List<TabItemNormalData> tagDataList;

	private TabItemNormalData curTag;

	private GamePropGuideItemData curPropGuideItemData;

	private bool isLock;

	private string tipText;

	private string propIconPath;

	private string propName;

	private string propDesc;

	private InteractionRequest refreshShowPropGuideItemRequest;

	private InteractionRequest refreshItemRequest;

	public List<GamePropGuideItemData> ShowPropGuideItemDataList
	{
		get
		{
			return showPropGuideItemDataList;
		}
		private set
		{
			Set(ref showPropGuideItemDataList, value, "ShowPropGuideItemDataList");
		}
	}

	public List<TabItemNormalData> TagDataList
	{
		get
		{
			return tagDataList;
		}
		private set
		{
			Set(ref tagDataList, value, "TagDataList");
		}
	}

	public string PropIconPath
	{
		get
		{
			return propIconPath;
		}
		private set
		{
			Set(ref propIconPath, value, "PropIconPath");
		}
	}

	public string PropName
	{
		get
		{
			return propName;
		}
		private set
		{
			Set(ref propName, value, "PropName");
		}
	}

	public string PropDesc
	{
		get
		{
			return propDesc;
		}
		private set
		{
			Set(ref propDesc, value, "PropDesc");
		}
	}

	public bool IsLock
	{
		get
		{
			return isLock;
		}
		private set
		{
			Set(ref isLock, value, "IsLock");
		}
	}

	public string TipText
	{
		get
		{
			return tipText;
		}
		private set
		{
			Set(ref tipText, value, "TipText");
		}
	}

	public GamePropGuideItemData CurPropGuideItemData => curPropGuideItemData;

	public InteractionRequest RefreshShowPropGuideItemRequest => refreshShowPropGuideItemRequest;

	public InteractionRequest RefreshItemRequest => refreshItemRequest;

	public GamePropGuideViewModel(OptionBase parent, List<GamePropGuideItemData> originalPropDataList, List<TabItemNormalData> tagDataList)
	{
		base.parent = parent;
		this.originalPropDataList = originalPropDataList;
		this.tagDataList = tagDataList;
		foreach (GamePropGuideItemData originalPropData in originalPropDataList)
		{
			originalPropData.SetParent(this);
		}
		foreach (TabItemNormalData tagData in tagDataList)
		{
			tagData.SetParent(this);
		}
		refreshShowPropGuideItemRequest = new InteractionRequest();
		refreshItemRequest = new InteractionRequest();
		SelectTagItemData(tagDataList[0]);
		SelectPropGuideItemData(ShowPropGuideItemDataList[0]);
		CheckTagRedPoint();
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is OptionArg optionArg)
		{
			if (optionArg.Obj is GamePropGuideItemData propGuideItemData && "OnClick".Equals(optionArg.OptionName))
			{
				SelectPropGuideItemData(propGuideItemData);
				refreshItemRequest.Raise();
				CheckTagRedPoint();
			}
		}
		else if (obj is TabItemNormalData { IsSelected: false } tabItemNormalData)
		{
			SelectTagItemData(tabItemNormalData);
			SelectPropGuideItemData(ShowPropGuideItemDataList[0]);
			refreshShowPropGuideItemRequest.Raise();
			refreshItemRequest.Raise();
		}
	}

	private void SelectPropGuideItemData(GamePropGuideItemData propGuideItemData)
	{
		curPropGuideItemData?.SetSelected(value: false);
		curPropGuideItemData = propGuideItemData;
		curPropGuideItemData.SetSelected(value: true);
		propGuideItemData.SetRedPoint();
		IsLock = curPropGuideItemData.IsLock;
		SetTipText();
		PropIconPath = curPropGuideItemData.IconPath;
		PropName = curPropGuideItemData.PropName;
		PropDesc = curPropGuideItemData.PropDesc.Replace("\\n", "\n");
	}

	private void SetTipText()
	{
		if (!IsLock)
		{
			TipText = "";
			return;
		}
		string text = "";
		switch (curPropGuideItemData.PropGuideType)
		{
		case 1:
			text = "武魂";
			break;
		case 2:
			text = "藏品";
			break;
		}
		TipText = "该" + text + "尚未解锁";
	}

	private void SelectTagItemData(TabItemNormalData tagItemData)
	{
		ClearCurTabRedPoint();
		CheckTagRedPoint();
		curTag = tagItemData;
		foreach (TabItemNormalData tagData in tagDataList)
		{
			tagData.IsSelected = tagData.ID == tagItemData.ID;
		}
		ShowPropGuideItemDataList = originalPropDataList.FindAll((GamePropGuideItemData p) => p.PropGuideType == tagItemData.ID);
		ShowPropGuideItemDataList.Sort(new GameNotePropSort());
	}

	private void ClearCurTabRedPoint()
	{
		if (curTag == null)
		{
			return;
		}
		foreach (GamePropGuideItemData showPropGuideItemData in ShowPropGuideItemDataList)
		{
			showPropGuideItemData.SetRedPoint();
		}
		foreach (TabItemNormalData tagData in tagDataList)
		{
			if (tagData.IsSelected)
			{
				tagData.RedPoint = false;
				break;
			}
		}
	}

	private void CheckTagRedPoint()
	{
		foreach (TabItemNormalData tagData in TagDataList)
		{
			tagData.RedPoint = false;
			foreach (GamePropGuideItemData originalPropData in originalPropDataList)
			{
				if (originalPropData.PropGuideType == tagData.ID && originalPropData.IsNew)
				{
					tagData.RedPoint = true;
					break;
				}
			}
		}
	}

	public override void Close()
	{
		ClearCurTabRedPoint();
		string optionName = "false";
		foreach (TabItemNormalData tagData in tagDataList)
		{
			if (tagData.RedPoint)
			{
				optionName = "true";
				break;
			}
		}
		parent?.ItemOnClick(new OptionArg(this, optionName));
		base.Close();
	}
}
