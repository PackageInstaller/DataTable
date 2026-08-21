using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class SectionFinishWindow : UGuiWindow
{
	public TextMeshProUGUI taskTitle;

	public TextMeshProUGUI sectionName;

	public KnapsackItemNew rewardPrefab;

	public RectTransform taskRewardRoot;

	public Button clickButton;

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
	private int rowCount = 8;

	public bool IsClicked;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<TaskDataViewModel>();
		BindingSet<SectionFinishWindow, TaskDataViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(taskTitle).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((TaskDataViewModel vm) => vm.TaskTitle);
		bindingSet.Bind<TextMeshProUGUI>(sectionName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((TaskDataViewModel vm) => vm.TaskName);
		bindingSet.Bind().For((SectionFinishWindow v) => v.OnCloseRequest).To((TaskDataViewModel vm) => vm.OnCloseRequest);
		clickButton.onClick.AddListener(OnClickButton);
		List<KnapsackItemViewModel> taskRewardVM = viewModel.GetTaskRewardVM(null);
		for (int num = 0; num < taskRewardVM.Count; num++)
		{
			KnapsackItemNew knapsackItemNew = UnityEngine.Object.Instantiate(rewardPrefab, taskRewardRoot, worldPositionStays: true);
			knapsackItemNew.Init(taskRewardVM[num]);
			if (num / rowCount == 0)
			{
				knapsackItemNew.RectTransform.anchoredPosition = GetItemPosition(num, (taskRewardVM.Count - rowCount > 0) ? rowCount : taskRewardVM.Count);
			}
			else
			{
				knapsackItemNew.RectTransform.anchoredPosition = GetItemPosition(num, taskRewardVM.Count - rowCount);
			}
			knapsackItemNew.gameObject.SetActive(value: true);
		}
		IsClicked = false;
		bindingSet.Build();
	}

	private Vector3 GetItemPosition(int index, int Count)
	{
		return new Vector3(GameEntry.UI.RootTransform.sizeDelta.x / 2f + spaceX * ((float)index % (float)rowCount) - (float)Count * size / 2f, (0f - spaceY) * (float)(index / rowCount), 0f) + startPosition;
	}

	public void OnClickButton()
	{
		if (!IsClicked)
		{
			IsClicked = true;
		}
	}

	private void OnCloseRequest(object sender, InteractionEventArgs e)
	{
		Close();
	}
}
