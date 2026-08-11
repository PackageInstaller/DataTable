#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;

namespace Ase;

public class ObserverUtility
{
	public static Dictionary<BattleObserverEventEnum, Type> observerConditionDic = new Dictionary<BattleObserverEventEnum, Type>
	{
		{
			BattleObserverEventEnum.EntityDead,
			typeof(ObserverEntityDeadRebornConditon)
		},
		{
			BattleObserverEventEnum.EntityReborn,
			typeof(ObserverEntityDeadRebornConditon)
		},
		{
			BattleObserverEventEnum.ReleaseSkill,
			typeof(ObserverReleaseSkillCondition)
		},
		{
			BattleObserverEventEnum.SkillDeriveWindow,
			typeof(ObserverSkillDeriveCondition)
		},
		{
			BattleObserverEventEnum.AddBuff,
			typeof(ObserverAddBuffCondition)
		},
		{
			BattleObserverEventEnum.RemoveBuff,
			typeof(ObserverRemoveBuffCondition)
		},
		{
			BattleObserverEventEnum.BuffLayerChanged,
			typeof(ObserverBuffLayerChangedCondition)
		},
		{
			BattleObserverEventEnum.Recover,
			typeof(ObserverRecoverCondition)
		},
		{
			BattleObserverEventEnum.ChangeState,
			typeof(ObserverEntityChangeStateConditon)
		},
		{
			BattleObserverEventEnum.AttackBefore,
			typeof(ObserverDamageProgressCondition)
		},
		{
			BattleObserverEventEnum.DamageBefore,
			typeof(ObserverDamageProgressCondition)
		},
		{
			BattleObserverEventEnum.Attack,
			typeof(ObserverDamageProgressCondition)
		},
		{
			BattleObserverEventEnum.Damage,
			typeof(ObserverDamageProgressCondition)
		},
		{
			BattleObserverEventEnum.InteractiveStart,
			typeof(ObserverInteractiveCondition)
		},
		{
			BattleObserverEventEnum.InteractiveSuccess,
			typeof(ObserverInteractiveCondition)
		},
		{
			BattleObserverEventEnum.InteractiveBreak,
			typeof(ObserverInteractiveCondition)
		},
		{
			BattleObserverEventEnum.RescueStart,
			typeof(ObserverRescueCondition)
		},
		{
			BattleObserverEventEnum.RescueSuccess,
			typeof(ObserverRescueCondition)
		},
		{
			BattleObserverEventEnum.RescueBreak,
			typeof(ObserverRescueCondition)
		},
		{
			BattleObserverEventEnum.WeaknessBar,
			typeof(ObserverWeaknessBarCondition)
		},
		{
			BattleObserverEventEnum.MoveState,
			typeof(ObserverMoveStateCondition)
		},
		{
			BattleObserverEventEnum.BattleStateChange,
			typeof(ObserverBattleStateCondition)
		}
	};

	public static ObserverConditionBase GetObserverCondition(BattleObserverEventEnum eventEnum)
	{
		if (observerConditionDic.TryGetValue(eventEnum, out var value))
		{
			return Activator.CreateInstance(value) as ObserverConditionBase;
		}
		Log.Error("未找到对应事件判断类:" + eventEnum);
		return null;
	}
}
