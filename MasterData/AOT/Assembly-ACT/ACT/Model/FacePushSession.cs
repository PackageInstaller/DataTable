using ACT.Config;

namespace ACT.Model;

public sealed class FacePushSession
{
	private readonly FacePushScheduler _scheduler;

	private bool _notified;

	private bool _shownNotified;

	internal int SessionId { get; }

	internal string OpenFailReason { get; private set; }

	public FacePushSourceType SourceType { get; }

	public PopUp Config { get; }

	public int OpenTime { get; private set; }

	internal FacePushSession(FacePushScheduler scheduler, int sessionId, FacePushSourceType sourceType, PopUp config)
	{
		_scheduler = scheduler;
		SessionId = sessionId;
		SourceType = sourceType;
		Config = config;
	}

	public bool NotifyClosed()
	{
		if (!TryMarkNotified())
		{
			FacePushFlowLog.Fail("关闭拍脸", DescribeRejectedCallback("关闭"));
			return false;
		}
		bool flag = _scheduler.NotifySessionClosed(this);
		if (!flag)
		{
			FacePushFlowLog.FailAlways("关闭拍脸", $"会话 {SessionId} 已不是当前拍脸");
		}
		return flag;
	}

	public bool NotifyCloseTransitionStarted()
	{
		bool flag = _scheduler.NotifySessionCloseTransitionStarted(this);
		if (!flag)
		{
			FacePushFlowLog.Fail("关闭衔接", $"会话 {SessionId} 已不是当前拍脸");
			return flag;
		}
		FacePushFlowLog.Success("关闭衔接", $"会话 {SessionId} 开始预排下一条");
		return flag;
	}

	public bool NotifyJumpClicked()
	{
		if (!TryMarkNotified())
		{
			FacePushFlowLog.Fail("拍脸跳转", DescribeRejectedCallback("跳转"));
			return false;
		}
		bool flag = _scheduler.NotifySessionJumpClicked(this);
		if (!flag)
		{
			FacePushFlowLog.FailAlways("拍脸跳转", $"会话 {SessionId} 已不是当前拍脸");
		}
		return flag;
	}

	public bool NotifyOpenFailed(string reason = null)
	{
		if (!TryMarkNotified())
		{
			FacePushFlowLog.Fail("打开失败通知", DescribeRejectedCallback("打开失败"));
			return false;
		}
		OpenFailReason = (string.IsNullOrEmpty(reason) ? "未提供具体原因" : reason);
		bool flag = _scheduler.NotifySessionOpenFailed(this);
		if (!flag)
		{
			FacePushFlowLog.FailAlways("打开失败通知", $"会话 {SessionId} 未被调度器接受：{OpenFailReason}");
		}
		return flag;
	}

	public bool NotifyShown()
	{
		if (_shownNotified || _notified)
		{
			FacePushFlowLog.Fail("拍脸展示", DescribeRejectedCallback("展示"));
			return false;
		}
		_shownNotified = true;
		OpenTime = TimeManager.ServerTime.NowTimestampSecond;
		bool flag = _scheduler.NotifySessionShown(this);
		if (!flag)
		{
			FacePushFlowLog.FailAlways("拍脸展示", $"会话 {SessionId} 已不是当前拍脸");
		}
		return flag;
	}

	private string DescribeRejectedCallback(string action)
	{
		if (_notified)
		{
			return $"会话 {SessionId} 的{action}重复通知";
		}
		if (_shownNotified)
		{
			return $"会话 {SessionId} 已经记录过展示";
		}
		return $"会话 {SessionId} 的{action}被拒绝";
	}

	private bool TryMarkNotified()
	{
		if (_notified)
		{
			return false;
		}
		_notified = true;
		return true;
	}
}
