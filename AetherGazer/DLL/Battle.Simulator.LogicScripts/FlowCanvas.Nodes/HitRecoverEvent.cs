using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("受击状态事件", 0)]
[Category("Logic/事件")]
[Description("受击状态事件")]
public class HitRecoverEvent : EventNode
{
	private FlowOutput logicTickEventOutput;

	private int _caster;

	private E_HitRecoverStatus _hitRecoverStatus;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override string name => $"{base.name}";

	protected override void RegisterPorts()
	{
		logicTickEventOutput = AddFlowOutput("输出");
		AddValueOutput("受击者ID：", () => _caster);
		AddValueOutput("受击状态：", () => _hitRecoverStatus);
	}

	public override void OnGraphStarted()
	{
		base.mSimContext.SimEventSystem.AddHandler<EntityHitRecoverStatusEvent>(OnHitRecoverStatusEventHandler);
	}

	public void OnHitRecoverStatusEventHandler(EntityHitRecoverStatusEvent spawnEvent)
	{
		_caster = spawnEvent.mEntityID;
		_hitRecoverStatus = spawnEvent.mHitRecoverStatus;
		Flow f = new Flow
		{
			returnData = returnData
		};
		logicTickEventOutput.Call(f);
	}
}
