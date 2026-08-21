using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class MultiRoomFunctionView : UGuiView
{
	[SerializeField]
	private GameObject viewObj;

	[SerializeField]
	private Button btnClose;

	[SerializeField]
	private LoopListView2 functionItemList;

	[SerializeField]
	private Transform viewPos;

	private MultiRoomFunctionViewModel viewModel;

	public void Init(MultiRoomFunctionViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<MultiRoomFunctionView, MultiRoomFunctionViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((MultiRoomFunctionViewModel vm) => vm.CloseView);
		bindingSet.Bind(this).For((MultiRoomFunctionView v) => v.UpdateFunctionList).To((MultiRoomFunctionViewModel vm) => vm.RefreshFunctionRequest);
		bindingSet.Bind(viewObj).For((GameObject v) => v.activeSelf).To((MultiRoomFunctionViewModel vm) => vm.IsOpen);
		bindingSet.Build();
		functionItemList.InitListView(viewModel.FunctionList.Count, OnGetFunctionItemByIndex);
	}

	private void UpdateFunctionList(object sender, InteractionEventArgs e)
	{
		functionItemList.SetListItemCount(viewModel.FunctionList.Count);
		functionItemList.RefreshAllShownItem();
		float x = viewModel.Position[0] + viewObj.GetComponent<RectTransform>().rect.width / 40f - viewObj.GetComponent<RectTransform>().rect.width / 2f;
		float y = viewModel.Position[1] + viewObj.GetComponent<RectTransform>().rect.height / 2f;
		viewPos.SetLocalPositionAndRotation(new Vector3(x, y), Quaternion.identity);
	}

	private LoopListViewItem2 OnGetFunctionItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.FunctionList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("FunctionItem");
		if (loopListViewItem != null)
		{
			TabItemNormal component = loopListViewItem.GetComponent<TabItemNormal>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.FunctionList[index]);
			}
			else
			{
				component.RefreshData(viewModel.FunctionList[index]);
			}
		}
		return loopListViewItem;
	}
}
