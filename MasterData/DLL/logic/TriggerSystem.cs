using System;
using System.Collections.Generic;
using Entitas;

public class TriggerSystem : IInitializeSystem, ISystem, IExecuteSystem
{
	private SimContext mSimContext;

	private SimWorldState mSimWorldState;

	private List<int> runningScripts = new List<int>();

	public TriggerSystem(SimContext sim)
	{
		mSimContext = sim;
	}

	public void Initialize()
	{
		mSimWorldState = mSimContext.sEntityWorldState.status;
		mSimContext.SimEventSystem.AddHandler<EntitySpawnedEvent>(OnSpawnEntityEventHandler);
		mSimContext.SimEventSystem.AddHandler<EntityDespawnedEvent>(OnDespawnEntityEventHandler);
		mSimContext.SimEventSystem.AddHandler<EntityTriggerEvent>(OnTriggerEventHandler);
		mSimContext.SimEventSystem.AddHandler<TriggerEnableEvent>(OnTriggerEnableEventHandler);
		mSimContext.SimEventSystem.AddHandler<HitTargetEvent>(OnHitTargetEventHandler);
		mSimContext.SimEventSystem.AddHandler<TriggerParametersEvent>(OnTriggerParametersEventHandler);
		mSimContext.SimEventSystem.AddHandler<SourceSpaceEvent>(OnSourceCodeEventHandler);
		mSimContext.SimEventSystem.AddHandler<EntityBreakEvent>(OnEntityBreakEventHandler);
		ISimulatorInferface simInterface = mSimContext.GetSimInterface();
		simInterface.mLogicInputEvent = (Action<int, int>)Delegate.Combine(simInterface.mLogicInputEvent, new Action<int, int>(OnLogicInputEventEventHander));
		ISimulatorInferface simInterface2 = mSimContext.GetSimInterface();
		simInterface2.mUpdateAbilityLogicEvent = (Action<int, int, int, int>)Delegate.Combine(simInterface2.mUpdateAbilityLogicEvent, new Action<int, int, int, int>(OnUpdateAbilityLogicEventHander));
		ISimulatorInferface simInterface3 = mSimContext.GetSimInterface();
		simInterface3.mCalcDamageEvent = (Action<DamageEventParam>)Delegate.Combine(simInterface3.mCalcDamageEvent, new Action<DamageEventParam>(OnCalcDamageEventHandler));
		ISimulatorInferface simInterface4 = mSimContext.GetSimInterface();
		simInterface4.mCDEndEvent = (Action<int, AbilityCD>)Delegate.Combine(simInterface4.mCDEndEvent, new Action<int, AbilityCD>(OnCDEndEventHandler));
		ISimulatorInferface simInterface5 = mSimContext.GetSimInterface();
		simInterface5.mUpdateBuffLogicEvent = (Action<int, int, int, EBuffLife, bool>)Delegate.Combine(simInterface5.mUpdateBuffLogicEvent, new Action<int, int, int, EBuffLife, bool>(OnLogicBuffUpdateHandler));
	}

	private void OnSourceCodeEventHandler(SourceSpaceEvent eventReceived)
	{
		if (eventReceived.mState == SourceSpaceEvent.E_SourceSpaceState.Prepare)
		{
			mSimWorldState.SetLogicTimerPauseFlag(isPause: true, LogicTimerPauseReason.SourceSpace);
		}
		if (eventReceived.mState == SourceSpaceEvent.E_SourceSpaceState.Enter)
		{
			mSimWorldState.SetLogicTimerPauseFlag(isPause: false, LogicTimerPauseReason.SourceSpace);
		}
		if (eventReceived.mState == SourceSpaceEvent.E_SourceSpaceState.Leavel)
		{
			mSimWorldState.SetLogicTimerPauseFlag(isPause: true, LogicTimerPauseReason.SourceSpace);
		}
		if (eventReceived.mState == SourceSpaceEvent.E_SourceSpaceState.Exit)
		{
			mSimWorldState.SetLogicTimerPauseFlag(isPause: false, LogicTimerPauseReason.SourceSpace);
		}
	}

