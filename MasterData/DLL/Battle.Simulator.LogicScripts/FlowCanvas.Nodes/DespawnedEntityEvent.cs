using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("实体销毁事件", 0)]
[Category("Logic/事件")]
[Description("当实体销毁时发送该事件")]
public class DespawnedEntityEvent : EventNode
{
	private int _abilityID;

	private int _killerID;

	private int _despawnedID;

	private long _despawnedFrame;

	private ValueInput<bool> _isRenderInput;

	private FlowOutput flowOut;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override string name => $"{base.name}";

	protected override void RegisterPorts()
	{
		flowOut = AddFlowOutput("输出");
		AddValueOutput("被销毁实体", () => _despawnedID);
		AddValueOutput("销毁者", () => _killerID);
		AddValueOutput("技能ID", () => _abilityID);
		AddValueOutput("销毁时间", () => _despawnedFrame);
		_isRenderInput = AddValueInput<bool>("是否渲染");
	}

	public override void OnGraphStarted()
	{
		if (_isRenderInput.GetValue())
		{
			base.mSimContext.SimToPresentationEventSystem.AddHandler<EntityDespawnedEvent>(OnDespawnedEntity);
		}
		else
		{
			base.mSimContext.SimEventSystem.AddHandler<EntityDespawnedEvent>(OnDespawnedEntity);
		}
	}

	public void OnDespawnedEntity(EntityDespawnedEvent despawnedEvent)
	{
		_abilityID = despawnedEvent.mAbilityID;
		_despawnedID = despawnedEvent.DestroyedEntity;
		_killerID = despawnedEvent.KillingEntity;
		_despawnedFrame = despawnedEvent.mDespawnedFrame;
		Flow f = new Flow
		{
			returnData = returnData
		};
		flowOut.Call(f);
	}
}
