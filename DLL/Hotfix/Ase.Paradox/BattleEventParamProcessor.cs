using System.Collections.Generic;
using UnityEngine.Pool;

namespace Ase.Paradox;

public abstract class BattleEventParamProcessor
{
	protected Dictionary<int, EventTreeConditionParams> ConditionParams;

	public Dictionary<int, EventTreeConditionParams> BattleEventParam => ConditionParams;

	protected BattleEventParamProcessor()
	{
		ConditionParams = CollectionPool<Dictionary<int, EventTreeConditionParams>, KeyValuePair<int, EventTreeConditionParams>>.Get();
	}

	public virtual void Processor(IObserverParams observerParams)
	{
		ConditionParams.Clear();
	}

	public static BattleEventParamProcessor CreateProcessor(BattleObserverEventEnum eventEnum)
	{
		return eventEnum switch
		{
			BattleObserverEventEnum.Hit => new HitEventParamProcessor(), 
			BattleObserverEventEnum.AttackBossWeak => new WeaknessParamProcessor(), 
			BattleObserverEventEnum.ReleaseSkill => new ReleaseSkillParamProcessor(), 
			BattleObserverEventEnum.Recover => new RecoverParamProcessor(), 
			_ => null, 
		};
	}

	public void Clear()
	{
		if (ConditionParams != null)
		{
			ConditionParams.Clear();
			CollectionPool<Dictionary<int, EventTreeConditionParams>, KeyValuePair<int, EventTreeConditionParams>>.Release(ConditionParams);
		}
	}
}
