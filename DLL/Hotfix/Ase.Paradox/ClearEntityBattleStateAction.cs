using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("实体脱离战斗状态", 0)]
[Description("实体脱离战斗状态")]
[Category("✫ DragonLost/Entity")]
public class ClearEntityBattleStateAction : ActionTaskBase
{
	[Name("脱离战斗状态的实体ID", 0)]
	[Description("脱离战斗状态的实体ID")]
	public BBParameter<int> EntityID;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetSystem<BattleStateSystem>().ClearEntityBattleState(EntityID.value);
		OnActionFinish();
	}
}
