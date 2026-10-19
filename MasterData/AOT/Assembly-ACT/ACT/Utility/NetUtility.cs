using System;
using System.Net.Http;
using System.Threading.Tasks;
using Newtonsoft.Json.Linq;
using UnityEngine;

namespace ACT.Utility;

public static class NetUtility
{
	public static async Task<JObject> GetJsonFileLinesAsync(string url)
	{
		using HttpClient client = new HttpClient();
		HttpResponseMessage httpResponseMessage = await client.GetAsync(url);
		try
		{
			httpResponseMessage.EnsureSuccessStatusCode();
			return JObject.Parse(await httpResponseMessage.Content.ReadAsStringAsync());
		}
		catch (Exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("没有找到" + url);
			}
			return null;
		}
	}
}
