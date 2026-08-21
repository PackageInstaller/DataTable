using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("怪物攻击完成", 0)]
[Category("✫ DragonLost/Monster")]
[Description("标记怪物的攻击行为已完成")]
public class MonsterAttackEnd : ActionTaskBase
{
	[Name("目标ID", 0)]
	[RequiredField]
	[Description("要攻击的目标实体的ID")]
	public BBParameter<int> TargetId;

	[Name("是否立即执行", 0)]
	[RequiredField]
	[Description("确定是否立即执行攻击结束的操作")]
	public readonly BBParameter<bool> IsImmediatelyExecute = false;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (IsImmediatelyExecute.value)
		{
			if (ownerEntity is MonsterEntity monsterEntity)
			{
				monsterEntity.GetSystem<MonsterAttackSystem>()?.ReleaseAttackById(monsterEntity.GetMonsterAttackCtrlId(), TargetId.value, ownerEntity.Id);
			}
			else
			{
				EndAction(success: false);
			}
		}
		EndAction();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (ownerEntity != null && !IsImmediatelyExecute.value && ownerEntity is MonsterEntity monsterEntity)
		{
			monsterEntity.GetSystem<MonsterAttackSystem>()?.ReleaseAttackById(monsterEntity.GetMonsterAttackCtrlId(), TargetId.value, ownerEntity.Id);
		}
	}
}
