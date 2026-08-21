using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("血量变化事件后", 0)]
[Category("Logic/事件")]
[Description("该事件发生在血量变化之后，此时血量=新血量\n变化量为正则加血,为负则扣血\n新血量小于0时会返回0")]
public class AfterHPModifyEvent : FlowNode
{
	private int _entityID;

	private long _curHP;

	private long _amount;

	private DamageType _damageType;

	private int _casterID;

	private int _actionID;

	private int _thrownID;

	private FlowOutput flowOut;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mOnAfterHPModify = (Action<int, long, long, DamageType, int, int, int>)Delegate.Combine(simInterface.mOnAfterHPModify, new Action<int, long, long, DamageType, int, int, int>(HPModifyCallback));
	}

	public override void OnGraphStoped()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mOnAfterHPModify = (Action<int, long, long, DamageType, int, int, int>)Delegate.Remove(simInterface.mOnAfterHPModify, new Action<int, long, long, DamageType, int, int, int>(HPModifyCallback));
	}

	private void HPModifyCallback(int entityID, long curHP, long amount, DamageType damageType, int casterID, int actionID, int thrownID)
	{
		_entityID = entityID;
		_curHP = curHP;
		_amount = amount;
		_damageType = damageType;
		_casterID = casterID;
		_actionID = actionID;
		_thrownID = thrownID;
		Flow f = new Flow
		{
			returnData = returnData
		};
		flowOut.Call(f);
	}

	protected override void RegisterPorts()
	{
		flowOut = AddFlowOutput("Out", "输出");
		AddValueOutput("实体ID", "实体D", () => _entityID);
		AddValueOutput("新血量", () => _curHP);
		AddValueOutput("变化量", "变化量", () => _amount);
		AddValueOutput("伤害类型", () => _damageType);
		AddValueOutput("来源实体", "伤害来源实体", () => _casterID);
		AddValueOutput("技能ID", () => _actionID);
		AddValueOutput("抛掷物ID", () => _thrownID);
	}
}
