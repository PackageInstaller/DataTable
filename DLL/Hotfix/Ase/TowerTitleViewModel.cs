namespace Ase;

public class TowerTitleViewModel : OptionBase
{
	private string titleName;

	private string contentDesc;

	public string TitleName
	{
		get
		{
			return titleName;
		}
		set
		{
			Set(ref titleName, value, "TitleName");
		}
	}

	public string ContentDesc
	{
		get
		{
			return contentDesc;
		}
		set
		{
			Set(ref contentDesc, value, "ContentDesc");
		}
	}

	public TowerTitleViewModel(string titleName, string contentDesc)
	{
		this.titleName = titleName;
		this.contentDesc = contentDesc;
	}
}
