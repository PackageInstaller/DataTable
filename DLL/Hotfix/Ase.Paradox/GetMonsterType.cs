#define ENABLE_LOG
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取怪物种类", 0)]
[Category("✫ DragonLost/Monster")]
[Description("获取指定怪物实体的种类ID")]
public class GetMonsterType : ActionTaskBase
{
	[Name("实体ID", 0)]
	[Description("要获取种类的怪物实体的ID")]
	public BBParameter<int> EntityId;

	[Name("类型ID", 0)]
	[Description("存储获取到的怪物种类ID")]
	public BBParameter<int> EntityType;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (!(GetEntity(EntityId.value, isSyncEntity: false) is MonsterEntity monsterEntity))
		{
			LogActionError("获取怪物种类: 实体为空!");
			EndAction();
		}
		else
		{
			EntityType.value = monsterEntity.MonsterType();
			EndAction();
		}
	}
}
