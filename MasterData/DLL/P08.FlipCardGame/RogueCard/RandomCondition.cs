using System;

namespace RogueCard;

public class RandomCondition : BaseCondition
{
	private int value;

	public RandomCondition(int[] param)
	{
		value = param[0];
	}

	public override bool Check(TriggerMoment moment)
	{
		if (new Random().Next(100) < value)
		{
			return true;
		}
		return false;
	}
}
