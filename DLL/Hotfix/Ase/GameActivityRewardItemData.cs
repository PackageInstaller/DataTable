using System.Collections.Generic;

namespace Ase;

public class GameActivityRewardItemData : OptionBase
{
	private int activeLevel;

	private int rewardId;

	private int state;

	private bool isSelect;

	private float position;

	private int indexId;

	private bool canOnClick;

	private List<KnapsackItemViewModel> rewardItemDataList;

	public int State
	{
		get
		{
			return state;
		}
		private set
		{
			Set(ref state, value, "State");
		}
	}

	public bool IsSelect
	{
		get
		{
			return isSelect;
		}
		set
		{
			Set(ref isSelect, value, "IsSelect");
		}
	}

	public int ActiveLevel => activeLevel;

	public int RewardId => rewardId;

	public List<KnapsackItemViewModel> RewardItemDataList => rewardItemDataList;

	public float Position => position;

	public int IndexId => indexId;

	public GameActivityRewardItemData(OptionBase parent, int rewardId, int activeLevel, int indexId)
	{
		base.parent = parent;
		this.rewardId = rewardId;
		this.activeLevel = activeLevel;
		canOnClick = true;
		State = 1;
		this.indexId = indexId;
		rewardItemDataList = new List<KnapsackItemViewModel>();
	}

	public void SetRewardList(List<KnapsackItemViewModel> rewardItemDataList)
	{
		this.rewardItemDataList = rewardItemDataList;
		foreach (KnapsackItemViewModel rewardItemData in rewardItemDataList)
		{
			rewardItemData.SetParent(this);
			if (State == 3)
			{
				rewardItemData.IsSelected = true;
			}
		}
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is KnapsackItemViewModel knapsackItemViewModel)
		{
			OpenViewArg openViewArg = knapsackItemViewModel.OpenPopupWindow(this);
			if (openViewArg != null)
			{
				parent?.ItemOnClick(openViewArg);
			}
		}
		else if (obj is OpenViewArg obj2)
		{
			parent?.ItemOnClick(obj2);
		}
	}

	public void SetState(bool receive)
	{
		if (!receive)
		{
			return;
		}
		State = 3;
		foreach (KnapsackItemViewModel rewardItemData in rewardItemDataList)
		{
			rewardItemData.IsSelected = true;
		}
	}

	public void SetState(int point)
	{
		if (State != 3 && point >= activeLevel)
		{
			State = 2;
		}
	}

	public void OnClick(float position)
	{
		if (canOnClick)
		{
			this.position = position;
			canOnClick = false;
			string optionName = ((State == 2) ? "Receive" : "Open");
			parent?.ItemOnClick(new OptionArg(this, optionName));
		}
	}

	public void ReSetBtn()
	{
		canOnClick = true;
	}
}
