using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroBreakoutWindow : UGuiWindow
{
	[SerializeField]
	private MoneyView moneyView;

	[SerializeField]
	private Button backBtn;

	[SerializeField]
	private Transform originalTrans;

	[SerializeField]
	private UIStarGroup starLevel;

	[SerializeField]
	private TextMeshProUGUI tips;

	[SerializeField]
	private Transform propertyGroup;

	[SerializeField]
	private Transform matPropGroup;

	[SerializeField]
	private Image moneyIcon;

	[SerializeField]
	private TextMeshProUGUI moneyAmount;

	[SerializeField]
	private Button breakoutBtn;

	[SerializeField]
	private GameObject greyBtnMask;

	[SerializeField]
	private TextMeshProUGUI btnText;

	[SerializeField]
	private KnapsackItemNew materialItemTpl;

	private GameObject _heroOriginal;

	private List<KnapsackItemNew> _materialItems;

	private string originalAssetPath;

	private HeroBreakoutViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_materialItems = new List<KnapsackItemNew>();
		_viewModel = GetData<HeroBreakoutViewModel>();
		BindingSet<HeroBreakoutWindow, HeroBreakoutViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(backBtn).For((Button v) => v.onClick).To((HeroBreakoutViewModel vm) => vm.Close);
		bindingSet.Bind().For((HeroBreakoutWindow v) => v.OpenUguiWindow).To((HeroBreakoutViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind().For((HeroBreakoutWindow v) => v.CloseWindow).To((HeroBreakoutViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(starLevel).For((UIStarGroup v) => v.CurCount).To((HeroBreakoutViewModel vm) => vm.HeroModel.StarLevel);
		bindingSet.Bind<TextMeshProUGUI>(tips).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroBreakoutViewModel vm) => vm.Tips);
		bindingSet.Bind(moneyIcon).For((Image v) => v.sprite).To((HeroBreakoutViewModel vm) => vm.MoneyIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(moneyAmount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroBreakoutViewModel vm) => vm.MoneyAmount);
		bindingSet.Bind(breakoutBtn).For((Button v) => v.onClick).To((HeroBreakoutViewModel vm) => vm.BreakoutCommand);
		bindingSet.Bind().For((HeroBreakoutWindow v) => v.RefreshData).To((HeroBreakoutViewModel vm) => vm.RefreshRequest);
		bindingSet.Build();
		breakoutBtn.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.HeroIdsCanBreak).SetFuncOnMessage((RedPointMessage message) => ((RedPointService)Singleton<ServiceSystem>.Instance.GetService<IRedPointService>()).HeroIdCanBreak.Contains(_viewModel.HeroModel.Id))
			.Invoke();
		InitHeroOriginal();
		moneyView.Init(new MoneyViewModel(_viewModel));
		moneyView.HideAll();
		moneyView.SetShow(RoleMoneyEnum.Coin);
		RefreshData();
	}

	private async void InitHeroOriginal()
	{
		if (_viewModel == null || originalTrans == null)
		{
			return;
		}
		HeroModel heroModel = _viewModel.HeroModel;
		if (!heroModel.IsNullOrEmpty())
		{
			originalAssetPath = heroModel.Original;
			GameObject gameObject = await InstantiateAsync(AssetUtility.GetUIItemAsset(heroModel.Original), originalTrans);
			if (gameObject != null)
			{
				_heroOriginal = gameObject;
				StreamerMode.ApplySpineSkin(gameObject);
			}
		}
	}

	private void RefreshData(object sender = null, InteractionEventArgs e = null)
	{
		for (int i = 0; i < propertyGroup.childCount; i++)
		{
			PropertyItem propertyItem = propertyGroup.GetChild(i)?.GetComponent<PropertyItem>();
			if (!(propertyItem == null))
			{
				if (!propertyItem.IsInitHandlerCalled)
				{
					propertyItem.Init(_viewModel.PropertyChangeDatas[i]);
				}
				else
				{
					propertyItem.RefreshData(_viewModel.PropertyChangeDatas[i]);
				}
			}
		}
		for (int j = 0; j < _viewModel.MaterialDatas.Count; j++)
		{
			if (_materialItems.Count <= j)
			{
				KnapsackItemNew knapsackItemNew = UnityEngine.Object.Instantiate(materialItemTpl, matPropGroup);
				knapsackItemNew.Init(_viewModel.MaterialDatas[j]);
				knapsackItemNew.Visibility = true;
				_materialItems.Add(knapsackItemNew);
			}
			else
			{
				_materialItems[j].RefreshData(_viewModel.MaterialDatas[j]);
			}
		}
		bool flag = _viewModel.EnoughMaterial && _viewModel.EnoughCoin;
		breakoutBtn.gameObject.SetActive(flag);
		greyBtnMask.gameObject.SetActive(!flag);
		((Graphic)(object)btnText).color = (flag ? Color.white : Color.gray);
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		if (_heroOriginal != null)
		{
			UnityEngine.Object.DestroyImmediate(_heroOriginal);
			_heroOriginal = null;
		}
		DoDismiss();
		GameEntry.Resource.UnloadAsset("Assets/Art/UI/UIForms/Role/MoneyView");
	}
}
