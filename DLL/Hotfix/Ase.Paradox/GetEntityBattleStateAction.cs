using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("检查实体是否处于战斗状态", 0)]
[Category("✫ DragonLost/Entity")]
[Description("检查实体是否处于战斗状态")]
public class GetEntityBattleStateAction : ConditionTaskBase
{
	[Name("实体ID", 0)]
	[Description("需要检测实体战斗状态的ID。")]
	public BBParameter<int> EntityId;

	protected override bool OnCheck()
	{
		base.OnCheck();
		return ownerEntity.GetSystem<BattleStateSystem>().GetEntityBattleState(EntityId.value);
	}
}
