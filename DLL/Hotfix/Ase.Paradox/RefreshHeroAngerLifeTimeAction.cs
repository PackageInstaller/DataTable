using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("刷新英雄怒气的衰减时间", 0)]
[Description("刷新指定实体的英雄怒气的衰减时间。")]
[Category("✫ DragonLost/Entity")]
public class RefreshHeroAngerLifeTimeAction : ActionTaskBase
{
	[Name("实体ID", 0)]
	[Description("要刷新怒气衰减时间的实体的ID。")]
	public BBParameter<int> EntityId;

	protected override void OnExecute()
	{
		base.OnExecute();
		GetEntity(EntityId.value, isSyncEntity: false).GetComponent<HeroAngerComponent>()?.RefreshHeroAngerLifeTime();
		EndAction();
	}
}
