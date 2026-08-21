#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class BannerViewModel : OptionBase
{
	private List<DRBanner> bannerConfigs = new List<DRBanner>();

	private InteractionRequest refreshRequest = new InteractionRequest();

	private bool showSwitch = true;

	private ISubscription<BannerMessage> _subscription;

	private bool jumpEnable = true;

	private BannerInfo _singleBannerInfo;

	private int secondDuration;

	private Timer durationTimer;

	public BannerInfo SingleBannerInfo => _singleBannerInfo;

	public List<DRBanner> BannerConfigs => bannerConfigs;

	public bool ShowSwitch
	{
		get
		{
			return showSwitch;
		}
		set
		{
			Set(ref showSwitch, value, "ShowSwitch");
		}
	}

	public InteractionRequest RefreshRequest => refreshRequest;

	public BannerViewModel()
	{
	}

	public BannerViewModel(OptionBase parent)
	{
		base.parent = parent;
		_subscription = Singleton<ServiceSystem>.Instance.GetService<IBannerService>().GetMessager().Subscribe<BannerMessage>(OnMessage);
		RefreshSingleBannerData(notifyUi: false);
	}

	private void OnMessage(BannerMessage msg)
	{
		RefreshSingleBannerData();
	}

	public void OnSingleBannerClick()
	{
		if (_singleBannerInfo != null && jumpEnable)
		{
			DRBanner config = _singleBannerInfo.Config;
			if (!string.IsNullOrEmpty(config.JumpWeb))
			{
				JumpWeb(config.JumpWeb);
			}
			else if (!string.IsNullOrEmpty(config.JumpWindow))
			{
				JumpWindow(config.JumpWindow, config.JumpConfig);
			}
			Close();
		}
	}

	private void RefreshSingleBannerData(bool notifyUi = true)
	{
		BannerInfo bannerInfo = Singleton<ServiceSystem>.Instance.GetService<IBannerService>()?.GetBannerWaitShow();
		if (bannerInfo != null && (_singleBannerInfo == null || _singleBannerInfo.Id != bannerInfo.Id))
		{
			_singleBannerInfo = bannerInfo;
			if (notifyUi)
			{
				refreshRequest.Raise();
			}
		}
	}

	public void SetSingleBannerShowed()
	{
		Singleton<ServiceSystem>.Instance.GetService<IBannerService>()?.SetBannerShowed(_singleBannerInfo.Id, _singleBannerInfo.UseCd);
	}

	public void RefreshBannerData(bool notifyUi = true)
	{
		bannerConfigs.Clear();
		bannerConfigs = BannerService.GetOpenBannerConfigs();
		bannerConfigs.Sort((DRBanner a, DRBanner b) => a.Sort.CompareTo(b.Sort));
		ShowSwitch = bannerConfigs.Count > 1;
		if (notifyUi)
		{
			refreshRequest.Raise();
		}
	}

	public void OnBannerClick(DRBanner drBanner)
	{
		if (drBanner != null && jumpEnable)
		{
			if (!string.IsNullOrEmpty(drBanner.JumpWeb))
			{
				JumpWeb(drBanner.JumpWeb);
			}
			else if (!string.IsNullOrEmpty(drBanner.JumpWindow))
			{
				JumpWindow(drBanner.JumpWindow, drBanner.JumpConfig);
			}
			Close();
		}
	}

	private void JumpWeb(string url)
	{
		try
		{
			jumpEnable = false;
			string text = GameEntry.Web.OpenWebViewWithUid(url, ((Component)(object)GameEntry.UI.Canvas).GetComponent<RectTransform>(), useToolBar: true, null, null);
			if (!string.IsNullOrEmpty(text))
			{
				Toast.ShowInfo(text);
			}
			BannerService.SendTDAEventClick(GetTDABannerId(), "跳转网页：" + url, secondDuration);
		}
		catch (Exception ex)
		{
			Log.Error(ex?.ToString() + ex.StackTrace);
		}
		finally
		{
			jumpEnable = true;
		}
	}

	private async void JumpWindow(string windowName, List<int> args)
	{
		List<object> list = new List<object>();
		if (args != null)
		{
			foreach (int arg in args)
			{
				list.Add(arg);
			}
		}
		JumpWindowParams pars = new JumpWindowParams(windowName, list);
		try
		{
			jumpEnable = false;
			OpenViewArg openViewArg = await new UIJumpHelper().CreateViewJumpData(pars, parent, "BannerWindow", delegate
			{
				jumpEnable = true;
			});
			if (openViewArg == null)
			{
				jumpEnable = true;
				return;
			}
			ItemOnClick(openViewArg);
			BannerService.SendTDAEventClick(GetTDABannerId(), "跳转界面：" + windowName, secondDuration);
		}
		catch (Exception ex)
		{
			Log.Error(ex?.ToString() + ex.StackTrace);
			jumpEnable = true;
		}
	}

	public void StartTimer()
	{
		if (durationTimer != null)
		{
			return;
		}
		try
		{
			durationTimer = Timer.Register(1f, OnComplete, null, isLooped: true, useRealTime: true);
		}
		catch (Exception)
		{
			Log.Error("BannerWindow：开启计时器失败");
		}
	}

	private void OnComplete()
	{
		secondDuration++;
	}

	private void CancelTimer()
	{
		if (durationTimer != null)
		{
			durationTimer.Cancel();
			durationTimer = null;
		}
	}

	private int GetTDABannerId()
	{
		if (_singleBannerInfo != null)
		{
			return _singleBannerInfo.Id;
		}
		return 0;
	}

	public override void Close()
	{
		BannerService.SendTDAEventClose(GetTDABannerId(), "用户点击关闭", secondDuration);
		base.Close();
	}

	protected override void Dispose(bool disposing)
	{
		_subscription?.Dispose();
		_subscription = null;
		CancelTimer();
		base.Dispose(disposing);
	}
}
