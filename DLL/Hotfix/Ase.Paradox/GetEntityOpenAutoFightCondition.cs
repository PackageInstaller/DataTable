using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取实体是否开启自动战斗", 0)]
[Category("✫ DragonLost/Entity")]
[Description("获取实体是否开启自动战斗")]
public class GetEntityOpenAutoFightCondition : ConditionTaskBase
{
	[Name("目标实体ID", 0)]
	[Description("目标实体ID")]
	public BBParameter<int> targetEntityId;

	protected override bool OnCheck()
	{
		base.OnCheck();
		BaseEntity entity = GetOwnerEntity().GetSystem<EntitySystem>().GetEntity(targetEntityId.value);
		if (entity == null)
		{
			return false;
		}
		return entity?.InFreedomBattleMode() ?? false;
	}
}
