using System.Collections.Generic;
using ACT.Condition.Interface;
using ACT.Event;
using ACT.Model;
using Fundamental;

namespace Runtime.Model.Condition;

public class ConditionModel : Model<ConditionModel>
{
	private ConditionCollection<int> _missionConditionCollections;

	private ConditionCollection<int> _avgConditionCollections;

	private ConditionCollection<int> _keyPointCollections;

	private ConditionCollection<int> _interactObjectCollections;

	private ConditionCollection<int> _npcEventConditionCollections;

	protected override void Init()
	{
		_missionConditionCollections = new ConditionCollection<int>();
		_missionConditionCollections.Alloc();
		_keyPointCollections = new ConditionCollection<int>();
		_keyPointCollections.Alloc();
		_interactObjectCollections = new ConditionCollection<int>();
		_interactObjectCollections.Alloc();
		_avgConditionCollections = new ConditionCollection<int>();
		_avgConditionCollections.Alloc();
		_npcEventConditionCollections = new ConditionCollection<int>();
		_npcEventConditionCollections.Alloc();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.MissionN_Accept, OnMissionEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.MissionN_GiveUp, OnMissionEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.MissionN_Success, OnMissionEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.MissionN_Failure, OnMissionEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.MissionN_ConditionUpdate, OnMissionEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.MissionN_StageUpdate, OnMissionEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.MissionN_Tracing, OnMissionEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.MissionN_TracingStageUpdate, OnMissionEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Conversation_AVG_Start, OnAVGEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Conversation_AVG_End, OnAVGEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.SendKeyPoint, OnKeyPointEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Npc_Dialog_Finish, OnNpcEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Npc_Dialog_Start, OnNpcEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Npc_Timeline_Finish, OnNpcEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Npc_Timeline_Start, OnNpcEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Npc_State_Changed, OnNpcEvent);
	}

	protected override void UnInit()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MissionN_Accept, OnMissionEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MissionN_GiveUp, OnMissionEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MissionN_Success, OnMissionEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MissionN_Failure, OnMissionEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MissionN_ConditionUpdate, OnMissionEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MissionN_StageUpdate, OnMissionEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MissionN_Tracing, OnMissionEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MissionN_TracingStageUpdate, OnMissionEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Conversation_AVG_Start, OnAVGEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Conversation_AVG_End, OnAVGEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.SendKeyPoint, OnKeyPointEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Npc_Dialog_Finish, OnNpcEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Npc_Dialog_Start, OnNpcEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Npc_Timeline_Finish, OnNpcEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Npc_Timeline_Start, OnNpcEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Npc_State_Changed, OnNpcEvent);
		_missionConditionCollections?.Free();
		_keyPointCollections?.Free();
		_interactObjectCollections?.Free();
		_interactObjectCollections?.Free();
		_avgConditionCollections?.Free();
		_npcEventConditionCollections?.Free();
		_missionConditionCollections = (_avgConditionCollections = (_keyPointCollections = (_interactObjectCollections = null)));
		_npcEventConditionCollections = null;
	}

	private void OnMissionEvent(BaseEventContent evt)
	{
		int num = 0;
		if (!(evt is MissionNAcceptEvt missionNAcceptEvt))
		{
			if (!(evt is MissionNGiveUpEvt missionNGiveUpEvt))
			{
				if (!(evt is MissionNSuccessEvt missionNSuccessEvt))
				{
					if (!(evt is MissionNFailureEvt missionNFailureEvt))
					{
						if (!(evt is MissionNConditionUpdateEvt missionNConditionUpdateEvt))
						{
							if (!(evt is MissionNStageUpdateEvt missionNStageUpdateEvt))
							{
								if (!(evt is MissionNTracingEvt missionNTracingEvt))
								{
									return;
								}
								num = missionNTracingEvt.missionId;
							}
							else
							{
								num = missionNStageUpdateEvt.missionId;
							}
						}
						else
						{
							num = missionNConditionUpdateEvt.missionId;
						}
					}
					else
					{
						num = missionNFailureEvt.missionId;
					}
				}
				else
				{
					num = missionNSuccessEvt.missionId;
				}
			}
			else
			{
				num = missionNGiveUpEvt.missionId;
			}
		}
		else
		{
			num = missionNAcceptEvt.missionId;
		}
		if (_missionConditionCollections.conditions.TryGetValue(num, out var value))
		{
			EvaluateConditionsWithSnapshot(value);
		}
	}

	public void RegisterMissionCondition(int missionID, ICondition condition)
	{
		if (!_missionConditionCollections.conditions.TryGetValue(missionID, out var value))
		{
			value = ListPool<ICondition>.Get();
			_missionConditionCollections.conditions[missionID] = value;
		}
		value.Add(condition);
	}

	public void UnRegisterMissionCondition(int missionID, ICondition condition)
	{
		if (_missionConditionCollections.conditions.TryGetValue(missionID, out var value))
		{
			value.Remove(condition);
		}
	}

	private static void EvaluateConditionsWithSnapshot(List<ICondition> conditions)
	{
		List<ICondition> list = ListPool<ICondition>.Get();
		try
		{
			list.AddRange(conditions);
			foreach (ICondition item in list)
			{
				item.IsPass();
			}
		}
		finally
		{
			ListPool<ICondition>.Release(list);
		}
	}

	private void OnAVGEvent(BaseEventContent obj)
	{
		int key = 0;
		if (!(obj is ConversationAVGStartEvt conversationAVGStartEvt))
		{
			if (obj is ConversationAVGEndEvt conversationAVGEndEvt)
			{
				key = conversationAVGEndEvt.conversationId;
			}
		}
		else
		{
			key = conversationAVGStartEvt.conversationId;
		}
		if (_avgConditionCollections.conditions.TryGetValue(key, out var value))
		{
			EvaluateConditionsWithSnapshot(value);
		}
	}

	public void RegisterAVGCondition(int avgId, ICondition condition)
	{
		if (!_avgConditionCollections.conditions.TryGetValue(avgId, out var value))
		{
			value = ListPool<ICondition>.Get();
			_avgConditionCollections.conditions[avgId] = value;
		}
		value.Add(condition);
	}

	public void UnRegisterAVGCondition(int avgId, ICondition condition)
	{
		if (_avgConditionCollections.conditions.TryGetValue(avgId, out var value))
		{
			value.Remove(condition);
		}
	}

	private void OnNpcEvent(BaseEventContent evt)
	{
		if (evt is NpcEvent npcEvent && _npcEventConditionCollections.conditions.TryGetValue(npcEvent.NpcID, out var value))
		{
			EvaluateConditionsWithSnapshot(value);
		}
	}

	public void RegisterNpcEventCondition(int npcID, ICondition condition)
	{
		if (!_npcEventConditionCollections.conditions.TryGetValue(npcID, out var value))
		{
			value = ListPool<ICondition>.Get();
			_npcEventConditionCollections.conditions[npcID] = value;
		}
		value.Add(condition);
	}

	public void UnRegisterNpcEventCondition(int npcID, ICondition condition)
	{
		if (_npcEventConditionCollections.conditions.TryGetValue(npcID, out var value))
		{
			value.Remove(condition);
		}
	}

	private void OnKeyPointEvent(BaseEventContent baseEventContent)
	{
		if (!(baseEventContent is KeyPointChange keyPointChange))
		{
			return;
		}
		foreach (int key in keyPointChange.keys)
		{
			if (_keyPointCollections.conditions.TryGetValue(key, out var value))
			{
				EvaluateConditionsWithSnapshot(value);
			}
		}
	}

	public void RegisterKeyPointCondition(int keyPointID, ICondition condition)
	{
		if (!_keyPointCollections.conditions.TryGetValue(keyPointID, out var value))
		{
			value = ListPool<ICondition>.Get();
			_keyPointCollections.conditions[keyPointID] = value;
		}
		value.Add(condition);
	}

	public void UnRegisterKeyPointCondition(int keyPointID, ICondition condition)
	{
		if (_keyPointCollections.conditions.TryGetValue(keyPointID, out var value))
		{
			value.Remove(condition);
		}
	}

	public void RegisterInteractObject(int interactObjectUID, ICondition condition)
	{
		if (!_interactObjectCollections.conditions.TryGetValue(interactObjectUID, out var value))
		{
			value = ListPool<ICondition>.Get();
			_interactObjectCollections.conditions[interactObjectUID] = value;
		}
		value.Add(condition);
	}

	public void UnRegisterInteractObject(int interactObjectUID, ICondition condition)
	{
		if (_interactObjectCollections.conditions.TryGetValue(interactObjectUID, out var value))
		{
			value.Remove(condition);
		}
	}

	private void ResetCollections<T>(Dictionary<T, ConditionCollection<T>> toReset)
	{
		if (toReset == null)
		{
			return;
		}
		foreach (KeyValuePair<T, ConditionCollection<T>> item in toReset)
		{
			foreach (KeyValuePair<T, List<ICondition>> condition in item.Value.conditions)
			{
				if (condition.Value != null)
				{
					ListPool<ICondition>.Release(condition.Value);
				}
			}
			DictionaryPool<T, List<ICondition>>.Release(item.Value.conditions);
		}
		DictionaryPool<T, ConditionCollection<T>>.Release(toReset);
	}
}
