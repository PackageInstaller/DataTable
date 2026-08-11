using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class TaskFinishWindow : UGuiWindow
{
	public TextMeshProUGUI taskName;

	public Transform taskLabelRoot;

	public KnapsackItemNew rewardPrefab;

	public AnimatorAnimation enterAnimation;

	public RectTransform taskRewardRoot;

	private TaskDataViewModel viewModel;

	[SerializeField]
	private Vector3 startPosition;

	[SerializeField]
	private float size = 192f;

	[SerializeField]
	private float spaceX = 188f;

	[SerializeField]
	private float spaceY = 176f;

	[SerializeField]
	private int rowCount = 6;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<TaskDataViewModel>();
		BindingSet<TaskFinishWindow, TaskDataViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(taskName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((TaskDataViewModel vm) => vm.TaskName);
		bindingSet.Bind().For((TaskFinishWindow v) => v.OnCloseRequest).To((TaskDataViewModel vm) => vm.OnCloseRequest);
		List<KnapsackItemViewModel> taskRewardVM = viewModel.GetTaskRewardVM(null);
		for (int num = 0; num < taskRewardVM.Count; num++)
		{
			KnapsackItemNew knapsackItemNew = UnityEngine.Object.Instantiate(rewardPrefab, taskRewardRoot, worldPositionStays: true);
			knapsackItemNew.Init(taskRewardVM[num]);
			if (num / rowCount == 0)
			{
				knapsackItemNew.RectTransform.anchoredPosition = GetItemPosition(num, (taskRewardVM.Count - 6 > 0) ? 6 : taskRewardVM.Count);
			}
			else
			{
				knapsackItemNew.RectTransform.anchoredPosition = GetItemPosition(num, taskRewardVM.Count - 6);
			}
			knapsackItemNew.gameObject.SetActive(value: true);
		}
		enterAnimation.animName = ((taskRewardVM.Count <= 6) ? "enter" : "enter2");
		bindingSet.Build();
	}

	private Vector3 GetItemPosition(int index, int Count)
	{
		return new Vector3(GameEntry.UI.RootTransform.sizeDelta.x / 2f + spaceX * ((float)index % (float)rowCount) - (float)Count * size / 2f, (0f - spaceY) * (float)(index / rowCount), 0f) + startPosition;
	}

	private void OnCloseRequest(object sender, InteractionEventArgs e)
	{
		Close();
	}
}
