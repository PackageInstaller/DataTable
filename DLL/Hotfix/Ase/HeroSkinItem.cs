using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroSkinItem : UGuiView
{
	[SerializeField]
	private Button btn;

	[SerializeField]
	protected Image icon;

	[SerializeField]
	protected Image icon2;

	[SerializeField]
	protected TextMeshProUGUI skinName;

	[SerializeField]
	protected TextMeshProUGUI heroName;

	[SerializeField]
	protected TextMeshProUGUI skinDesc;

	[SerializeField]
	protected Image quality;

	[SerializeField]
	protected Image headIcon;

	[SerializeField]
	protected GameObject selected;

	[SerializeField]
	protected GameObject inActiveMask;

	private HeroSkinItemData _viewModel;

	public HeroSkinItemData ViewModel => _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<HeroSkinItemData>(userData);
		BindingSet<HeroSkinItem, HeroSkinItemData> bindingSet = this.CreateBindingSet(_viewModel);
		if (btn != null)
		{
			bindingSet.Bind(btn).For((Button v) => v.onClick).To((HeroSkinItemData vm) => vm.OnItemClick);
		}
		if (icon != null)
		{
			bindingSet.Bind(icon).For((Image v) => v.sprite).To((HeroSkinItemData vm) => vm.Icon)
				.WithConversion("ItemIcon");
		}
		if (icon2 != null)
		{
			bindingSet.Bind(icon2).For((Image v) => v.sprite).To((HeroSkinItemData vm) => vm.Icon)
				.WithConversion("ItemIcon");
		}
		if (quality != null)
		{
			bindingSet.Bind(quality).For((Image v) => v.sprite).To((HeroSkinItemData vm) => vm.QualityIcon)
				.WithConversion("ItemIcon");
		}
		if ((UnityEngine.Object)(object)skinName != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(skinName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkinItemData vm) => vm.SkinName);
		}
		if ((UnityEngine.Object)(object)heroName != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(heroName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkinItemData vm) => vm.HeroName);
		}
		if ((UnityEngine.Object)(object)skinDesc != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(skinDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkinItemData vm) => vm.SkinDesc);
		}
		if (headIcon != null)
		{
			bindingSet.Bind(headIcon).For((Image v) => v.sprite).To((HeroSkinItemData vm) => vm.HeadIcon)
				.WithConversion("ItemIcon");
		}
		if (selected != null)
		{
			bindingSet.Bind(selected).For((GameObject v) => v.activeSelf).To((HeroSkinItemData vm) => vm.Selected);
		}
		if (inActiveMask != null)
		{
			bindingSet.Bind(inActiveMask).For((GameObject v) => v.activeSelf).To((HeroSkinItemData vm) => vm.InActiveMask);
		}
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		if (userData is HeroSkinItemData heroSkinItemData)
		{
			_viewModel = heroSkinItemData;
			this.SetDataContext(heroSkinItemData);
		}
	}
}
