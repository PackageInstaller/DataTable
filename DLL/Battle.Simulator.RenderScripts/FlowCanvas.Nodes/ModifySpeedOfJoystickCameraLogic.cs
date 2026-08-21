using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("[摩托艇]设置相机摇杆转向速度(渲染)", 0)]
[Category("Render/UI")]
[Description("设置相机摇杆转向速度")]
public class ModifySpeedOfJoystickCameraLogic : FlowControlNode
{
	private ValueInput<int> _speed;

	private FlowOutput _output;

	private FlowOutput _errorOut;

	protected override void RegisterPorts()
	{
		_speed = AddValueInput<int>("转向速度", "speed").SetDefaultAndSerializedValue(10);
		_output = AddFlowOutput("Out", "output");
		_errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null)
			{
				_errorOut.Call(f);
			}
			else
			{
				GameObject battlePanelGameObject = battleScene.battlePanelGameObject;
				if (battlePanelGameObject == null)
				{
					_errorOut.Call(f);
				}
				else
				{
					BattleUI component = battlePanelGameObject.GetComponent<BattleUI>();
					if (component == null)
					{
						_errorOut.Call(f);
					}
					else if (component.joystickController == null)
					{
						_errorOut.Call(f);
					}
					else if (!(component.joystickController.GetControllerGameLogic() is P08JoystickCameraControllerGameLogic p08JoystickCameraControllerGameLogic))
					{
						_errorOut.Call(f);
					}
					else
					{
						p08JoystickCameraControllerGameLogic.speed = _speed.value;
						_output.Call(f);
					}
				}
			}
		});
	}
}
