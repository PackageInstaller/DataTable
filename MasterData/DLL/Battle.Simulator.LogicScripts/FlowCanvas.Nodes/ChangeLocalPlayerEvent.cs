using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("更改主控实体事件", 0)]
[Category("Common/事件")]
[Description("更改主控实体")]
public class ChangeLocalPlayerEvent : EventNode
{
	private ValueInput<bool> _isRenderInput;

	private int _fromID;

	private int _toID;

	private bool _morePlayerAgent;

	private FlowOutput output;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override void OnGraphStarted()
	{
		if (!_isRenderInput.value)
		{
			base.mSimContext.SimEventSystem.AddHandler<PlayerChangeEvent>(OnPlayerChange);
		}
		else
		{
			base.mSimContext.SimToPresentationEventSystem.AddHandler<PlayerChangeEvent>(OnPlayerChange);
		}
	}

	private void OnPlayerChange(PlayerChangeEvent eventReceived)
	{
		_fromID = eventReceived.mFromEntity;
		_toID = eventReceived.mToEntity;
		_morePlayerAgent = eventReceived.mMorePlayerAgent;
		Flow f = new Flow
		{
			returnData = returnData
		};
		output.Call(f);
	}

	protected override void RegisterPorts()
	{
		_isRenderInput = AddValueInput<bool>("是否渲染");
		AddValueOutput("旧的实体ID", () => _fromID);
		AddValueOutput("新的实体ID", () => _toID);
		AddValueOutput("允许存在多个玩家Agent", () => _morePlayerAgent);
		output = AddFlowOutput("输出");
	}
}
