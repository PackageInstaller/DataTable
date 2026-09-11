using System;
using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能执行事件(投技+技能时间)", 0)]
[Category("Logic/Abilities/具体")]
[Description("投技时间")]
public class LogicAbilityEventGrabInSpecifiedTime : EventNode
{
	private FlowOutput abilityGrabEnterEvent;

	private FlowOutput abilityGrabExitEvent;

	private FlowOutput abilityThrowEnterEvent;

	private FlowOutput abilityThrowExitEvent;

	private ValueInput<int> abilityIDInput;

	private ValueInput<int> roleIDInput;

	private int mEntityID;

	private int mAbilityID;

	private int mLogicTime;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mUpdateAbilityLogicEvent = (Action<int, int, int, int>)Delegate.Combine(simInterface.mUpdateAbilityLogicEvent, new Action<int, int, int, int>(LogicAbilityUpdateEventHandler));
	}

	protected override void RegisterPorts()
	{
		roleIDInput = AddValueInput<int>("实体类型ID", "角色ID");
		abilityIDInput = AddValueInput<int>("投技ID(后三位)");
		abilityGrabEnterEvent = AddFlowOutput("抓取开始");
		abilityGrabExitEvent = AddFlowOutput("抓取结束");
		abilityThrowEnterEvent = AddFlowOutput("投掷开始");
		abilityThrowExitEvent = AddFlowOutput("投掷结束");
		AddValueOutput("实体ID", () => mEntityID);
		AddValueOutput("投技ID", () => mAbilityID);
		AddValueOutput("时间", () => mLogicTime);
	}

	public void LogicAbilityUpdateEventHandler(int entityID, int abilityID, int logicTime, int logicTimeStep)
	{
		mEntityID = entityID;
		mAbilityID = abilityID;
		mLogicTime = logicTime;
		if (roleIDInput.value * 1000 + abilityIDInput.value != mAbilityID)
		{
			return;
		}
		Flow f = new Flow
		{
			returnData = returnData
		};
		Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(abilityID);
		if (config == null)
		{
			return;
		}
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
		if (AbilitiesProcessor.OnAbilityGrabEnter(config, logicTime + logicTimeStep, logicTimeStep) || OnAbilityGrabUpdate(config, logicTime + logicTimeStep))
		{
			abilityGrabEnterEvent.Call(f);
			if (entityWithEntityID != null)
			{
				int mGrabTarget = entityWithEntityID.entityBlackboard.var.mGrabTarget;
				SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(mGrabTarget);
				if (entityWithEntityID2 != null)
				{
					entityWithEntityID2.entityBlackboard.var.mIsCaught = true;
				}
			}
		}
		else if (AbilitiesProcessor.OnAbilityGrabExit(config, logicTime + logicTimeStep, logicTimeStep))
		{
			abilityGrabExitEvent.Call(f);
		}
		else if (AbilitiesProcessor.OnAbilityThrowEnter(config, logicTime + logicTimeStep, logicTimeStep))
		{
			abilityThrowEnterEvent.Call(f);
		}
		else
		{
			if (!AbilitiesProcessor.OnAbilityThrowExit(config, logicTime + logicTimeStep, logicTimeStep))
			{
				return;
			}
			if (entityWithEntityID != null)
			{
				int mGrabTarget2 = entityWithEntityID.entityBlackboard.var.mGrabTarget;
				SimEntity entityWithEntityID3 = base.mSimContext.GetEntityWithEntityID(mGrabTarget2);
				if (entityWithEntityID3 != null)
				{
					entityWithEntityID3.entityBlackboard.var.mIsCaught = false;
				}
			}
			abilityThrowExitEvent.Call(f);
		}
	}

	public bool OnAbilityGrabUpdate(Timeline timeline, int logicTime)
	{
		if (timeline.AbilityGrabInfo == null || timeline.AbilityGrabInfo.Duration == 0)
		{
			return false;
		}
		int start = timeline.AbilityGrabInfo.Start;
		int num = start + timeline.AbilityGrabInfo.Duration;
		if (logicTime >= start && logicTime < num)
		{
			return true;
		}
		return false;
	}
}
