using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("取消红锁图标(渲染)", 0)]
[Category("Render/Camera")]
[Description("设置相机手动锁定某个怪, 传进来的如果不是怪可能会出错")]
public class CancelRedLock : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null)
			{
				errorOut.Call(f);
			}
			else
			{
				WorldStateManager worldSatetManager = battleScene.GetWorldSatetManager();
				if (worldSatetManager == null)
				{
					errorOut.Call(f);
				}
				else
				{
					if (worldSatetManager.hasManualLock)
					{
						worldSatetManager.hasManualLock = false;
						worldSatetManager.lockedAgentID = 0;
					}
					output.Call(f);
				}
			}
		});
	}
}
