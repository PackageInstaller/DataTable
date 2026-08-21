#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using Ase.ECS;
using GameFramework;

namespace Ase;

public class EntityVoiceComponent : BaseComponent, IObserverHandler
{
	protected Dictionary<BattleObserverEventEnum, List<BattleVoiceData>> voiceDataDic;

	protected float volume;

	private LinkedList<BattleVoiceData> battleVoiceDataList;

	public override void OnAwake(object data = null)
	{
		base.OnAwake(data);
		voiceDataDic = new Dictionary<BattleObserverEventEnum, List<BattleVoiceData>>();
		battleVoiceDataList = new LinkedList<BattleVoiceData>();
		Singleton<AudioSystem>.Instance.RegisterEntityGroup(mBaseEntity.Id);
	}

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		InitVoiceConfigs();
		BattleObserverSystem system = mBaseEntity.GetSystem<BattleObserverSystem>();
		if (system == null)
		{
			return;
		}
		foreach (BattleObserverEventEnum key in voiceDataDic.Keys)
		{
			system.Attach(key, this);
		}
	}

	protected virtual void InitVoiceConfigs()
	{
		DRBattleVoice[] dataRows = GameEntry.DataTable.GetDataRows((DRBattleVoice p) => p.ObjectId == mBaseEntity.EntityId);
		if (dataRows != null)
		{
			foreach (DRBattleVoice dRBattleVoice in dataRows)
			{
				if (!voiceDataDic.TryGetValue(dRBattleVoice.BattleObserverEventEnum, out var value))
				{
					value = new List<BattleVoiceData>();
					voiceDataDic.Add(dRBattleVoice.BattleObserverEventEnum, value);
				}
				value.Add(new BattleVoiceData(mBaseEntity, dRBattleVoice));
			}
		}
		volume = 1f;
		if (mBaseEntity is HeroEntity heroEntity && !heroEntity.BattleHeroData.IsSelf)
		{
			DRConstantConfig dataRow = GameEntry.DataTable.GetDataRow<DRConstantConfig>(1019);
			if (dataRow == null)
			{
				Log.Error("战斗语音常数表为空");
			}
			else
			{
				volume = dataRow.Value;
			}
		}
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		if (battleVoiceDataList.IsNullOrEmpty())
		{
			return;
		}
		LinkedListNode<BattleVoiceData> linkedListNode = battleVoiceDataList.First;
		while (linkedListNode != null)
		{
			BattleVoiceData value = linkedListNode.Value;
			linkedListNode = linkedListNode.Next;
			if (value != null)
			{
				value.Update(deltaTime);
				if (value.CheckDelayTime())
				{
					OnPlayVoice(value);
					value.Reset();
					battleVoiceDataList.Remove(value);
				}
			}
		}
	}

	public void OnNotify(IObserverParams param)
	{
		if (param == null || !voiceDataDic.TryGetValue(param.ObserverEventType, out var value))
		{
			return;
		}
		foreach (BattleVoiceData item in value)
		{
			if (item.CheckCondition(mBaseEntity, param) && item.CheckCoolingTime())
			{
				if (item.CheckDelayTime())
				{
					OnPlayVoice(item);
				}
				else
				{
					battleVoiceDataList.AddLast(item);
				}
			}
		}
	}

	protected virtual void OnPlayVoice(BattleVoiceData data)
	{
		if (data != null && data.Config != null)
		{
			int id = data.Config.VoiceId;
			DRAudio soundIdByParentSkinConfig = mBaseEntity.GetSoundIdByParentSkinConfig(data.Config.VoiceId);
			if (soundIdByParentSkinConfig != null)
			{
				id = soundIdByParentSkinConfig.Id;
			}
			Singleton<AudioSystem>.Instance?.PlayEntityVoice(mBaseEntity.Id, id, data.Config.Priority, (float)data.Config.Volume / 100f * volume);
		}
	}

	public override void OnDispose()
	{
		base.OnDispose();
		Singleton<AudioSystem>.Instance.UnRegisterEntityGroup(mBaseEntity.Id, stopVoice: true);
		BattleObserverSystem system = mBaseEntity.GetSystem<BattleObserverSystem>();
		if (system != null)
		{
			foreach (BattleObserverEventEnum key in voiceDataDic.Keys)
			{
				system.Detach(key, this);
			}
		}
		voiceDataDic.Clear();
		battleVoiceDataList.Clear();
	}
}
