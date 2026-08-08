using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("添加词缀事件", 0)]
[Category("Logic/事件")]
[Description("添加词缀事件")]
public class AddAffixEvent : EventNode
{
	private int _entityID;

	private int _affixID;

	private int _level;

	private FlowOutput _output;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mAddAffixEvent = (Action<int, int, int>)Delegate.Combine(simInterface.mAddAffixEvent, new Action<int, int, int>(OnAddAffixEvent));
	}

	public override void OnGraphStoped()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mAddAffixEvent = (Action<int, int, int>)Delegate.Remove(simInterface.mAddAffixEvent, new Action<int, int, int>(OnAddAffixEvent));
	}

	private void OnAddAffixEvent(int entityID, int id, int l)
	{
		_affixID = id;
		_level = l;
		_entityID = entityID;
		Flow flow = default(Flow);
		flow.returnData = returnData;
		flow.Call(_output);
	}

	protected override void RegisterPorts()
	{
		AddValueOutput("实体ID", () => _entityID);
		AddValueOutput("词缀ID", () => _affixID);
		AddValueOutput("词缀等级", () => _level);
		_output = AddFlowOutput("");
	}
}
