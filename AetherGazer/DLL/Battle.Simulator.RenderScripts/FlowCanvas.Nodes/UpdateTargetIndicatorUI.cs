using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("更新UI上的路径点指示器(渲染)", 0)]
[Category("Render/Trigger")]
[Description("更新UI上的路径点指示器(渲染)")]
public class UpdateTargetIndicatorUI : FlowNode
{
	private TargetIndicatorUI mTargetIndicatorUI;

	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		ValueInput<bool> flagInput = AddValueInput<bool>("开关");
		ValueInput<Int3> targetPosInput = AddValueInput<Int3>("目标点");
		AddFlowInput("", delegate(Flow f)
		{
			if (mTargetIndicatorUI == null)
			{
				BattleUI battleUI = BattleUI.GetBattleUI();
				if (battleUI != null)
				{
					mTargetIndicatorUI = battleUI.TragetIndicatorUI;
				}
			}
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null || battleScene.GetBattleSimulatorSystem() == null || battleScene.GetAgentManager() == null || battleScene.GetAgentManager().GetPlayerAgent() == null)
			{
				output.Call(f);
			}
			else
			{
				Transform transform = battleScene.GetAgentManager().GetPlayerAgent().transform;
				if (transform == null)
				{
					output.Call(f);
				}
				else
				{
					if (mTargetIndicatorUI != null)
					{
						if (flagInput.value)
						{
							Vector3 vector = (Vector3)targetPosInput.value;
							mTargetIndicatorUI.MUnderPathControl = false;
							mTargetIndicatorUI.DrawUI(enable: true, transform.position, vector, Vector3.Distance(transform.position, vector));
						}
						else
						{
							mTargetIndicatorUI.DrawUI(enable: false, Vector3.zero, Vector3.zero, 0f);
							mTargetIndicatorUI.MUnderPathControl = true;
						}
					}
					output.Call(f);
				}
			}
		});
	}
}
