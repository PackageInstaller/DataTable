using GraphicGadgets.Runtime.Fluid2D;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("移除扰动效果(Fluid2D)", 0)]
[Category("Render/Asset")]
[Description("移除扰动效果")]
public class RemoveAgitatorController2 : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<string> sceneFluidLocalPath = AddValueInput<string>("场景的Fluid2D组件路径").SetDefaultAndSerializedValue("Terrain");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID/抛掷物ID");
		ValueInput<string> attachPointInput = AddValueInput<string>("挂点");
		ValueInput<string> sourceIDInput = AddValueInput<string>("扰动源名字");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("Error");
		AddFlowInput("", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null || battleScene.sceneSetting == null)
			{
				errorOut.Call(f);
			}
			else
			{
				Fluid2D fluid2D = null;
				Transform transform = battleScene.sceneSetting.transform.Find(sceneFluidLocalPath.value);
				if (transform != null)
				{
					fluid2D = transform.GetComponent<Fluid2D>();
				}
				if (fluid2D == null)
				{
					errorOut.Call(f);
				}
				else
				{
					Transform transform2 = null;
					int value = entityIDInput.value;
					if (value > 0)
					{
						NAgent nAgent = AgentManager.GetAgentManager()?.GetAgent(value);
						if (nAgent != null)
						{
							transform2 = nAgent.transform;
						}
					}
					else
					{
						ThrownManager thrownManager = battleScene.GetBattleSimulatorSystem()?.ThrownManager;
						if (thrownManager != null && thrownManager.TryGetThrown(value, out var thrownStateOfRender))
						{
							transform2 = thrownStateOfRender?.AudioRoot?.transform;
						}
					}
					if (transform2 == null)
					{
						errorOut.Call(f);
					}
					else
					{
						if (!string.IsNullOrEmpty(attachPointInput.value))
						{
							Transform transform3 = transform2.Find(attachPointInput.value);
							if (transform3 != null)
							{
								transform2 = transform3;
							}
						}
						Transform transform4 = transform2.Find(sourceIDInput.value);
						if (transform4 != null)
						{
							AgitatorController component = transform4.GetComponent<AgitatorController>();
							if (component != null)
							{
								fluid2D.RemoveAgitator(component);
							}
							Object.Destroy(transform4.gameObject);
						}
						output.Call(f);
					}
				}
			}
		});
	}
}
