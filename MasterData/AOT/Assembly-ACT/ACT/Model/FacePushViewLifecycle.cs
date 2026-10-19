using System;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.Model;

public sealed class FacePushViewLifecycle
{
	private FacePushSession _session;

	private FacePushCloseReason _closeReason;

	private bool _shownNotified;

	private bool _closeTransitionNotified;

	private bool _notified;

	public bool HasSession => _session != null;

	public FacePushButtonActionType ButtonActionType
	{
		get
		{
			if (_session?.Config != null)
			{
				return (FacePushButtonActionType)_session.Config.buttonActionType;
			}
			return FacePushButtonActionType.None;
		}
	}

	public void Bind(object viewData)
	{
		_session = (viewData as IFacePushViewData)?.FacePushSession;
		_closeReason = FacePushCloseReason.Closed;
		_shownNotified = false;
		_closeTransitionNotified = false;
		_notified = false;
	}

	public bool NotifyShown()
	{
		if (_session == null || _shownNotified || _notified)
		{
			return false;
		}
		_shownNotified = true;
		return _session.NotifyShown();
	}

	public void MarkJumpClicked()
	{
		_closeReason = FacePushCloseReason.JumpClicked;
	}

	public bool TryExecuteButtonAction(Func<bool> canJump = null, Action onJump = null, Action onDirectPurchase = null, Action onClaimReward = null, Action onOpenActivityPage = null)
	{
		if (ButtonActionType == FacePushButtonActionType.None)
		{
			return false;
		}
		switch (ButtonActionType)
		{
		case FacePushButtonActionType.Jump:
			if (onJump == null)
			{
				return TryInvokeButtonAction(null, ButtonActionType);
			}
			if (canJump != null && !canJump())
			{
				return true;
			}
			MarkJumpClicked();
			return TryInvokeButtonAction(onJump, ButtonActionType);
		case FacePushButtonActionType.DirectPurchase:
			return TryInvokeButtonAction(onDirectPurchase, ButtonActionType);
		case FacePushButtonActionType.ClaimReward:
			return TryInvokeButtonAction(onClaimReward, ButtonActionType);
		case FacePushButtonActionType.OpenActivityPage:
			return TryInvokeButtonAction(onOpenActivityPage, ButtonActionType);
		default:
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning($"未知的拍脸按钮行为：{_session.Config.buttonActionType}，配置 id：{_session.Config.id}");
			}
			return true;
		}
	}

	private bool TryInvokeButtonAction(Action action, FacePushButtonActionType actionType)
	{
		if (action != null)
		{
			action();
			return true;
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogWarning($"拍脸配置 {_session.Config.id} 的按钮行为 {actionType} 未由当前 UI 实现。");
		}
		return true;
	}

	public bool NotifyCloseTransitionStarted()
	{
		if (_session == null || _closeReason != FacePushCloseReason.Closed || _closeTransitionNotified || _notified)
		{
			return false;
		}
		_closeTransitionNotified = true;
		_notified = true;
		return _session.NotifyCloseTransitionStarted();
	}

	public bool NotifyOnCloseComplete()
	{
		if (_session == null || _notified)
		{
			return false;
		}
		FacePushSession session = _session;
		FacePushCloseReason closeReason = _closeReason;
		if (closeReason == FacePushCloseReason.Closed)
		{
			return NotifyCloseTransitionStarted();
		}
		_notified = true;
		NotifyOnCloseCompleteAsync(session, closeReason).Forget();
		return true;
	}

	private async UniTaskVoid NotifyOnCloseCompleteAsync(FacePushSession session, FacePushCloseReason closeReason)
	{
		await UniTask.Yield();
		if (closeReason == FacePushCloseReason.JumpClicked)
		{
			session.NotifyJumpClicked();
		}
		else
		{
			session.NotifyClosed();
		}
	}

	public bool NotifyOpenFailed(string reason = null)
	{
		if (_session == null || _shownNotified || _notified)
		{
			if (_session != null)
			{
				FacePushFlowLog.Fail("拍脸界面打开", (_notified || _shownNotified) ? "本次拍脸已经通知过结果" : "没有拍脸会话");
			}
			return false;
		}
		_notified = true;
		string reason2 = (string.IsNullOrEmpty(reason) ? "界面数据无效" : reason);
		FacePushFlowLog.FailAlways("拍脸界面打开", reason2);
		return _session.NotifyOpenFailed(reason2);
	}
}
