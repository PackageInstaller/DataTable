using System;
using System.Linq.Expressions;
using Coffee.UIExtensions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TowerTalentItemView : UGuiView
{
	public int TalentId;

	public int TalentType;

	[SerializeField]
	private GameObject lockState;

	[SerializeField]
	private GameObject activeState;

	[SerializeField]
	private GameObject normalLevel;

	[SerializeField]
	private GameObject maxLevel;

	[SerializeField]
	private TextMeshProUGUI levelText;

	[SerializeField]
	private Image Icon;

	[SerializeField]
	private GameObject canUpLevel;

	[SerializeField]
	private GameObject selectGo;

	[SerializeField]
	private Button itemBtn;

	[SerializeField]
	private AutoDispose upLevelEffect;

	[SerializeField]
	private UIParticle upLevelParticle;

	private TowerTalentItemViewModel _viewModel;

	[SerializeField]
	private bool lockShowDefault;

	public new void Init(object userData)
	{
		_viewModel = (TowerTalentItemViewModel)userData;
		BindingSet<TowerTalentItemView, TowerTalentItemViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(lockState).For((GameObject v) => v.activeSelf).ToExpression((TowerTalentItemViewModel vm) => !vm.Data.UnLock);
		bindingSet.Bind(activeState).For((GameObject v) => v.activeSelf).ToExpression((TowerTalentItemViewModel vm) => vm.Data.UnLock && vm.Data.TalntLevel > 0);
		bindingSet.Bind(normalLevel).For((GameObject v) => v.activeSelf).ToExpression((TowerTalentItemViewModel vm) => (vm.Data.TalntLevel > 0 && vm.Data.TalntLevel < vm.Data.MaxLevel) || lockShowDefault);
		bindingSet.Bind(maxLevel).For((GameObject v) => v.activeSelf).ToExpression((TowerTalentItemViewModel vm) => vm.Data.TalntLevel >= vm.Data.MaxLevel);
		bindingSet.Bind<TextMeshProUGUI>(levelText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((TowerTalentItemViewModel vm) => $"Lv.{(((!vm.Data.UnLock && lockShowDefault) || (lockShowDefault && vm.Data.TalntLevel == 0)) ? 1 : vm.Data.TalntLevel)}");
		bindingSet.Bind(canUpLevel).For((GameObject v) => v.activeSelf).To((TowerTalentItemViewModel vm) => vm.Data.CanUpLevel);
		bindingSet.Bind(selectGo).For((GameObject v) => v.activeSelf).To((TowerTalentItemViewModel vm) => vm.IsSelect);
		bindingSet.Bind().For((TowerTalentItemView v) => v.OnTalentUpLevelRequest).To((TowerTalentItemViewModel vm) => vm.Data.UpLevelSuccessRequest);
		if (Icon != null)
		{
			bindingSet.Bind(Icon).For((Image v) => v.sprite).ToExpression((TowerTalentItemViewModel vm) => vm.Data.IconName)
				.WithConversion("ItemIcon");
		}
		bindingSet.Bind(itemBtn).For((Button v) => v.onClick).To((TowerTalentItemViewModel vm) => vm.OnClick);
		bindingSet.Build();
		itemBtn.onClick.AddListener(delegate
		{
			_viewModel.OnClick();
		});
		upLevelEffect.AddDisposeAction(delegate(GameObject e)
		{
			e.SetActive(value: false);
		});
		upLevelEffect.time = 1f;
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		_viewModel = (TowerTalentItemViewModel)userData;
		this.SetDataContext(_viewModel);
	}

	private void OnTalentUpLevelRequest(object sender, InteractionEventArgs args)
	{
		if (!lockShowDefault)
		{
			upLevelEffect.ResetTime(1f);
			if (upLevelEffect.gameObject.activeSelf)
			{
				upLevelParticle.Play();
			}
			else
			{
				upLevelEffect.gameObject.SetActive(value: true);
			}
		}
	}
}
