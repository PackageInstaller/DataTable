using GraphicGadgets.Runtime.Fluid2D;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("添加扰动效果(FluidLocal)", 0)]
[Category("Render/Asset")]
[Description("添加扰动效果, 如果要移除的话, 一定要在实体或弹道销毁前移除")]
public class CreateAgitatorController : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<string> sceneFluidLocalPath = AddValueInput<string>("场景的FluidLocal组件路径").SetDefaultAndSerializedValue("Terrain");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID/抛掷物ID");
		ValueInput<string> sourceIDInput = AddValueInput<string>("扰动源名字");
		ValueInput<string> attachPointInput = AddValueInput<string>("挂点");
		ValueInput<Vector3> localOffsetInput = AddValueInput<Vector3>("本地偏移").SetDefaultAndSerializedValue(Vector3.zero);
		ValueInput<Color> colorInput = AddValueInput<Color>("颜色").SetDefaultAndSerializedValue(Color.white);
		ValueInput<bool> localPlayerInput = AddValueInput<bool>("是否是玩家").SetDefaultAndSerializedValue(v: false);
		ValueInput<float> radiusInput = AddValueInput<float>("扰动半径").SetDefaultAndSerializedValue(0.15f);
		ValueInput<float> sizeInput = AddValueInput<float>("扰动源碰撞区域").SetDefaultAndSerializedValue(0.1f);
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("Error");
		AddFlowInput("", delegate(Flow f)
		{
			Transform transform = null;
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null || battleScene.sceneSetting == null)
			{
				errorOut.Call(f);
			}
			else
			{
				FluidLocal fluidLocal = null;
				Transform transform2 = battleScene.sceneSetting.transform.Find(sceneFluidLocalPath.value);
				if (transform2 != null)
				{
					fluidLocal = transform2.GetComponent<FluidLocal>();
				}
				if (fluidLocal == null)
				{
					errorOut.Call(f);
				}
				else
				{
					int value = entityIDInput.value;
					if (value > 0)
					{
						NAgent nAgent = AgentManager.GetAgentManager()?.GetAgent(value);
						if (nAgent != null)
						{
							transform = nAgent.transform;
						}
					}
					else
					{
						ThrownManager thrownManager = battleScene.GetBattleSimulatorSystem()?.ThrownManager;
						if (thrownManager != null && thrownManager.TryGetThrown(value, out var thrownStateOfRender))
						{
							transform = thrownStateOfRender?.AudioRoot?.transform;
						}
					}
					if (transform == null)
					{
						errorOut.Call(f);
					}
					else
					{
						if (!string.IsNullOrEmpty(attachPointInput.value))
						{
							Transform transform3 = transform.Find(attachPointInput.value);
							if (transform3 != null)
							{
								transform = transform3;
							}
						}
						AgitatorController agitatorController = null;
						Transform transform4 = transform.Find(sourceIDInput.value);
						if (transform4 == null)
						{
							GameObject gameObject = new GameObject(sourceIDInput.value);
							agitatorController = gameObject.AddComponent<AgitatorController>();
							gameObject.transform.parent = transform;
						}
						else
						{
							agitatorController = transform4.GetComponent<AgitatorController>();
							if (agitatorController != null)
							{
								agitatorController = transform4.gameObject.AddComponent<AgitatorController>();
							}
						}
						if (agitatorController == null)
						{
							errorOut.Call(f);
						}
						else
						{
							agitatorController.agitatorColor = colorInput.value;
							agitatorController.radius = radiusInput.value;
							agitatorController.size = sizeInput.value;
							agitatorController.mainCharacter = localPlayerInput.value;
							agitatorController.transform.localPosition = localOffsetInput.value;
							fluidLocal.AddAgitator(agitatorController);
							output.Call(f);
						}
					}
				}
			}
		});
	}
}
