using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroItem : UGuiView
{
	[SerializeField]
	private HeroIconTypeEnum iconType = HeroIconTypeEnum.Card;

	[SerializeField]
	private Image headIcon;

	[SerializeField]
	private TextMeshProUGUI level;

	[SerializeField]
	private GameObject levelFix;

	[SerializeField]
	private Image rarityTag;

	[SerializeField]
	private Image rarityTagIcon;

	[SerializeField]
	private Image destinyIcon;

	[SerializeField]
	private Image attrIcon;

	[SerializeField]
	private GameObject noEmpty;

	[SerializeField]
	private GameObject empty;

	[SerializeField]
	private GameObject select;

	[SerializeField]
	private GameObject checkRoot;

	[SerializeField]
	private TextMeshProUGUI seatText;

	[SerializeField]
	private Button itemBtn;

	[SerializeField]
	private GameObject customTag;

	[SerializeField]
	private GameObject selectHeroObj;

	[SerializeField]
	private TextMeshProUGUI selectHeroIndex;

	protected HeroItemViewModel _viewModel;

	public HeroItemViewModel ViewModel => _viewModel;

	public void Init(HeroItemViewModel viewModel)
	{
		_viewModel = viewModel;
		BindingSet<HeroItem, HeroItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		if (headIcon != null)
		{
			bindingSet.Bind(headIcon).For((Image v) => v.sprite).ToExpression((HeroItemViewModel vm) => StreamerMode.GetHeroItemIcon(vm.HeroModel, iconType))
				.WithConversion("ItemIcon");
			bindingSet.Bind(headIcon.gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroItemViewModel vm) => !vm.HeroModel.Empty);
		}
		if (attrIcon != null)
		{
			bindingSet.Bind(attrIcon).For((Image v) => v.sprite).ToExpression((HeroItemViewModel vm) => $"hero_attr_{(int)vm.HeroModel.Attribute}")
				.WithConversion("ItemIcon");
		}
		if (destinyIcon != null)
		{
			bindingSet.Bind(destinyIcon).For((Image v) => v.sprite).ToExpression((HeroItemViewModel vm) => $"Hero_Seat_{vm.HeroModel.DestinyLevel}")
				.WithConversion("ItemIcon");
		}
		if (rarityTag != null)
		{
			bindingSet.Bind(rarityTag).For((Image v) => v.color).To((HeroItemViewModel vm) => vm.RarityColor);
		}
		if (rarityTagIcon != null)
		{
			bindingSet.Bind(rarityTagIcon).For((Image v) => v.sprite).ToExpression((HeroItemViewModel vm) => $"hero_rarity_tag_{vm.HeroModel.Rarity}")
				.WithConversion("ItemIcon");
		}
		if (itemBtn != null)
		{
			bindingSet.Bind(itemBtn).For((Button v) => v.onClick).To((HeroItemViewModel vm) => vm.OnClick);
		}
		if (select != null)
		{
			bindingSet.Bind(select.gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroItemViewModel vm) => vm.IsSelected);
		}
		if (checkRoot != null)
		{
			bindingSet.Bind(checkRoot).For((GameObject v) => v.activeSelf).ToExpression((HeroItemViewModel vm) => vm.IsChecked);
		}
		if ((UnityEngine.Object)(object)seatText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(seatText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroItemViewModel vm) => vm.SeatText);
		}
		if ((UnityEngine.Object)(object)level != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(level).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HeroItemViewModel vm) => $"{vm.HeroModel.Level}");
		}
		if (levelFix != null)
		{
			bindingSet.Bind(((Component)(object)level).gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroItemViewModel vm) => vm.LevelFix < 0);
			bindingSet.Bind(levelFix).For((GameObject v) => v.activeSelf).ToExpression((HeroItemViewModel vm) => vm.LevelFix > 0);
		}
		if (empty != null)
		{
			bindingSet.Bind(empty).For((GameObject v) => v.activeSelf).ToExpression((HeroItemViewModel vm) => vm.HeroModel.Empty);
		}
		if (noEmpty != null)
		{
			bindingSet.Bind(noEmpty).For((GameObject v) => v.activeSelf).ToExpression((HeroItemViewModel vm) => !vm.HeroModel.Empty);
		}
		if (customTag != null)
		{
			bindingSet.Bind(customTag).For((GameObject v) => v.activeSelf).To((HeroItemViewModel vm) => vm.ShowCustomTag);
		}
		if (selectHeroObj != null)
		{
			bindingSet.Bind(selectHeroObj).For((GameObject v) => v.activeSelf).To((HeroItemViewModel vm) => vm.IsSelected);
		}
		if ((UnityEngine.Object)(object)selectHeroIndex != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(selectHeroIndex).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroItemViewModel vm) => vm.SelectHeroIndex);
		}
		bindingSet.Build();
	}

	public void RefreshData(HeroItemViewModel viewModel)
	{
		_viewModel = viewModel;
		this.SetDataContext(viewModel);
	}
}
