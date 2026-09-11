using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline.Character;

namespace FlowCanvas.Nodes;

[Name("启用或关闭部件溶解效果(渲染)", 0)]
[Category("Render/Buff/Buff特效/溶解")]
[Description("启用或关闭部件溶解效果;\n从 tpose 下级开始,例如 cloth01")]
public class EnableDissoveEffectOfPart : FlowControlNodeOfRender
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDInput = AddValueInput<int>("实体ID", "agentID");
		ValueInput<string> partPathInput = AddValueInput<string>("部件路径(完整)", "partPath").SetDefaultAndSerializedValue(string.Empty);
		ValueInput<bool> enableInput = AddValueInput<bool>("启用", "enable");
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
							CharacterEffectOverrider component = transform.GetComponent<CharacterEffectOverrider>();
							if (component != null)
							{
								component.enabled = enableInput.value;
							}
							output.Call(f);
						}
					}
				}
			}
		});
		AddValueOutput("实体ID", "agentID", () => agentIDInput.value);
	}
}
