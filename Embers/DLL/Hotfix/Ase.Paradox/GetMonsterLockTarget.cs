#define ENABLE_LOG
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取怪物锁敌目标", 0)]
[Category("✫ DragonLost/Monster")]
[Description("获取指定怪物实体锁定的目标ID，并判断是否为自身")]
public class GetMonsterLockTarget : ActionTaskBase
{
	[Name("怪物ID", 0)]
	[Description("要获取锁敌目标的怪物实体的ID")]
	public BBParameter<int> MonsterId;

	[Name("锁定的目标ID", 0)]
	[Description("存储获取到的怪物锁定的目标ID")]
	public BBParameter<int> LockTargetId;

	[Name("目标是否是自己", 0)]
	[Description("存储是否锁定的目标是怪物自身")]
	public BBParameter<bool> IsSelf;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (!(GetEntity(MonsterId.value, isSyncEntity: false) is MonsterEntity monsterEntity))
		{
			LogActionError("获取怪物锁敌目标: 实体为空!");
			EndAction();
			return;
		}
		int variableValue = monsterEntity.GetComponent<AIParadoxComponent>().GetVariableValue<int>("e_targetID");
		LockTargetId.value = variableValue;
		IsSelf.value = ownerEntity.Id == variableValue;
		EndAction();
	}
}
