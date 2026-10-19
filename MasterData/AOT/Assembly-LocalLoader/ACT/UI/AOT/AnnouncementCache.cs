using System;
using System.IO;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using ACT.Error;
using UnityEngine;
using UnityEngine.Networking;

namespace ACT.UI.AOT;

public static class AnnouncementCache
{
	private static string CachePath
	{
		get
		{
			string text = Path.Combine(Application.persistentDataPath, "cache", "annc");
			if (!Directory.Exists(text))
			{
				Directory.CreateDirectory(text);
			}
			return text;
		}
	}

	public static async Task<byte[]> CacheImage(string url, CancellationToken token)
	{
		try
		{
			string file = url.Replace("\\", "/").Split("/").LastOrDefault();
			if (!string.IsNullOrWhiteSpace(file))
			{
				if (TryGetCache(file, out var bytes))
				{
					return bytes;
				}
				UnityWebRequest request = UnityWebRequest.Get(url);
				await request.SendWebRequest();
				if (token.IsCancellationRequested)
				{
					return null;
				}
				if (request.result == UnityWebRequest.Result.Success)
				{
					byte[] data = request.downloadHandler.data;
					SaveCache(file, data);
					return data;
				}
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError($"Error when download announcement banner: {request.responseCode}");
				}
				LuminErrorAOT.ReportGameLoadingError("C02-0014", "02", 2, request.responseCode.ToString());
				return null;
			}
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("Error when download announcement banner: " + url);
			}
			LuminErrorAOT.ReportGameLoadingError("C02-0014", "02", 2, "Invalid url");
		}
		catch (Exception message)
		{
			Debug.LogError(message);
		}
		return null;
	}

	public static void SaveCache(string key, byte[] bytes)
	{
		File.WriteAllBytes(Path.Combine(CachePath, key), bytes);
	}

	public static bool TryGetCache(string key, out byte[] bytes)
	{
		string path = Path.Combine(CachePath, key);
		if (File.Exists(path))
		{
			bytes = File.ReadAllBytes(path);
			return true;
		}
		bytes = null;
		return false;
	}
}
