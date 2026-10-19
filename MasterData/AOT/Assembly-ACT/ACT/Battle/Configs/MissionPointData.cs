using System;
using ACT.MissionSystem;
using ACT.World;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

public abstract class MissionPointData : IEquatable<MissionPointData>
{
	public int PointId { get; }

	public int MissionId { get; private set; }

	public bool Use3DLogic { get; private set; }

	public bool NeedEffect { get; private set; }

	public MapArea MapArea { get; private set; }

	public bool ShowIcon { get; set; } = true;

	public bool ShowRadius { get; set; }

	public float Radius { get; set; } = 10f;

	public int MapLayer => 0;

	public virtual bool IsSameWorld => MapArea == (MapArea)Singleton<GameManager>.instance.worldManager.ActiveMapId;

	public virtual bool IsSameArea => MapArea == (MapArea)Singleton<GameManager>.instance.worldManager.ActiveMapId;

	protected MissionPointData(int missionId, int pointId, bool use3DLogic, MapArea area, bool needEffect)
	{
		PointId = pointId;
		MissionId = missionId;
		Use3DLogic = use3DLogic;
		NeedEffect = needEffect;
		MapArea = area;
	}

	public virtual void Init()
	{
	}

	public virtual void UnInit()
	{
	}

	public bool InRadius(Vector3 pos)
	{
		return Vector3.Distance(pos, GetActualPos()) < Radius;
	}

	public abstract Vector3 GetActualPos();

	public MapArea GetActualMapArea()
	{
		return MapArea;
	}

	public MapLayer GetActualMapLayer()
	{
		return (MapLayer)MapLayer;
	}

	public Vector3 GetGuidePointPosition()
	{
		return GetActualPos();
	}

	public MapArea GetGuidePointMapArea()
	{
		return GetActualMapArea();
	}

	public MapLayer GetGuidePointMapLayer()
	{
		return GetActualMapLayer();
	}

	public int GetMissionType()
	{
		return Singleton<MissionManager>.instance.GetMissionConfig(MissionId).MissionType;
	}

	public int GetSpriteId()
	{
		return Singleton<MissionManager>.instance.GetMissionConfig(MissionId).MissionType;
	}

	public override string ToString()
	{
		return $"PointId : {PointId} \n" + $"MissionId : {MissionId} \n" + $"PointType : {GetType()} \n" + $"ConfigPosition : {GetActualPos()} \n";
	}

	public override int GetHashCode()
	{
		return PointId.GetHashCode();
	}

	public override bool Equals(object obj)
	{
		return Equals((MissionPointData)obj);
	}

	public virtual bool Equals(MissionPointData other)
	{
		if (other == null)
		{
			return false;
		}
		return other.PointId == PointId;
	}
}
