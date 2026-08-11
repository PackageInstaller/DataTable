using System.Collections.Generic;

namespace Ase;

public class AchievementProgressItemData : OptionBase
{
	private string title;

	private string fillText;

	private float fill;

	private List<AchievementRewardItemData> achievementRewardItemDataList;

	private bool canReceived;

	public int type;

	public string Title
	{
		get
		{
			return title;
		}
		set
		{
			Set(ref title, value, "Title");
		}
	}

	public float Fill
	{
		get
		{
			return fill;
		}
		set
		{
			Set(ref fill, value, "Fill");
		}
	}

	public string FillText
	{
		get
		{
			return fillText;
		}
		set
		{
			Set(ref fillText, value, "FillText");
		}
	}

	public bool CanReceived
	{
		get
		{
			return canReceived;
		}
		set
		{
			Set(ref canReceived, value, "CanReceived");
		}
	}

	public List<AchievementRewardItemData> AchievementRewardItemDataList
	{
		get
		{
			return achievementRewardItemDataList;
		}
		set
		{
			Set(ref achievementRewardItemDataList, value, "AchievementRewardItemDataList");
		}
	}

	public AchievementProgressItemData(OptionBase parent, int type, string title, int finishNum, int targetNum, int groupId, int state)
	{
		base.parent = parent;
		this.type = type;
		this.title = title;
		achievementRewardItemDataList = new List<AchievementRewardItemData>();
		fillText = $"{finishNum}/{targetNum}";
		fill = ((finishNum >= targetNum) ? 1f : ((float)finishNum / (float)targetNum));
		int num = ((finishNum >= targetNum) ? 1 : 2);
		num = ((state >= 1) ? 3 : num);
		CanReceived = num == 1;
		LoadReward(groupId, num);
	}

	private void LoadReward(int groupId, int state)
	{
		List<int> list = GameEntry.DataTable.GetDataTable<DRDropGroups>().GetDataRow((DRDropGroups p) => p.GroupId == groupId)?.ChildrenSetId;
		if (list == null)
		{
			return;
		}
		foreach (int goodsId in list)
		{
			DRGoodsGroup[] dataRows = GameEntry.DataTable.GetDataTable<DRGoodsGroup>().GetDataRows((DRGoodsGroup p) => p.ChildSetId == goodsId);
			foreach (DRGoodsGroup dRGoodsGroup in dataRows)
			{
				PropDataBase propDataBase = PropDataBase.CreateByType(dRGoodsGroup.Type, dRGoodsGroup.GoodsId, dRGoodsGroup.GoodsMin);
				AchievementRewardItemData item = new AchievementRewardItemData(this, propDataBase.Icon, propDataBase.GetRarity(), propDataBase.Amount, state);
				achievementRewardItemDataList.Add(item);
			}
		}
	}

	public void SetReceived()
	{
		foreach (AchievementRewardItemData achievementRewardItemData in achievementRewardItemDataList)
		{
			achievementRewardItemData.SetState(3);
		}
	}

	public void OpenAchieve()
	{
		parent?.ItemOnClick(new OptionArg(this, "OpenAchieve"));
	}

	public void ReceiveReward()
	{
		parent?.ItemOnClick(new OptionArg(this, "ReceiveReward"));
	}
}
