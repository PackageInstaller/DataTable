using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("更换摇杆为相机控制(渲染)", 0)]
[Category("Render/UI")]
[Description("更换摇杆为相机控制(本质还是摇杆)")]
public class ChangeJoystickCamereLogic : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		ValueInput<float> cameraSensitivityInput = AddValueInput<float>("相机灵敏度", "cameraSensitivity").SetDefaultAndSerializedValue(0.5f);
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
							component.joystickController.Init(Vector3.zero, 0f, new P08JoystickCameraControllerGameLogic(cameraSensitivityInput.value));
						}
						output.Call(f);
					}
				}
			}
		});
	}
}
