using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline.Character;

namespace FlowCanvas.Nodes;

[Name("切换Agent材质", 0)]
[Category("Render/CharacterEffect")]
[Description("切换Agent材质")]
public class SetCharacterMaterialSwitcher : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDInput = AddValueInput<int>("实体ID");
		ValueInput<string> pathInput = AddValueInput<string>("部位名称(组件相对路径)");
		ValueInput<bool> activeInput = AddValueInput<bool>("是否切换");
		AddValueOutput("实体ID", () => agentIDInput.GetValue());
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("Error");
		AddFlowInput("", delegate(Flow f)
		{
			AgentManager agentManager = AgentManager.GetAgentManager();
			if (agentManager == null)
			{
				errorOut.Call(f);
			}
			else
			{
				NAgent agent = agentManager.GetAgent(agentIDInput.value);
				if (agent == null)
				{
					errorOut.Call(f);
				}
				else
				{
					Transform transform = agent.transform.Find(pathInput.value);
					if (transform == null)
					{
						errorOut.Call(f);
					}
					else
					{
						CharacterMaterialSwitcher component = transform.GetComponent<CharacterMaterialSwitcher>();
						if ((Object)(object)component == null)
						{
							errorOut.Call(f);
						}
						else
						{
							component.swap = activeInput.value;
							output.Call(f);
						}
					}
				}
			}
		});
	}
}
