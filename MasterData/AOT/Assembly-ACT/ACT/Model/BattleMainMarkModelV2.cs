using System.Collections.Generic;
using System.Threading;
using ACT.Battle.Configs;
using ACT.Event;
using Fundamental;

namespace ACT.Model;

public class BattleMainMarkModelV2 : Model<BattleMainMarkModelV2>
{
	private int m_IncrementId = 1;

	private List<MissionPointData> m_Points = new List<MissionPointData>();

	private Dictionary<int, MissionPointData> m_PointDict = new Dictionary<int, MissionPointData>();

	public IReadOnlyList<MissionPointData> Points => m_Points;

	public IReadOnlyDictionary<int, MissionPointData> PointDict => m_PointDict;

	protected override void Init()
	{
	}

	protected override void UnInit()
	{
		foreach (MissionPointData point in Points)
		{
			point.UnInit();
		}
		m_Points.Clear();
		m_PointDict.Clear();
	}

	public int GetNewPointId()
	{
		return Interlocked.Increment(ref m_IncrementId);
	}

	public void RegisterPoint(MissionPointData point)
	{
		if (point != null && !m_PointDict.ContainsKey(point.PointId))
		{
			m_Points.Add(point);
			m_PointDict.Add(point.PointId, point);
			point.Init();
			MissionNPointAddedEvt evt = Singleton<EventManager>.instance.GetEvt<MissionNPointAddedEvt>();
			evt.missionPointData = point;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.TracingPointAdded, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	public void UnregisterPoint(MissionPointData point)
	{
		if (point != null && m_PointDict.Remove(point.PointId))
		{
			m_Points.Remove(point);
			point.UnInit();
			MissionNPointRemovedEvt evt = Singleton<EventManager>.instance.GetEvt<MissionNPointRemovedEvt>();
			evt.missionPointData = point;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.TracingPointRemoved, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	public MissionPointData GetMissionPointData(int missionPointId)
	{
		m_PointDict.TryGetValue(missionPointId, out var value);
		return value;
	}
}
