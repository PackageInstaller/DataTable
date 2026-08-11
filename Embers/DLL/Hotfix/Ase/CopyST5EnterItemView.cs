using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CopyST5EnterItemView : UGuiView
{
	public TeamBPConfigView teamBpConfigView;

	public Transform teamRoot;

	public Transform teamListRoot;

	public Transform highlightRoot;

	public Transform blockRoot;

	public LoopListView2 heroList;

	private bool isBlock;

	public Button BtnReset;

	private CopyST5EnterItemViewModel viewModel;

	public CopyST5EnterItemViewModel ViewModel
	{
		get
		{
			return viewModel;
		}
		set
		{
			if (viewModel == null)
			{
				OnInit(value);
			}
			else
			{
				RefreshData(value);
			}
		}
	}

	public bool IsBlock
	{
		get
		{
			return isBlock;
		}
		set
		{
			isBlock = value;
			BtnReset.gameObject.SetActive(isBlock);
			blockRoot.gameObject.SetActive(isBlock);
		}
	}

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<CopyST5EnterItemViewModel>(userData);
		BindingSet<CopyST5EnterItemView, CopyST5EnterItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((CopyST5EnterItemView v) => v.OnOpt).To((CopyST5EnterItemViewModel vm) => vm.OptRequest);
		bindingSet.Bind(BtnReset).For((Button v) => v.onClick).To((CopyST5EnterItemViewModel vm) => vm.OptCommand)
			.CommandParameter("ResetTeam");
		bindingSet.Bind(this).For((CopyST5EnterItemView v) => v.IsBlock).To((CopyST5EnterItemViewModel vm) => vm.IsBlock);
		bindingSet.Build();
		heroList.InitListView(viewModel.TeamItemList.Count, OnGetTeamItemByIndex);
		teamBpConfigView.Init(viewModel.BpConfigViewModel);
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<CopyST5EnterItemViewModel>(userData);
		this.SetDataContext(viewModel);
		heroList.SetListItemCount(viewModel.TeamItemList.Count);
		heroList.RefreshAllShownItem();
		teamBpConfigView.RefreshData(viewModel.BpConfigViewModel);
	}

	private LoopListViewItem2 OnGetTeamItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.TeamItemList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("TeamItem");
		if (loopListViewItem != null)
		{
			CopyTeamItemView component = loopListViewItem.GetComponent<CopyTeamItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.TeamItemList[index]);
			}
			else
			{
				component.RefreshData(viewModel.TeamItemList[index]);
			}
			component.CurIndex = index;
		}
		return loopListViewItem;
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	private void SettleOpt(string optName)
	{
		if ("HighlightTeam".Equals(optName))
		{
			heroList.transform.SetParent(highlightRoot);
		}
		else if ("ResetTeam".Equals(optName))
		{
			heroList.transform.SetParent(teamListRoot);
		}
	}
}
