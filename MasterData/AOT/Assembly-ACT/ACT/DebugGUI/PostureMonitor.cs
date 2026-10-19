using ACT.Battle;
using Bamboo.ECS;

namespace ACT.DebugGUI;

public class PostureMonitor : EntityBehaveMonitor
{
	private DebugGUILabel burstLabel;

	private DebugGUILabel postureLabel;

	protected override bool OnInit()
	{
		burstLabel = new DebugGUILabel();
		postureLabel = new DebugGUILabel();
		ebwnd.AddGUI(burstLabel);
		ebwnd.AddGUI(postureLabel);
		if (eb.IsBattleBehaveNotCharacter())
		{
			CompAbility compAbility = eb.GetCompAbility();
			ebwnd.AddGUI(new DebugGUIButton("开起架势态", () =>
			{
				compAbility.SetPostureActive(value: true);
			}));
			ebwnd.AddGUI(new DebugGUIButton("关闭架势态", () =>
			{
				compAbility.SetPostureActive(value: false);
			}));
			ebwnd.AddGUI(new DebugGUIButton("开启狂暴态", () =>
			{
				compAbility.SetPostureBurst(value: true);
			}));
			ebwnd.AddGUI(new DebugGUIButton("关闭狂暴态", () =>
			{
				compAbility.SetPostureBurst(value: false);
			}));
			ebwnd.AddGUI(new DebugGUIButton("回复架势值", () =>
			{
				compAbility.ServerSetPosture(compAbility.maxPosture);
			}));
		}
		return base.OnInit();
	}

	public override void OnUpdate()
	{
		if (eb.IsBattleBehaveNotCharacter())
		{
			CompAbility compAbility = eb.GetCompAbility();
			burstLabel.label = $"是否爆发状态 ： {compAbility.IsPostureBurst}";
			postureLabel.label = $"是否架势状态 ： {compAbility.IsHavePosture}";
		}
		base.OnUpdate();
	}
}
