using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase.ECS;

public class AbnormalStateItemView : UGuiView
{
	public Image OuterFill;

	public Image InnerFill;

	public Image Icon;

	private AbnormalStateViewModel _viewModel;

	private float currentProgress;

	public float CurrentProgress
	{
		get
		{
			return currentProgress;
		}
		set
		{
			float num = _viewModel.CurrentProgress / _viewModel.MaxProgress;
			OuterFill.fillAmount = (_viewModel.WillRemove ? 1f : num);
			InnerFill.fillAmount = (_viewModel.WillRemove ? num : 0f);
		}
	}

	public void Init(AbnormalStateViewModel abnormalStateViewModel)
	{
		BindingSet<AbnormalStateItemView, AbnormalStateViewModel> bindingSet = this.CreateBindingSet(abnormalStateViewModel);
		_viewModel = abnormalStateViewModel;
		bindingSet.Bind(OuterFill).For((Image v) => v.color).To((AbnormalStateViewModel vm) => vm.OutColor);
		bindingSet.Bind(InnerFill).For((Image v) => v.color).To((AbnormalStateViewModel vm) => vm.InnerColor);
		bindingSet.Bind().For((AbnormalStateItemView v) => v.CurrentProgress).To((AbnormalStateViewModel vm) => vm.CurrentProgress);
		bindingSet.Bind<CanvasGroup>(CanvasGroup).For((Expression<Func<CanvasGroup, float>>)((CanvasGroup v) => v.alpha)).To((AbnormalStateViewModel vm) => vm.RemoveCanvasGroup);
		bindingSet.Bind(Icon).For((Image v) => v.sprite).To((AbnormalStateViewModel vm) => vm.StateIcon)
			.WithConversion("ItemIcon");
		bindingSet.Build();
	}

	public void ResetViewModel(AbnormalStateViewModel abnormalStateViewModel)
	{
		this.SetDataContext(abnormalStateViewModel);
		_viewModel = abnormalStateViewModel;
	}
}
