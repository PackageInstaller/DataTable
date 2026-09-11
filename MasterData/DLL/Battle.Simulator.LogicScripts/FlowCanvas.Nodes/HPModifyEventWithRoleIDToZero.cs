using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("血量变化事件(归0&实体类型ID)(逻辑)", 0)]
[Category("Logic/事件")]
[Description("该事件发生在血量变化之前，此时血量=旧血量\n变化量为正则加血,为负则扣血\n新旧血量小于0时会返回0，且新血量=旧血量+变化量，故新血量可能不准确\n必须传入实体类型ID\n只有新血量<=0才会触发")]
public class HPModifyEventWithRoleIDToZero : EventNode
{
	private int _entityID;

	private long _oldHP;

	private long _newHP;

	private long _amount;

	private int _casterID;

	private int _actionID;

	private int _thrownID;

	private DamageType _damageType;

	private FlowOutput flowOut;

	private ValueInput<int> _roleIDInput;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override string name => $"{base.name}";

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mOnHPModify = (Action<int, long, long, long, int, int, int, DamageType>)Delegate.Combine(simInterface.mOnHPModify, new Action<int, long, long, long, int, int, int, DamageType>(HPModifyCallback));
	}

	public override void OnGraphStoped()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mOnHPModify = (Action<int, long, long, long, int, int, int, DamageType>)Delegate.Remove(simInterface.mOnHPModify, new Action<int, long, long, long, int, int, int, DamageType>(HPModifyCallback));
	}

	protected override void RegisterPorts()
	{
		flowOut = AddFlowOutput("Out", "输出");
		_roleIDInput = AddValueInput<int>("实体类型ID", "roleID");
		AddValueOutput("实体ID", "实体D", () => _entityID);
		AddValueOutput("旧血量", "旧血量", () => _oldHP);
		AddValueOutput("新血量", "新血量", () => _newHP);
		AddValueOutput("变化量", "变化量", () => _amount);
		AddValueOutput("来源实体", "伤害来源实体", () => _casterID);
		AddValueOutput("技能ID", () => _actionID);
		AddValueOutput("抛掷物ID", () => _thrownID);
		AddValueOutput("伤害类型", () => _damageType);
	}

	public void HPModifyCallback(int entityID, long oldHP, long newHP, long amount, int casterID, int actionID, int thrownID, DamageType damageType)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityConfig && entityWithEntityID.entityConfig.mId == _roleIDInput.value && newHP <= 0)
		{
			_entityID = entityID;
			_oldHP = oldHP;
			_newHP = newHP;
			_amount = amount;
			_casterID = casterID;
			_actionID = actionID;
			_thrownID = thrownID;
			_damageType = damageType;
			Flow f = new Flow
			{
				returnData = returnData
			};
			flowOut.Call(f);
		}
	}
}
