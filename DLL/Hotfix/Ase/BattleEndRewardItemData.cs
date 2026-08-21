using System.Collections.Generic;

namespace Ase;

public class BattleEndRewardItemData : KnapsackItemViewModel
{
	private bool isExtraItem;

	private string extraText;

	private int rewardItemType;

	private long uid;

	private bool isLock;

	private Dictionary<int, string> exTraTextDic = new Dictionary<int, string>
	{
		[0] = "普通奖励",
		[1] = "组队奖励",
		[2] = "评分奖励",
		[3] = "道具加成"
	};

	public bool IsLock
	{
		get
		{
			return isLock;
		}
		set
		{
			Set(ref isLock, value, "IsLock");
		}
	}

	public bool IsExtraItem => isExtraItem;

	public string ExtraText => extraText;

	public int RewardItemType => rewardItemType;

	public long Uid => uid;

	public BattleEndRewardItemData(OptionBase parent, KnapsackPropData data, int type)
		: base(parent, data)
	{
		isExtraItem = false;
		extraText = exTraTextDic[type];
		rewardItemType = type;
		if (type != 0)
		{
			isExtraItem = true;
		}
		uid = 0L;
		isLock = false;
	}

	public BattleEndRewardItemData(OptionBase parent, EquipmentDataBase data, int type)
		: base(parent, data)
	{
		isExtraItem = false;
		extraText = exTraTextDic[type];
		rewardItemType = type;
		if (type != 0)
		{
			isExtraItem = true;
		}
		uid = data.Uid;
		isLock = false;
	}
}
