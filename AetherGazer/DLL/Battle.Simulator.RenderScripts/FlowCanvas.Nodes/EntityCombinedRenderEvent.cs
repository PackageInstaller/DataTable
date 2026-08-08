using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("实体组合事件(渲染)", 0)]
[Category("Render/事件")]
[Description("当实体挂载到实体上的时候，发出的事件，之后用来处理渲染层的挂载")]
public class EntityCombinedRenderEvent : EventNode
{
	private ValueInput<CombinedStep> _Step;

	private FlowOutput _Out;

	private int _EntityIDA;

	private int _EntityIDB;

	private Stack<Flow.ReturnData> mReturnData = new Stack<Flow.ReturnData>();

	public override void OnGraphStarted()
	{
		base.mSimContext.SimToPresentationEventSystem.AddHandler<EntityCombinedEvent>(OnEventHandler);
	}

	protected override void RegisterPorts()
	{
		_Step = AddValueInput<CombinedStep>("阶段", "step");
		_Out = AddFlowOutput("Out", "output");
		AddValueOutput("挂件实体ID", () => _EntityIDA);
		AddValueOutput("基座实体ID", () => _EntityIDB);
	}

	private void OnEventHandler(EntityCombinedEvent evt)
	{
		if (evt.mCombinedStep == _Step.GetValue())
		{
			_EntityIDA = evt.mPendantEntityID;
			_EntityIDB = evt.mBedEntityID;
			Flow f = new Flow
			{
				returnData = mReturnData
			};
			_Out.Call(f);
		}
	}
}
