using GameFramework.Runtime;

namespace Ase;

public class HeroCultivatePreviewViewModel : HeroCultivateViewModel
{
	private SelectItemViewModel oriItem;

	private SelectItemViewModel maxItem;

	private int maxLevel = 1;

	private long maxExp = 1L;

	private bool isOri = true;

	public override int CurTabType
	{
		get
		{
			return curTabType;
		}
		set
		{
			curTabType = value;
		}
	}

	public SelectItemViewModel OriItem => oriItem;

	public SelectItemViewModel MaxItem => maxItem;

	public HeroCultivatePreviewViewModel(OptionBase parent, int heroId, int skinId)
	{
		base.parent = parent;
		WeaponData heldWeapon = WeaponData.CreateWeaponData(GameEntry.DataTable.GetDataRow<DRHeroInfo>(heroId).InitialWeapon);
		HeroModel heroModel = HeroModel.CreatePreview(heroId, heldWeapon, skinId);
		base.ChangeHeroEnable = false;
		maxStarLevel = Singleton<OuterSystem>.Instance.GetConstantConfigInt(Constant.ConstantConfig.MaxStarHero, 5);
		_heroInfoViewModel = new HeroInfoViewModel(this);
		_heroTalentViewModel = new HCTalentPreviewViewModel(this);
		_heroTalentViewModel.preview = true;
		_growRarityViewModel = new HeroGrowRarityViewModel(this, heroModel);
		_growRarityInfoViewModel = new HeroGrowRarityInfoViewModel(this);
		optCmd = new SimpleCommand<string>(OnOpt);
		_weaponDetailViewModel = new WeaponDetailViewModel(this, heroModel.HeldWeapon);
		_weaponDetailViewModel.isPreview = true;
		_onRefreshRequest = new InteractionRequest();
		_onShowDetailPropViewRequest = new InteractionRequest<PropertyDetailViewModel>();
		base.HeroModel = heroModel;
		_heroInfoViewModel.SetData(base.HeroModel);
		oriItem = new SelectItemViewModel(this);
		oriItem.SetSelect(isSelect: true);
		maxItem = new SelectItemViewModel(this);
		DRHeroGrade[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRHeroGrade>();
		if (allDataRow != null && allDataRow.Length != 0)
		{
			maxLevel = allDataRow[allDataRow.Length - 1].Id;
			maxExp = allDataRow[allDataRow.Length - 1].NeedExp;
		}
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj.Equals("ShowPreviewConfig") || obj.Equals("HidePreviewConfig"))
		{
			optRequest.Raise((string)obj);
		}
	}

	protected override void OnOpt(string optName)
	{
		base.OnOpt(optName);
		if (optName.Equals("PreviewOri"))
		{
			isOri = true;
			oriItem.SetSelect(isSelect: true);
			maxItem.SetSelect(isSelect: false);
			_heroModel.SetHeroTalentInit();
			_heroModel.Level = 1;
			_heroModel.StarLevel = 0;
			_heroModel.Exp = 0L;
			_heroTalentViewModel.SetOri(isOri: true);
			RefreshData();
		}
		else if (optName.Equals("PreviewMax"))
		{
			isOri = false;
			oriItem.SetSelect(isSelect: false);
			maxItem.SetSelect(isSelect: true);
			_heroModel.SetHeroTalentMax();
			_heroModel.Level = maxLevel;
			_heroModel.StarLevel = base.MaxStarLevel;
			_heroModel.Exp = maxExp;
			_heroTalentViewModel.SetOri(isOri: false);
			RefreshData();
		}
	}

	protected override void RefreshData()
	{
		_heroTalentViewModel.RefreshData(base.HeroModel);
		UpdateHeroSkill(forceFresh: true);
		ShowSkillItem(base.CurSkillItem);
		_onRefreshRequest.Raise();
	}

	protected override void SetArmourProperty()
	{
	}
}
