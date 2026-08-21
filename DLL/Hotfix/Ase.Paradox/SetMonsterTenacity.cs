#define ENABLE_LOG
using System;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("设置怪物韧性", 0)]
[Category("✫ DragonLost/Monster")]
[Description("根据攻击者实体ID设置怪物的韧性")]
[Obsolete("当前节点弃用")]
public class SetMonsterTenacity : ActionTaskBase
{
	[Name("攻击者实体ID", 0)]
	[Description("进行攻击的实体的ID")]
	public BBParameter<int> AttackId;

	[Name("实体ID", 0)]
	[Description("要设置韧性的怪物实体的ID")]
	public BBParameter<int> EntityId;

	[Name("削韧值", 0)]
	[Description("要削减的韧性值")]
	public BBParameter<float> Value;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(EntityId.value, isSyncEntity: false);
		BaseEntity entity2 = GetEntity(AttackId.value, isSyncEntity: false);
		if (entity == null || entity2 == null)
		{
			LogActionError("设置怪物韧性错误：实体为空!");
			EndAction();
			return;
		}
		bool bossKnockDown = false;
		int realTenacityValue = 0;
		entity.GetComponent<TenacityComponent>().DealTenacityHit(Value.value, entity2, ref bossKnockDown, ref realTenacityValue);
		entity2.GetSystem<BattleSystem>().Account(AccountType.Tenacity, realTenacityValue, entity2.Id);
		EndAction();
	}
}
