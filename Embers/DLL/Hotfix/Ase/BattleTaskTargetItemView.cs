using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BattleTaskTargetItemView : UGuiView
{
	[SerializeField]
	private Image icon;

	[SerializeField]
	private GameObject extraicon;

	[SerializeField]
	private TextMeshProUGUI taskName;

	[SerializeField]
	private TextMeshProUGUI taskDesc;

	[SerializeField]
	private TextMeshProUGUI taskProgress;

	[SerializeField]
	private GameObject complete;

	[SerializeField]
	private GameObject noComplete;

	[SerializeField]
	private Color completeColor;

	[SerializeField]
	private Color normalColor;

	[SerializeField]
	private Button changeTrackBtn;

	[SerializeField]
	private Button taskUIPosBtn;

	[SerializeField]
	private GameObject taskUICanClick;

	[SerializeField]
	private GameObject taskUICantClick;

	[SerializeField]
	private List<GameObject> showEffects;

	private BattleTaskTargetItemViewModel viewModel;

	[SerializeField]
	private AutoDispose trackUIEffectDisplay;

	[SerializeField]
	private Animator _animator;

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<BattleTaskTargetItemViewModel>(userData);
		if ((bool)trackUIEffectDisplay)
		{
			trackUIEffectDisplay.AddDisposeAction(delegate(GameObject e)
			{
				e.SetActive(value: false);
			});
		}
		BindingSet<BattleTaskTargetItemView, BattleTaskTargetItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		if (icon != null)
		{
			bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((BattleTaskTargetItemViewModel vm) => $"task_mark_{vm.Data.TaskType}")
				.WithConversion("ItemIcon");
		}
		if ((UnityEngine.Object)(object)taskName != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(taskName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BattleTaskTargetItemViewModel vm) => vm.Data.TaskName);
		}
		if ((UnityEngine.Object)(object)taskDesc != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(taskDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BattleTaskTargetItemViewModel vm) => vm.Data.TargetDesc);
		}
		if (complete != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(taskProgress).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BattleTaskTargetItemViewModel vm) => ((vm.Data.ParallelTaskType == 0 && vm.Data.TaskType != 3) || vm.Data.ParallelTaskType == 4) ? "" : $"({vm.Data.Progress}/{vm.Data.TargetValue})");
			bindingSet.Bind(complete).For((GameObject v) => v.activeSelf).ToExpression((BattleTaskTargetItemViewModel vm) => vm.Data.Finish);
			bindingSet.Bind<TextMeshProUGUI>(taskProgress).For((Expression<Func<TextMeshProUGUI, Color>>)((TextMeshProUGUI v) => ((Graphic)v).color)).ToExpression((BattleTaskTargetItemViewModel vm) => vm.Data.Finish ? completeColor : normalColor);
			bindingSet.Bind<TextMeshProUGUI>(taskDesc).For((Expression<Func<TextMeshProUGUI, Color>>)((TextMeshProUGUI v) => ((Graphic)v).color)).ToExpression((BattleTaskTargetItemViewModel vm) => vm.Data.Finish ? completeColor : normalColor);
		}
		if (noComplete != null)
		{
			bindingSet.Bind(noComplete).For((GameObject v) => v.activeSelf).ToExpression((BattleTaskTargetItemViewModel vm) => !vm.Data.Finish);
		}
		if (extraicon != null)
		{
			bindingSet.Bind(extraicon).For((GameObject v) => v.activeSelf).ToExpression((BattleTaskTargetItemViewModel vm) => vm.Data.TaskExtra == 1 && !vm.Data.Finish);
		}
		if (changeTrackBtn != null)
		{
			changeTrackBtn.onClick.AddListener(ChangeTrack);
		}
		if (taskUIPosBtn != null)
		{
			bindingSet.Bind(taskUICanClick).For((GameObject v) => v.activeSelf).ToExpression((BattleTaskTargetItemViewModel vm) => vm.BattleTaskTargetViewModel.TaskDirUIAlpha == 1);
			bindingSet.Bind(taskUICantClick).For((GameObject v) => v.activeSelf).ToExpression((BattleTaskTargetItemViewModel vm) => vm.BattleTaskTargetViewModel.TaskDirUIAlpha == 0);
			bindingSet.Bind(taskUIPosBtn).For((Button v) => v.interactable).ToExpression((BattleTaskTargetItemViewModel vm) => !vm.BattleTaskTargetViewModel.InBattleState);
			bindingSet.Bind(taskUIPosBtn.gameObject).For((GameObject v) => v.activeSelf).ToExpression((BattleTaskTargetItemViewModel vm) => vm.BattleTaskTargetViewModel.ShowTaskUIPosBtn);
			taskUIPosBtn.onClick.AddListener(ClickTaskDirUIBtn);
		}
		bindingSet.Build();
		ShowEffect();
	}

	private void ClickTaskDirUIBtn()
	{
		viewModel.ClickTaskDirUIBtn();
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<BattleTaskTargetItemViewModel>(userData);
		ShowEffect();
		this.SetDataContext(viewModel);
		if ((UnityEngine.Object)(object)_animator != null)
		{
			_animator.Play("TargetTask");
		}
	}

	private void ShowEffect()
	{
		if (showEffects == null)
		{
			return;
		}
		for (int i = 0; i < showEffects.Count; i++)
		{
			if (viewModel != null && viewModel.Data != null)
			{
				showEffects[i].gameObject.SetActive(viewModel.Data.TaskType - 1 == i);
			}
			else
			{
				showEffects[i].gameObject.SetActive(value: false);
			}
		}
	}

	private async void ChangeTrack()
	{
		if (viewModel != null)
		{
			TrackDisappearPlayHideAn();
			trackUIEffectDisplay.gameObject.SetActive(value: true);
			changeTrackBtn.interactable = false;
			await UniTask.WaitForSeconds(0.5f);
			viewModel.ItemOnClick(new OptionArg(this, "ClickChangeTrackItemView"));
			changeTrackBtn.interactable = true;
		}
	}

	public void TrackDisappearPlayHideAn()
	{
		if ((UnityEngine.Object)(object)_animator != null)
		{
			_animator.Play("TargetTaskHide");
		}
	}
}
