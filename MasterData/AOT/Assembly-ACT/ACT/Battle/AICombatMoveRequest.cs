using UnityEngine;

namespace ACT.Battle;

public struct AICombatMoveRequest(CompNav compNav, Vector3 candidate, string moveKey, bool validatePath, int priority)
{
	public bool isValid = compNav != null;

	public CompNav compNav = compNav;

	public Vector3 candidate = candidate;

	public string moveKey = moveKey ?? string.Empty;

	public bool validatePath = validatePath;

	public int priority = priority;

	public float requestTime = Time.time;
}
