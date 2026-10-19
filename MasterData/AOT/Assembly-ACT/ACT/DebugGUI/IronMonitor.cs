using ACT.Battle;
using Bamboo.ECS;

namespace ACT.DebugGUI;

public class IronMonitor : EntityBehaveMonitor
{
	private bool isIron;

	protected override bool OnInit()
	{
		DebugGUIToggle debugGUI = new DebugGUIToggle("无敌", (bool b) =>
		{
			isIron = b;
		});
		ebwnd.AddGUI(debugGUI);
		return true;
	}

	public override void OnUpdate()
	{
		if (isIron)
		{
			CompAbility? compAbility = eb.GetCompAbility();
			compAbility.SetHPWithoutNotify(compAbility.maxHP);
		}
	}
}
