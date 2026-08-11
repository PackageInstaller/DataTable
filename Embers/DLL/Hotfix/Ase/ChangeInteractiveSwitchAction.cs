using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase;

[Name("修改交互开关（多人交互使用）", 0)]
[Description("根据指定的开关值修改交互物体的开关状态。")]
[Category("✫ DragonLost/Interactive")]
public class ChangeInteractiveSwitchAction : ActionTaskBase
{
	[Name("开关值", 0)]
	[Description("要设置的交互物体的开关状态值。")]
	public BBParameter<bool> switchValue = new BBParameter<bool>();

	protected override async void OnExecute()
	{
		base.OnExecute();
		GetOwnerEntity().GetComponent<BattleInteractiveStateComponent>().ChangeInteractiveSwitch(switchValue.value);
		OnActionFinish();
	}
}
