using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ArmourAffixRefreshView : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI armourName;

	[SerializeField]
	private AttributeItem curMainAffix;

	[SerializeField]
	private RectTransform curSubAffixRoot;

	[SerializeField]
	private AttributeItem cacheMainAffix;

	[SerializeField]
	private RectTransform cacheSubAffixRoot;

	[SerializeField]
	private AttributeItem affixItemTpl;

	[SerializeField]
	private RectTransform unknownSubAffixRoot;

	[SerializeField]
	private GameObject unknownItemTpl;

	[SerializeField]
	private GameObject refreshEffect2;

	[SerializeField]
	private KnapsackItemNew costPropItem;

	[SerializeField]
	private TextMeshProUGUI costPropCount;

	[SerializeField]
	private TextMeshProUGUI costPropCountNotEnough;

	[SerializeField]
	private Button btnRefresh;

	[SerializeField]
	private TextMeshProUGUI btnRefreshText;

	[SerializeField]
	private GameObject btnRefreshMask;

	[SerializeField]
	private Button btnClosePreference;

	[SerializeField]
	private Button btnPreference;

	[SerializeField]
	private GameObject preferenceInfo;

	[SerializeField]
	private TextMeshProUGUI preferenceInfoText;

	[SerializeField]
	private GameObject preferencePanel;

	[SerializeField]
	private RectTransform preferenceItemRoot;

	[SerializeField]
	private Toggle preferenceItemTpl;

	private GameObjectPool _preferenceItemPool;

	[SerializeField]
	private Button btnRule;

	[SerializeField]
	private Button btnDecompose;

	[SerializeField]
	private MoneyView moneyView;

	[SerializeField]
	private Animator animator;

	[SerializeField]
	private string refreshAniName;

	[SerializeField]
	private string refreshAniTrigger;

	[SerializeField]
	private string enterAniTrigger;

	private GameObjectPool _curSubAffixPool;

	private GameObjectPool _cacheSubAffixPool;

	private GameObjectPool _unknownSubAffixPool;

	private ArmourAffixRefreshViewModel _viewModel;

	public void Init(ArmourAffixRefreshViewModel viewModel)
	{
		_viewModel = viewModel;
		BindingSet<ArmourAffixRefreshView, ArmourAffixRefreshViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind().For((ArmourAffixRefreshView v) => ((UGuiView)v).OnVisibleChanged).To((ArmourAffixRefreshViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind<TextMeshProUGUI>(armourName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((ArmourAffixRefreshViewModel vm) => vm.ArmourData.Name);
		bindingSet.Bind(btnRefresh).For((Button v) => v.onClick).To((ArmourAffixRefreshViewModel vm) => vm.RefreshAffixCmd);
		bindingSet.Bind(btnRefresh).For((Button v) => v.enabled).ToExpression((ArmourAffixRefreshViewModel vm) => !vm.BtnRefreshMask);
		bindingSet.Bind(btnRefreshMask).For((GameObject v) => v.activeSelf).To((ArmourAffixRefreshViewModel vm) => vm.BtnRefreshMask);
		bindingSet.Bind<TextMeshProUGUI>(btnRefreshText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourAffixRefreshViewModel vm) => vm.BtnRefreshText);
		bindingSet.Bind<TextMeshProUGUI>(costPropCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourAffixRefreshViewModel vm) => vm.CostPropCount);
		bindingSet.Bind<TextMeshProUGUI>(costPropCountNotEnough).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourAffixRefreshViewModel vm) => vm.CostPropCount);
		bindingSet.Bind(((Component)(object)costPropCount).gameObject).For((GameObject v) => v.activeSelf).To((ArmourAffixRefreshViewModel vm) => vm.CostEnough);
		bindingSet.Bind(((Component)(object)costPropCountNotEnough).gameObject).For((GameObject v) => v.activeSelf).ToExpression((ArmourAffixRefreshViewModel vm) => !vm.CostEnough);
		bindingSet.Bind().For((ArmourAffixRefreshView v) => v.PlayRefreshAnimation).To((ArmourAffixRefreshViewModel vm) => vm.RefreshAnimateRst);
		bindingSet.Bind().For((ArmourAffixRefreshView v) => v.OnArmourRefreshed).To((ArmourAffixRefreshViewModel vm) => vm.ArmourRefreshRst);
		bindingSet.Bind(btnRule).For((Button v) => v.onClick).To((ArmourAffixRefreshViewModel vm) => vm.OpenWindowRst)
			.CommandParameter("OpenRule");
		bindingSet.Bind(btnDecompose).For((Button v) => v.onClick).To((ArmourAffixRefreshViewModel vm) => vm.OpenWindowRst)
			.CommandParameter("OpenArmourFilterWindow");
		bindingSet.Build();
		_curSubAffixPool = new GameObjectPool(affixItemTpl.gameObject, curSubAffixRoot);
		_cacheSubAffixPool = new GameObjectPool(affixItemTpl.gameObject, cacheSubAffixRoot);
		_unknownSubAffixPool = new GameObjectPool(unknownItemTpl, unknownSubAffixRoot);
		OnInit();
	}

	private void OnInit()
	{
		InitPreferenceSetting();
		RefreshMainAffixItem(isInit: true);
		RefreshCurSubAffix();
		RefreshCacheSubAffix();
		RefreshUnknownSubAffix();
		RefreshEffect();
		costPropItem.Init(_viewModel.CostPropItemData);
		moneyView.Init(new MoneyViewModel(_viewModel));
		moneyView.SetShow(RoleMoneyEnum.ArmourAffixRefresh);
		MarkViewModelVisibleAfterShown().Forget();
	}

	private async UniTaskVoid MarkViewModelVisibleAfterShown()
	{
		await UniTask.WaitUntil(() => Visibility);
		if ((UnityEngine.Object)(object)animator != null)
		{
			animator.SetTrigger(enterAniTrigger);
		}
	}

	private void OnArmourRefreshed(object sender, InteractionEventArgs e)
	{
		RefreshMainAffixItem(isInit: false);
		RefreshCurSubAffix();
		RefreshCacheSubAffix();
		RefreshUnknownSubAffix();
		RefreshEffect();
	}

	protected override void OnVisibleChanged(object sender, InteractionEventArgs e)
	{
		_viewModel.RefreshArmour(_viewModel.ArmourData);
		bool flag = (bool)e.Context;
		CanvasGroup.alpha = (flag ? 1 : 0);
		CanvasGroup.blocksRaycasts = flag;
		if (flag && (UnityEngine.Object)(object)animator != null)
		{
			animator.SetTrigger(enterAniTrigger);
		}
	}

	private void PlayRefreshAnimation(object sender, InteractionEventArgs e)
	{
		RefreshCurSubAffix();
		if ((UnityEngine.Object)(object)animator != null)
		{
			animator.SetTrigger(refreshAniTrigger);
		}
		AnimationClip val = animator.runtimeAnimatorController.animationClips.ToList().Find((AnimationClip p) => ((UnityEngine.Object)(object)p).name.Equals(refreshAniName));
		if ((UnityEngine.Object)(object)val != null)
		{
			CancelInvoke("RefreshAnimationFinished");
			Invoke("RefreshAnimationFinished", val.length);
			_viewModel.SetWindowMaskTime(val.length);
		}
	}

	private void RefreshAnimationFinished()
	{
		RefreshCacheSubAffix();
	}

	private void InitPreferenceSetting()
	{
		btnClosePreference.onClick.AddListener(delegate
		{
			btnClosePreference.gameObject.SetActive(value: false);
			preferencePanel.SetActive(value: false);
		});
		btnPreference.onClick.AddListener(delegate
		{
			btnClosePreference.gameObject.SetActive(value: true);
			preferencePanel.SetActive(!preferencePanel.activeSelf);
		});
		_preferenceItemPool = new GameObjectPool(preferenceItemTpl.gameObject, preferenceItemRoot);
		foreach (var preference in _viewModel.PreferenceList)
		{
			GameObject obj = _preferenceItemPool.Allocate();
			obj.GetComponent<Toggle>()?.SetIsOnWithoutNotify(preference.Item2);
			obj.GetComponent<Toggle>()?.onValueChanged.AddListener(delegate(bool isOn)
			{
				OnPreferenceChanged(preference.Item1, isOn);
			});
			((TMP_Text)obj.GetComponentInChildren<TextMeshProUGUI>()).text = preference.Item1.Desc;
		}
		RefreshPreferenceInfo();
	}

	private void OnPreferenceChanged(DRAffix config, bool isOn)
	{
		_viewModel.SetPreference(config, isOn);
		RefreshPreferenceInfo();
	}

	private void RefreshPreferenceInfo()
	{
		List<(DRAffix, bool)> list = _viewModel.PreferenceList.FindAll(((DRAffix, bool) p) => p.Item2);
		preferenceInfo.SetActive(list.Count > 0);
		((TMP_Text)preferenceInfoText).text = $"已选择{list.Count}条";
	}

	private void RefreshMainAffixItem(bool isInit)
	{
		if (_viewModel.ArmourData != null && !_viewModel.ArmourData.Empty)
		{
			if (isInit)
			{
				curMainAffix.Init(new AttributeItemData(new EquipAttribute(_viewModel.ArmourData.GetMainAttribute())));
				cacheMainAffix.Init(new AttributeItemData(new EquipAttribute(_viewModel.ArmourData.GetMainAttribute())));
			}
			else
			{
				curMainAffix.RefreshData(new AttributeItemData(new EquipAttribute(_viewModel.ArmourData.GetMainAttribute())));
				cacheMainAffix.RefreshData(new AttributeItemData(new EquipAttribute(_viewModel.ArmourData.GetMainAttribute())));
			}
		}
	}

	private void RefreshCurSubAffix()
	{
		_curSubAffixPool.RecycleAll();
		if (_viewModel.ArmourData == null || _viewModel.ArmourData.Empty)
		{
			return;
		}
		List<EquipAttribute> subAttribute = _viewModel.ArmourData.GetSubAttribute();
		if (subAttribute == null)
		{
			return;
		}
		foreach (EquipAttribute item in subAttribute)
		{
			GameObject obj = _curSubAffixPool.Allocate(out var newCreate);
			obj.transform.SetAsLastSibling();
			AttributeItem component = obj.GetComponent<AttributeItem>();
			if (newCreate)
			{
				component.Init(new AttributeItemData(new EquipAttribute(item)));
			}
			else
			{
				component.RefreshData(new AttributeItemData(new EquipAttribute(item)));
			}
		}
	}

	private void RefreshUnknownSubAffix()
	{
		_unknownSubAffixPool.RecycleAll();
		if (_viewModel.ArmourData == null || _viewModel.ArmourData.Empty)
		{
			return;
		}
		List<EquipAttribute> subAttribute = _viewModel.ArmourData.GetSubAttribute();
		if (subAttribute == null)
		{
			return;
		}
		foreach (EquipAttribute item in subAttribute)
		{
			_ = item;
			_unknownSubAffixPool.Allocate().transform.SetAsLastSibling();
		}
	}

	private void RefreshCacheSubAffix()
	{
		_cacheSubAffixPool.RecycleAll();
		if (_viewModel.ArmourData == null || _viewModel.ArmourData.Empty)
		{
			return;
		}
		List<EquipAttribute> subAttribute = _viewModel.ArmourData.GetSubAttribute();
		if (subAttribute == null)
		{
			return;
		}
		foreach (EquipAttribute item in subAttribute)
		{
			GameObject obj = _cacheSubAffixPool.Allocate(out var newCreate);
			obj.transform.SetAsLastSibling();
			AttributeItem component = obj.GetComponent<AttributeItem>();
			if (newCreate)
			{
				component.Init(new AttributeItemData(new EquipAttribute(item)));
			}
			else
			{
				component.RefreshData(new AttributeItemData(new EquipAttribute(item)));
			}
		}
	}

	private void RefreshEffect()
	{
		if (_viewModel.ArmourData != null && !_viewModel.ArmourData.Empty)
		{
			List<EquipAttribute> subAttribute = _viewModel.ArmourData.GetSubAttribute();
			if (subAttribute != null)
			{
				refreshEffect2.SetActive(subAttribute.Count > 1);
			}
		}
	}

	protected override void OnDestroy()
	{
		CancelInvoke("RefreshAnimationFinished");
		base.OnDestroy();
	}
}
