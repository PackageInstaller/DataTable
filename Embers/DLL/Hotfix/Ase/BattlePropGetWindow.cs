using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BattlePropGetWindow : UGuiWindow
{
	[SerializeField]
	private Button btnClose;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private new TextMeshProUGUI name;

	[SerializeField]
	private TextMeshProUGUI desc;

	[SerializeField]
	private TextMeshProUGUI newTitle;

	[SerializeField]
	private TextMeshProUGUI oldTitle;

	[SerializeField]
	private UIStarGroup star2;

	[SerializeField]
	private AutoDispose autoDispose;

	[SerializeField]
	private AutoDispose newStarEffectAutoDispose;

	private BattlePropGetViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<BattlePropGetViewModel>();
		BindingSet<BattlePropGetWindow, BattlePropGetViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((BattlePropGetViewModel vm) => vm.Close);
		bindingSet.Bind(this).For((BattlePropGetWindow v) => v.OnDismissRequest).To((BattlePropGetViewModel vm) => vm.DismissRequest);
		bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BattlePropGetViewModel vm) => vm.Name);
		bindingSet.Bind<TextMeshProUGUI>(desc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BattlePropGetViewModel vm) => vm.Desc);
		bindingSet.Bind(icon).For((Image v) => v.sprite).To((BattlePropGetViewModel vm) => vm.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(((Component)(object)newTitle).gameObject).For((GameObject v) => v.activeSelf).To((BattlePropGetViewModel vm) => vm.IsNew);
		bindingSet.Bind(((Component)(object)oldTitle).gameObject).For((GameObject v) => v.activeSelf).ToExpression((BattlePropGetViewModel vm) => !vm.IsNew);
		bindingSet.Bind(star2).For((UIStarGroup v) => v.MaxCount).To((BattlePropGetViewModel vm) => vm.StarCountMax);
		bindingSet.Bind(star2).For((UIStarGroup v) => v.CurCount).To((BattlePropGetViewModel vm) => vm.NewStarCount);
		bindingSet.Build();
		btnClose.interactable = false;
		autoDispose.AddDisposeAction((Action<GameObject>)delegate
		{
			btnClose.interactable = true;
		});
		newStarEffectAutoDispose.AddDisposeAction(delegate(GameObject go)
		{
			go.gameObject.SetActive(value: false);
			star2.SetAlpha(1);
		});
		star2.AddEffectAction(PlayStarEffect);
	}

	public void PlayStarEffect()
	{
		star2.SetEffectToNewStar(newStarEffectAutoDispose);
	}

	public void PlayEnd()
	{
		btnClose.interactable = true;
	}
}
