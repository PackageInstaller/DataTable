using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("[摇杆]设置摇杆移动半径(渲染)", 0)]
[Category("Render/UI")]
[Description("设置摇杆移动半径")]
public class SetMoveAreaRadius : FlowControlNode
{
	private ValueInput<float> _moveAreaRadiusInput;

	private FlowOutput _output;

	private FlowOutput _errorOut;

	protected override void RegisterPorts()
	{
		_moveAreaRadiusInput = AddValueInput<float>("moveAreaRadius", "摇杆移动半径").SetDefaultAndSerializedValue(50f);
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
					else
					{
						component.joystickController.moveAreaRadius = _moveAreaRadiusInput.value;
						_output.Call(f);
					}
				}
			}
		});
	}
}
