using System.Collections.Generic;
using System.Reflection;
using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ArmourPresetApplyView : UGuiView
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private Button btnApply;

	[SerializeField]
	private LoopListView2 conflictList;

	[SerializeField]
	private float defaultPaddingLeft;

	private ArmourPresetApplyViewModel viewModel;

	private bool listInited;

	private static readonly BindingFlags PrivateInstance = BindingFlags.Instance | BindingFlags.NonPublic;

	private static readonly FieldInfo PaddingLeftField = typeof(LoopListView2).GetField("mPaddingLeft", PrivateInstance);

	private static readonly FieldInfo ItemPrefabDataListField = typeof(LoopListView2).GetField("mItemPrefabDataList", PrivateInstance);

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<ArmourPresetApplyViewModel>(userData);
		BindViewModel();
		RefreshView();
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		viewModel = GetUserData<ArmourPresetApplyViewModel>(userData);
		this.SetDataContext(viewModel);
		RefreshView();
	}

	private void BindViewModel()
	{
		if (viewModel != null)
		{
			BindingSet<ArmourPresetApplyView, ArmourPresetApplyViewModel> bindingSet = this.CreateBindingSet(viewModel);
			bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((ArmourPresetApplyViewModel vm) => ((OptionBase)vm).Close);
			bindingSet.Bind(btnApply).For((Button v) => v.onClick).To((ArmourPresetApplyViewModel vm) => vm.ConfirmApply);
			bindingSet.Bind(this).For((ArmourPresetApplyView v) => v.OnRefresh).To((ArmourPresetApplyViewModel vm) => vm.RefreshRequest);
			bindingSet.Build();
		}
	}

	private LoopListViewItem2 OnGetConflictItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.ConflictItems.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("ArmourPresetApplyItem");
		if (loopListViewItem == null)
		{
			return null;
		}
		ArmourPresetApplyItem component = loopListViewItem.GetComponent<ArmourPresetApplyItem>();
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			component.Init(viewModel.ConflictItems[index]);
		}
		else
		{
			component.RefreshData(viewModel.ConflictItems[index]);
		}
		return loopListViewItem;
	}

	private void OnRefresh(object sender, InteractionEventArgs e)
	{
		RefreshView();
	}

	private void RefreshView()
	{
		if (viewModel != null && !(conflictList == null))
		{
			RefreshListPaddingLeft();
			if (!listInited)
			{
				conflictList.InitListView(viewModel.ConflictItems.Count, OnGetConflictItemByIndex);
				listInited = true;
			}
			else
			{
				conflictList.SetListItemCount(viewModel.ConflictItems.Count);
				conflictList.RefreshAllShownItem();
			}
		}
	}

	private void RefreshListPaddingLeft()
	{
		if (!(conflictList == null) && !(PaddingLeftField == null))
		{
			float num = CalculatePaddingLeft();
			PaddingLeftField.SetValue(conflictList, num);
		}
	}

	private float CalculatePaddingLeft()
	{
		int num = viewModel?.ConflictItems.Count ?? 0;
		if (num <= 0)
		{
			return defaultPaddingLeft;
		}
		RectTransform conflictListViewport = GetConflictListViewport();
		float num2 = ((conflictListViewport == null) ? 0f : conflictListViewport.rect.width);
		if (num2 <= 0f)
		{
			return defaultPaddingLeft;
		}
		if (!TryGetConflictItemLayout(out var itemWidth, out var itemPadding) || itemWidth <= 0f)
		{
			return defaultPaddingLeft;
		}
		float num3 = itemWidth * (float)num + (float)Mathf.Max(0, num - 1) * itemPadding;
		if (num3 > num2)
		{
			return defaultPaddingLeft;
		}
		return Mathf.Max(0f, (num2 - num3) * 0.5f);
	}

	private RectTransform GetConflictListViewport()
	{
		ScrollRect component = conflictList.GetComponent<ScrollRect>();
		if (component != null && component.viewport != null)
		{
			return component.viewport;
		}
		return conflictList.transform as RectTransform;
	}

	private bool TryGetConflictItemLayout(out float itemWidth, out float itemPadding)
	{
		itemWidth = 0f;
		itemPadding = 0f;
		if (ItemPrefabDataListField == null)
		{
			return false;
		}
		if (!(ItemPrefabDataListField.GetValue(conflictList) is List<ItemPrefabConfData> { Count: >0 } list) || list[0]?.mItemPrefab == null)
		{
			return false;
		}
		RectTransform rectTransform = list[0].mItemPrefab.transform as RectTransform;
		if (rectTransform == null)
		{
			return false;
		}
		itemWidth = rectTransform.rect.width;
		itemPadding = list[0].mPadding;
		return true;
	}
}
