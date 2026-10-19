using System;
using System.Text;
using UnityEngine;

namespace YooAsset;

[Serializable]
internal class RemoteCommand
{
	public int CommandType;

	public string CommandParam;

	public static byte[] Serialize(RemoteCommand command)
	{
		return Encoding.UTF8.GetBytes(JsonUtility.ToJson(command));
	}

	public static RemoteCommand Deserialize(byte[] data)
	{
		return JsonUtility.FromJson<RemoteCommand>(Encoding.UTF8.GetString(data));
	}
}
