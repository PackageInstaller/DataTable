using GameFramework.Runtime;

namespace Ase;

public class HeroSkinGetViewModel : OptionBase
{
	private VoiceGroup _voiceGroup;

	private int _configId;

	private string _skinSpinePath;

	private string _skinTagIcon = "";

	private string _skinName;

	private string _heroName;

	private string _qualityIcon = "";

	private string _qualityLargeIcon = "";

	private string _voiceText;

	private int _voiceId;

	private bool _skinApplied;

	private SimpleCommand _applySkinCmd;

	public SimpleCommand ApplySkinCmd => _applySkinCmd;

	public bool SkinApplied
	{
		get
		{
			return _skinApplied;
		}
		private set
		{
			Set(ref _skinApplied, value, "SkinApplied");
		}
	}

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

	public string SkinTagIcon
	{
		get
		{
			return _skinTagIcon;
		}
		set
		{
			Set(ref _skinTagIcon, value, "SkinTagIcon");
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

	public HeroSkinGetViewModel()
	{
	}

	public HeroSkinGetViewModel(OptionBase parent, DRUIHeroSkin drHeroSkin)
	{
		base.parent = parent;
		_voiceGroup = Singleton<AudioSystem>.Instance.RegisterGroup(VoiceGroupEnum.HeroSkin);
		_applySkinCmd = new SimpleCommand(ApplySkin);
		if (drHeroSkin != null)
		{
			DRHeroInfo dataRow = GameEntry.DataTable.GetDataRow<DRHeroInfo>(drHeroSkin.HeroID);
			DRVoice dataRow2 = GameEntry.DataTable.GetDataRow<DRVoice>(drHeroSkin.GetVoice);
			ConfigId = drHeroSkin.Id;
			SkinSpinePath = HeroDefinition.GetHeroOriginalPath(drHeroSkin.HeroID, drHeroSkin.Suffix, useLanguageSetting: true);
			SkinTagIcon = drHeroSkin.TagShow;
			SkinName = drHeroSkin.SkinName;
			HeroName = dataRow?.Name ?? "";
			QualityIcon = $"Hero_Seat_{drHeroSkin.SkinRarity - 2}";
			QualityLargeIcon = $"Hero/HeroGrowRarity/SeatIcon{drHeroSkin.SkinRarity}_1104";
			VoiceText = dataRow2?.Desc ?? "";
			_voiceId = dataRow2?.VoiceId ?? 0;
		}
	}

	public void PlayGetVoice()
	{
		_voiceGroup.Play(_voiceId);
	}

	public void StopVoice()
	{
		_voiceGroup.Stop();
	}

	private async void ApplySkin()
	{
		if (_configId <= 0)
		{
			Toast.ShowInfo("配置异常，无法投影");
			return;
		}
		_applySkinCmd.Enabled = false;
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IHeroService>().SetHeroSkinChangeRequest(_configId);
		loading?.Dispose();
		if (num)
		{
			SkinApplied = true;
		}
		_applySkinCmd.Enabled = true;
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
