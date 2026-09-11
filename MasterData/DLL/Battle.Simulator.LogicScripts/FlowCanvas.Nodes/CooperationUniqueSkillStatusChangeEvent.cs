using System;
using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("连携奥义状态变更事件", 0)]
[Category("Logic/Event")]
[Description("监听连携奥义的禁用/启用事件，如果不输入实体类型ID则默认为监听所有连携奥义状态变更事件")]
public class CooperationUniqueSkillStatusChangeEvent : EventNode
{
	private FlowOutput _out;

	private ValueInput<int> _roleID;

	private int _cooperationUniqueSkillID;

	private bool _isOpen;

	private Stack<Flow.ReturnData> _returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		_out = AddFlowOutput("Out", "output");
		_roleID = AddValueInput<int>("实体类型ID", "roleID").SetDefaultAndSerializedValue(0);
		_cooperationUniqueSkillID = 0;
		_isOpen = false;
		AddValueOutput("连携奥义ID", "cooperationUniqueSkillID", () => _cooperationUniqueSkillID);
		AddValueOutput("开关状态", "isOpen", () => _isOpen);
	}

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mCooperateUniqueSkillStatusChangeEvent = (Action<bool, int>)Delegate.Combine(simInterface.mCooperateUniqueSkillStatusChangeEvent, new Action<bool, int>(OnInvoke));
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mCooperateUniqueSkillStatusChangeEvent = (Action<bool, int>)Delegate.Remove(simInterface.mCooperateUniqueSkillStatusChangeEvent, new Action<bool, int>(OnInvoke));
	}

	private void OnInvoke(bool isOpen, int cooperationUniqueSkillID)
	{
		Flow f = new Flow
		{
			returnData = _returnData
		};
		cooperate_unique_skill config;
		if (_roleID.value == 0)
		{
			_cooperationUniqueSkillID = cooperationUniqueSkillID;
			_isOpen = isOpen;
			_out.Call(f);
		}
		else if (ConfigHelper.GetInstance().TryGetConfig<cooperate_unique_skill>(cooperationUniqueSkillID, out config) && config.CooperateRoleIds.Contains(_roleID.value))
		{
			_cooperationUniqueSkillID = cooperationUniqueSkillID;
			_isOpen = isOpen;
			_out.Call(f);
		}
	}
}
