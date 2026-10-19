using System;
using System.Collections.Generic;
using ACT.Event;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle;

public class ChTimeStatisticsManager
{
	private const int InvalidCharacterId = -100;

	private Dictionary<int, float> timeRecord = new Dictionary<int, float>();

	private DateTime currentChStartTime;

	private int currentChId;

	public void Bind()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.AfterEnterWorld, AfterEnterScene);
	}

	public float GetTimeStatistics(int id)
	{
		return timeRecord.GetValueOrDefault(id, 0f);
	}

	public void AfterEnterScene(BaseEventContent content)
	{
		ResetRecording();
		UnRegister();
		Register();
	}

	private void OnBeforeBattleCharacterChange(BaseEventContent content)
	{
		if (content is BattleCharacterChangeEvt battleCharacterChangeEvt)
		{
			Calculate();
			RecordCharacter(battleCharacterChangeEvt.newEb.GetCompCharacter().characterSource.Id());
		}
	}

	private void Register()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BeforeBattleCharacterChange, OnBeforeBattleCharacterChange);
	}

	private void UnRegister()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BeforeBattleCharacterChange, OnBeforeBattleCharacterChange);
	}

	public void Calculate()
	{
		if (currentChId != -100)
		{
			float num = (float)(DateTime.Now - currentChStartTime).TotalSeconds;
			if (!timeRecord.TryAdd(currentChId, num))
			{
				timeRecord[currentChId] += num;
			}
			currentChStartTime = DateTime.Now;
		}
	}

	public void RecordCharacter(int chId)
	{
		if (chId == -100)
		{
			StopRecording();
			return;
		}
		currentChId = chId;
		currentChStartTime = DateTime.Now;
	}

	public void StopRecording()
	{
		Calculate();
		currentChId = -100;
	}

	public void ResetRecording()
	{
		currentChId = -100;
		currentChStartTime = DateTime.Now;
		timeRecord.Clear();
		if (MonoECS.instance.mainEntity.IsValid)
		{
			currentChId = MonoECS.instance.mainEntity.GetCompCharacter().characterSource.Id();
		}
	}
}
