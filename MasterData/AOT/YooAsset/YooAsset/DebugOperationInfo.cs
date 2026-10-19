using System;
using System.Collections.Generic;

namespace YooAsset;

[Serializable]
internal struct DebugOperationInfo : IComparer<DebugOperationInfo>, IComparable<DebugOperationInfo>
{
	public string OperationName;

	public string OperationDesc;

	public uint Priority;

	public float Progress;

	public string BeginTime;

	public long ProcessTime;

	public string Status;

	public List<DebugOperationInfo> Childs;

	public int CompareTo(DebugOperationInfo other)
	{
		return Compare(this, other);
	}

	public int Compare(DebugOperationInfo a, DebugOperationInfo b)
	{
		return string.CompareOrdinal(a.OperationName, b.OperationName);
	}
}
