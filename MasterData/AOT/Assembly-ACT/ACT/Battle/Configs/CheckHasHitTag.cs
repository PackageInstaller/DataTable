using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断命中标签", "Predicate", new string[] { "check", "has", "hit", "tag", "state", "status", "predicate", "condition" })]
public class CheckHasHitTag : ConfigPredicate
{
	[Tooltip("检测是否包含指定的HitTag")]
	public HitTag hitTag;

	public override bool Check(ActionMemory memory)
	{
		if (memory.evt is IGetAttackData getAttackData)
		{
			return getAttackData.GetAttackData().hitTag.HasFlag(hitTag);
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError("'CheckHasHitTag'只能在有AttackData数据的事件中使用");
		}
		return false;
	}
}
