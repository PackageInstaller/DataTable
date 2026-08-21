using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BattleDropItem : UGuiView
{
	[SerializeField]
	private Image icon;

	[SerializeField]
	private Image qualityBg;

	[SerializeField]
	private TextMeshProUGUI nameShow;

	[SerializeField]
	private new TextMeshProUGUI name;

	[SerializeField]
	private TextMeshProUGUI count;

	[SerializeField]
	private TextMeshProUGUI countShow;

	[SerializeField]
	private GameObject effectQuality3;

	[SerializeField]
	private GameObject effectQuality4;

	private BattleDropItemData _viewModel;

	private Action<BattleDropItem> hideCallback;

	private bool iniitialized;

	public bool Iniitialized => iniitialized;

	public void Init(BattleDropItemData viewModel, Action<BattleDropItem> hideCallback)
	{
		_viewModel = viewModel;
		this.hideCallback = hideCallback;
		BindingSet<BattleDropItem, BattleDropItemData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(icon).For((Image v) => v.sprite).To((BattleDropItemData vm) => vm.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(qualityBg).For((Image v) => v.sprite).ToExpression((BattleDropItemData vm) => $"battle_pickup_{vm.Quality}")
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BattleDropItemData vm) => vm.Name);
		bindingSet.Bind<TextMeshProUGUI>(nameShow).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BattleDropItemData vm) => vm.NameShow);
		bindingSet.Bind<TextMeshProUGUI>(count).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BattleDropItemData vm) => vm.Count);
		bindingSet.Bind<TextMeshProUGUI>(countShow).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BattleDropItemData vm) => vm.CountShow);
		bindingSet.Bind(effectQuality3).For((GameObject v) => v.activeSelf).ToExpression((BattleDropItemData vm) => vm.Quality == 3);
		bindingSet.Bind(effectQuality4).For((GameObject v) => v.activeSelf).ToExpression((BattleDropItemData vm) => vm.Quality == 4);
		bindingSet.Build();
		iniitialized = true;
	}

	public void RefreshData(BattleDropItemData viewModel)
	{
		_viewModel = viewModel;
		this.SetDataContext(viewModel);
	}

	public void Show()
	{
		Visibility = true;
		CancelInvoke("Hide");
		if (EnterAnimation != null)
		{
			EnterAnimation.OnEnd(AutoHide).Play();
		}
		else
		{
			AutoHide();
		}
	}

	public void AutoHide()
	{
		Invoke("Hide", _viewModel.ShowTime);
	}

	public void Hide()
	{
		if (ExitAnimation != null)
		{
			ExitAnimation.OnEnd(delegate
			{
				hideCallback?.Invoke(this);
				Visibility = false;
			}).Play();
		}
		else
		{
			hideCallback?.Invoke(this);
			Visibility = false;
		}
	}

	protected override void OnDestroy()
	{
		CancelInvoke("Hide");
		base.OnDestroy();
	}
}
