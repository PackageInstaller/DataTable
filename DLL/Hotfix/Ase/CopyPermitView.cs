using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CopyPermitView : UGuiView
{
	public Button btn;

	public GameObject red;

	public Button btnClose;

	public TextMeshProUGUI curLev;

	public TextMeshProUGUI curDesc;

	public LoopListView2 taskList;

	public GameObject completeRoot1;

	public GameObject bigRoot1;

	public GameObject bigRoot2;

	public GameObject smallRoot1;

	private CopyPermitViewModel viewModel;

	protected override void OnInit(object userData)
	{
		if (viewModel != null)
		{
			RefreshData(userData);
			return;
		}
		viewModel = GetUserData<CopyPermitViewModel>(userData);
		this.CreateBindingSet(viewModel).Build();
		bigRoot1.gameObject.SetActive(value: false);
		bigRoot2.gameObject.SetActive(value: false);
		smallRoot1.gameObject.SetActive(value: true);
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		SettleOpt("RefreshAllPermit");
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	private void SettleOpt(string optName)
	{
		if ("OnOpenBig".Equals(optName))
		{
			if (viewModel.IsAllComplete)
			{
				((Component)(object)curDesc).gameObject.SetActive(value: false);
				smallRoot1.gameObject.SetActive(value: false);
				bigRoot2.gameObject.SetActive(value: true);
				bigRoot1.gameObject.SetActive(value: false);
				completeRoot1.gameObject.SetActive(value: true);
				return;
			}
			((Component)(object)curDesc).gameObject.SetActive(value: true);
			bigRoot1.gameObject.SetActive(value: true);
			bigRoot2.gameObject.SetActive(value: true);
			smallRoot1.gameObject.SetActive(value: false);
			completeRoot1.gameObject.SetActive(value: false);
			if (taskList.IsInited)
			{
				taskList.SetListItemCount(viewModel.TaskList.Count);
				taskList.RefreshAllShownItem();
			}
			else
			{
				taskList.InitListView(viewModel.TaskList.Count, OnGetTaskItemByIndex);
			}
		}
		else if ("OnCloseBig".Equals(optName))
		{
			if (viewModel.IsAllComplete)
			{
				smallRoot1.gameObject.SetActive(value: true);
				bigRoot2.gameObject.SetActive(value: false);
				bigRoot1.gameObject.SetActive(value: false);
				completeRoot1.gameObject.SetActive(value: false);
			}
			else
			{
				bigRoot1.gameObject.SetActive(value: false);
				bigRoot2.gameObject.SetActive(value: false);
				smallRoot1.gameObject.SetActive(value: true);
				completeRoot1.gameObject.SetActive(value: false);
			}
		}
		else if ("RefreshAllPermit".Equals(optName) && viewModel != null)
		{
			if (taskList.IsInited)
			{
				taskList.SetListItemCount(viewModel.TaskList.Count);
				taskList.RefreshAllShownItem();
			}
			else
			{
				taskList.InitListView(viewModel.TaskList.Count, OnGetTaskItemByIndex);
			}
		}
	}

	private LoopListViewItem2 OnGetTaskItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.TaskList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("PermitItemView");
		if (loopListViewItem != null)
		{
			PermitTaskItemView component = loopListViewItem.GetComponent<PermitTaskItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.TaskList[index]);
			}
			else
			{
				component.RefreshData(viewModel.TaskList[index]);
			}
		}
		return loopListViewItem;
	}
}
