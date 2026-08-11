#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class HeroCultivateViewModel : OptionBase
{
	private int heroIndex;

	private HeroModel leftHero;

	private HeroModel rightHero;

	protected int curTabType = 1;

	protected HeroModel _heroModel;

	private List<HeroItemViewModel> _showHeroModels;

	private Dictionary<HeroSkillTypeEnum, HCTSkillItemViewModel> skillList;

	private HeroWeaponDescViewModel _heroWeaponDescViewModel;

	protected WeaponDetailViewModel _weaponDetailViewModel;

	protected HeroInfoViewModel _heroInfoViewModel;

	protected HCTalentViewModel _heroTalentViewModel;

	private WeaponChangeViewModel weaponChangeViewModel;

	private WeaponCultureViewModel weaponCultureViewModel;

	private ArmourRecommendViewModel armourRecommendViewModel;

	protected HeroGrowRarityViewModel _growRarityViewModel;

	protected HeroGrowRarityInfoViewModel _growRarityInfoViewModel;

	private InteractionRequest<bool> setGrowRarityInfoViewVisible = new InteractionRequest<bool>();

	private InteractionRequest<bool> playUIVisibleAnimation = new InteractionRequest<bool>();

	private InteractionRequest<int> playVoiceRst = new InteractionRequest<int>();

	protected int maxStarLevel;

	private List<AttributeItemData> armourAttributeItemDataList;

	private List<EntryLevelItemData> armourEntryDataList;

	private bool changeHeroEnable;

	private bool armourRedPoint;

	private VoiceGroup voiceGroup;

	private TabItemNormalData armourAttributeBtn;

	private TabItemNormalData armourEntryBtn;

	private ISubscription<UserInfoMessage> subscription_UserInfo;

	private bool isSelf;

	private bool isShowSkillSkinBtn;

	private InteractionRequest<EntryLevelItem> openHeroEquipViewEntryPanelRequest = new InteractionRequest<EntryLevelItem>();

	protected InteractionRequest<string> optRequest = new InteractionRequest<string>();

	protected InteractionRequest _onRefreshRequest = new InteractionRequest();

	private InteractionRequest _onRefreshEquipRequest = new InteractionRequest();

	protected InteractionRequest<PropertyDetailViewModel> _onShowDetailPropViewRequest = new InteractionRequest<PropertyDetailViewModel>();

	private InteractionRequest<EntryItem> _showEntryDetailRequest = new InteractionRequest<EntryItem>();

	private SimpleCommand onLikabilityBtnClickCmd;

	private SimpleCommand onSkinBtnClickCmd;

	private SimpleCommand onCultivateBtnClickCmd;

	private SimpleCommand onHeroGiftBtnClickCmd;

	private SimpleCommand onHeroFileBtnClickCmd;

	private SimpleCommand<int> openEquipWarehouseCmd;

	private SimpleCommand openArmourEntryDetailCmd;

	private SimpleCommand onHeroBookBtnClickCmd;

	protected SimpleCommand<string> optCmd;

	private SimpleCommand onSkillSkinBtnClickCmd;

	private bool multiEnter;

	private HCTSkillItemViewModel curSkillItem;

	private bool openArmourChange;

	private bool openArmourPreset;

	private int voiceId;

	private bool gameNoneReq;

	private float windowMaskLeftTime;

	public bool MultiEnter => multiEnter;

	public VoiceGroup VoiceGroup => voiceGroup;

	public HeroModel HeroModel
	{
		get
		{
			return _heroModel;
		}
		set
		{
			Set(ref _heroModel, value, "HeroModel");
			RefreshData();
		}
	}

	public bool ChangeHeroEnable
	{
		get
		{
			return changeHeroEnable;
		}
		set
		{
			Set(ref changeHeroEnable, value, "ChangeHeroEnable");
		}
	}

	public virtual int CurTabType
	{
		get
		{
			return curTabType;
		}
		set
		{
			if (curTabType != value)
			{
				voiceGroup?.Stop();
			}
			curTabType = value;
		}
	}

	public int HeroIndex
	{
		get
		{
			return heroIndex;
		}
		set
		{
			if (heroIndex != value)
			{
				voiceGroup?.Stop();
			}
			Set(ref heroIndex, value, "HeroIndex");
			LeftHero = ((value > 0) ? ShowHeroModels[value - 1].HeroModel : ShowHeroModels[ShowHeroModels.Count - 1].HeroModel);
			RightHero = ((value < ShowHeroModels.Count - 1) ? ShowHeroModels[value + 1].HeroModel : ShowHeroModels[0].HeroModel);
		}
	}

	public HeroModel LeftHero
	{
		get
		{
			return leftHero;
		}
		set
		{
			Set(ref leftHero, value, "LeftHero");
		}
	}

	public HeroModel RightHero
	{
		get
		{
			return rightHero;
		}
		set
		{
			Set(ref rightHero, value, "RightHero");
		}
	}

	public float WindowMaskLeftTime
	{
		get
		{
			return windowMaskLeftTime;
		}
		set
		{
			Set(ref windowMaskLeftTime, value, "WindowMaskLeftTime");
		}
	}

	public List<AttributeItemData> ArmourAttributeItemDataList
	{
		get
		{
			return armourAttributeItemDataList;
		}
		set
		{
			Set(ref armourAttributeItemDataList, value, "ArmourAttributeItemDataList");
		}
	}

	public List<EntryLevelItemData> ArmourEntryDataList
	{
		get
		{
			return armourEntryDataList;
		}
		set
		{
			Set(ref armourEntryDataList, value, "ArmourEntryDataList");
		}
	}

	public bool ArmourRedPoint
	{
		get
		{
			return armourRedPoint;
		}
		set
		{
			Set(ref armourRedPoint, value, "ArmourRedPoint");
		}
	}

	public bool IsSelf
	{
		get
		{
			return isSelf;
		}
		set
		{
			Set(ref isSelf, value, "IsSelf");
		}
	}

	public bool IsShowSkillSkinBtn
	{
		get
		{
			return isShowSkillSkinBtn;
		}
		set
		{
			Set(ref isShowSkillSkinBtn, value, "IsShowSkillSkinBtn");
		}
	}

	public int MaxStarLevel => maxStarLevel;

	public HeroWeaponDescViewModel HeroWeaponDescViewModel => _heroWeaponDescViewModel;

	public HeroInfoViewModel HeroInfoViewModel => _heroInfoViewModel;

	public WeaponDetailViewModel WeaponDetailViewModel => _weaponDetailViewModel;

	public HCTalentViewModel HeroTalentViewModel => _heroTalentViewModel;

	public InteractionRequest<bool> SetGrowRarityInfoViewVisible => setGrowRarityInfoViewVisible;

	public HeroGrowRarityViewModel GrowRarityViewModel => _growRarityViewModel;

	public HeroGrowRarityInfoViewModel GrowRarityInfoViewModel => _growRarityInfoViewModel;

	public List<HeroItemViewModel> ShowHeroModels => _showHeroModels;

	public Dictionary<HeroSkillTypeEnum, HCTSkillItemViewModel> SkillList => skillList;

	public HCTSkillItemViewModel CurSkillItem => curSkillItem;

	public SimpleCommand OnSkinBtnClickCmd => onSkinBtnClickCmd;

	public SimpleCommand OnLikabilityBtnClickCmd => onLikabilityBtnClickCmd;

	public SimpleCommand OnCultivateBtnClickCmd => onCultivateBtnClickCmd;

	public SimpleCommand OnHeroGiftBtnClickCmd => onHeroGiftBtnClickCmd;

	public SimpleCommand OnHeroFileBtnClickCmd => onHeroFileBtnClickCmd;

	public SimpleCommand<int> OpenEquipWarehouseCmd => openEquipWarehouseCmd;

	public SimpleCommand OpenArmourEntryDetailCmd => openArmourEntryDetailCmd;

	public SimpleCommand OnHeroBookBtnClickCmd => onHeroBookBtnClickCmd;

	public SimpleCommand OnSkillSkinBtnClickCmd => onSkillSkinBtnClickCmd;

	public InteractionRequest OnRefreshRequest => _onRefreshRequest;

	public InteractionRequest OnRefreshEquipRequest => _onRefreshEquipRequest;

	public InteractionRequest<PropertyDetailViewModel> OnShowDetailPropViewRequest => _onShowDetailPropViewRequest;

	public InteractionRequest<EntryItem> ShowEntryDetailRequest => _showEntryDetailRequest;

	public TabItemNormalData ArmourAttributeBtn => armourAttributeBtn;

	public TabItemNormalData ArmourEntryBtn => armourEntryBtn;

	public InteractionRequest<EntryLevelItem> OpenHeroEquipViewEntryPanelRequest => openHeroEquipViewEntryPanelRequest;

	public InteractionRequest<bool> PlayUiVisibleAnimation => playUIVisibleAnimation;

	public InteractionRequest<int> PlayVoiceRst => playVoiceRst;

	public ICommand OptCmd => optCmd;

	public IInteractionRequest OptRequest => optRequest;

	public override async void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is ArmourChangeViewModel)
		{
			SetArmourProperty();
			_onRefreshEquipRequest.Raise();
			_onRefreshRequest.Raise();
		}
		else if (obj is ArmourPresetWindowViewModel)
		{
			SetArmourProperty();
			_onRefreshEquipRequest.Raise();
			_onRefreshRequest.Raise();
		}
		else if (obj is WeaponChangeViewModel)
		{
			weaponChangeViewModel = null;
			_weaponDetailViewModel.RefreshData(HeroModel.HeldWeapon);
			_onRefreshRequest.Raise();
		}
		else if (obj is string text)
		{
			if (text.Equals("Hide_GrowRarityInfoView"))
			{
				ChangeGrowRarityInfoVisible(visible: false);
			}
			else if (text.Equals("HideUI"))
			{
				playUIVisibleAnimation.Raise(context: false);
			}
			else if (text.Equals("ShowUI"))
			{
				playUIVisibleAnimation.Raise(context: true);
			}
			else if (text.Equals("SyncWithServerData"))
			{
				SyncWithServerData();
			}
			else if (text.Equals("RefetchHeroData"))
			{
				RefetchHeroData();
			}
		}
		else if (obj is HeroUpgradeViewModel)
		{
			_onRefreshRequest.Raise();
		}
		else if (obj is WeaponDetailViewModel weaponDetailViewModel)
		{
			if (weaponDetailViewModel.ActionName.Equals("ChangeWeapon"))
			{
				OpenWeaponChangeWindow();
			}
			else if (weaponDetailViewModel.ActionName.Equals("OpenCulture"))
			{
				OpenWeaponCulture();
			}
		}
		else if (obj is WeaponCultureViewModel)
		{
			weaponCultureViewModel = null;
			WeaponData weaponById = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetWeaponById(HeroModel.HeldWeapon.Uid);
			_weaponDetailViewModel.RefreshData(weaponById);
			_onRefreshRequest.Raise();
		}
		else if (obj is HeroGrowRarityViewModel heroGrowRarityViewModel)
		{
			if (heroGrowRarityViewModel.CurSeatConfig != null)
			{
				_growRarityInfoViewModel.Refresh(heroGrowRarityViewModel.CurSeatConfig, heroGrowRarityViewModel.CurItemState, heroGrowRarityViewModel.CurOptType, heroGrowRarityViewModel.CurSeatPoint);
				ChangeGrowRarityInfoVisible(visible: true, heroGrowRarityViewModel.CurSeatPoint);
			}
		}
		else if (obj is KnapsackItemViewModel knapsackItemViewModel)
		{
			OpenViewArg openViewArg = knapsackItemViewModel.OpenPopupWindow(this, null, showOutsideMask: true, showOwnCount: true, !multiEnter);
			if (openViewArg != null)
			{
				openWindowRequest.Raise(openViewArg);
			}
		}
		else if (obj is HCTSkillItemViewModel skillItem)
		{
			ShowSkillItem(skillItem);
		}
		else if (obj is OptionArg optionArg)
		{
			if ("QuickFilterRecommend".Equals(optionArg.OptionName) && optionArg.Obj is ArmourRecommendViewModel armourRecommendViewModel)
			{
				OpenArmourChangeWindow(ArmourEnum.Box, armourRecommendViewModel);
				showViewRequest.Raise(new ShowViewArg(armourRecommendViewModel, isShow: false));
			}
			else if ("QuickFilterRecommendWithoutOtherEntry".Equals(optionArg.OptionName) && optionArg.Obj is ArmourRecommendViewModel armourRecommendViewModel2)
			{
				OpenArmourChangeWindow(ArmourEnum.Box, armourRecommendViewModel2, includeOtherEntry: false);
				showViewRequest.Raise(new ShowViewArg(armourRecommendViewModel2, isShow: false));
			}
			else if ("CloseRecommend".Equals(optionArg.OptionName))
			{
				showViewRequest.Raise(new ShowViewArg(optionArg.Obj, isShow: false));
			}
			else if (optionArg.OptionName.Equals("UpdateWindowMaskTime") && optionArg.Obj is float newLeftTime)
			{
				UpdateWindowMaskLeftTime(newLeftTime);
			}
			else if (optionArg.OptionName.Equals("ChangeHero") && optionArg.Obj is int index)
			{
				ChangeHeroModel(index);
			}
			else if (optionArg.OptionName.Equals("OnShowEntryPanel"))
			{
				ShowEntryDetail((EntryItem)optionArg.Obj);
			}
			else if (optionArg.OptionName.Equals("Option_HeroUpgradeSuccess") && optionArg.Obj is int heroId)
			{
				HeroModel heroById = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(heroId);
				DRVoice heroSkinVoiceConfig = HeroDefinition.GetHeroSkinVoiceConfig(heroId, heroById.SkinConfigId, 3);
				if (heroSkinVoiceConfig != null)
				{
					playVoiceRst.Raise(heroSkinVoiceConfig.VoiceId);
				}
				_onRefreshRequest.Raise();
			}
			else if (optionArg.OptionName.Equals("Option_HeroBreakoutSuccess") && optionArg.Obj is int heroId2)
			{
				HeroModel heroById2 = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(heroId2);
				DRVoice heroSkinVoiceConfig2 = HeroDefinition.GetHeroSkinVoiceConfig(heroId2, heroById2.SkinConfigId, 4);
				if (heroSkinVoiceConfig2 != null)
				{
					playVoiceRst.Raise(heroSkinVoiceConfig2.VoiceId);
				}
				_onRefreshRequest.Raise();
			}
			if ("OnMulti".Equals(optionArg.OptionName))
			{
				parent.ItemOnClick(optionArg);
				return;
			}
			if (optionArg.OptionName.Equals("OpenEntryPanelLevel"))
			{
				ShowEntryDetail((EntryLevelItem)optionArg.Obj);
				return;
			}
			if (optionArg.Obj is HeroGrowRarityInfoViewModel heroGrowRarityInfoViewModel)
			{
				if (optionArg.OptionName == "Hide")
				{
					ChangeGrowRarityInfoVisible(visible: false);
				}
				else if (optionArg.OptionName == "Light")
				{
					LightUpHeroDestiny(heroGrowRarityInfoViewModel.HeroId, heroGrowRarityInfoViewModel.OptType, heroGrowRarityInfoViewModel.Point);
				}
				return;
			}
			object obj2 = optionArg.Obj;
			if (obj2 is HeroGiftViewModel heroGiftViewModel && optionArg.OptionName.Equals("SendGift"))
			{
				Loading loading = await Loading.Show();
				int oldFeelingLevel = heroGiftViewModel.HeroModel.FeelingLevel;
				bool flag = await Singleton<ServiceSystem>.Instance.GetService<IHeroService>().SendHeroGiftRequest(heroGiftViewModel.HeroModel.Id, heroGiftViewModel.CurGiftItemData.PropData.Id, heroGiftViewModel.CurGiftItemData.UseCount);
				loading.Dispose();
				heroGiftViewModel.OnSendGiftFinished(flag, heroGiftViewModel.CurGiftItemData.PropData.Id, oldFeelingLevel);
				if (flag)
				{
					_onRefreshRequest.Raise();
				}
			}
		}
		else if (obj is TabItemNormalData tabItemNormalData)
		{
			SwitchTab(tabItemNormalData);
		}
	}

	public override void RefreshWhenBack(ViewBackArg arg)
	{
		GetVmByTabIndex(CurTabType)?.RefreshWhenBack(arg);
	}

	private async Task RefetchHeroData()
	{
		Loading loading = await Loading.Show();
		try
		{
			await ServiceHelper.RequestDataInPropTable();
			if (!(await Singleton<ServiceSystem>.Instance.GetService<IHeroService>().RequestServiceData()))
			{
				await UIHelper.AccountDisconnect();
				return;
			}
			SyncWithServerData();
			RefreshData();
		}
		catch (Exception ex)
		{
			Log.Error(ex.Message + " / " + ex.StackTrace);
			await UIHelper.AccountDisconnect();
		}
		finally
		{
			loading.Dispose();
		}
	}

	public OptionBase GetVmByTabIndex(int tabIndex)
	{
		return tabIndex switch
		{
			4 => _heroTalentViewModel, 
			5 => _growRarityViewModel, 
			2 => weaponCultureViewModel, 
			_ => null, 
		};
	}

	public HeroCultivateViewModel()
	{
	}

	public HeroCultivateViewModel(OptionBase parentVm, HeroModel heroModel, int enterType = 1, bool changeHeroEnable = true, List<HeroItemViewModel> heroItemList = null, bool isSelf = true)
	{
		parent = parentVm;
		subscription_UserInfo = Context.GetApplicationContext().GetService<IMessenger>().Subscribe<UserInfoMessage>(OnUserInfoNotify);
		ChangeHeroEnable = changeHeroEnable;
		maxStarLevel = Singleton<OuterSystem>.Instance.GetConstantConfigInt(Constant.ConstantConfig.MaxStarHero, 5);
		voiceGroup = Singleton<AudioSystem>.Instance.RegisterGroup(VoiceGroupEnum.Cultivate);
		if (heroItemList == null)
		{
			_showHeroModels = new List<HeroItemViewModel>();
			foreach (HeroModel item in Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetAllHeroData().Values.ToList())
			{
				_showHeroModels.Add(new HeroItemViewModel(this, item));
			}
			_showHeroModels.Sort(new HeroSortByLevel());
		}
		else
		{
			_showHeroModels = heroItemList;
		}
		_heroInfoViewModel = new HeroInfoViewModel(this);
		_heroTalentViewModel = new HCTalentViewModel(this, isSelf);
		_growRarityViewModel = new HeroGrowRarityViewModel(this, heroModel, isSelf);
		_growRarityInfoViewModel = new HeroGrowRarityInfoViewModel(this, isSelf);
		IsSelf = isSelf;
		IsShowSkillSkinBtn = GameEntry.DataTable.GetDataRow((DRSkillSkinList p) => p.HeroId == heroModel.Id) != null;
		optCmd = new SimpleCommand<string>(OnOpt);
		openEquipWarehouseCmd = new SimpleCommand<int>(OpenEquipWarehouse);
		onSkinBtnClickCmd = new SimpleCommand(OnSkinBtnClick);
		onLikabilityBtnClickCmd = new SimpleCommand(OnLikabilityBtnClick);
		onCultivateBtnClickCmd = new SimpleCommand(OnCultivateBtnClick);
		onHeroGiftBtnClickCmd = new SimpleCommand(OnHeroGiftBtnClick);
		onHeroFileBtnClickCmd = new SimpleCommand(OnHeroFileBtnClick);
		openArmourEntryDetailCmd = new SimpleCommand(OnArmourEntryDetailBtnClick);
		onHeroBookBtnClickCmd = new SimpleCommand(OnHeroBookBtnClick);
		onSkillSkinBtnClickCmd = new SimpleCommand(OnSkillSkinBtnClick);
		_weaponDetailViewModel = new WeaponDetailViewModel(this, heroModel.HeldWeapon);
		_weaponDetailViewModel.LeftBtnText = "替换";
		_weaponDetailViewModel.RightBtnText = "培养";
		_weaponDetailViewModel.IsSelf = isSelf;
		armourAttributeItemDataList = new List<AttributeItemData>();
		armourEntryDataList = new List<EntryLevelItemData>();
		_onRefreshRequest = new InteractionRequest();
		_onRefreshEquipRequest = new InteractionRequest();
		_onShowDetailPropViewRequest = new InteractionRequest<PropertyDetailViewModel>();
		_showEntryDetailRequest = new InteractionRequest<EntryItem>();
		CurTabType = enterType;
		HeroModel = heroModel;
		SetHeroIndex(heroModel);
		SetArmourProperty();
		armourAttributeBtn = new TabItemNormalData(this, string.Empty, 1, isSelected: true);
		armourEntryBtn = new TabItemNormalData(this, string.Empty, 2);
	}

	public void SetMultiEnter(bool isMultiEnter)
	{
		multiEnter = isMultiEnter;
	}

	private void OnUserInfoNotify(UserInfoMessage msg)
	{
		if (msg != null && msg.MessageType == UserInfoMessage.MsgTypeEnum.AccountDataRefreshByReLogin)
		{
			SyncWithServerData();
		}
	}

	private void SyncWithServerData()
	{
		IHeroService service = Singleton<ServiceSystem>.Instance.GetService<IHeroService>();
		if (_showHeroModels != null && service != null)
		{
			for (int i = 0; i < _showHeroModels.Count; i++)
			{
				int id = _showHeroModels[i].HeroModel.Id;
				_showHeroModels[i] = new HeroItemViewModel(this, service.GetHeroById(id));
			}
			if (!HeroModel.IsNullOrEmpty())
			{
				HeroModel = service.GetHeroById(HeroModel.Id);
			}
		}
	}

	protected virtual void OnOpt(string optName)
	{
		optCmd.Enabled = false;
		if (optName.Equals("ShowProperty"))
		{
			ShowSkillItem(null);
			optRequest.Raise("ShowProperty");
		}
		else if (optName.Equals("ShowSkill"))
		{
			UpdateHeroSkill(forceFresh: false);
			optRequest.Raise("ShowSkill");
		}
		else if (optName.Equals("ShowSkillDesc"))
		{
			optRequest.Raise("ShowSkillDesc");
		}
		else if (optName.Equals("HideSkillDesc"))
		{
			optRequest.Raise("HideSkillDesc");
		}
		else if (optName.Equals("OpenWeaponDesc"))
		{
			if (_heroWeaponDescViewModel == null)
			{
				_heroWeaponDescViewModel = new HeroWeaponDescViewModel(this, _heroModel.Weapon);
			}
			optRequest.Raise("OpenWeaponDesc");
		}
		optCmd.Enabled = true;
	}

	protected void UpdateHeroSkill(bool forceFresh)
	{
		if (!((skillList == null) | forceFresh))
		{
			return;
		}
		if (skillList == null)
		{
			skillList = new Dictionary<HeroSkillTypeEnum, HCTSkillItemViewModel>();
			skillList.Add(HeroSkillTypeEnum.Interaction1, new HCTSkillItemViewModel(this));
			skillList.Add(HeroSkillTypeEnum.Interaction2, new HCTSkillItemViewModel(this));
		}
		foreach (HCTSkillData value in _heroModel.HCTSkillDatas.Values)
		{
			if (HeroSkillTypeEnum.Roll != value.SkillTypeEnum && value.IsOriginSkill)
			{
				HCTSkillData data = CreatePropertySkillData(value);
				if (skillList.ContainsKey(value.SkillTypeEnum))
				{
					skillList[value.SkillTypeEnum].RefreshData(data);
				}
				else
				{
					skillList.Add(value.SkillTypeEnum, new HCTSkillItemViewModel(this, data));
				}
			}
		}
		DRHeroPassive dataRow = GameEntry.DataTable.GetDataRow<DRHeroPassive>(_heroModel.Id);
		if (dataRow == null)
		{
			skillList[HeroSkillTypeEnum.Interaction1].RefreshData(HeroSkillTypeEnum.Interaction1, "", "", "");
			skillList[HeroSkillTypeEnum.Interaction2].RefreshData(HeroSkillTypeEnum.Interaction2, "", "", "");
		}
		else
		{
			skillList[HeroSkillTypeEnum.Interaction1].RefreshData(HeroSkillTypeEnum.Interaction1, dataRow.SkillPassiveName, dataRow.SkillPassiveName, dataRow.SkillPassive);
			skillList[HeroSkillTypeEnum.Interaction2].RefreshData(HeroSkillTypeEnum.Interaction2, dataRow.TeamPassiveName, dataRow.TeamPassiveName, dataRow.TeamPassive);
		}
		skillList[HeroSkillTypeEnum.Interaction1].RefreshIconSkin(_heroModel.SkinConfigId, _heroModel.SkinSuffix, _heroModel.Id);
		skillList[HeroSkillTypeEnum.Interaction2].RefreshIconSkin(_heroModel.SkinConfigId, _heroModel.SkinSuffix, _heroModel.Id);
	}

	private HCTSkillData CreatePropertySkillData(HCTSkillData talentSkillData)
	{
		DRHeroSKillInfo dataRow = GameEntry.DataTable.GetDataRow((DRHeroSKillInfo p) => p.HeroId == _heroModel.Id && p.HeroSkillTypeEnum == talentSkillData.SkillTypeEnum);
		if (dataRow == null || dataRow.SkillId == talentSkillData.SkillId)
		{
			return talentSkillData;
		}
		DRHeroSKillConfig dataRow2 = GameEntry.DataTable.GetDataRow<DRHeroSKillConfig>(dataRow.SkillId);
		if (dataRow2 == null)
		{
			Log.Error($"HeroSKillInfo 表默认绑定技能Id【{dataRow.SkillId}】找不到对应的 HeroSKillConfig，英雄【{_heroModel.Id}】");
			return talentSkillData;
		}
		DRHeroTalentBig dataRow3 = GameEntry.DataTable.GetDataRow((DRHeroTalentBig p) => p.SkillId == talentSkillData.SkillId && p.Level == talentSkillData.Level);
		if (dataRow3 == null)
		{
			Log.Error($"英雄【{_heroModel.Id}】燃点表找不到 SkillId【{talentSkillData.SkillId}】Level【{talentSkillData.Level}】的数据");
			return talentSkillData;
		}
		HCTSkillData hCTSkillData = HCTSkillData.CreateOrigin(dataRow2, dataRow3, null);
		hCTSkillData.RefreshIconSkin(_heroModel.SkinConfigId, _heroModel.SkinSuffix);
		hCTSkillData.SetDeriveSkill(talentSkillData.DeriveSkills);
		hCTSkillData.HideDeriveSkillId(talentSkillData.HideDeriveSkillDesc);
		return hCTSkillData;
	}

	public void ShowSkillItem(HCTSkillItemViewModel skillItem)
	{
		if (skillItem == null)
		{
			if (curSkillItem != null)
			{
				curSkillItem.SetSelect(isSelect: false);
			}
			curSkillItem = null;
			return;
		}
		if (curSkillItem == null)
		{
			curSkillItem = skillItem;
		}
		else if (curSkillItem != skillItem)
		{
			curSkillItem.SetSelect(isSelect: false);
		}
		curSkillItem = skillItem;
		curSkillItem.SetSelect(isSelect: true);
		optRequest.Raise("ShowSkillDesc");
	}

	private void SwitchTab(TabItemNormalData tabItemNormalData)
	{
		if (!tabItemNormalData.IsSelected)
		{
			armourAttributeBtn.IsSelected = tabItemNormalData.ID == armourAttributeBtn.ID;
			armourEntryBtn.IsSelected = tabItemNormalData.ID == armourEntryBtn.ID;
		}
	}

	private void ShowEntryDetail(EntryItem entryItem)
	{
		entryItem.ViewModel.SetSelect(isSelect: true);
		EntryItem entryItemByHero = GetEntryItemByHero(entryItem);
		_showEntryDetailRequest.Raise(entryItemByHero);
	}

	private void ShowEntryDetail(EntryLevelItem entryLevelItem)
	{
		openHeroEquipViewEntryPanelRequest.Raise(entryLevelItem);
	}

	private EntryItem GetEntryItemByHero(EntryItem entryItem)
	{
		List<EntryData> allEntry = _heroModel.GetAllEntry();
		for (int i = 0; i < allEntry.Count; i++)
		{
			if (allEntry[i].DrEntry.EntryId == entryItem.ViewModel.EntryData.DrEntry.EntryId)
			{
				entryItem.ViewModel.SetLevel(allEntry[i].DrEntry.Level);
			}
		}
		return entryItem;
	}

	protected virtual void RefreshData()
	{
		_heroInfoViewModel.SetData(HeroModel);
		_weaponDetailViewModel.RefreshData(HeroModel.HeldWeapon);
		_growRarityViewModel.RefreshData(HeroModel);
		_heroTalentViewModel.RefreshData(HeroModel);
		UpdateHeroSkill(forceFresh: true);
		SetArmourProperty();
		_heroWeaponDescViewModel?.SetWeaponEnum(_heroModel.Weapon);
		armourRecommendViewModel?.RefreshHero(HeroModel);
		_onRefreshRequest.Raise();
	}

	protected virtual void SetArmourProperty()
	{
		RefreshArmourAttribute();
		RefreshArmourEntry();
		CheckArmourRedPoint();
	}

	private void RefreshArmourAttribute()
	{
		ArmourAttributeItemDataList.Clear();
		ArmourAttributeItemDataList.AddRange(ArmourOverviewDisplayUtil.BuildAttributeItems(_heroModel.Armours));
	}

	private void RefreshArmourEntry()
	{
		ArmourEntryDataList.Clear();
		ArmourEntryDataList.AddRange(ArmourOverviewDisplayUtil.BuildEntryItems(this, _heroModel.Armours));
	}

	private void CheckArmourRedPoint()
	{
		ArmourRedPoint = false;
		for (int i = 0; i < 5; i++)
		{
			List<ArmourData> armourListByType = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetArmourListByType((ArmourEnum)i);
			bool flag = false;
			foreach (ArmourData item in armourListByType)
			{
				if (item.GetOwnerId() == 0)
				{
					flag = true;
					break;
				}
			}
			if (flag && (!_heroModel.Armours.ContainsKey(i) || _heroModel.Armours[i] == null))
			{
				ArmourRedPoint = true;
				break;
			}
		}
	}

	public async void ChangeLock()
	{
		Loading loading = await Loading.Show();
		await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().ChangeLock(5, _heroModel.HeldWeapon.Uid);
		loading.Dispose();
	}

	private async void LightUpHeroDestiny(int heroId, int optType, int point = 0)
	{
		Loading loading = await Loading.Show();
		RequestResult requestResult = await Singleton<ServiceSystem>.Instance.GetService<IHeroService>().LightUpHeroDestiny(heroId, optType, point);
		if (requestResult.success)
		{
			_growRarityViewModel?.OnLightSuccess(heroId, optType, point);
		}
		else if (requestResult.obj != null && requestResult.obj is string text && text.Equals("SyncWithServerData"))
		{
			SyncWithServerData();
		}
		_growRarityInfoViewModel?.OnLightFinish(requestResult.success);
		loading.Dispose();
	}

	private void ChangeGrowRarityInfoVisible(bool visible, int pointIndex = 0)
	{
		setGrowRarityInfoViewVisible.Raise(visible);
		_growRarityViewModel?.OnInfoViewVisibleChanged(visible, pointIndex);
	}

	private void SetHeroIndex(HeroModel heroModel)
	{
		for (int i = 0; i < ShowHeroModels.Count; i++)
		{
			if (ShowHeroModels[i].HeroModel == heroModel)
			{
				HeroIndex = i;
			}
		}
	}

	public void ShowDetailPropView(PropertyDetailViewModel vm)
	{
		_onShowDetailPropViewRequest.Raise(vm);
	}

	public void OpenHeroGuideURL()
	{
		try
		{
			if (HeroModel.IsNullOrEmpty())
			{
				return;
			}
			DRHeroGuide dataRow = GameEntry.DataTable.GetDataRow<DRHeroGuide>(HeroModel.Id);
			if (dataRow != null && !string.IsNullOrEmpty(dataRow.Link))
			{
				string text = GameEntry.Web.OpenWebViewWithUid(dataRow.Link, ((Component)(object)GameEntry.UI.Canvas).GetComponent<RectTransform>(), useToolBar: true, null, null);
				if (!string.IsNullOrEmpty(text))
				{
					Toast.ShowInfo(text);
				}
			}
		}
		catch (Exception message)
		{
			Log.Error(message);
			throw;
		}
	}

	public void ChangeHeroModel(int index)
	{
		if (ShowHeroModels.Count <= 1)
		{
			return;
		}
		switch (index)
		{
		case 1:
			HeroIndex++;
			if (HeroIndex >= ShowHeroModels.Count)
			{
				HeroIndex = 0;
			}
			HeroModel = ShowHeroModels[HeroIndex].HeroModel;
			break;
		case -1:
			HeroIndex--;
			if (HeroIndex < 0)
			{
				HeroIndex = ShowHeroModels.Count - 1;
			}
			HeroModel = ShowHeroModels[HeroIndex].HeroModel;
			break;
		}
	}

	public void OpenArmourChangeWindow(ArmourEnum armourEnum)
	{
		OpenArmourChangeWindow(armourEnum, null);
	}

	private void OpenArmourChangeWindow(ArmourEnum armourEnum, ArmourRecommendViewModel recommendViewModel, bool includeOtherEntry = true)
	{
		if (!openArmourChange)
		{
			openArmourChange = true;
			ArmourChangeViewModel armourChangeViewModel = new ArmourChangeViewModel(this, _heroModel, armourEnum);
			if (recommendViewModel != null)
			{
				armourChangeViewModel.ApplyRecommendFilterOnOpen(recommendViewModel, includeOtherEntry);
			}
			openWindowRequest.Raise(new OpenViewArg(typeof(ArmourChangeWindow), armourChangeViewModel), delegate
			{
				openArmourChange = false;
			});
		}
	}

	public void OpenArmourPresetWindow()
	{
		if (IsSelf && !openArmourPreset)
		{
			openArmourPreset = true;
			ArmourPresetWindowViewModel userData = new ArmourPresetWindowViewModel(this, _heroModel);
			openWindowRequest.Raise(new OpenViewArg(typeof(ArmourPresetWindow), userData), delegate
			{
				openArmourPreset = false;
			});
		}
	}

	public void OpenArmourRecommendWindow()
	{
		if (IsSelf)
		{
			if (armourRecommendViewModel == null)
			{
				armourRecommendViewModel = new ArmourRecommendViewModel(this, _heroModel);
			}
			else
			{
				armourRecommendViewModel.RefreshHero(_heroModel);
			}
			openWindowRequest.Raise(new OpenViewArg(typeof(ArmourRecommendView), armourRecommendViewModel, "HeroCultivate", isOpenWindow: false));
		}
	}

	private void TryPlayVoiceGroup(int id)
	{
		voiceId = id;
	}

	public override void Close()
	{
		weaponChangeViewModel?.Close();
		weaponCultureViewModel?.Close();
		parent?.ItemOnClick(this);
		SetArmourProperty();
		Singleton<ServiceSystem>.Instance.GetService<IRedPointService>().RemoveTalentTree();
		base.Close();
	}

	public override void Dispose()
	{
		Singleton<AudioSystem>.Instance.UnRegisterGroup(VoiceGroupEnum.Cultivate, stopVoice: true);
		voiceGroup = null;
		base.Dispose();
	}

	private async void OpenEquipWarehouse(int enterType)
	{
		openEquipWarehouseCmd.Enabled = false;
		if (enterType < 1)
		{
			WeaponChangeViewModel userData = new WeaponChangeViewModel(this, HeroModel);
			openWindowRequest.Raise(new OpenViewArg(typeof(WeaponChangeWindow), userData), delegate
			{
				openEquipWarehouseCmd.Enabled = true;
			});
		}
		else
		{
			ArmourChangeViewModel userData2 = new ArmourChangeViewModel(this, HeroModel, (ArmourEnum)enterType);
			openWindowRequest.Raise(new OpenViewArg(typeof(ArmourChangeWindow), userData2), delegate
			{
				openEquipWarehouseCmd.Enabled = true;
			});
		}
	}

	private async void OpenWeaponCulture()
	{
		WeaponData weaponById = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetWeaponById(HeroModel.HeldWeapon.Uid);
		weaponCultureViewModel = new WeaponCultureViewModel(this, weaponById);
		await GameEntry.UI.OpenWindow<WeaponCultureWindow>("Equipment/WeaponCultureWindow", weaponCultureViewModel, delegate
		{
			weaponCultureViewModel = null;
		});
		weaponCultureViewModel.OpenCulturePanel();
		_weaponDetailViewModel.ResetRightCmd();
	}

	private void OpenWeaponChangeWindow()
	{
		weaponChangeViewModel = new WeaponChangeViewModel(this, HeroModel);
		openWindowRequest.Raise(new OpenViewArg(typeof(WeaponChangeWindow), weaponChangeViewModel, delegate
		{
			weaponChangeViewModel = null;
		}));
		_weaponDetailViewModel.ResetLeftCmd();
	}

	private void OnSkinBtnClick()
	{
		onSkinBtnClickCmd.Enabled = false;
		int skinConfigId = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(_heroModel.Id).SkinConfigId;
		int beforeSkinId = _heroModel.SkinConfigId;
		HeroSkinPreViewViewModel heroSkinPreViewViewModel = new HeroSkinPreViewViewModel(this, _heroModel.Id, skinConfigId);
		heroSkinPreViewViewModel.SetWindowType(1);
		openWindowRequest.Raise(new OpenViewArg(typeof(HeroSkinPreViewWindow), heroSkinPreViewViewModel), delegate
		{
			int skinConfigId2 = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(_heroModel.Id).SkinConfigId;
			if (skinConfigId2 != beforeSkinId)
			{
				_heroModel.SetSkin(skinConfigId2);
				_heroTalentViewModel?.RefreshBigPointSkillIcons();
			}
			onSkinBtnClickCmd.Enabled = true;
		});
	}

	private void OnLikabilityBtnClick()
	{
	}

	private async void OnCultivateBtnClick()
	{
		onCultivateBtnClickCmd.Enabled = false;
		if (_heroModel.Level >= _heroModel.CurMaxLevel)
		{
			HeroBreakoutViewModel userData = new HeroBreakoutViewModel(this, HeroModel);
			openWindowRequest.Raise(new OpenViewArg(typeof(HeroBreakoutWindow), userData), delegate
			{
				onCultivateBtnClickCmd.Enabled = true;
			});
		}
		else
		{
			HeroUpgradeViewModel userData2 = new HeroUpgradeViewModel(this, HeroModel);
			openWindowRequest.Raise(new OpenViewArg(typeof(HeroUpgradeWindow), userData2), delegate
			{
				onCultivateBtnClickCmd.Enabled = true;
			});
		}
	}

	private void OnHeroGiftBtnClick()
	{
		onHeroGiftBtnClickCmd.Enabled = false;
		HeroGiftViewModel userData = new HeroGiftViewModel(this, HeroModel);
		openWindowRequest.Raise(new OpenViewArg(typeof(HeroGiftWindow), userData), delegate
		{
			onHeroGiftBtnClickCmd.Enabled = true;
		});
	}

	private async void OnHeroFileBtnClick()
	{
		try
		{
			if (!gameNoneReq)
			{
				gameNoneReq = await Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().RequestGameNoteData();
			}
			onHeroFileBtnClickCmd.Enabled = false;
			GameHeroInfoViewModel userData = new GameHeroInfoViewModel(this, HeroModel.Id);
			openWindowRequest.Raise(new OpenViewArg(typeof(GameHeroInfoWindow), userData), delegate
			{
				onHeroFileBtnClickCmd.Enabled = true;
			});
		}
		catch (Exception ex)
		{
			Log.Error("打开图鉴失败，发生异常！" + ex.Message + " / " + ex.StackTrace);
		}
	}

	private async void OnHeroBookBtnClick()
	{
		try
		{
			if (!gameNoneReq)
			{
				gameNoneReq = await Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().RequestGameNoteData();
			}
			onHeroBookBtnClickCmd.Enabled = false;
			GameHeroInfoViewModel userData = new GameHeroInfoViewModel(this, HeroModel.Id, 3);
			openWindowRequest.Raise(new OpenViewArg(typeof(GameHeroInfoWindow), userData), delegate
			{
				onHeroBookBtnClickCmd.Enabled = true;
			});
		}
		catch (Exception ex)
		{
			Log.Error("打开图鉴失败，发生异常！" + ex.Message + " / " + ex.StackTrace);
		}
	}

	private async void OnSkillSkinBtnClick()
	{
		try
		{
			onSkillSkinBtnClickCmd.Enabled = false;
			HeroSkillSkinViewModel userData = new HeroSkillSkinViewModel(this, HeroModel);
			openWindowRequest.Raise(new OpenViewArg(typeof(HeroSkillSkinWindow), userData), delegate
			{
				onSkillSkinBtnClickCmd.Enabled = true;
			});
		}
		catch (Exception ex)
		{
			Log.Error("打开技能皮肤失败，发生异常！" + ex.Message + " / " + ex.StackTrace);
		}
	}

	private async void OnArmourEntryDetailBtnClick()
	{
		openArmourEntryDetailCmd.Enabled = false;
		await Singleton<ServiceSystem>.Instance.GetService<IBFBEService>().GetHeroSkillCamreaSkin();
		ArmourEntryDetailViewModel userData = new ArmourEntryDetailViewModel(this, HeroModel);
		openWindowRequest.Raise(new OpenViewArg(typeof(ArmourEntryDetailWindow), userData), delegate
		{
			openArmourEntryDetailCmd.Enabled = true;
		});
	}

	private void UpdateWindowMaskLeftTime(float newLeftTime)
	{
		if (!(WindowMaskLeftTime >= newLeftTime))
		{
			WindowMaskLeftTime = newLeftTime;
		}
	}

	public void RefreshAllSkillData()
	{
		UpdateHeroSkill(forceFresh: true);
	}
}
