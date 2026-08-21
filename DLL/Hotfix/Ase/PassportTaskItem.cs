using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PassportTaskItem : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI count;

	[SerializeField]
	private TextMeshProUGUI taskName;

	[SerializeField]
	private TextMeshProUGUI rewardItemCount;

	[SerializeField]
	private Button btnJump;

	[SerializeField]
	private Button btnGetReward;

	[SerializeField]
	private GameObject TipObj;

	[SerializeField]
	private GameObject finishObj;

	[SerializeField]
	private GameObject jumpObj;

	[SerializeField]
	private GameObject getRewardObj;

	[SerializeField]
	private UIParticlePlayer taskCompleteEffect;

	private PassportTaskItemData viewModel;

	public void Init(PassportTaskItemData viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<PassportTaskItem, PassportTaskItemData> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind<TextMeshProUGUI>(count).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((PassportTaskItemData vm) => $"{vm.FinishCount}/{vm.TotalCount}");
		bindingSet.Bind<TextMeshProUGUI>(taskName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PassportTaskItemData vm) => vm.TaskName);
		bindingSet.Bind<TextMeshProUGUI>(rewardItemCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PassportTaskItemData vm) => vm.RewardItemCount);
		bindingSet.Bind(btnJump).For((Button v) => v.onClick).To((PassportTaskItemData vm) => vm.Jump);
		bindingSet.Bind(btnGetReward).For((Button v) => v.onClick).To((PassportTaskItemData vm) => vm.GetReward);
		bindingSet.Bind(TipObj).For((GameObject v) => v.activeSelf).ToExpression((PassportTaskItemData vm) => (int)vm.PassportTaskState == 2);
		bindingSet.Bind(finishObj).For((GameObject v) => v.activeSelf).ToExpression((PassportTaskItemData vm) => (int)vm.PassportTaskState == 3);
		bindingSet.Bind(jumpObj).For((GameObject v) => v.activeSelf).ToExpression((PassportTaskItemData vm) => (int)vm.PassportTaskState == 1);
		bindingSet.Bind(getRewardObj).For((GameObject v) => v.activeSelf).ToExpression((PassportTaskItemData vm) => (int)vm.PassportTaskState == 0);
		bindingSet.Bind(this).For((PassportTaskItem v) => v.PlayTaskComplete).To((PassportTaskItemData vm) => vm.PlayCompleteEffectRequest);
		bindingSet.Build();
	}

	private void PlayTaskComplete(object sender, InteractionEventArgs e)
	{
		if (taskCompleteEffect != null)
		{
			taskCompleteEffect.Hide();
			taskCompleteEffect.Play();
		}
	}

	public void RefreshTaskItem(PassportTaskItemData viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
	}
}
