using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("本地是否在半径内(渲染)", 0)]
[Category("Render/PosAndRot")]
[Description("判断本地玩家是否在半径内")]
public class InRangeForLocalPlayerRender : FlowControlNodeOfRender
{
	private ValueInput<Int3> _positionInput;

	private ValueInput<int> _radiusInput;

	private FlowOutput _trueOut;

	private FlowOutput _falseOut;

	private FlowOutput _errorOut;

	private int _localPlayer;

	protected override void RegisterPorts()
	{
		_positionInput = AddValueInput<Int3>("位置", "position");
		_radiusInput = AddValueInput<int>("半径(毫米)", "radius").SetDefaultAndSerializedValue(2000);
		_trueOut = AddFlowOutput("True", "true");
		_falseOut = AddFlowOutput("False", "false");
		_errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", delegate(Flow f)
		{
			_localPlayer = 0;
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
					NAgent playerAgent = agentManager.GetPlayerAgent();
					if (playerAgent == null)
					{
						_localPlayer = 0;
						_errorOut.Call(f);
					}
					else
					{
						_localPlayer = playerAgent.AgentID;
						float num = (float)_radiusInput.value / 1000f;
						if ((playerAgent.transform.position - (Vector3)_positionInput.value).sqrMagnitude <= num * num)
						{
							_trueOut.Call(f);
						}
						else
						{
							_falseOut.Call(f);
						}
					}
				}
			}
		});
		AddValueOutput("玩家", "player1", () => _localPlayer);
	}
}
