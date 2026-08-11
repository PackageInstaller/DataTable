using System.Collections.Generic;

namespace Ase;

public class DrawCardSingleViewModel : OptionBase
{
	private HeroModel heroModel;

	private WeaponData weaponData;

	private string weaponEnumName;

	private bool isHero;

	private bool isNew;

	private bool isSSR;

	private bool isShowFinal;

	private List<KnapsackItemViewModel> knapsackItemViewModels;

	private int rarity;

	private bool isClick;

	private string copyWritingText;

	private VoiceGroup voiceGroup;

	public bool IsHero => isHero;

	public HeroModel HeroModel => heroModel;

	public WeaponData WeaponData => weaponData;

	public string WeaponEnumName => weaponEnumName;

	public bool IsNew => isNew;

	public bool IsSsr => isSSR;

	public int Rarity => rarity;

	public bool IsShowFinal => isShowFinal;

	public string CopyWritingText => copyWritingText;

	public List<KnapsackItemViewModel> KnapsackItemViewModels => knapsackItemViewModels;

	public DrawCardSingleViewModel(OptionBase parent, HeroModel heroModel, List<KnapsackPropData> knapsackPropDataList, bool isShowFinal, bool isNew = false)
	{
		voiceGroup = Singleton<AudioSystem>.Instance.RegisterGroup(VoiceGroupEnum.DrawCard);
		base.parent = parent;
		isHero = true;
		this.heroModel = heroModel;
		rarity = heroModel.RawDestinyLevel;
		this.isNew = isNew;
		isSSR = HeroModel.Rarity == 4;
		this.isShowFinal = isShowFinal;
		LoadItemViewModels(knapsackPropDataList);
		DRVoice dataRow = GameEntry.DataTable.GetDataRow((DRVoice p) => p.ObjectId == heroModel.Id && p.Type == 1);
		if (dataRow != null)
		{
			copyWritingText = dataRow.Desc.Replace("\\n", "\n");
		}
		isClick = false;
	}

	public DrawCardSingleViewModel(OptionBase parent, WeaponData weaponData, List<KnapsackPropData> knapsackPropDataList, bool isShowFinal, bool isNew = false)
	{
		voiceGroup = Singleton<AudioSystem>.Instance.RegisterGroup(VoiceGroupEnum.DrawCard);
		base.parent = parent;
		isHero = false;
		this.weaponData = weaponData;
		this.isNew = isNew;
		weaponEnumName = UiConvert.Equip.WeaponEnum2Name[weaponData.WeaponEnum];
		rarity = weaponData.Rarity - 2;
		isSSR = weaponData.Rarity == 4;
		this.isShowFinal = isShowFinal;
		LoadItemViewModels(knapsackPropDataList);
		DRVoice dataRow = GameEntry.DataTable.GetDataRow((DRVoice p) => p.ObjectId == weaponData.Id && p.Type == 0);
		if (dataRow != null)
		{
			copyWritingText = dataRow.Desc.Replace("\\n", "\n");
		}
		isClick = false;
	}

	private void LoadItemViewModels(List<KnapsackPropData> knapsackPropDataList)
	{
		knapsackItemViewModels = new List<KnapsackItemViewModel>();
		foreach (KnapsackPropData knapsackPropData in knapsackPropDataList)
		{
			knapsackItemViewModels.Add(new KnapsackItemViewModel(this, knapsackPropData));
		}
	}

	public void OpenFinal()
	{
		if (!isClick)
		{
			isClick = true;
			parent?.ItemOnClick(new OptionArg(this, "SingleShowSkip"));
			Close();
		}
	}

	public void Next()
	{
		if (!isClick)
		{
			isClick = true;
			parent?.ItemOnClick(new OptionArg(this, "Next"));
		}
	}

	public void PlayAudio()
	{
		if (IsHero)
		{
			DRVoice heroSkinVoiceConfig = HeroDefinition.GetHeroSkinVoiceConfig(HeroModel.Id, HeroModel.SkinConfigId, 1);
			if (heroSkinVoiceConfig != null)
			{
				voiceGroup.Stop();
				voiceGroup.Play(heroSkinVoiceConfig.VoiceId);
			}
		}
	}

	public override void Close()
	{
		voiceGroup?.Stop();
		base.Close();
	}
}
