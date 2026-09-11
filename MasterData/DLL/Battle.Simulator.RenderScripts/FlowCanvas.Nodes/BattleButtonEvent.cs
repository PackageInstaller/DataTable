using System.Collections.Generic;

namespace FlowCanvas.Nodes;

public class BattleButtonEvent : EventNode
{
	protected FlowOutput _output;

	protected ValueInput<int> _roleInput;

	protected Stack<Flow.ReturnData> _returnData = new Stack<Flow.ReturnData>(16);

	protected ButtonType _buttonID = ButtonType.MELEE;

	protected override void RegisterPorts()
	{
		_roleInput = AddValueInput<int>("玩家实体类型ID", "玩家角色ID");
		_output = AddFlowOutput("OUT");
		AddValueOutput("按钮ID", () => _buttonID);
	}

	protected void Call(FlowOutput output)
	{
		Flow f = new Flow
		{
			returnData = _returnData
		};
		output.Call(f);
	}
}
