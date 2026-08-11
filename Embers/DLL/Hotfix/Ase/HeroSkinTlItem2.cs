using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroSkinTlItem2 : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI tlGroupName;

	[SerializeField]
	private Button btnPlay;

	[SerializeField]
	private GameObject normal;

	[SerializeField]
	private GameObject selected;

	private HeroSkinTlItemData2 _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<HeroSkinTlItemData2>(userData);
		BindingSet<HeroSkinTlItem2, HeroSkinTlItemData2> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind<TextMeshProUGUI>(tlGroupName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkinTlItemData2 vm) => vm.TlGroupName);
		bindingSet.Bind(btnPlay).For((Button v) => v.onClick).To((HeroSkinTlItemData2 vm) => vm.PlayTimeline);
		if (normal != null)
		{
			bindingSet.Bind(normal).For((GameObject v) => v.activeSelf).ToExpression((HeroSkinTlItemData2 vm) => !vm.Selected);
		}
		if (selected != null)
		{
			bindingSet.Bind(selected).For((GameObject v) => v.activeSelf).To((HeroSkinTlItemData2 vm) => vm.Selected);
		}
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		if (userData is HeroSkinTlItemData2 heroSkinTlItemData)
		{
			_viewModel = heroSkinTlItemData;
			this.SetDataContext(heroSkinTlItemData);
		}
	}
}
