#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using MiniJSON;
using UnityEngine;

namespace Ase;

public class SDKCallBack : MonoBehaviour
{
	public ISDKService m_Service;

	public void BindServices(ISDKService service)
	{
		m_Service = service;
	}

	public void OnLoginSuccess(string data)
	{
		Dictionary<string, object> dictionary = Json.Deserialize(data) as Dictionary<string, object>;
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.userid = dictionary["uid"].ToString();
		loginInfo.name = dictionary["username"].ToString();
		loginInfo.token = dictionary["token"].ToString();
		try
		{
			loginInfo.channel = Convert.ToInt64(dictionary["channelId"].ToString());
		}
		catch (InvalidCastException)
		{
			Log.Error("Channel转换失败");
		}
		m_Service.OnLoginSuccess(loginInfo);
	}

	public void OnLogoutSuccess(string data)
	{
		Json.Deserialize(data);
		m_Service.OnLogoutSuccess();
	}

	public void OnLoginFaile(string data)
	{
		Dictionary<string, object> dictionary = Json.Deserialize(data) as Dictionary<string, object>;
		LoginInfo loginInfo = new LoginInfo();
		loginInfo.userid = dictionary["uid"].ToString();
		loginInfo.name = dictionary["username"].ToString();
		loginInfo.token = dictionary["token"].ToString();
		try
		{
			loginInfo.channel = Convert.ToInt64(dictionary["channelId"].ToString());
		}
		catch (InvalidCastException)
		{
			Log.Error("Channel转换失败");
		}
		m_Service.OnLoginFaile(loginInfo);
	}

	public void OnPaySuccess(string data)
	{
		m_Service.OnPaySuccess();
	}

	public void OnPayFail(string data)
	{
		Dictionary<string, object> eventPropertys = Json.Deserialize(data) as Dictionary<string, object>;
		m_Service.OnPayFail(eventPropertys);
	}

	public void OnPayCancel(string data)
	{
		Dictionary<string, object> eventPropertys = Json.Deserialize(data) as Dictionary<string, object>;
		m_Service.OnPayCancel(eventPropertys);
	}

	public void OnGetDeviceInfo(string data)
	{
		KiifInterface.Instance._MODEL = data;
	}
}
