using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("命中判定检查(过时)", 0)]
[Category("Logic/事件")]
[Description("当攻击命中时触发")]
public class AbilityHitCheckEvent : EventNode
{
	private int _attacker;

	private int _abilityID;

	private int _hitIndex;

	private int _hitCount;

	private FlowOutput _out;

	private ValueInput<bool> _isRenderInput;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override string name => $"{base.name}";

	protected override void RegisterPorts()
	{
		_out = AddFlowOutput("输出");
		AddValueOutput("攻击者", () => _attacker);
		AddValueOutput("技能ID", () => _abilityID);
		AddValueOutput("第几次判定", () => _hitIndex);
		AddValueOutput("命种个数", () => _hitCount);
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mHitCheckEvent = (Action<int, int, int, int>)Delegate.Combine(simInterface.mHitCheckEvent, new Action<int, int, int, int>(OnHitCheckEventHandler));
	}

	private void OnHitCheckEventHandler(int entityID, int abilityID, int hitIndex, int hitCount)
	{
		_attacker = entityID;
		_abilityID = abilityID;
		_hitIndex = hitIndex;
		_hitCount = hitCount;
		Flow f = new Flow
		{
			returnData = returnData
		};
		_out.Call(f);
	}
}
