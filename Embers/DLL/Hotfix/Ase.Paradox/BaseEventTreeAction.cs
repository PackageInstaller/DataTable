using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine.Pool;

namespace Ase.Paradox;

public abstract class BaseEventTreeAction : ActionTaskBase
{
	[Name("绑定的实体Id", 0)]
	public BBParameter<int> EntityId;

	[Name("绑定的黑板值的key", 0)]
	public string BlackKey;

	[Name("黑板值设置的值", 0)]
	public float SetBlackValue;

	[Name("需要事件执行者", 0)]
	public bool ShowAttackId;

	[Name("事件执行者ID", 0)]
	[ShowIf("ShowAttackId", true)]
	public BBParameter<int> AttackId;

	[Name("需要事件触发者", 0)]
	public bool ShowDefenseId;

	[Name("事件触发者ID", 0)]
	[ShowIf("ShowDefenseId", true)]
	public BBParameter<int> DefenseId;

	[Name("返回注册Id", 0)]
	public BBParameter<int> returnActionId;

	protected Dictionary<int, EventTreeConditionParams> Condition;

	public abstract BattleObserverEventEnum EventEnum { get; }

	protected override void OnExecute()
	{
		base.OnExecute();
		Condition = CollectionPool<Dictionary<int, EventTreeConditionParams>, KeyValuePair<int, EventTreeConditionParams>>.Get();
		if (ShowAttackId)
		{
			Condition.Add(6001, EventTreeConditionParams.Create(AttackId.value));
		}
		if (ShowDefenseId)
		{
			Condition.Add(6003, EventTreeConditionParams.Create(DefenseId.value));
		}
	}

	protected void EventTreeEndAction()
	{
		BaseEntity entity = ownerEntity.GetSystem<EntitySystem>().GetEntity(EntityId.value);
		returnActionId.value = ownerEntity.GetSystem<ParadoxSystem>().RegistrationTree(entity, EventEnum, BlackKey, SetBlackValue, Condition, this);
		EndAction();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		Clear();
	}

	protected virtual void Clear()
	{
		if (Condition != null)
		{
			CollectionPool<Dictionary<int, EventTreeConditionParams>, KeyValuePair<int, EventTreeConditionParams>>.Release(Condition);
			Condition = null;
		}
	}
}
