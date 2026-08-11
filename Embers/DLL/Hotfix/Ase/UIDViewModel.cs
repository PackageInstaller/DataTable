namespace Ase;

public class UIDViewModel : OptionBase
{
	private long uid;

	public long UID
	{
		get
		{
			return uid;
		}
		set
		{
			if (value != 0L)
			{
				Set(ref uid, value, "UID");
			}
		}
	}

	public UIDViewModel()
	{
	}

	public UIDViewModel(long uid)
	{
		this.uid = uid;
	}
}
