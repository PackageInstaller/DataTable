using System.Collections.Generic;

namespace Ase;

public class BuffConditionDelayExcute : BuffConditionBase
{
	private float delayTime;

	public override BuffConditionType BuffConditionType => BuffConditionType.DelayExcute;

	protected override int paramsMinCount => 1;

	protected override void OnInit(List<string> paramList)
	{
		delayTime = Utility.Convert.StringToFloat(paramList[0]);
	}

	protected override string OnGetDataString()
	{
		return $"{delayTime}";
	}

	public override bool OnCheck(Buff buff = null)
	{
		if (buff == null)
		{
			return false;
		}
		if (buff.CurLifeTime == 0f)
		{
			return false;
		}
		return buff.CurLifeTime >= delayTime;
	}
}
