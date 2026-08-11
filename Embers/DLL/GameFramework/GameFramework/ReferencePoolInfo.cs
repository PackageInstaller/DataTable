using System;
using System.Runtime.InteropServices;

namespace GameFramework;

[StructLayout(LayoutKind.Auto)]
public struct ReferencePoolInfo(Type type, int unusedReferenceCount, int usingReferenceCount, int acquireReferenceCount, int releaseReferenceCount, int addReferenceCount, int removeReferenceCount)
{
	private readonly Type m_Type = type;

	private readonly int m_UnusedReferenceCount = unusedReferenceCount;

	private readonly int m_UsingReferenceCount = usingReferenceCount;

	private readonly int m_AcquireReferenceCount = acquireReferenceCount;

	private readonly int m_ReleaseReferenceCount = releaseReferenceCount;

	private readonly int m_AddReferenceCount = addReferenceCount;

	private readonly int m_RemoveReferenceCount = removeReferenceCount;

	public Type Type => m_Type;

	public int UnusedReferenceCount => m_UnusedReferenceCount;

	public int UsingReferenceCount => m_UsingReferenceCount;

	public int AcquireReferenceCount => m_AcquireReferenceCount;

	public int ReleaseReferenceCount => m_ReleaseReferenceCount;

	public int AddReferenceCount => m_AddReferenceCount;

	public int RemoveReferenceCount => m_RemoveReferenceCount;
}
