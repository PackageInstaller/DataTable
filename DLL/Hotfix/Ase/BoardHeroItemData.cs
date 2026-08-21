namespace Ase;

public class BoardHeroItemData : ItemOptionBase
{
	private int heroId;

	private string headIcon = "";

	private bool isSelected;

	private bool showCustomTag;

	public int HeroId
	{
		get
		{
			return heroId;
		}
		private set
		{
			Set(ref heroId, value, "HeroId");
		}
	}

	public string HeadIcon
	{
		get
		{
			return headIcon;
		}
		private set
		{
			Set(ref headIcon, value, "HeadIcon");
		}
	}

	public bool IsSelected
	{
		get
		{
			return isSelected;
		}
		private set
		{
			Set(ref isSelected, value, "IsSelected");
		}
	}

	public bool ShowCustomTag
	{
		get
		{
			return showCustomTag;
		}
		private set
		{
			Set(ref showCustomTag, value, "ShowCustomTag");
		}
	}

	public BoardHeroItemData()
	{
	}

	public BoardHeroItemData(OptionBase parent, int heroId)
	{
		base.parent = parent;
		HeroId = heroId;
		HeadIcon = $"{heroId}_BoardIcon";
	}

	public void SetSelected(bool value)
	{
		IsSelected = value;
	}

	public void SetShowCustomTag(bool value)
	{
		ShowCustomTag = value;
	}

	public void OnClick()
	{
		parent?.ItemOnClick(this);
	}
}
