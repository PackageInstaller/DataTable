namespace Ase;

public class HeroSkinPopupViewModel : OptionBase
{
	private int _configId;

	private string _skinSpinePath;

	private string _skinName;

	private string _heroName;

	private string _qualityIcon = "";

	private string _qualityLargeIcon = "";

	private string _voiceText;

	public int ConfigId
	{
		get
		{
			return _configId;
		}
		protected set
		{
			Set(ref _configId, value, "ConfigId");
		}
	}

	public string SkinSpinePath
	{
		get
		{
			return _skinSpinePath;
		}
		set
		{
			Set(ref _skinSpinePath, value, "SkinSpinePath");
		}
	}

	public string SkinName
	{
		get
		{
			return _skinName;
		}
		protected set
		{
			Set(ref _skinName, value, "SkinName");
		}
	}

	public string HeroName
	{
		get
		{
			return _heroName;
		}
		protected set
		{
			Set(ref _heroName, value, "HeroName");
		}
	}

	public string QualityIcon
	{
		get
		{
			return _qualityIcon;
		}
		protected set
		{
			Set(ref _qualityIcon, value, "QualityIcon");
		}
	}

	public string QualityLargeIcon
	{
		get
		{
			return _qualityLargeIcon;
		}
		protected set
		{
			Set(ref _qualityLargeIcon, value, "QualityLargeIcon");
		}
	}

	public string VoiceText
	{
		get
		{
			return _voiceText;
		}
		set
		{
			Set(ref _voiceText, value, "VoiceText");
		}
	}

	public HeroSkinPopupViewModel()
	{
	}

	public HeroSkinPopupViewModel(OptionBase parent, DRUIHeroSkin drHeroSkin)
	{
		base.parent = parent;
		if (drHeroSkin != null)
		{
			DRHeroInfo dataRow = GameEntry.DataTable.GetDataRow<DRHeroInfo>(drHeroSkin.HeroID);
			DRVoice dataRow2 = GameEntry.DataTable.GetDataRow<DRVoice>(drHeroSkin.GetVoice);
			ConfigId = drHeroSkin.Id;
			SkinSpinePath = HeroDefinition.GetHeroOriginalPath(drHeroSkin.HeroID, drHeroSkin.Suffix, useLanguageSetting: true);
			SkinName = drHeroSkin.SkinName;
			HeroName = dataRow?.Name ?? "";
			QualityIcon = $"Hero_Seat_{drHeroSkin.SkinRarity - 2}";
			QualityLargeIcon = $"Hero/HeroGrowRarity/SeatIcon{drHeroSkin.SkinRarity}_1104";
			VoiceText = dataRow2?.Desc ?? "";
		}
	}

	protected override void Dispose(bool disposing)
	{
		Singleton<AudioSystem>.Instance.UnRegisterGroup(VoiceGroupEnum.HeroSkin);
		base.Dispose(disposing);
	}

	public override void Close()
	{
		parent?.ItemOnClick(new OptionArg(this, ""));
		base.Close();
	}
}
