using UnityEngine;

namespace ACT;

public abstract class MissionStateAdapter
{
	public abstract int Id { get; }

	public abstract bool IsTracing();

	public abstract bool IsFirstMissionInGroup();

	public abstract bool IsLastMissionInGroup();

	public abstract int GetMissionType();

	public abstract string GetMissionName();

	public abstract string GetMissionTitle();

	public abstract string GetMissionContent();

	public abstract string GetBlockText();

	public abstract bool IsBlocked();

	public abstract void RefreshDistanceText();

	public abstract string GetDistanceText();

	public abstract string GetTeleportText();

	public abstract Color GetDistanceColor();

	public abstract bool IsCrossMap();

	public abstract bool IsInZone();
}
