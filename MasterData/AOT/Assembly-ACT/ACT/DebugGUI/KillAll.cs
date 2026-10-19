using ACT.Battle;
using Bamboo.ECS;

namespace ACT.DebugGUI;

public class KillAll : SingleMonitor
{
	protected override bool OnInit()
	{
		sigwnd.AddGUI(new DebugGUIButton("kill all", () =>
		{
			GameManager.entities.ForEachEntities((Entity eb) =>
			{
				if (eb.GetAlliance() == Alliance.Enemy && eb.CanRemove() && eb.IsMonster())
				{
					eb.KillEntity();
				}
			});
		}));
		sigwnd.AddGUI(new DebugGUIButton("kill self", () =>
		{
			Entity mainEntity = MonoECS.instance.mainEntity;
			mainEntity.GetCompAbility().ServerSetHP(0);
			mainEntity.KillEntity();
		}));
		return true;
	}
}
