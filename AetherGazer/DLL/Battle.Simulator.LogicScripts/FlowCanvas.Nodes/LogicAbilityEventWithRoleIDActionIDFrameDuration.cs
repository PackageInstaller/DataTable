using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能执行事件(后三位)(帧数区间)实体类型ID", 0)]
[Category("Logic/Abilities")]
[Description("技能Update时调用的事件,帧数左右都包含, 角色ID和动作ID为0的时候不参与过滤")]
public class LogicAbilityEventWithRoleIDActionIDFrameDuration : EventNode
{
	private ValueInput<int> startFrameInput;

	private ValueInput<int> endFrameInput;

	private ValueInput<int> roleIDInput;

	private ValueInput<int> actionIDInput;

	private FlowOutput startFrameOutput;

	private FlowOutput endFrameOutput;

	private FlowOutput falseOutput;

	private FlowOutput trueOutput;

	protected int m_entityID;

	protected int m_abilityID;

	protected int m_actionID;

	protected int m_logicTime;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mUpdateAbilityLogicEvent = (Action<int, int, int, int>)Delegate.Combine(simInterface.mUpdateAbilityLogicEvent, new Action<int, int, int, int>(LogicAbilityUpdateHandler));
	}

	private void LogicAbilityUpdateHandler(int entityID, int abilityID, int logicTime, int logicTimeStep)
	{
		int num = abilityID % 1000;
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
		int value = actionIDInput.value;
		if ((value != 0 && value != num) || entityWithEntityID == null || !entityWithEntityID.hasEntityConfig)
		{
			return;
		}
		int value2 = roleIDInput.value;
		if (value2 == 0 || value2 == entityWithEntityID.entityConfig.mId)
		{
			m_entityID = entityID;
			m_abilityID = abilityID;
			m_actionID = num;
			m_logicTime = logicTime;
			Flow f = new Flow
			{
				returnData = returnData,
				userData = entityWithEntityID
			};
			int configInterval = CommonProcessor.GetConfigInterval();
			int value3 = startFrameInput.value;
			int value4 = endFrameInput.value;
			int num2 = logicTime / configInterval;
			if (value3 == num2)
			{
				startFrameOutput.Call(f);
			}
			else if (value4 == num2)
			{
				endFrameOutput.Call(f);
			}
			else if (value3 < num2 && value4 > num2)
			{
				trueOutput.Call(f);
			}
			else
			{
				falseOutput.Call(f);
			}
		}
	}

	protected void AddCustionOutput()
	{
		AddValueOutput("实体ID", "实体ID:", () => m_entityID);
		AddValueOutput("后三位", "actionID", () => m_actionID);
		AddValueOutput("时间(毫秒)", "时间:", () => m_logicTime);
		AddValueOutput("TimelineID(过时)", "技能ID:", () => m_abilityID);
		trueOutput = AddFlowOutput("在区间内");
		startFrameOutput = AddFlowOutput("等于起始帧数");
		endFrameOutput = AddFlowOutput("等于结束帧数");
		falseOutput = AddFlowOutput("不在区间内");
	}

	protected void AddCustomInput()
	{
		roleIDInput = AddValueInput<int>("实体类型ID", "角色ID");
		actionIDInput = AddValueInput<int>("动作ID");
		startFrameInput = AddValueInput<int>("起始帧数");
		endFrameInput = AddValueInput<int>("结束帧数");
	}

	protected override void RegisterPorts()
	{
		AddCustionOutput();
		AddCustomInput();
	}
}