	private void OnTriggerEnableEventHandler(TriggerEnableEvent eventReceived)
	{
		int id = eventReceived.id;
		if (eventReceived.enable)
		{
			mSimWorldState.mRunningTriggerScripts.Add(id);
			if (!mSimWorldState.mTriggerScripts.TryGetValue(id, out var value))
			{
				return;
			}
			for (int i = 0; i < value.Count; i++)
			{
				ISimulatorInferface simulatorInferface = value[i];
				if (simulatorInferface != null && simulatorInferface.mTriggerEnableEvent != null)
				{
					simulatorInferface.mTriggerEnableEvent(id, arg2: true);
				}
			}
			return;
		}
		if (mSimWorldState.mTriggerScripts.TryGetValue(id, out var value2))
		{
			for (int j = 0; j < value2.Count; j++)
			{
				ISimulatorInferface simulatorInferface2 = value2[j];
				if (simulatorInferface2 != null && simulatorInferface2.mTriggerEnableEvent != null)
				{
					simulatorInferface2.mTriggerEnableEvent(id, arg2: false);
				}
			}
		}
		mSimWorldState.mRunningTriggerScripts.Remove(id);
	}

	private void OnTriggerParametersEventHandler(TriggerParametersEvent eventReceived)
	{
		int triggerID = eventReceived.triggerID;
		if (!mSimWorldState.mTriggerScripts.TryGetValue(triggerID, out var value))
		{
			return;
		}
		for (int i = 0; i < value.Count; i++)
		{
			ISimulatorInferface simulatorInferface = value[i];
			if (simulatorInferface != null && simulatorInferface.mLogicTriggerParametersEvent != null)
			{
				simulatorInferface.mLogicTriggerParametersEvent(triggerID, eventReceived.param1, eventReceived.param2, eventReceived.param3, eventReceived.param4);
			}
		}
	}

	private void OnEntityBreakEventHandler(EntityBreakEvent eventReceived)
	{
		foreach (int runningScript in runningScripts)
		{
			if (!mSimWorldState.mTriggerScripts.TryGetValue(runningScript, out var value))
			{
				continue;
			}
			for (int i = 0; i < value.Count; i++)
			{
				ISimulatorInferface simulatorInferface = value[i];
				if (simulatorInferface != null && simulatorInferface.mEntityBreakTriggerEvent != null)
				{
					simulatorInferface.mEntityBreakTriggerEvent(runningScript, eventReceived);
				}
			}
		}
	}

	private void OnHitTargetEventHandler(HitTargetEvent eventReceived)
	{
		foreach (int runningScript in runningScripts)
		{
			if (!mSimWorldState.mTriggerScripts.TryGetValue(runningScript, out var value))
			{
				continue;
			}
			for (int i = 0; i < value.Count; i++)
			{
				ISimulatorInferface simulatorInferface = value[i];
				if (simulatorInferface != null && simulatorInferface.mHitTargetTriggerEvent != null)
				{
					simulatorInferface.mHitTargetTriggerEvent(runningScript, eventReceived);
				}
			}
		}
	}

	private void OnLogicInputEventEventHander(int arg1, int arg2)
	{
		foreach (int runningScript in runningScripts)
		{
			if (!mSimWorldState.mTriggerScripts.TryGetValue(runningScript, out var value))
			{
				continue;
			}
			for (int i = 0; i < value.Count; i++)
			{
				ISimulatorInferface simulatorInferface = value[i];
				if (simulatorInferface != null && simulatorInferface.mLogicInputTriggerEvent != null)
				{
					simulatorInferface.mLogicInputTriggerEvent(runningScript, arg1, arg2);
				}
			}
		}
	}

	private void OnUpdateAbilityLogicEventHander(int arg1, int arg2, int arg3, int arg4)
	{
		foreach (int runningScript in runningScripts)
		{
			if (!mSimWorldState.mTriggerScripts.TryGetValue(runningScript, out var value))
			{
				continue;
			}
			for (int i = 0; i < value.Count; i++)
			{
				ISimulatorInferface simulatorInferface = value[i];
				if (simulatorInferface != null && simulatorInferface.mUpdateAbilityLogicTriggerEvent != null)
				{
					simulatorInferface.mUpdateAbilityLogicTriggerEvent(runningScript, arg1, arg2, arg3, arg4);
				}
			}
		}
	}

