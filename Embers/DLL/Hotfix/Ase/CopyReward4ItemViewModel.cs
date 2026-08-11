using System.Collections.Generic;

namespace Ase;

public class CopyReward4ItemViewModel : OptionBase
{
	private int count;

	private int id;

	private int index;

	private int zone;

	private List<ReceiveItemViewModel> rewardItemDatas;

	private PropDataBase prop;

	private int state;

	private string name;

	private int copyZoneType;

	private int checkType;

	public int Count
	{
		get
		{
			return count;
		}
		set
		{
			Set(ref count, value, "Count");
		}
	}

	public int State
	{
		get
		{
			return state;
		}
		set
		{
			Set(ref state, value, "State");
		}
	}

	public List<ReceiveItemViewModel> RewardItemDatas => rewardItemDatas;

	public int Id => id;

	public int Index => index;

	public int Zone => zone;

	public string Name
	{
		get
		{
			return name;
		}
		set
		{
			Set(ref name, value, "Name");
		}
	}

	public int CopyZoneType => copyZoneType;

	public int CheckType => checkType;

	public CopyReward4ItemViewModel()
	{
	}

	public CopyReward4ItemViewModel(OptionBase parent, string name, int id, int copyZoneType, int count, List<PropDataBase> props)
	{
		base.parent = parent;
		this.name = name;
		this.copyZoneType = copyZoneType;
		this.id = id;
		index = id;
		zone = 0;
		this.count = count;
		rewardItemDatas = new List<ReceiveItemViewModel>();
		for (int i = 0; i < props.Count; i++)
		{
			rewardItemDatas.Add(new ReceiveItemViewModel(props[i], this));
		}
	}

	public CopyReward4ItemViewModel(OptionBase parent, int zone, int id, int index, int count, List<PropDataBase> props)
	{
		base.parent = parent;
		this.id = id;
		this.index = index;
		this.zone = zone;
		this.count = count;
		rewardItemDatas = new List<ReceiveItemViewModel>();
		for (int i = 0; i < props.Count; i++)
		{
			rewardItemDatas.Add(new ReceiveItemViewModel(props[i], this));
		}
	}

	public void SetCheckType(int checkType)
	{
		this.checkType = checkType;
	}

	public void SetState(int state)
	{
		State = state;
		for (int i = 0; i < rewardItemDatas.Count; i++)
		{
			rewardItemDatas[i].SetGot(state == 3);
			rewardItemDatas[i].SetLock(state == 2);
		}
	}

	public string GetPropIcon()
	{
		if (rewardItemDatas == null || rewardItemDatas.Count == 0)
		{
			return "";
		}
		return rewardItemDatas[0].PropDataBase.Icon;
	}

	public bool CheckScore(long score, long totalScore)
	{
		if (checkType != 1)
		{
			return totalScore >= count;
		}
		return score >= count;
	}

	public void OnClick()
	{
		if (state == 1)
		{
			parent.ItemOnClick(this);
		}
	}

	public override void ItemOnClick(object obj)
	{
		parent.ItemOnClick(obj);
	}
}
