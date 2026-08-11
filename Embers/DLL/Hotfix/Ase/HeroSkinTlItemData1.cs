namespace Ase;

public class HeroSkinTlItemData1 : OptionBase
{
	private string _skinIcon = "";

	private string _favorability;

	private string _skinName;

	private string _skinDesc;

	private bool _saved;

	private bool _selected;

	private DRSkinMessage _drSkinMessage;

	private DRUIHeroSkin _druiHeroSkin;

	public string SkinIcon
	{
		get
		{
			return _skinIcon;
		}
		set
		{
			Set(ref _skinIcon, value, "SkinIcon");
		}
	}

	public string Favorability
	{
		get
		{
			return _favorability;
		}
		set
		{
			Set(ref _favorability, value, "Favorability");
		}
	}

	public string SkinName
	{
		get
		{
			return _skinName;
		}
		set
		{
			Set(ref _skinName, value, "SkinName");
		}
	}

	public string SkinDesc
	{
		get
		{
			return _skinDesc;
		}
		set
		{
			Set(ref _skinDesc, value, "SkinDesc");
		}
	}

	public bool Saved
	{
		get
		{
			return _saved;
		}
		set
		{
			Set(ref _saved, value, "Saved");
		}
	}

	public bool Selected
	{
		get
		{
			return _selected;
		}
		set
		{
			Set(ref _selected, value, "Selected");
		}
	}

	public DRSkinMessage DrSkinMessage => _drSkinMessage;

	public DRUIHeroSkin DruiHeroSkin => _druiHeroSkin;

	public HeroSkinTlItemData1()
	{
	}

	public HeroSkinTlItemData1(OptionBase parent, DRSkinMessage drSkinMessage, DRUIHeroSkin druiHeroSkin)
	{
		base.parent = parent;
		if (drSkinMessage != null)
		{
			_drSkinMessage = drSkinMessage;
			SkinDesc = drSkinMessage.Message;
			SkinName = drSkinMessage.Name;
			if (druiHeroSkin != null)
			{
				_druiHeroSkin = druiHeroSkin;
				int heroID = druiHeroSkin.HeroID;
				Favorability = $"{Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(heroID)?.FeelingLevel ?? 0}";
				SkinIcon = GameEntry.DataTable.GetDataRow<DRHeadAvatar>(druiHeroSkin.SkinHead)?.Icon ?? "";
			}
		}
	}

	public void RefreshSaved(bool saved)
	{
		Saved = saved;
	}

	public void OnItemClick()
	{
		if (_drSkinMessage != null)
		{
			parent?.ItemOnClick(this);
		}
	}

	public void Save()
	{
		if (_drSkinMessage != null)
		{
			parent?.ItemOnClick(_drSkinMessage.Id);
		}
	}
}
