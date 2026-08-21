using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GetErrorDialogWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private Button btnBack2;

	[SerializeField]
	private RectTransform rTF;

	[SerializeField]
	private LoopListView2 attachmentGetList;

	[SerializeField]
	private ListPaddingCal padding;

	private GetErrorDialogViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<GetErrorDialogViewModel>();
		BindingSet<GetErrorDialogWindow, GetErrorDialogViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((GetErrorDialogWindow v) => v.OnDismissRequest).To((GetErrorDialogViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((GetErrorDialogViewModel vm) => vm.Close);
		bindingSet.Bind(btnBack2).For((Button v) => v.onClick).To((GetErrorDialogViewModel vm) => vm.Close);
		bindingSet.Build();
		InitListParam();
	}

	public void InitListParam()
	{
		attachmentGetList.ArrangeType = padding.Cal(viewModel.AttachmentGetErrorList.Count, rTF.rect.width);
		attachmentGetList.InitListView(viewModel.AttachmentGetErrorList.Count, OnGetAttachmentGetItemByIndex);
	}

	private LoopListViewItem2 OnGetAttachmentGetItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.AttachmentGetErrorList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("PropItemLarge");
		if (loopListViewItem != null)
		{
			KnapsackItemNew component = loopListViewItem.GetComponent<KnapsackItemNew>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.AttachmentGetErrorList[index]);
			}
			else
			{
				component.RefreshData(viewModel.AttachmentGetErrorList[index]);
			}
		}
		return loopListViewItem;
	}
}
