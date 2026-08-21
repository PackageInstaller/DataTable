using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取实体受击后的状态", 0)]
[Description("获取实体受到伤害后的状态,如果死亡则获取死亡前的受伤状态")]
[Category("✫ DragonLost/Entity")]
public class GetEntityDamageState : ActionTaskBase
{
	[Name("实体ID", 0)]
	public BBParameter<int> EntityId;

	[Name("状态ID", 0)]
	public BBParameter<int> StateId;

	protected override void OnExecute()
	{
		base.OnExecute();
		BattleDamageProgressSystem.DamageResultStateInfo obj = ownerEntity.GetSystem<BattleDamageProgressSystem>()?.GetDamageResultInfo(EntityId.value);
		StateId.value = obj?.damageState ?? 0;
	}
}
