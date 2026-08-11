using System.Collections.Generic;

namespace Ase;

public class AccountLimitationData : OptionBase
{
	private int _copyEnterLimit;

	private int _friendSendEnergyLimit;

	private int _friendReceiveEnergyLimit;

	private int _mfForceCancelTimes;

	private int _diamondBugVitLimit;

	public int CopyEnterLimit
	{
		get
		{
			return _copyEnterLimit;
		}
		private set
		{
			Set(ref _copyEnterLimit, value, "CopyEnterLimit");
		}
	}

	public int FriendSendEnergyLimit
	{
		get
		{
			return _friendSendEnergyLimit;
		}
		private set
		{
			Set(ref _friendSendEnergyLimit, value, "FriendSendEnergyLimit");
		}
	}

	public int FriendReceiveEnergyLimit
	{
		get
		{
			return _friendReceiveEnergyLimit;
		}
		private set
		{
			Set(ref _friendReceiveEnergyLimit, value, "FriendReceiveEnergyLimit");
		}
	}

	public int MfForceCancelTimes
	{
		get
		{
			return _mfForceCancelTimes;
		}
		private set
		{
			Set(ref _mfForceCancelTimes, value, "MfForceCancelTimes");
		}
	}

	public int DiamondBugVitLimit
	{
		get
		{
			return _diamondBugVitLimit;
		}
		private set
		{
			Set(ref _diamondBugVitLimit, value, "DiamondBugVitLimit");
		}
	}

	public AccountLimitationData(OptionBase parent)
	{
		base.parent = parent;
	}

	public void UpdateAccountLimitationData(List<PbTimedRefreshInfo> infos)
	{
		foreach (PbTimedRefreshInfo info in infos)
		{
			SetValue(info.MainType, (int)info.Count);
		}
	}

	private void SetValue(int id, int value)
	{
		switch (id)
		{
		case 1:
			CopyEnterLimit = value;
			break;
		case 2:
			FriendSendEnergyLimit = value;
			break;
		case 3:
			FriendReceiveEnergyLimit = value;
			break;
		case 4:
			MfForceCancelTimes = value;
			break;
		case 5:
			DiamondBugVitLimit = value;
			break;
		}
	}
}
