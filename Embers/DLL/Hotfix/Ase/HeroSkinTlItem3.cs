using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroSkinTlItem3 : UGuiView
{
	public int timelineId;

	[SerializeField]
	private TextMeshProUGUI tlName;

	[SerializeField]
	private Image tlIcon;

	[SerializeField]
	private Button btnPlay;

	[SerializeField]
	private GameObject lockGo;

	[SerializeField]
	private GameObject unRead;

	private HeroSkinTlItemData3 _viewModel;

	public bool initialized;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		initialized = true;
		_viewModel = GetUserData<HeroSkinTlItemData3>(userData);
		BindingSet<HeroSkinTlItem3, HeroSkinTlItemData3> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind<TextMeshProUGUI>(tlName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkinTlItemData3 vm) => vm.TlName);
		bindingSet.Bind(tlIcon).For((Image v) => v.sprite).To((HeroSkinTlItemData3 vm) => vm.TlIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(btnPlay).For((Button v) => v.onClick).To((HeroSkinTlItemData3 vm) => vm.PlayTimeline);
		bindingSet.Bind(lockGo).For((GameObject v) => v.activeSelf).ToExpression((HeroSkinTlItemData3 vm) => !vm.Unlock);
		bindingSet.Bind(unRead).For((GameObject v) => v.activeSelf).ToExpression((HeroSkinTlItemData3 vm) => vm.Unlock && !vm.Read);
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		if (userData is HeroSkinTlItemData3 heroSkinTlItemData)
		{
			_viewModel = heroSkinTlItemData;
			this.SetDataContext(heroSkinTlItemData);
		}
	}
}
