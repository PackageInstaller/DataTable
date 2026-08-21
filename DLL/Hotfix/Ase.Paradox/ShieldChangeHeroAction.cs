using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("屏蔽切换AI", 0)]
[Category("✫ DragonLost/System")]
[Description("控制是否屏蔽角色之间的AI切换。")]
public class ShieldChangeHeroAction : ActionTaskBase
{
	[Name("是否屏蔽", 0)]
	[Description("设置为true以屏蔽角色之间的AI切换")]
	public BBParameter<bool> IsShield;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetSystem<BattleSystem>().IsShieldChange = IsShield.value;
		EndAction();
	}
}
