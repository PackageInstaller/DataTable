namespace Ase;

public class StarConditionItem2Data : OptionBase
{
	private int _starCount;

	private string _text;

	private int _singleStarState;

	public int StarCount => _starCount;

	public string Text => _text;

	public int SingleStarState => _singleStarState;

	public StarConditionItem2Data(DRStarCondition drStarCondition, int value)
	{
		if (drStarCondition.JudgingCondition == 1 && drStarCondition.StarCondition == 1001)
		{
			float starConditionNum = drStarCondition.StarConditionNum;
			_text = $"{starConditionNum}秒内击败BOSS";
			_singleStarState = ((!((float)value >= starConditionNum)) ? 2 : 0);
		}
	}

	public StarConditionItem2Data()
	{
		_singleStarState = 1;
		_text = "战斗中死亡1次";
	}

	public StarConditionItem2Data(int maxValue, int maxBattleTime, int starCount, bool isDeath = false, int death = 0)
	{
		if (isDeath)
		{
			_starCount = death;
			_text = ((death == 0) ? "<color=#7B7B7B>未扣除璀璨星徽" : $"战斗中死亡{death}次");
		}
		else
		{
			_starCount = starCount;
			_text = ((starCount > 0) ? $"{maxValue}秒内通关" : $"{maxBattleTime}秒内通关");
		}
	}
}
