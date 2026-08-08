using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("玩家1是否在半径内(渲染)", 0)]
[Category("Render/PosAndRot")]
[Description("判断玩家1是否在半径内")]
public class InRangeForPlayer1Render : FlowControlNodeOfRender
{
	private ValueInput<Int3> _positionInput;

	private ValueInput<int> _radiusInput;

	private FlowOutput _trueOut;

	private FlowOutput _falseOut;

	private FlowOutput _errorOut;

	private int _player1;

	protected override void RegisterPorts()
	{
		_positionInput = AddValueInput<Int3>("位置", "position");
		_radiusInput = AddValueInput<int>("半径(毫米)", "radius").SetDefaultAndSerializedValue(2000);
		_trueOut = AddFlowOutput("True", "true");
		_falseOut = AddFlowOutput("False", "false");
		_errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", delegate(Flow f)
		{
			_player1 = 0;
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null)
			{
				_errorOut.Call(f);
			}
			else
			{
				AgentManager agentManager = battleScene.GetAgentManager();
				if (agentManager == null)
				{
					_errorOut.Call(f);
				}
				else
				{
					_player1 = agentManager.mMemberSeats[MemberPosition.First];
					NAgent agent = agentManager.GetAgent(_player1);
					float num = (float)_radiusInput.value / 1000f;
					if ((agent.transform.position - (Vector3)_positionInput.value).sqrMagnitude <= num * num)
					{
						_trueOut.Call(f);
					}
					else
					{
						_falseOut.Call(f);
					}
				}
			}
		});
		AddValueOutput("玩家1", "player1", () => _player1);
	}
}
