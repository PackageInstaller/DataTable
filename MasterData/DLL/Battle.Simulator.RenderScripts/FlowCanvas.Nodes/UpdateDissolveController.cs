using ParadoxNotion.Design;
using RenderPipeline.SimPipeline.Script.Scene;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("更新部件溶解效果(控制器版)(渲染)", 0)]
[Category("Render/Buff/Buff特效/溶解")]
[Description("更新部件溶解效果,如果部件是关闭状态也会自动启动,关闭需要使用【启用或关闭部件溶解效果】;\n从 tpose 下级开始,例如 cloth01")]
public class UpdateDissolveController : FlowControlNodeOfRender
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDInput = AddValueInput<int>("实体ID", "agentID");
		ValueInput<string> partPathInput = AddValueInput<string>("部件路径(完整)", "partPath").SetDefaultAndSerializedValue(string.Empty);
		ValueInput<float> factorInput = AddValueInput<float>("值(0-1)", "value");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "intput", delegate(Flow f)
		{
			if (string.IsNullOrEmpty(partPathInput.value))
			{
				errorOut.Call(f);
			}
			else
			{
				BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
				if (battleScene == null)
				{
					errorOut.Call(f);
				}
				else
				{
					NAgent agent = battleScene.GetAgentManager().GetAgent(agentIDInput.value);
					if (agent == null)
					{
						errorOut.Call(f);
					}
					else
					{
						Transform transform = agent.transform.Find(partPathInput.value);
						if (transform == null)
						{
							errorOut.Call(f);
						}
						else
						{
							DissolveController dissolveController = U3DUtil.Get<DissolveController>(transform.gameObject);
							if (!dissolveController.enabled)
							{
								dissolveController.enabled = true;
							}
							dissolveController.dissolveIntensity = factorInput.value;
							output.Call(f);
						}
					}
				}
			}
		});
		AddValueOutput("实体ID", "agentID", () => agentIDInput.value);
	}
}
