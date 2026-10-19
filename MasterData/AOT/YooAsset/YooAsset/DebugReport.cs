using System;
using System.Collections.Generic;
using System.Text;
using UnityEngine;

namespace YooAsset;

[Serializable]
internal class DebugReport
{
	public string DebuggerVersion = "2.3.3";

	public int FrameCount;

	public List<DebugPackageData> PackageDatas = new List<DebugPackageData>(10);

	public static byte[] Serialize(DebugReport debugReport)
	{
		return Encoding.UTF8.GetBytes(JsonUtility.ToJson(debugReport));
	}

	public static DebugReport Deserialize(byte[] data)
	{
		return JsonUtility.FromJson<DebugReport>(Encoding.UTF8.GetString(data));
	}
}
