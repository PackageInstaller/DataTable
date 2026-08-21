namespace Ase;

public class ReceiveItemViewModel : KnapsackItemViewModel
{
	private bool isGot;

	private bool isUp;

	private bool isTeam;

	private bool isLock;

	private string countRange = "";

	public string CountRange
	{
		get
		{
			return countRange;
		}
		private set
		{
			Set(ref countRange, value, "CountRange");
		}
	}

	public bool IsGot
	{
		get
		{
			return isGot;
		}
		private set
		{
			Set(ref isGot, value, "IsGot");
		}
	}

	public bool IsUp
	{
		get
		{
			return isUp;
		}
		private set
		{
			Set(ref isUp, value, "IsUp");
		}
	}

	public bool IsTeam
	{
		get
		{
			return isTeam;
		}
		private set
		{
			Set(ref isTeam, value, "IsTeam");
		}
	}

	public bool IsLock
	{
		get
		{
			return isLock;
		}
		private set
		{
			Set(ref isLock, value, "IsLock");
		}
	}

	public ReceiveItemViewModel(PropDataBase data, OptionBase parent)
		: base(parent, data)
	{
		if (data is WeaponData weaponData)
		{
			weaponData.SetWeaponIcon(2);
		}
	}

	public void SetCountRange(string countRange)
	{
		CountRange = countRange;
	}

	public void SetGot(bool isGot)
	{
		IsGot = isGot;
	}

	public void SetLock(bool isLock)
	{
		IsLock = isLock;
	}

	public void SetUp(bool isUp)
	{
		IsUp = isUp;
	}

	public void SetTeam(bool isTeam)
	{
		IsTeam = isTeam;
	}
}
