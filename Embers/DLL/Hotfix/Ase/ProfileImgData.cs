using GameFramework.Runtime;

namespace Ase;

public class ProfileImgData : ViewModelBase
{
	private string profileImg;

	private string profileBoder;

	private bool isOwned;

	private bool isSelected;

	private string itemName;

	private string itemDesc;

	public bool IsSelected
	{
		get
		{
			return isSelected;
		}
		set
		{
			Set(ref isSelected, value, "IsSelected");
		}
	}

	public string ProfileImg
	{
		get
		{
			return profileImg;
		}
		set
		{
			Set(ref profileImg, value, "ProfileImg");
		}
	}

	public string ProfileBoder
	{
		get
		{
			return profileBoder;
		}
		set
		{
			Set(ref profileBoder, value, "ProfileBoder");
		}
	}

	public bool IsOwned
	{
		get
		{
			return !isOwned;
		}
		set
		{
			Set(ref isOwned, value, "IsOwned");
		}
	}

	public string ItemName
	{
		get
		{
			return itemName;
		}
		set
		{
			Set(ref itemName, value, "ItemName");
		}
	}

	public string ItemDesc
	{
		get
		{
			return itemDesc;
		}
		set
		{
			Set(ref itemDesc, value, "ItemDesc");
		}
	}

	public ProfileImgData(string profileImg, string profileBoder, bool isOwned, string itemName, string itemDesc, bool isSelected = false)
	{
		this.profileImg = profileImg;
		this.profileBoder = profileBoder;
		this.isOwned = isOwned;
		this.isSelected = isSelected;
		this.itemName = itemName;
		this.itemDesc = itemDesc;
	}
}
