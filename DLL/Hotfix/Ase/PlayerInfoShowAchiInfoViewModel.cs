namespace Ase;

public class PlayerInfoShowAchiInfoViewModel : OptionBase
{
	private string achiIcon;

	private string achiDesc;

	private int achiRarity;

	public string AchiIcon
	{
		get
		{
			return achiIcon;
		}
		set
		{
			Set(ref achiIcon, value, "AchiIcon");
		}
	}

	public string AchiDesc
	{
		get
		{
			return achiDesc;
		}
		set
		{
			Set(ref achiDesc, value, "AchiDesc");
		}
	}

	public int AchiRarity
	{
		get
		{
			return achiRarity;
		}
		set
		{
			Set(ref achiRarity, value, "AchiRarity");
		}
	}

	public void SetCurAchiInfo(AchiItemData achiItemData)
	{
		AchiIcon = achiItemData.AchiIcon;
		AchiDesc = achiItemData.AchiDesc;
		AchiRarity = achiItemData.AchiRarity;
	}
}
