using GameFramework.Runtime;

namespace Ase;

public class CopyEntryData : ViewModelBase
{
	private int entryType;

	private bool red;

	public int EntryType
	{
		get
		{
			return entryType;
		}
		private set
		{
			Set(ref entryType, value, "EntryType");
		}
	}

	public bool Red
	{
		get
		{
			return red;
		}
		private set
		{
			Set(ref red, value, "Red");
		}
	}

	public CopyEntryData(int entryType, bool red)
	{
		this.entryType = entryType;
		this.red = red;
	}

	public void SetRed(bool red)
	{
		Red = red;
	}
}
