using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("[摇杆]得到摇杆移动死区(渲染)", 0)]
[Category("Render/UI")]
[Description("得到摇杆移动死区")]
public class GetMoveAreaDeadRadius : FlowControlNode
{
	private FlowOutput _output;

	private FlowOutput _errorOut;

	private float _moveAreaDeadRadius;

	protected override void RegisterPorts()
	{
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
						_moveAreaDeadRadius = component.joystickController.moveAreaDeadRadius;
						_output.Call(f);
					}
				}
			}
		});
		AddValueOutput("摇杆移动死区", "moveAreaDeadRadius", () => _moveAreaDeadRadius);
	}
}