	private void OnCalcDamageEventHandler(DamageEventParam obj)
	{
		foreach (int runningScript in runningScripts)
		{
			if (!mSimWorldState.mTriggerScripts.TryGetValue(runningScript, out var value))
			{
				continue;
			}
			for (int i = 0; i < value.Count; i++)
			{
				ISimulatorInferface simulatorInferface = value[i];
				if (simulatorInferface != null && simulatorInferface.mCalcDamageTriggerEvent != null)
				{
					simulatorInferface.mCalcDamageTriggerEvent(runningScript, obj);
				}
			}
		}
	}

	private void OnCDEndEventHandler(int entityID, AbilityCD abilityCD)
	{
		foreach (int runningScript in runningScripts)
		{
			if (!mSimWorldState.mTriggerScripts.TryGetValue(runningScript, out var value))
			{
				continue;
			}
			for (int i = 0; i < value.Count; i++)
			{
				ISimulatorInferface simulatorInferface = value[i];
				if (simulatorInferface != null && simulatorInferface.mCDEndTriggerEvent != null)
				{
					simulatorInferface.mCDEndTriggerEvent(runningScript, entityID, abilityCD);
				}
			}
		}
	}

	private void OnLogicBuffUpdateHandler(int ownerID, int buffIndex, int buffClass, EBuffLife buffLife, bool isTimeoutLeft)
	{
		foreach (int runningScript in runningScripts)
		{
			if (!mSimWorldState.mTriggerScripts.TryGetValue(runningScript, out var value))
			{
				continue;
			}
			for (int i = 0; i < value.Count; i++)
			{
				ISimulatorInferface simulatorInferface = value[i];
				if (simulatorInferface != null && simulatorInferface.mUpdateBuffLogicTriggerEvent != null)
				{
					simulatorInferface.mUpdateBuffLogicTriggerEvent(runningScript, ownerID, buffIndex, buffClass, buffLife, isTimeoutLeft);
				}
			}
		}
	}

	private void OnTriggerEventHandler(EntityTriggerEvent eventReceived)
	{
	}

	private void OnDespawnEntityEventHandler(EntityDespawnedEvent eventReceived)
	{
	}

	private void OnSpawnEntityEventHandler(EntitySpawnedEvent eventReceived)
	{
		if (eventReceived.mSpawnType == E_SpawnType.TRIGGER)
		{
			if (eventReceived.mTriggerData.IsEnable)
			{
				mSimContext.PostEvent(TriggerEnableEvent.Claim(eventReceived.mTriggerData.Id, enable: true));
			}
			if (mSimContext.GetSimInterface().mLogicTriggerInitEvent != null)
			{
				mSimContext.GetSimInterface().mLogicTriggerInitEvent(eventReceived.NewEntity, eventReceived.mTriggerData);
			}
		}
	}

	public void CopyRunningScripts(List<int> scripts)
	{
		runningScripts.Clear();
		runningScripts.AddRange(scripts);
	}

	public void Execute()
	{
		CopyRunningScripts(mSimWorldState.mRunningTriggerScripts);
		if (mSimWorldState.mLogicTimerPauseFlag != 0)
		{
			return;
		}
		foreach (int runningScript in runningScripts)
		{
			if (!mSimWorldState.mTriggerScripts.TryGetValue(runningScript, out var value))
			{
				continue;
			}
			for (int i = 0; i < value.Count; i++)
			{
				ISimulatorInferface simulatorInferface = value[i];
				if (simulatorInferface != null && simulatorInferface.mLogicTriggerEvent != null)
				{
					SimEntity simEntityByTriggerID = CommonProcessor.GetSimEntityByTriggerID(runningScript);
					if (simEntityByTriggerID != null)
					{
						simEntityByTriggerID.entityTrigger.mActiveFrameCount++;
					}
					simulatorInferface.mLogicTriggerEvent(simEntityByTriggerID.creationIndex);
				}
			}
		}
	}
}
