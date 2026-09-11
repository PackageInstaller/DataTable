using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("受击事件(指定行为)", 0)]
[Category("Logic/事件")]
[Description("受击状态事件")]
public class HitRecoverEvent2 : EventNode
{
	private FlowOutput enterEventOutput;

	private FlowOutput leaveOutput;

	private int _hurtEntityID;

	private int _hurtAbilityID;

	private int _castEntityID;

	private int _castAbilityID;

	private int _castHitGroupID;

	private E_HitRecoverStatus _hitRecoverStatus;

	private ValueInput<int> intput;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override string name => $"{base.name}";

	protected override void RegisterPorts()
	{
		enterEventOutput = AddFlowOutput("进入");
		leaveOutput = AddFlowOutput("离开");
		intput = AddValueInput<int>("技能ID");
		AddValueOutput("攻击者ID：", () => _castEntityID);
		AddValueOutput("攻击者行为ID：", () => _castAbilityID);
		AddValueOutput("攻击者第几次命中：", () => _castHitGroupID);
		AddValueOutput("受击者ID：", () => _hurtEntityID);
		AddValueOutput("受击者行为ID：", () => _hurtAbilityID);
		AddValueOutput("受击状态：", () => _hitRecoverStatus);
	}

	public override void OnGraphStarted()
	{
		base.mSimContext.SimEventSystem.AddHandler<EntityHitRecoverStatusEvent>(OnHitRecoverStatusEventHandler);
	}

	public void OnHitRecoverStatusEventHandler(EntityHitRecoverStatusEvent spawnEvent)
	{
		_hurtEntityID = spawnEvent.mEntityID;
		_hurtAbilityID = spawnEvent.mAbilityID;
		_castEntityID = spawnEvent.mCasterID;
		_castAbilityID = spawnEvent.mActionID;
		_castHitGroupID = spawnEvent.mHitIndex;
		_hitRecoverStatus = spawnEvent.mHitRecoverStatus;
		if (_castAbilityID == intput.value)
		{
			Flow f = new Flow
			{
				returnData = returnData
			};
			if (E_HitRecover.OnLeave == spawnEvent.mHitRecover)
			{
				leaveOutput.Call(f);
			}
			else if (E_HitRecover.OnEnter == spawnEvent.mHitRecover)
			{
				enterEventOutput.Call(f);
			}
		}
	}
}
