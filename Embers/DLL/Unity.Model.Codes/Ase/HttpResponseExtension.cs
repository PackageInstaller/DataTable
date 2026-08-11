#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using GameFramework;
using GameFramework.WebRequest;
using Newtonsoft.Json;

namespace Ase;

public static class HttpResponseExtension
{
	public static (T, string) GetResponseData<T>(this WebRequestResponse response) where T : class
	{
		if (response == null)
		{
			return (null, "请求失败.");
		}
		if (response.IsError)
		{
			return (null, response.ErrorMessage);
		}
		byte[] webResponseBytes = response.GetWebResponseBytes();
		if (webResponseBytes.Length <= 3)
		{
			return (null, "数据长度错误.");
		}
		T item = null;
		string text = string.Empty;
		string item2 = string.Empty;
		try
		{
			text = Utility.Converter.GetString(response.GetWebResponseBytes(), 3, webResponseBytes.Length - 3);
			item = JsonConvert.DeserializeObject<T>(text);
		}
		catch (Exception ex)
		{
			Log.Error($"反序列化[{typeof(T)}]数据出错. 数据 = {text}  错误信息 = {ex.Message}");
			item2 = "数据解析错误.";
		}
		return (item, item2);
	}

	public static (T, string) GetResponseDataNoBom<T>(this WebRequestResponse response) where T : class
	{
		if (response == null)
		{
			return (null, "请求失败.");
		}
		if (response.IsError)
		{
			return (null, response.ErrorMessage);
		}
		if (response.GetWebResponseBytes().Length <= 3)
		{
			return (null, "数据长度错误.");
		}
		T item = null;
		string text = string.Empty;
		string item2 = string.Empty;
		try
		{
			text = Utility.Converter.GetString(response.GetWebResponseBytes());
			item = JsonConvert.DeserializeObject<T>(text);
		}
		catch (Exception ex)
		{
			Log.Error($"反序列化[{typeof(T)}]数据出错. 数据 = {text}  错误信息 = {ex.Message}");
			item2 = "数据解析错误.";
		}
		return (item, item2);
	}
}
