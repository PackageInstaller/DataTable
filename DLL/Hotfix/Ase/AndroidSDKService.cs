#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using UnityEngine;

namespace Ase;

public sealed class AndroidSDKService : ISDKService, IDisposable
{
	public SDKLoginResult loginResult;

	public SDKPayResult payResult;

	private GameObject callbackGo;

	private Loading m_loading;

	private int productId;

	public AndroidSDKService()
	{
		callbackGo = new GameObject("AndroidSDKCallback");
		UnityEngine.Object.DontDestroyOnLoad(callbackGo);
		callbackGo.AddComponent<SDKCallBack>().BindServices(this);
	}

	public async UniTask<SDKLoginResult> Login()
	{
		loginResult = null;
		Singleton<ServiceSystem>.Instance.GetService<ISDKService>()?.OnSetDistinctId(TDAAgent.GetDistinctId());
		KiifInterface.Instance.Login();
		await UniTask.WaitUntil(() => loginResult != null);
		return loginResult;
	}

	public async void Pay(PyParams payInfos)
	{
		PyParams payinfo = new PyParams();
		m_loading = await Loading.ShowWithMessage("正在获取订单号...");
		SDKPayResult sDKPayResult = await Singleton<ServiceSystem>.Instance.GetService<ISDKService>().Pay(loginResult.Uid, loginResult.Username, payInfos.product_Id);
		if (sDKPayResult != null)
		{
			m_loading?.Dispose();
			m_loading = null;
			payinfo.app_User_Id = loginResult.Uid;
			payinfo.app_user_Name = loginResult.Username;
			payinfo.app_order_Id = sDKPayResult.OrderId;
			payinfo.amount = payInfos.amount;
			payinfo.app_Ext1 = payInfos.app_Ext1;
			payinfo.role_name = payInfos.role_name;
			payinfo.sid = payInfos.sid;
			payinfo.serverName = payInfos.serverName;
			payinfo.product_name = payInfos.product_name;
			payinfo.vipLevel = payInfos.vipLevel;
			payinfo.roleLevel = payInfos.roleLevel;
			payinfo.UnionName = payInfos.UnionName;
			payinfo.game_Role_Id = payInfos.game_Role_Id;
			payinfo.product_Id = payInfos.product_Id;
			payinfo.UnionName = payInfos.UnionName;
			payinfo.sign = sDKPayResult.OrderSign;
			productId = payInfos.product_Id;
			m_loading = await Loading.ShowWithMessage("正在支付...");
			KiifInterface.Instance.Py(payinfo);
		}
		else
		{
			m_loading?.Dispose();
			m_loading = null;
			Toast.ShowInfo("支付失败,建议您先确认所购商品类型，再尝试重新购买!");
		}
	}

	public void ReportPlayerData(ExtraGameData data)
	{
		KiifInterface.Instance.SubmitGameData(data);
	}

	public void Logout()
	{
		KiifInterface.Instance.Logout();
	}

	public void CustomerSer()
	{
		KiifInterface.Instance.CustomerService();
	}

	public void OpenTapReview()
	{
		KiifInterface.Instance.OpenReview();
	}

	public async UniTask<SDKPayResult> Pay(MakePayOrderRequest sdkPay)
	{
		try
		{
			MakePayOrderResponse makePayOrderResponse = await Singleton<NetworkSystem>.Instance.Call<MakePayOrderResponse>(sdkPay);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(makePayOrderResponse, "请求支付") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(makePayOrderResponse.Error, "请求支付失败"))
			{
				payResult = SDKPayResult.Create(makePayOrderResponse);
				return payResult;
			}
		}
		catch (Exception ex)
		{
			Log.Error("发送支付请求失败!" + ex.StackTrace + " / " + ex.Message);
			Toast.ShowError("发送支付请求失败");
		}
		return null;
	}

	public async UniTask<SDKPayResult> Pay(string uid, string name, int goodId)
	{
		MakePayOrderRequest makePayOrderRequest = MakePayOrderRequest.Create();
		makePayOrderRequest.Uid = uid;
		makePayOrderRequest.GoodsId = goodId;
		makePayOrderRequest.CName = name;
		return await Pay(makePayOrderRequest);
	}

	public void OnLoginSuccess(LoginInfo loginInfo)
	{
		loginResult = new SDKLoginResult(loginInfo.userid, loginInfo.token, loginInfo.name, "Success", loginInfo.channel);
	}

	public void OnLoginFaile(LoginInfo loginInfo)
	{
		loginResult = new SDKLoginResult(loginInfo.userid, loginInfo.name, loginInfo.token, "Faile", loginInfo.channel);
	}

	public void OnLoginCancel(LoginInfo loginInfo)
	{
		loginResult = new SDKLoginResult(loginInfo.userid, loginInfo.name, loginInfo.token, "Cancel", loginInfo.channel);
	}

	public void OnPayFail(Dictionary<string, object> eventPropertys)
	{
		m_loading?.Dispose();
		m_loading = null;
		TDAHandler.Instance.SendUserEvent("recharge_failure", eventPropertys);
	}

	public async UniTask OnPayCancel(Dictionary<string, object> eventPropertys)
	{
		m_loading?.Dispose();
		m_loading = null;
		TDAHandler.Instance.SendUserEvent("recharge_cancel", eventPropertys);
		await PayCancel(productId.ToString());
		productId = 0;
	}

	public async UniTask PayCancel(string productId)
	{
		ProtoDefaultGetRequest protoDefaultGetRequest = ProtoDefaultGetRequest.Create();
		protoDefaultGetRequest.Type = 6;
		protoDefaultGetRequest.SpareStrings.Add(productId);
		try
		{
			await Singleton<NetworkSystem>.Instance.Call<GetFloorCopyStarInfoResponse>(protoDefaultGetRequest);
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
	}

	public void OnLogoutSuccess()
	{
		Singleton<ServiceSystem>.Instance.GetService<IAccountService>().Logout();
	}

	public bool IfShowCustomerServiceBtn()
	{
		if (loginResult == null)
		{
			return false;
		}
		return loginResult.ChannelID switch
		{
			7L => true, 
			8L => true, 
			46L => false, 
			259L => true, 
			1000L => true, 
			_ => false, 
		};
	}

	public bool IfShowWriteOffBtn()
	{
		if (loginResult == null)
		{
			return false;
		}
		return loginResult.ChannelID switch
		{
			7L => false, 
			8L => false, 
			46L => true, 
			_ => false, 
		};
	}

	public void WriteOff()
	{
		KiifInterface.Instance.WriteOff();
	}

	public void OnSetDistinctId(string distinctId)
	{
		KiifInterface.Instance.OnSetDistinctId(distinctId);
	}

	public void OnSetAccountId(string account_id)
	{
		KiifInterface.Instance.OnSetAccountId(account_id);
	}

	public void OnPaySuccess()
	{
		m_loading?.Dispose();
		m_loading = null;
	}

	public void Dispose()
	{
		productId = 0;
		UnityEngine.Object.Destroy(callbackGo);
	}

	public SDKLoginResult GetSDKLoginResult()
	{
		return loginResult;
	}
}
