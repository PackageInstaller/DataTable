using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroSkinTlItem1 : UGuiView
{
	[SerializeField]
	private Image skinIcon;

	[SerializeField]
	private TextMeshProUGUI favorability;

	[SerializeField]
	private TextMeshProUGUI skinName;

	[SerializeField]
	private TextMeshProUGUI skinDesc;

	[SerializeField]
	private Button button;

	[SerializeField]
	private Button btnSave;

	[SerializeField]
	private GameObject saveGo;

	[SerializeField]
	private GameObject savedGo;

	[SerializeField]
	private GameObject selected;

	private HeroSkinTlItemData1 _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<HeroSkinTlItemData1>(userData);
		BindingSet<HeroSkinTlItem1, HeroSkinTlItemData1> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(skinIcon).For((Image v) => v.sprite).To((HeroSkinTlItemData1 vm) => vm.SkinIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(selected).For((GameObject v) => v.activeSelf).To((HeroSkinTlItemData1 vm) => vm.Selected);
		bindingSet.Bind<TextMeshProUGUI>(favorability).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkinTlItemData1 vm) => vm.Favorability);
		bindingSet.Bind(button).For((Button v) => v.onClick).To((HeroSkinTlItemData1 vm) => vm.OnItemClick);
		if ((UnityEngine.Object)(object)skinName != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(skinName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkinTlItemData1 vm) => vm.SkinName);
		}
		if ((UnityEngine.Object)(object)skinDesc != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(skinDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkinTlItemData1 vm) => vm.SkinDesc);
		}
		if (btnSave != null)
		{
			bindingSet.Bind(btnSave).For((Button v) => v.onClick).To((HeroSkinTlItemData1 vm) => vm.Save);
		}
		if (saveGo != null)
		{
			bindingSet.Bind(saveGo).For((GameObject v) => v.activeSelf).ToExpression((HeroSkinTlItemData1 vm) => !vm.Saved);
		}
		if (savedGo != null)
		{
			bindingSet.Bind(savedGo).For((GameObject v) => v.activeSelf).To((HeroSkinTlItemData1 vm) => vm.Saved);
		}
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		if (userData is HeroSkinTlItemData1 heroSkinTlItemData)
		{
			_viewModel = heroSkinTlItemData;
			this.SetDataContext(heroSkinTlItemData);
		}
	}
}
