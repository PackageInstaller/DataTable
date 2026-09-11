using System.Collections.Generic;

public class MapTriggerManager : IGameModule
{
	public class TriggerStatus
	{
		public int mTriggerID;

		public bool mEnable;

		public ProtoEntityData mConfig;

		public int activeFrameCount;
	}

	private List<int> triggersToEnableList = new List<int>(100);

	private List<int> triggersEnableList = new List<int>(100);

	private List<int> triggersToDisableList = new List<int>(100);

	private List<int> triggersDisableList = new List<int>(100);

	private Dictionary<int, TriggerStatus> triggerStates = new Dictionary<int, TriggerStatus>(100, new IntComparer());

	public OnVoidHandler<int, ProtoEntityData> onTriggerEnableHandler;

	public OnVoidHandler<int, ProtoEntityData> onTriggerUpdateHandler;

	public OnVoidHandler<int, ProtoEntityData> onTriggerDisableHandler;

	public OnVoidHandler<int, string, string> onTriggerSendEvent;

	public bool useMapCameraParam;

	public int missionClearTimes;

	public List<IBehavior> EnvironmentHelperList = new List<IBehavior>();

	public void Initialize()
	{
		ClientSimulator.Instance.GetSimToPresentation().AddHandler<EntitySpawnedEvent>(OnUnitSpawnedInSim);
		ClientSimulator.Instance.GetSimToPresentation().AddHandler<TriggerEnableEvent>(OnOnTriggerEnableInSim);
		missionClearTimes = (NScene.GetCurrentScene() as BattleScene).ready.SceneDataForExcehange.MMissionClearTimes;
	}

	private void OnOnTriggerEnableInSim(TriggerEnableEvent eventReceived)
	{
		if (eventReceived.enable && !triggersToEnableList.Contains(eventReceived.id))
		{
			triggersToEnableList.Add(eventReceived.id);
		}
		else if (!eventReceived.enable && !triggersToDisableList.Contains(eventReceived.id))
		{
			triggersToDisableList.Add(eventReceived.id);
		}
	}

	private void OnUnitSpawnedInSim(EntitySpawnedEvent eventReceived)
	{
		if (eventReceived.mSpawnType == E_SpawnType.TRIGGER)
		{
			triggerStates.Add(eventReceived.mTriggerData.Id, new TriggerStatus
			{
				mTriggerID = eventReceived.mTriggerData.Id,
				mEnable = eventReceived.mTriggerData.IsEnable,
				mConfig = eventReceived.mTriggerData
			});
			if (eventReceived.mTriggerData.IsEnable && !triggersToEnableList.Contains(eventReceived.mTriggerData.Id))
			{
				triggersToEnableList.Add(eventReceived.mTriggerData.Id);
			}
		}
	}

	public void Reset()
	{
	}

	public void Shutdown()
	{
		for (int i = 0; i < EnvironmentHelperList.Count; i++)
		{
			EnvironmentHelperList[i].DestroyBehavior();
		}
		EnvironmentHelperList.Clear();
		ClientSimulator.Instance.GetSimToPresentation().RemoveHandler<EntitySpawnedEvent>(OnUnitSpawnedInSim);
		ClientSimulator.Instance.GetSimToPresentation().RemoveHandler<TriggerEnableEvent>(OnOnTriggerEnableInSim);
		triggerStates.Clear();
		onTriggerEnableHandler = null;
		onTriggerUpdateHandler = null;
		onTriggerDisableHandler = null;
		onTriggerSendEvent = null;
	}

	public void FixedUpdate()
	{
	}

	public void Update()
	{
	}

	public void LateUpdate()
	{
		if (EnvironmentHelperList.Count > 0)
		{
			for (int i = 0; i < EnvironmentHelperList.Count; i++)
			{
				EnvironmentHelperList[i].LateUpdateBehavior();
			}
		}
	}

	public void CopyList(List<int> from, List<int> to)
	{
		to.Clear();
		for (int i = 0; i < from.Count; i++)
		{
			to.Add(from[i]);
		}
	}

	public void UpdateLogic(SimStateFrame stateFrame)
	{
		if (stateFrame.IsPrediction)
		{
			return;
		}
		Dictionary<int, TriggerStatus>.Enumerator enumerator = triggerStates.GetEnumerator();
		WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
		while (enumerator.MoveNext())
		{
			if (onTriggerUpdateHandler != null && enumerator.Current.Value.mEnable && worldStateManager != null && worldStateManager.logicTimerPauseFlag == 0)
			{
				onTriggerUpdateHandler(enumerator.Current.Key, enumerator.Current.Value.mConfig);
				triggerStates[enumerator.Current.Key].activeFrameCount++;
			}
		}
		CopyList(triggersToEnableList, triggersEnableList);
		CopyList(triggersToDisableList, triggersDisableList);
		triggersToEnableList.Clear();
		triggersToDisableList.Clear();
		for (int i = 0; i < triggersDisableList.Count; i++)
		{
			int num = triggersDisableList[i];
			if (triggerStates.ContainsKey(num))
			{
				triggerStates[num].mEnable = false;
				triggerStates[num].activeFrameCount = 0;
				if (onTriggerDisableHandler != null)
				{
					onTriggerDisableHandler(num, triggerStates[num].mConfig);
				}
			}
		}
		for (int j = 0; j < triggersEnableList.Count; j++)
		{
			int num2 = triggersEnableList[j];
			if (triggerStates.ContainsKey(num2))
			{
				triggerStates[num2].mEnable = true;
				triggerStates[num2].activeFrameCount = 0;
				if (onTriggerEnableHandler != null)
				{
					onTriggerEnableHandler(num2, triggerStates[num2].mConfig);
				}
			}
		}
	}

	public void DisableATrigger(int triggerID)
	{
		if (!triggersToDisableList.Contains(triggerID))
		{
			triggersToDisableList.Add(triggerID);
		}
	}

	public TriggerStatus GetTriggerState(int triggerID)
	{
		return triggerStates[triggerID];
	}
}
