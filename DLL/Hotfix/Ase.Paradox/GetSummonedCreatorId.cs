using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取召唤物创建者ID", 0)]
[Description("获取召唤物创建者 ID。")]
[Category("✫ DragonLost/Entity")]
public class GetSummonedCreatorId : ActionTaskBase
{
	[Name("召唤物ID", 0)]
	[Description("召唤物ID。")]
	public BBParameter<int> summonedId;

	[Space(10)]
	[Name("创建者ID", 0)]
	public BBParameter<int> creatorId;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (ownerEntity.GetSystem<EntitySystem>().GetEntity(summonedId.value) is SummonedEntity { Parent: not null } summonedEntity)
		{
			creatorId.value = summonedEntity.Parent.Id;
			EndAction();
		}
	}
}
