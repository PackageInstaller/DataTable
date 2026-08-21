#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using GameFramework;

namespace Ase;

[Obsolete("时间区间不适合事件Timing机制,已新增单独的区间机制")]
public class ObserverSkillBreakCondition : ObserverConditionBase
{
	protected override bool IsCondition(IObserverParams param, ObserverConditionParams[] conditionParams)
	{
		Log.Error("该条件判断以弃用");
		return false;
	}
}
