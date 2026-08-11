using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BuffDescWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	private BuffDescViewModel viewModel;

	public LoopListView2 BuffListView;

	public LoopListView2 BuffListPreView;

	public GameObject MoreBuffObj;

	private bool isShow;

	public bool IsShow
	{
		get
		{
			return isShow;
		}
		set
		{
			OnShowChange(value);
		}
	}

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<BuffDescViewModel>();
		InitListView();
		BindingSet<BuffDescWindow, BuffDescViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((BuffDescWindow v) => v.Refresh).To((BuffDescViewModel vm) => vm.UpdateDescRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((BuffDescViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind().For((BuffDescWindow v) => v.IsShow).To((BuffDescViewModel vm) => vm.IsVisible);
		bindingSet.Build();
	}

	private void InitListView()
	{
		BuffListView.InitListView(viewModel.BuffVMs.Count, OnGetAttributeItemByIndex);
		BuffListPreView.InitListView(GetPreviewCount(), OnGetAttributeIconItemByIndex);
	}

	private void OnShowChange(bool isShow)
	{
		base.gameObject.SetActive(isShow);
		if (isShow)
		{
			Refresh(null, null);
		}
	}

	private void Refresh(object sender, InteractionEventArgs e)
	{
		BuffListView.SetListItemCount(viewModel.BuffVMs.Count);
		BuffListView.RefreshAllShownItem();
		BuffListPreView.SetListItemCount(GetPreviewCount());
		BuffListPreView.RefreshAllShownItem();
	}

	private int GetPreviewCount()
	{
		int num = viewModel.BuffPre.Count;
		if (num != 8)
		{
			if (num > 8)
			{
				num = 7;
				MoreBuffObj.SetActive(value: true);
			}
			else
			{
				MoreBuffObj.SetActive(value: false);
			}
		}
		else
		{
			MoreBuffObj.SetActive(value: false);
		}
		return num;
	}

	private LoopListViewItem2 OnGetAttributeItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.BuffVMs.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("BuffDescItemView");
		if (loopListViewItem != null)
		{
			BuffDescItemView component = loopListViewItem.GetComponent<BuffDescItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.BuffVMs[index]);
			}
			else
			{
				component.RefreshData(viewModel.BuffVMs[index]);
			}
			component.SetDesText();
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetAttributeIconItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.BuffPre.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("BuffPreviewItemView");
		if (loopListViewItem != null)
		{
			BuffPreviewItemView component = loopListViewItem.GetComponent<BuffPreviewItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.BuffPre[index]);
			}
			else
			{
				component.RefreshData(viewModel.BuffPre[index]);
			}
		}
		return loopListViewItem;
	}
}
