using System;
using ACT.World;
using UnityEngine;

namespace ACT.Battle.Configs;

public class FixedAreaMissionPoint : MissionPointData, IEquatable<Vector3>, IEquatable<FixedAreaMissionPoint>
{
	public Vector3 FixedPos { get; private set; }

	public FixedAreaMissionPoint(int missionId, int pointId, bool use3DLogic, MapArea area, Vector3 fixedPos)
		: base(missionId, pointId, use3DLogic, area, needEffect: true)
	{
		FixedPos = fixedPos;
	}

	public override bool Equals(object obj)
	{
		if (obj is FixedAreaMissionPoint other)
		{
			return Equals(other);
		}
		return base.Equals((MissionPointData)obj);
	}

	public bool Equals(Vector3 other)
	{
		return (double)Vector3.Magnitude(other - FixedPos) < 0.01;
	}

	public override bool Equals(MissionPointData other)
	{
		return Equals((object)other);
	}

	public bool Equals(FixedAreaMissionPoint other)
	{
		if (other != null)
		{
			return (double)Vector3.Magnitude(other.FixedPos - FixedPos) < 0.01;
		}
		return false;
	}

	public override Vector3 GetActualPos()
	{
		return FixedPos;
	}
}
