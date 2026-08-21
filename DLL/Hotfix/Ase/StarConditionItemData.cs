#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;

namespace Ase;

public class StarConditionItemData : OptionBase
{
	private bool isBroken;

	private int count;

	private bool isTrue;

	private string condition;

	private int color;

	public string Condition => condition;

	public bool IsBroken
	{
		get
		{
			return isBroken;
		}
		private set
		{
			Set(ref isBroken, value, "IsBroken");
		}
	}

	public bool IsTrue
	{
		get
		{
			return isTrue;
		}
		set
		{
			Set(ref isTrue, value, "IsTrue");
		}
	}

	public int Count
	{
		get
		{
			return count;
		}
		private set
		{
			Set(ref count, value, "Count");
		}
	}

	public int Color
	{
		get
		{
			return color;
		}
		set
		{
			Set(ref color, value, "Color");
		}
	}

	public StarConditionItemData()
	{
	}

	public StarConditionItemData(bool isTrue, float targetCondition, int type, DRStarConditionList drStarCondition, int count = 1)
	{
		this.isTrue = isTrue;
		switch (type)
		{
		case 1:
			condition = drStarCondition.StarCondition + "小于" + targetCondition + drStarCondition.Suffix;
			break;
		case 2:
			condition = drStarCondition.StarCondition + "大于" + targetCondition + drStarCondition.Suffix;
			break;
		default:
			condition = "条件错误!";
			Log.Error("评分条件参数错误");
			break;
		}
		this.count = count;
	}

	public StarConditionItemData(bool isBroken, string text, int color)
	{
		this.isBroken = isBroken;
		condition = text;
		this.color = color;
		Count = 1;
	}
}
