using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("[摇杆]设置摇杆移动死区(渲染)", 0)]
[Category("Render/UI")]
[Description("设置摇杆移动死区")]
public class SetMoveAreaDeadRadius : FlowControlNode
{
	private ValueInput<float> _moveAreaDeadRadiusInput;

	private FlowOutput _output;

	private FlowOutput _errorOut;

	protected override void RegisterPorts()
	{
		_moveAreaDeadRadiusInput = AddValueInput<float>("moveAreaDeadRadius", "摇杆移动死区");
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
						component.joystickController.moveAreaDeadRadius = _moveAreaDeadRadiusInput.value;
						_output.Call(f);
					}
				}
			}
		});
	}
}
