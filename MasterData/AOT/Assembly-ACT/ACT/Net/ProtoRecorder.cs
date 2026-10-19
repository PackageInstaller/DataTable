using System;
using System.Collections.Generic;
using System.IO;
using Newtonsoft.Json;
using UnityEngine;

namespace ACT.Net;

public static class ProtoRecorder
{
	private static string m_LogPath = "./ACTLogs/";

	private static string m_FileName = "protoLog_" + DateTime.Now.ToString("yyyy_MM_dd") + "_" + DateTime.Now.ToString("HH_mm_ss") + ".json";

	private static List<MsgData> data = new List<MsgData>();

	private static string json;

	public static void SaveBinaryDataAsJson(NetCommand command, Span<byte> binaryData)
	{
		string timestamp = Convert.ToString(DateTimeOffset.UtcNow.ToUnixTimeMilliseconds());
		data.Add(new MsgData
		{
			msg = command.ToString(),
			timestamp = timestamp,
			binary = Convert.ToBase64String(binaryData)
		});
		json = JsonConvert.SerializeObject(data);
	}

	public static void OutPutFile()
	{
		if (!Directory.Exists(m_LogPath))
		{
			Directory.CreateDirectory(m_LogPath);
		}
		using StreamWriter streamWriter = new StreamWriter(m_LogPath + m_FileName);
		streamWriter.Write(json);
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("协议录制数据导出成功！路径:" + m_LogPath + "/" + m_FileName);
		}
	}
}
