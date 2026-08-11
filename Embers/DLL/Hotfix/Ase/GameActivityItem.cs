using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GameActivityItem : UGuiView
{
	[SerializeField]
	private GameObject redPoint;

	[SerializeField]
	private GameObject normal;

	[SerializeField]
	private TextMeshProUGUI taskComplete;

	[SerializeField]
	private TextMeshProUGUI taskName;

	[SerializeField]
	private Image rewardImg;

	[SerializeField]
	private TextMeshProUGUI rewardCount;

	[SerializeField]
	private GameObject rewardFinish;

	[SerializeField]
	private Button stateBtn;

	[SerializeField]
	private TextMeshProUGUI stateText;

	[SerializeField]
	private GameObject stateJump;

	[SerializeField]
	private GameObject stateComplete;

	[SerializeField]
	private GameObject stateFinish;

	[SerializeField]
	private Button openPropBtn;

	private GameActivityItemData viewModel;

	public void Init(GameActivityItemData viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<GameActivityItem, GameActivityItemData> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(redPoint).For((GameObject v) => v.activeSelf).ToExpression((GameActivityItemData vm) => vm.TaskState == 3);
		bindingSet.Bind(normal).For((GameObject v) => v.activeSelf).ToExpression((GameActivityItemData vm) => vm.TaskState != 3);
		bindingSet.Bind<TextMeshProUGUI>(taskComplete).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GameActivityItemData vm) => vm.CompleteText);
		bindingSet.Bind<TextMeshProUGUI>(taskName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GameActivityItemData vm) => vm.TaskName);
		bindingSet.Bind(rewardImg).For((Image v) => v.sprite).ToExpression((GameActivityItemData vm) => vm.IconPath)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(rewardCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GameActivityItemData vm) => vm.RewardCount);
		bindingSet.Bind(rewardFinish).For((GameObject v) => v.activeSelf).ToExpression((GameActivityItemData vm) => vm.TaskState == 0);
		bindingSet.Bind(stateBtn).For((Button v) => v.onClick).To((GameActivityItemData vm) => vm.OnClickCmd);
		bindingSet.Bind<TextMeshProUGUI>(stateText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GameActivityItemData vm) => vm.StateText);
		bindingSet.Bind(stateJump).For((GameObject v) => v.activeSelf).ToExpression((GameActivityItemData vm) => vm.TaskState == 1);
		bindingSet.Bind(stateComplete).For((GameObject v) => v.activeSelf).ToExpression((GameActivityItemData vm) => vm.TaskState == 3);
		bindingSet.Bind(stateFinish).For((GameObject v) => v.activeSelf).ToExpression((GameActivityItemData vm) => vm.TaskState == 0);
		bindingSet.Bind(openPropBtn).For((Button v) => v.onClick).To((GameActivityItemData vm) => vm.OpenProp);
		bindingSet.Build();
	}

	public void RefreshGameActivityItem(GameActivityItemData data)
	{
		viewModel = data;
		this.SetDataContext(data);
	}
}
