using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroPropertyView : HeroCultivateView
{
	[SerializeField]
	private Image colorBg;

	[SerializeField]
	private Image weapon;

	[SerializeField]
	private TextMeshProUGUI weaponName;

	[SerializeField]
	private TextMeshProUGUI heroName;

	[SerializeField]
	private Image attrIcon;

	[SerializeField]
	private Image sectIcon;

	[SerializeField]
	private Button btnHeroGift;

	[SerializeField]
	private Button btnHeroFile;

	[SerializeField]
	private Button btnHeroBook;

	[SerializeField]
	private Image seatIcon;

	[SerializeField]
	private TextMeshProUGUI heroLev;

	[SerializeField]
	private TextMeshProUGUI heroExperience;

	[SerializeField]
	private Image progress;

	[SerializeField]
	private UIStarGroup stars;

	private List<PropertyItem> _propItemList;

	[SerializeField]
	private Transform propertyTrans;

	[SerializeField]
	private Button detailPropertyBtn;

	[SerializeField]
	private Button likabilityBtn;

	[SerializeField]
	private TextMeshProUGUI feelingProgressText;

	[SerializeField]
	private Image feelingProgress;

	[SerializeField]
	private Image feelingIconProgress;

	[SerializeField]
	private GameObject maxFeelingIcon;

	[SerializeField]
	private TextMeshProUGUI feelingLevelText;

	[SerializeField]
	private TextMeshProUGUI feelingLevelDesc;

	[SerializeField]
	private Button skinBtn;

	[SerializeField]
	private Button cultivateBtn;

	[SerializeField]
	private GameObject cultivateObj;

	[SerializeField]
	private TextMeshProUGUI btnText;

	[SerializeField]
	private GameObject cultivateBtnMask;

	[SerializeField]
	private Button skillSkinBtn;

	[SerializeField]
	private Button openWeaponDesc;

	[SerializeField]
	private Button btnShowProperty;

	[SerializeField]
	private Button btnShowSkill;

	[SerializeField]
	private GameObject skillSelGo;

	[SerializeField]
	private GameObject propertySelGo;

	[SerializeField]
	private GameObject skillGo;

	[SerializeField]
	private List<HCTSkillItemView> skillItems;

	[SerializeField]
	private Button btnCloseDesc;

	[SerializeField]
	private HCSkillDescAutoFitView skillAutoFit;

	[SerializeField]
	private RectTransform skillAutoFitRT;

	[SerializeField]
	private Button btnOpenGuideURL;

	private Animator viewAnimator;

	public GameObject previewConfig;

	private HeroCultivateViewModel _viewModel;

	private bool isInitSkill;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewAnimator = GetComponent<Animator>();
		_viewModel = GetUserData<HeroCultivateViewModel>(userData);
		InitPropItems();
		BindingSet<HeroPropertyView, HeroCultivateViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((HeroPropertyView v) => v.RefreshAll).To((HeroCultivateViewModel vm) => vm.OnRefreshRequest);
		bindingSet.Bind<TextMeshProUGUI>(heroName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HeroCultivateViewModel vm) => vm.HeroModel.Name);
		bindingSet.Bind<TextMeshProUGUI>(weaponName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HeroCultivateViewModel vm) => vm.HeroModel.WeaponName);
		bindingSet.Bind(weapon).For((Image v) => v.sprite).ToExpression((HeroCultivateViewModel vm) => $"Icon_{vm.HeroModel.Weapon.ToString()}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(attrIcon).For((Image v) => v.sprite).ToExpression((HeroCultivateViewModel vm) => $"hero_attr_{(int)vm.HeroModel.Attribute}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(sectIcon).For((Image v) => v.sprite).ToExpression((HeroCultivateViewModel vm) => $"Icon_{vm.HeroModel.FactionIcon}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(stars).For((UIStarGroup v) => v.CurCount).ToExpression((HeroCultivateViewModel vm) => vm.HeroModel.StarLevel);
		bindingSet.Bind(seatIcon).For((Image v) => v.sprite).ToExpression((HeroCultivateViewModel vm) => $"Hero_Seat_{vm.HeroModel.DestinyLevel}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(likabilityBtn).For((Button v) => v.onClick).To((HeroCultivateViewModel vm) => vm.OnLikabilityBtnClickCmd);
		bindingSet.Bind(skinBtn).For((Button v) => v.onClick).To((HeroCultivateViewModel vm) => vm.OnSkinBtnClickCmd);
		bindingSet.Bind(cultivateBtn).For((Button v) => v.onClick).To((HeroCultivateViewModel vm) => vm.OnCultivateBtnClickCmd);
		bindingSet.Bind(btnHeroGift).For((Button v) => v.onClick).To((HeroCultivateViewModel vm) => vm.OnHeroGiftBtnClickCmd);
		bindingSet.Bind(btnHeroFile).For((Button v) => v.onClick).To((HeroCultivateViewModel vm) => vm.OnHeroFileBtnClickCmd);
		bindingSet.Bind(btnHeroBook).For((Button v) => v.onClick).To((HeroCultivateViewModel vm) => vm.OnHeroBookBtnClickCmd);
		bindingSet.Bind(skillSkinBtn).For((Button v) => v.onClick).To((HeroCultivateViewModel vm) => vm.OnSkillSkinBtnClickCmd);
		bindingSet.Bind(openWeaponDesc).For((Button v) => v.onClick).To((HeroCultivateViewModel vm) => vm.OptCmd)
			.CommandParameter("OpenWeaponDesc");
		bindingSet.Bind().For((HeroPropertyView v) => v.OnOpt).To((HeroCultivateViewModel vm) => vm.OptRequest);
		bindingSet.Bind(btnShowProperty).For((Button v) => v.onClick).To((HeroCultivateViewModel vm) => vm.OptCmd)
			.CommandParameter("ShowProperty");
		bindingSet.Bind(btnShowSkill).For((Button v) => v.onClick).To((HeroCultivateViewModel vm) => vm.OptCmd)
			.CommandParameter("ShowSkill");
		bindingSet.Bind(btnOpenGuideURL).For((Button v) => v.onClick).To((HeroCultivateViewModel vm) => vm.OpenHeroGuideURL);
		bindingSet.Bind(skillSkinBtn.gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroCultivateViewModel vm) => vm.IsShowSkillSkinBtn);
		if (!_viewModel.IsSelf)
		{
			bindingSet.Bind(cultivateObj).For((GameObject v) => v.activeSelf).ToExpression((HeroCultivateViewModel vm) => vm.IsSelf);
			bindingSet.Bind(skinBtn.gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroCultivateViewModel vm) => vm.IsSelf);
			bindingSet.Bind(btnHeroBook.gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroCultivateViewModel vm) => vm.IsSelf);
			bindingSet.Bind(btnHeroFile.gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroCultivateViewModel vm) => vm.IsSelf);
			bindingSet.Bind(btnHeroGift.gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroCultivateViewModel vm) => vm.IsSelf);
			bindingSet.Bind(btnOpenGuideURL.gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroCultivateViewModel vm) => vm.IsSelf);
			bindingSet.Bind(likabilityBtn.gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroCultivateViewModel vm) => vm.IsSelf);
			bindingSet.Bind(skillSkinBtn.gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroCultivateViewModel vm) => vm.IsSelf);
		}
		bindingSet.Build();
		detailPropertyBtn.onClick.AddListener(ShowHeroDetailPropView);
		btnCloseDesc.onClick.AddListener(delegate
		{
			SettleOpt("HideDesc");
		});
		SettleOpt("ShowProperty");
		InitRedPoint();
		RefreshAll();
		skinBtn.gameObject.SetActive(!GameEntry.BuiltinData.OpenTestFlight);
		if (!_viewModel.IsSelf)
		{
			skinBtn.gameObject.SetActive(value: false);
		}
	}

	private void InitPropItems()
	{
		_propItemList = new List<PropertyItem>();
		for (int i = 0; i < propertyTrans.childCount; i++)
		{
			PropertyItem component = propertyTrans.GetChild(i).GetComponent<PropertyItem>();
			component.Init(new PropertyData());
			_propItemList.Add(component);
		}
	}

	private void InitRedPoint()
	{
		if (!_viewModel.IsSelf)
		{
			return;
		}
		cultivateBtn.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.HaveHeroUpgradeProp).AddEnum(RedPointMessageEnum.HeroIdsCanBreak)
			.SetFuncOnMessage(delegate
			{
				RedPointService redPointService = (RedPointService)Singleton<ServiceSystem>.Instance.GetService<IRedPointService>();
				HeroModel heroModel = _viewModel.HeroModel;
				if (heroModel.Level < heroModel.CurMaxLevel)
				{
					return redPointService.HaveHeroUpgradeProp;
				}
				if (heroModel.Level >= heroModel.CurMaxLevel && heroModel.StarLevel < _viewModel.MaxStarLevel)
				{
					RoleViewModel roleData = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData();
					int accountLv = heroModel.DrHeroStars[heroModel.StarLevel + 1].AccountLv;
					if (roleData.PlayerInfo.Level < accountLv)
					{
						return false;
					}
					return redPointService.HeroIdCanBreak.Contains(heroModel.Id);
				}
				return false;
			})
			.Invoke();
	}

	private void RefreshAll(object sender = null, InteractionEventArgs e = null)
	{
		cultivateBtn.GetComponent<UIRedPoint>()?.Invoke();
		RefreshBg();
		UpdateExp();
		UpdateFeeling();
		UpdatePropertys();
		UpdateBtn();
	}

	private void RefreshBg()
	{
		ColorUtility.TryParseHtmlString(UiConvert.Hero.Attribute2Color[_viewModel.HeroModel.Attribute], out var color);
		colorBg.color = color;
	}

	private void UpdateExp()
	{
		HeroModel heroModel = _viewModel.HeroModel;
		((TMP_Text)heroLev).text = $"{heroModel.Level}<size=32><color=#7F766E>/{heroModel.CurMaxLevel}</color></size>";
		DRHeroGrade dataRow = GameEntry.DataTable.GetDataRow<DRHeroGrade>(heroModel.Level + 1);
		if (heroModel.Level >= heroModel.CurMaxLevel || dataRow == null)
		{
			((TMP_Text)heroExperience).text = string.Empty;
			progress.fillAmount = 1f;
		}
		else
		{
			((TMP_Text)heroExperience).text = $"{heroModel.Exp}/{dataRow.NeedExp}";
			progress.fillAmount = (float)heroModel.Exp / (float)dataRow.NeedExp;
		}
	}

	private void UpdateFeeling()
	{
		int maxFeelingLevel = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetMaxFeelingLevel();
		HeroModel heroModel = _viewModel.HeroModel;
		bool flag = heroModel.FeelingLevel >= maxFeelingLevel;
		float num = (flag ? 1f : ((float)heroModel.FeelingExp / (float)heroModel.FeelingExpToNextLevel));
		((TMP_Text)feelingProgressText).text = $"{Math.Round(num * 100f)}%";
		feelingProgress.fillAmount = num;
		feelingIconProgress.fillAmount = num;
		((TMP_Text)feelingLevelText).text = heroModel.FeelingLevel.ToString();
		((TMP_Text)feelingLevelDesc).text = heroModel.FeelingDesc;
		maxFeelingIcon.SetActive(flag);
	}

	private void UpdatePropertys()
	{
		NumericalProperty totalProperty = _viewModel.HeroModel.TotalProperty;
		double value = totalProperty.GetTotalProperty("Attack");
		double value2 = totalProperty.GetTotalProperty("Hp");
		double value3 = totalProperty.GetTotalProperty("Defence");
		double value4 = totalProperty.GetTotalProperty("Crit");
		double value5 = totalProperty.GetTotalProperty("CritRadio") + 1f;
		double value6 = totalProperty.GetTotalProperty("Energy");
		_propItemList[0].RefreshData(new PropertyData("Hp", "体力", value2));
		_propItemList[1].RefreshData(new PropertyData("Defence", "防御", value3));
		_propItemList[2].RefreshData(new PropertyData("Attack", "攻击", value));
		_propItemList[3].RefreshData(new PropertyData("Crit", "暴击", value4));
		_propItemList[4].RefreshData(new PropertyData("CritRadio", "暴击伤害", value5));
		_propItemList[5].RefreshData(new PropertyData("Energy", "耐力上限", value6));
	}

	private void UpdateBtn()
	{
		HeroModel heroModel = _viewModel.HeroModel;
		if (heroModel.Level < heroModel.CurMaxLevel)
		{
			((Graphic)(object)btnText).color = Color.white;
			((TMP_Text)btnText).text = "升级";
			cultivateBtn.gameObject.SetActive(value: true);
			cultivateBtnMask.SetActive(value: false);
		}
		else if (heroModel.Level >= heroModel.CurMaxLevel && heroModel.StarLevel < _viewModel.MaxStarLevel)
		{
			RoleViewModel roleData = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData();
			int accountLv = heroModel.DrHeroStars[heroModel.StarLevel + 1].AccountLv;
			if (roleData.PlayerInfo.Level < accountLv)
			{
				((Graphic)(object)btnText).color = Color.gray;
				((TMP_Text)btnText).text = $"需要传火等级{accountLv}";
				cultivateBtn.gameObject.SetActive(value: false);
				cultivateBtnMask.SetActive(value: true);
			}
			else
			{
				((Graphic)(object)btnText).color = Color.white;
				((TMP_Text)btnText).text = "突破";
				cultivateBtn.gameObject.SetActive(value: true);
				cultivateBtnMask.SetActive(value: false);
			}
		}
		else
		{
			((Graphic)(object)btnText).color = Color.gray;
			((TMP_Text)btnText).text = "已达到最大等级";
			cultivateBtn.gameObject.SetActive(value: false);
			cultivateBtnMask.SetActive(value: true);
		}
	}

	public override void Show()
	{
		UpdatePropertys();
		base.Show();
	}

	public void PlayVisibleAnimation(bool visible)
	{
		if (visible)
		{
			Animator obj = viewAnimator;
			if (obj != null)
			{
				obj.SetTrigger("showUI");
			}
		}
		else
		{
			Animator obj2 = viewAnimator;
			if (obj2 != null)
			{
				obj2.SetTrigger("hideUI");
			}
		}
	}

	private void ShowHeroDetailPropView()
	{
		HeroModel heroModel = _viewModel.HeroModel;
		NumericalProperty totalProperty = heroModel.TotalProperty;
		double rawValue = totalProperty.GetProperty("Hp") + totalProperty.GetFixProperty("Hp");
		double num = totalProperty.GetPropertyByRadio("Hp");
		double rawValue2 = totalProperty.GetProperty("Defence") + totalProperty.GetFixProperty("Defence");
		double num2 = totalProperty.GetPropertyByRadio("Defence");
		double rawValue3 = totalProperty.GetProperty("Attack") + totalProperty.GetFixProperty("Attack");
		double num3 = totalProperty.GetPropertyByRadio("Attack");
		List<PropertyData> primeProps = new List<PropertyData>
		{
			new PropertyData("Hp", NumericalExtension.GetOuterDisplayValue(rawValue), (num > 0.0) ? ("    +" + NumericalExtension.GetOuterDisplayValue(num)) : ""),
			new PropertyData("Defence", NumericalExtension.GetOuterDisplayValue(rawValue2), (num2 > 0.0) ? ("    +" + NumericalExtension.GetOuterDisplayValue(num2)) : ""),
			new PropertyData("Attack", NumericalExtension.GetOuterDisplayValue(rawValue3), (num3 > 0.0) ? ("    +" + NumericalExtension.GetOuterDisplayValue(num3)) : "")
		};
		string outerDisplayPercentValue = NumericalExtension.GetOuterDisplayPercentValue(totalProperty.GetProperty("Crit"));
		string outerDisplayPercentValue2 = NumericalExtension.GetOuterDisplayPercentValue(totalProperty.GetProperty("CritRadio") + 1f);
		string outerDisplayValue = NumericalExtension.GetOuterDisplayValue(totalProperty.GetProperty("Energy"));
		string outerDisplayPercentValue3 = NumericalExtension.GetOuterDisplayPercentValue(totalProperty.GetProperty("LightDamageRadio"));
		string outerDisplayPercentValue4 = NumericalExtension.GetOuterDisplayPercentValue(totalProperty.GetProperty("DarkDamageRadio"));
		string outerDisplayPercentValue5 = NumericalExtension.GetOuterDisplayPercentValue(totalProperty.GetProperty("WaterDamageRadio"));
		string outerDisplayPercentValue6 = NumericalExtension.GetOuterDisplayPercentValue(totalProperty.GetProperty("FireDamageRadio"));
		string outerDisplayPercentValue7 = NumericalExtension.GetOuterDisplayPercentValue(totalProperty.GetProperty("WindDamageRadio"));
		string outerDisplayPercentValue8 = NumericalExtension.GetOuterDisplayPercentValue(totalProperty.GetProperty("IceDamageRadio"));
		string outerDisplayPercentValue9 = NumericalExtension.GetOuterDisplayPercentValue(totalProperty.GetProperty("ThunderDamageRadio"));
		List<PropertyData> advanceProps = new List<PropertyData>
		{
			new PropertyData("Crit", outerDisplayPercentValue, ""),
			new PropertyData("CritRadio", outerDisplayPercentValue2, ""),
			new PropertyData("Energy", outerDisplayValue, ""),
			new PropertyData("LightDamageRadio", outerDisplayPercentValue3, ""),
			new PropertyData("DarkDamageRadio", outerDisplayPercentValue4, ""),
			new PropertyData("WaterDamageRadio", outerDisplayPercentValue5, ""),
			new PropertyData("FireDamageRadio", outerDisplayPercentValue6, ""),
			new PropertyData("WindDamageRadio", outerDisplayPercentValue7, ""),
			new PropertyData("IceDamageRadio", outerDisplayPercentValue8, ""),
			new PropertyData("ThunderDamageRadio", outerDisplayPercentValue9, "")
		};
		_viewModel.ShowDetailPropView(new PropertyDetailViewModel(_viewModel, OuterPropertyType.Hero, primeProps, advanceProps, null, GetEntryList(heroModel)));
	}

	private List<EntryLevelItemData> GetEntryList(HeroModel heroModel)
	{
		List<EntryLevelItemData> list = new List<EntryLevelItemData>();
		heroModel.Armours.TryGetValue(5, out var value);
		int num = value?.EntryDataList[0].DrEntry.EntryId ?? 0;
		List<EntryData> allEntry = heroModel.GetAllEntry();
		if (num != 0)
		{
			EntryLevelItemData item = new EntryLevelItemData(null, value.EntryDataList[0], value.EntryDataList[0].CurLevel, showLevel: false);
			list.Add(item);
		}
		foreach (EntryData item3 in allEntry)
		{
			if (item3.DrEntry.EntryId != num)
			{
				EntryLevelItemData item2 = new EntryLevelItemData(null, item3, item3.CurLevel);
				list.Add(item2);
			}
		}
		list.Sort(delegate(EntryLevelItemData x, EntryLevelItemData y)
		{
			if (x.ShowLevel.CompareTo(y.ShowLevel) != 0)
			{
				return x.ShowLevel.CompareTo(y.ShowLevel);
			}
			if (x.EntryData.IsSpecial.CompareTo(y.EntryData.IsSpecial) != 0)
			{
				return y.EntryData.IsSpecial.CompareTo(x.EntryData.IsSpecial);
			}
			return (x.IsMax.CompareTo(y.IsMax) != 0) ? y.IsMax.CompareTo(x.IsMax) : y.CurLevel.CompareTo(x.CurLevel);
		});
		return list;
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	private void SettleOpt(string optName)
	{
		bool flag = true;
		if ("ShowProperty".Equals(optName))
		{
			flag = true;
			skillAutoFitRT.gameObject.SetActive(value: false);
			btnCloseDesc.gameObject.SetActive(value: false);
		}
		else
		{
			if (!"ShowSkill".Equals(optName))
			{
				if ("ShowSkillDesc".Equals(optName))
				{
					skillAutoFitRT.gameObject.SetActive(value: true);
					btnCloseDesc.gameObject.SetActive(value: true);
					if (_viewModel.CurSkillItem.Data.SkillTypeEnum == HeroSkillTypeEnum.Interaction1 || _viewModel.CurSkillItem.Data.SkillTypeEnum == HeroSkillTypeEnum.Interaction2)
					{
						skillAutoFit.InitPureDesc(_viewModel.CurSkillItem.Desc, _viewModel.CurSkillItem.Data.SkillType, _viewModel.CurSkillItem.Data.Name);
					}
					else
					{
						skillAutoFit.Init(_viewModel.CurSkillItem, _viewModel.HeroTalentViewModel.GetSmallDesc(_viewModel.CurSkillItem), max: false);
					}
				}
				else if ("HideDesc".Equals(optName))
				{
					skillAutoFitRT.gameObject.SetActive(value: false);
					btnCloseDesc.gameObject.SetActive(value: false);
					_viewModel.ShowSkillItem(null);
				}
				return;
			}
			InitSkill();
			flag = false;
		}
		skillSelGo.SetActive(!flag);
		propertySelGo.SetActive(flag);
		detailPropertyBtn.gameObject.SetActive(flag);
		propertyTrans.gameObject.SetActive(flag);
		skillGo.gameObject.SetActive(!flag);
	}

	private void InitSkill()
	{
		if (!isInitSkill)
		{
			for (int i = 0; i < skillItems.Count; i++)
			{
				if (_viewModel.SkillList.ContainsKey(skillItems[i].skillTypeEnum))
				{
					skillItems[i].Init(_viewModel.SkillList[skillItems[i].skillTypeEnum]);
				}
			}
		}
		isInitSkill = true;
	}

	public override void Hide()
	{
		SettleOpt("HideDesc");
		_viewModel.ShowSkillItem(null);
		base.Hide();
	}

	public void RefreshAllSkillData()
	{
		_viewModel.RefreshAllSkillData();
		UpdateExp();
	}
}
