using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Event;
using ACT.Game.Data;
using ACT.UI;
using Bamboo.Precache;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.Model;

public class BattleMainMarkModel : Model<BattleMainMarkModel>
{
	public Dictionary<SceneStatus, List<MissionArrowData>> MissionArrowDict = new Dictionary<SceneStatus, List<MissionArrowData>>();

	private CancellationTokenSource m_UpdateCancellationTokenSource;

	protected override void Init()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Battle_TP, RefreshMissionCache);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Battle_SwitchMotionPath, RefreshMissionCache);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.NPCPoint_Refresh, RefreshMissionCache);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.TracingPointAdded, OnTracingPointAdded);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.TracingPointRemoved, OnTracingPointRemoved);
		m_UpdateCancellationTokenSource?.Cancel();
		m_UpdateCancellationTokenSource?.Dispose();
		m_UpdateCancellationTokenSource = new CancellationTokenSource();
		BeginUpdate(m_UpdateCancellationTokenSource.Token).Forget();
	}

	private async UniTask BeginUpdate(CancellationToken cancellationToken)
	{
		while (!cancellationToken.IsCancellationRequested)
		{
			foreach (KeyValuePair<SceneStatus, List<MissionArrowData>> item in MissionArrowDict)
			{
				foreach (MissionArrowData item2 in item.Value)
				{
					if (item2.missionPointData != null && item2.effectGo != null && (bool)item2.effectGo.Result)
					{
						item2.effectGo.Result.SetActive(item2.missionPointData.IsSameWorld);
					}
				}
			}
			await UniTask.Yield(cancellationToken, cancelImmediately: true);
		}
	}

	protected override void UnInit()
	{
		m_UpdateCancellationTokenSource?.Cancel();
		m_UpdateCancellationTokenSource?.Dispose();
		m_UpdateCancellationTokenSource = null;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Battle_TP, RefreshMissionCache);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Battle_SwitchMotionPath, RefreshMissionCache);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.NPCPoint_Refresh, RefreshMissionCache);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.TracingPointAdded, OnTracingPointAdded);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.TracingPointRemoved, OnTracingPointRemoved);
		foreach (KeyValuePair<SceneStatus, List<MissionArrowData>> item in MissionArrowDict)
		{
			List<MissionArrowData> value = item.Value;
			for (int i = 0; i < value.Count; i++)
			{
				ReleaseMissionArrowData(value[i]);
			}
		}
		MissionArrowDict?.Clear();
	}

	private void OnTracingPointAdded(BaseEventContent evt)
	{
		MissionPointData missionPointData = (evt as MissionNPointAddedEvt).missionPointData;
		_ = missionPointData.PointId;
		MissionArrowData newData = MissionArrowData.s_MissionDataPool.Get();
		newData.Activate();
		newData.missionPointData = missionPointData;
		if (missionPointData.NeedEffect)
		{
			InstanceHandle instanceHandle = PrecacheManager.Instance.GetInstanceHandle(GameLoader.meta.missionArrowEffect.GUID);
			newData.Asset = GameLoader.meta.missionArrowEffect;
			newData.effectGo = instanceHandle;
			if (instanceHandle.IsDone)
			{
				instanceHandle.Result.transform.SetParent(null, worldPositionStays: true);
				newData.UpdateEffectPosition();
				Singleton<EventManager>.instance.AddEventListener(ClientEvent.Scene_PartionChange_Complete, newData.UpdateEffectPosition);
			}
			else
			{
				instanceHandle.Completed += (InstanceHandle l) =>
				{
					if (newData.isActive)
					{
						if (!l.Result)
						{
							PrecacheManager.Instance.ReleaseInstanceHandle(l);
							newData.effectGo = null;
						}
						else
						{
							l.Result.transform.SetParent(null, worldPositionStays: true);
							newData.UpdateEffectPosition();
							Singleton<EventManager>.instance.AddEventListener(ClientEvent.Scene_PartionChange_Complete, newData.UpdateEffectPosition);
						}
					}
				};
			}
		}
		GetCurrentTrackMissionDatas().Add(newData);
		MissionNArrowPointAddedEvt evt2 = Singleton<EventManager>.instance.GetEvt<MissionNArrowPointAddedEvt>();
		evt2.missionArrowData = newData;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.TracingArrowAdded, evt2);
		Singleton<EventManager>.instance.ReleaseEvt(evt2);
	}

	private void OnTracingPointRemoved(BaseEventContent evt)
	{
		MissionPointData missionPointData = (evt as MissionNPointRemovedEvt).missionPointData;
		foreach (KeyValuePair<SceneStatus, List<MissionArrowData>> item in MissionArrowDict)
		{
			List<MissionArrowData> value = item.Value;
			if (value == null)
			{
				continue;
			}
			MissionArrowData missionArrowData = null;
			for (int i = 0; i < value.Count; i++)
			{
				if (value[i].missionPointData.PointId == missionPointData.PointId)
				{
					missionArrowData = value[i];
					break;
				}
			}
			if (missionArrowData != null)
			{
				value.Remove(missionArrowData);
				MissionNArrowPointRemovedEvt evt2 = Singleton<EventManager>.instance.GetEvt<MissionNArrowPointRemovedEvt>();
				evt2.missionArrowData = missionArrowData;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.TracingArrowRemoved, evt2);
				Singleton<EventManager>.instance.ReleaseEvt(evt2);
				ReleaseMissionArrowData(missionArrowData);
				break;
			}
		}
	}

	private static void ReleaseMissionArrowData(MissionArrowData data)
	{
		if (data == null || !data.TryDeactivate())
		{
			return;
		}
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Scene_PartionChange_Complete, data.UpdateEffectPosition);
		if (data.effectGo == null)
		{
			MissionArrowData.s_MissionDataPool.Release(data);
			return;
		}
		data.effectGo.Completed += (InstanceHandle handle) =>
		{
			PrecacheManager.Instance.ReleaseInstanceHandle(handle);
			data.effectGo = null;
			MissionArrowData.s_MissionDataPool.Release(data);
		};
	}

	public List<MissionArrowData> GetCurrentTrackMissionDatas()
	{
		if (!MissionArrowDict.TryGetValue(MonoECS.instance.sceneStatus, out var value))
		{
			value = new List<MissionArrowData>();
			MissionArrowDict.TryAdd(MonoECS.instance.sceneStatus, value);
		}
		return value;
	}

	private void RefreshMissionCache(BaseEventContent obj)
	{
		List<MissionPointData> list = GetCurrentTrackMissionDatas().ConvertAll((MissionArrowData _) => _.missionPointData);
		Model<MapModel>.Interface?.OnTrackMissionGuidePointUpdate(list, list);
	}
}
