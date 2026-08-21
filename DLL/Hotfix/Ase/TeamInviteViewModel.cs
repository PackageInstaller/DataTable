using Cysharp.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public class TeamInviteViewModel : OptionBase
{
	private long friendId;

	private long roomId;

	private int model;

	private CopyData copyData;

	private string _friendName;

	private string _copyName;

	private SimpleCommand _cancelCmd;

	private SimpleCommand _confirmCmd;

	private Timer countdownTimer;

	private int _waitTime;

	private bool _needSendCancel;

	public string FriendName
	{
		get
		{
			return _friendName;
		}
		set
		{
			Set(ref _friendName, value, "FriendName");
		}
	}

	public string CopyName
	{
		get
		{
			return _copyName;
		}
		set
		{
			Set(ref _copyName, value, "CopyName");
		}
	}

	public int WaitTime
	{
		get
		{
			return _waitTime;
		}
		set
		{
			Set(ref _waitTime, value, "WaitTime");
		}
	}

	public bool NeedSendCancel
	{
		get
		{
			return _needSendCancel;
		}
		set
		{
			_needSendCancel = value;
		}
	}

	public long FriendId => friendId;

	public long RoomId => roomId;

	public int Model => model;

	public CopyData CopyData => copyData;

	public SimpleCommand CancelCmd => _cancelCmd;

	public SimpleCommand ConfirmCmd => _confirmCmd;

	public TeamInviteViewModel(OptionBase parent, MultiFightInviteFriendNotify message, CopyData copyData)
	{
		base.parent = parent;
		friendId = message.FriendId;
		roomId = message.RoomId;
		this.copyData = copyData;
		model = Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().GetModel(message.CopyId);
		_friendName = message.UserName;
		_copyName = copyData.Name ?? "";
		_cancelCmd = new SimpleCommand(CancelOnclick);
		_confirmCmd = new SimpleCommand(ConfirmOnclick);
		NeedSendCancel = true;
		_waitTime = 15;
		countdownTimer = Timer.Register(1f, CountDown, null, isLooped: true, useRealTime: true);
	}

	private void CountDown()
	{
		WaitTime--;
		if (WaitTime <= 0)
		{
			WaitTime = 0;
			UniTask.Delay(500);
			CancelOnclick();
		}
	}

	private void CancelOnclick()
	{
		if (NeedSendCancel)
		{
			NeedSendCancel = false;
			parent?.ItemOnClick(new OptionArg(this, "Cancel"));
		}
	}

	private void ConfirmOnclick()
	{
		if (NeedSendCancel)
		{
			NeedSendCancel = false;
			parent?.ItemOnClick(new OptionArg(this, "Confirm"));
		}
	}

	public void CloseWaitTime()
	{
		if (countdownTimer != null)
		{
			countdownTimer.Cancel();
			countdownTimer = null;
		}
	}
}
