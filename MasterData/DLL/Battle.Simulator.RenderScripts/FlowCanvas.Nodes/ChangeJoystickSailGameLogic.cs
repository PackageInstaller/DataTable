using Packages.BattleSimulator.Simulator.SimulatorUI;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("更换摇杆为航行玩法控制杆(渲染)", 0)]
[Category("Render/UI")]
[Description("更换摇杆为航行玩法控制杆(本质为按照输入的坐标轴进行移动)")]
public class ChangeJoystickSailGameLogic : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		ValueInput<Vector3> baseForwardInput = AddValueInput<Vector3>("初始朝向").SetDefaultAndSerializedValue(Vector3.forward);
		ValueInput<float> moveAreaRadiusInput = AddValueInput<float>("摇杆半径", "moveAreaRadius").SetDefaultAndSerializedValue(100f);
		ValueInput<float> moveAreaDeadRadiusInput = AddValueInput<float>("摇杆死区", "moveAreaDeadRadius").SetDefaultAndSerializedValue(30f);
		AddFlowInput("In", "input", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null)
			{
				error.Call(f);
			}
			else
			{
				GameObject battlePanelGameObject = battleScene.battlePanelGameObject;
				if (battlePanelGameObject == null)
				{
					error.Call(f);
				}
				else
				{
					BattleUI component = battlePanelGameObject.GetComponent<BattleUI>();
					if (component == null)
					{
						error.Call(f);
					}
					else
					{
						if (component.joystickController != null)
						{
							component.joystickController.moveAreaRadius = moveAreaRadiusInput.value;
							component.joystickController.moveAreaDeadRadius = moveAreaDeadRadiusInput.value;
							component.joystickController.Init(Vector3.zero, 0f, new P08JoystickWithSailGame(baseForwardInput.value.NewY(0f)));
						}
						output.Call(f);
					}
				}
			}
		});
	}
}
