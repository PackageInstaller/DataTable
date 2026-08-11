using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BattleExpUpView : UGuiView
{
	public float ExpTweenTime = 1.5f;

	public float Wait2TweenTime = 1f;

	[SerializeField]
	private UIView expPart;

	[SerializeField]
	private Image expBar;

	[SerializeField]
	private TextMeshProUGUI curExpText;

	[SerializeField]
	private TextMeshProUGUI curLevelText;

	[SerializeField]
	private UIView levelUpPart;

	[SerializeField]
	private TextMeshProUGUI levelText;

	[SerializeField]
	private Image levelRankIcon;

	private BattleExpUpViewModel _viewModel;

	public void Init(BattleExpUpViewModel viewModel)
	{
		_viewModel = viewModel;
		_viewModel.ExpTweenTime = ExpTweenTime;
		_viewModel.Wait2TweenTime = Wait2TweenTime;
		BindingSet<BattleExpUpView, BattleExpUpViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(expBar).For((Image v) => v.fillAmount).To((BattleExpUpViewModel vm) => vm.ExpRate);
		bindingSet.Bind<TextMeshProUGUI>(curExpText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BattleExpUpViewModel vm) => vm.CurExpText);
		bindingSet.Bind<TextMeshProUGUI>(curLevelText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BattleExpUpViewModel vm) => vm.CurLevel);
		bindingSet.Bind<TextMeshProUGUI>(levelText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BattleExpUpViewModel vm) => vm.CurLevel);
		bindingSet.Bind(levelRankIcon).For((Image v) => v.sprite).To((BattleExpUpViewModel vm) => vm.CurLevelRankIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind().For((BattleExpUpView v) => v.SetExpBarVisible).To((BattleExpUpViewModel vm) => vm.SetExpBarVisible);
		bindingSet.Bind().For((BattleExpUpView v) => v.SetLevelUpVisible).To((BattleExpUpViewModel vm) => vm.SetLevelUpVisible);
		bindingSet.Build();
	}

	private void SetExpBarVisible(object sender, InteractionEventArgs e)
	{
		if ((bool)e.Context)
		{
			expPart.Visibility = true;
			if (expPart.EnterAnimation != null)
			{
				expPart.EnterAnimation.OnEnd(_viewModel.ExpBarTween).Play();
			}
			else
			{
				_viewModel.ExpBarTween();
			}
		}
		else if (expPart.ExitAnimation != null)
		{
			expPart.ExitAnimation.OnEnd(Handler).Play();
		}
		else
		{
			Handler();
		}
		void Handler()
		{
			expPart.Visibility = false;
			_viewModel.OnExpBarTweenCompleted();
		}
	}

	private void SetLevelUpVisible(object sender, InteractionEventArgs e)
	{
		if ((bool)e.Context)
		{
			levelUpPart.Visibility = true;
			if (levelUpPart.EnterAnimation != null)
			{
				levelUpPart.EnterAnimation.OnEnd(Handler).Play();
			}
			else
			{
				Handler();
			}
		}
		void Handler()
		{
			if (levelUpPart.ExitAnimation != null)
			{
				levelUpPart.ExitAnimation.OnEnd(delegate
				{
					levelUpPart.Visibility = false;
					_viewModel.OnLevelUpTweenCompleted();
				}).Play();
			}
			else
			{
				levelUpPart.Visibility = false;
				_viewModel.OnLevelUpTweenCompleted();
			}
		}
	}

	public override void AfterCloseView()
	{
		_viewModel = null;
	}
}
