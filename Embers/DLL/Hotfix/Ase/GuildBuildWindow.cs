using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GuildBuildWindow : UGuiWindow
{
	[SerializeField]
	private Button btnOutside;

	[SerializeField]
	private Button btnClose;

	[SerializeField]
	private TextMeshProUGUI curLevel;

	[SerializeField]
	private TextMeshProUGUI curMemberLimit;

	[SerializeField]
	private TextMeshProUGUI curFundLimit;

	[SerializeField]
	private TextMeshProUGUI curActiveCost;

	[SerializeField]
	private GameObject upgradeInfo;

	[SerializeField]
	private TextMeshProUGUI upgradeLevel;

	[SerializeField]
	private TextMeshProUGUI upgradeMemberLimit;

	[SerializeField]
	private TextMeshProUGUI upgradeFundLimit;

	[SerializeField]
	private TextMeshProUGUI upgradeActiveCost;

	[SerializeField]
	private RectTransform effectItemRoot;

	[SerializeField]
	private GameObject effectItemTpl;

	[SerializeField]
	private TextMeshProUGUI maxLevelTips;

	[SerializeField]
	private GameObject consumeInfo;

	[SerializeField]
	private KnapsackItemNew consumeProp;

	[SerializeField]
	private TextMeshProUGUI consumeCount;

	[SerializeField]
	private Button btnUpgrade;

	[SerializeField]
	private TextMeshProUGUI btnText;

	[SerializeField]
	private GameObject btnUpgradeMask;

	private GameObjectPool effectItemPool;

	private GuildBuildViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		effectItemPool = new GameObjectPool(effectItemTpl, effectItemRoot);
		base.OnCreate(bundle);
		_viewModel = GetData<GuildBuildViewModel>();
		BindingSet<GuildBuildWindow, GuildBuildViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((GuildBuildWindow v) => v.OnDismissRequest).To((GuildBuildViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((GuildBuildWindow v) => v.OpenUguiWindow).To((GuildBuildViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((GuildBuildViewModel vm) => vm.Close);
		bindingSet.Bind(btnOutside).For((Button v) => v.onClick).To((GuildBuildViewModel vm) => vm.Close);
		bindingSet.Bind<TextMeshProUGUI>(curLevel).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildBuildViewModel vm) => vm.CurLevel);
		bindingSet.Bind<TextMeshProUGUI>(curMemberLimit).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildBuildViewModel vm) => vm.CurMemberLimit);
		bindingSet.Bind<TextMeshProUGUI>(curFundLimit).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildBuildViewModel vm) => vm.CurFundLimit);
		bindingSet.Bind<TextMeshProUGUI>(curActiveCost).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildBuildViewModel vm) => vm.CurActiveCost);
		bindingSet.Bind(upgradeInfo).For((GameObject v) => v.activeSelf).To((GuildBuildViewModel vm) => vm.ShowUpgradeInfo);
		bindingSet.Bind(((Component)(object)maxLevelTips).gameObject).For((GameObject v) => v.activeSelf).ToExpression((GuildBuildViewModel vm) => !vm.ShowUpgradeInfo);
		bindingSet.Bind<TextMeshProUGUI>(upgradeLevel).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildBuildViewModel vm) => vm.NextLevel);
		bindingSet.Bind<TextMeshProUGUI>(upgradeMemberLimit).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildBuildViewModel vm) => vm.NextMemberLimit);
		bindingSet.Bind<TextMeshProUGUI>(upgradeFundLimit).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildBuildViewModel vm) => vm.NextFundLimit);
		bindingSet.Bind<TextMeshProUGUI>(upgradeActiveCost).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildBuildViewModel vm) => vm.NextActiveCost);
		bindingSet.Bind(consumeInfo).For((GameObject v) => v.activeSelf).To((GuildBuildViewModel vm) => vm.ShowConsume);
		bindingSet.Bind<TextMeshProUGUI>(consumeCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildBuildViewModel vm) => vm.ConsumeFundText);
		bindingSet.Bind(btnUpgrade).For((Button v) => v.onClick).To((GuildBuildViewModel vm) => vm.UpgradeCmd);
		bindingSet.Bind(btnUpgrade).For((Button v) => v.enabled).ToExpression((GuildBuildViewModel vm) => !vm.ShowBtnMask);
		bindingSet.Bind<TextMeshProUGUI>(btnText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildBuildViewModel vm) => vm.BtnText);
		bindingSet.Bind(btnUpgradeMask).For((GameObject v) => v.activeSelf).To((GuildBuildViewModel vm) => vm.ShowBtnMask);
		bindingSet.Build();
		consumeProp.Init(_viewModel.ConsumePropData);
		RefreshEffectItems();
	}

	private void RefreshEffectItems(object sender = null, InteractionEventArgs e = null)
	{
		effectItemPool.RecycleAll();
		if (_viewModel.NextEffects == null)
		{
			return;
		}
		foreach (string nextEffect in _viewModel.NextEffects)
		{
			GameObject obj = effectItemPool.Allocate();
			obj.transform.SetSiblingIndex(effectItemRoot.childCount - 1);
			((TMP_Text)obj.transform.GetChild(0).GetComponent<TextMeshProUGUI>()).text = nextEffect;
		}
	}

	protected override void OnDestroy()
	{
		effectItemPool?.Dispose();
		effectItemPool = null;
		base.OnDestroy();
	}
}
