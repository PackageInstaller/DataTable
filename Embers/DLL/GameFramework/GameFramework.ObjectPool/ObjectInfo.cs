using System;
using System.Runtime.InteropServices;

namespace GameFramework.ObjectPool;

[StructLayout(LayoutKind.Auto)]
public struct ObjectInfo(string name, bool locked, bool customCanReleaseFlag, int priority, DateTime lastUseTime, int spawnCount)
{
	private readonly string m_Name = name;

	private readonly bool m_Locked = locked;

	private readonly bool m_CustomCanReleaseFlag = customCanReleaseFlag;

	private readonly int m_Priority = priority;

	private readonly DateTime m_LastUseTime = lastUseTime;

	private readonly int m_SpawnCount = spawnCount;

	public string Name => m_Name;

	public bool Locked => m_Locked;

	public bool CustomCanReleaseFlag => m_CustomCanReleaseFlag;

	public int Priority => m_Priority;

	public DateTime LastUseTime => m_LastUseTime;

	public bool IsInUse => m_SpawnCount > 0;

	public int SpawnCount => m_SpawnCount;
}
