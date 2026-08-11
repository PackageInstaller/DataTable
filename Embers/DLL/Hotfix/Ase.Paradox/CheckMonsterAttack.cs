using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("怪物申请攻击", 0)]
[Category("✫ DragonLost/Monster")]
[Description("检查怪物是否可以发起攻击请求。")]
public class CheckMonsterAttack : ConditionTaskBase
{
	[Name("目标实体ID", 0)]
	[Description("要攻击的目标实体的ID。")]
	[RequiredField]
	public BBParameter<int> targetId;

	protected override bool OnCheck()
	{
		base.OnCheck();
		if (ownerEntity is MonsterEntity monsterEntity)
		{
			MonsterAttackSystem system = monsterEntity.GetSystem<MonsterAttackSystem>();
			if (system != null && system.RequestAttackById(ownerEntity.Id, monsterEntity.GetMonsterAttackCtrlId(), targetId.value))
			{
				return true;
			}
		}
		return false;
	}
}
