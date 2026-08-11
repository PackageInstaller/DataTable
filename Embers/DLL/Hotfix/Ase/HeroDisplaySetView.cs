using System;
using System.Collections.Generic;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroDisplaySetView : UGuiView
{
	[SerializeField]
	private RectTransform subTabRoot;

	[SerializeField]
	private TabItem subTabTpl;

	[SerializeField]
	private LoopGridView loopGridView;

	[SerializeField]
	private CanvasGroup heroFrameInfoPart;

	[SerializeField]
	private HeroFrameItem selectedItem;

	[SerializeField]
	private TextMeshProUGUI selectName;

	[SerializeField]
	private GameObject expirePart;

	[SerializeField]
	private TextMeshProUGUI expireText;

	[SerializeField]
	private GameObject expireIcon;

	[SerializeField]
	private GameObject sourcePart;

	[SerializeField]
	private TextMeshProUGUI sourceText;

	[SerializeField]
	private TextMeshProUGUI descText;

	[SerializeField]
	private CanvasGroup heroFrameSetPart;

	[SerializeField]
	private HeroFrameSetItem frameSetItem1;

	[SerializeField]
	private HeroFrameSetItem frameSetItem2;

	[SerializeField]
	private HeroFrameSetItem frameSetItem3;

	[SerializeField]
	private Button btnJump;

	[SerializeField]
	private string jumpWindow;

	[SerializeField]
	private List<int> jumpParams;

	private GameObjectPool _subTabItemPool;

	private HeroDisplaySetViewModel _viewModel;

	protected override void OnInit(object userData)
	{
		_subTabItemPool = new GameObjectPool(subTabTpl.gameObject, subTabRoot);
		base.OnInit(userData);
		_viewModel = GetUserData<HeroDisplaySetViewModel>(userData);
		BindingSet<HeroDisplaySetView, HeroDisplaySetViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((HeroDisplaySetView v) => v.OnSubTabChanged).To((HeroDisplaySetViewModel vm) => vm.SubTabChangedRst);
		bindingSet.Bind().For((HeroDisplaySetView v) => v.OnDataListChanged).To((HeroDisplaySetViewModel vm) => vm.DataListChangeRst);
		bindingSet.Bind().For((HeroDisplaySetView v) => v.RefreshSelectInfo).To((HeroDisplaySetViewModel vm) => vm.CurSelectChangedRst);
		bindingSet.Build();
		if (btnJump != null)
		{
			JumpWindowParams param = new JumpWindowParams(jumpWindow, jumpParams);
			btnJump.onClick.AddListener(delegate
			{
				_viewModel.ItemOnClick(param);
			});
		}
		OnInit();
		InitSubTabs();
		loopGridView.InitGridView(_viewModel.GetDisplayDataCount(), OnGetItemByIndex);
		UpdateUiLayoutBySubTab();
		InitInfo();
	}

	private void OnInit()
	{
		frameSetItem1.Init(_viewModel.FrameSetItemDataList[0]);
		frameSetItem2.Init(_viewModel.FrameSetItemDataList[1]);
		frameSetItem3.Init(_viewModel.FrameSetItemDataList[2]);
	}

	private void InitSubTabs()
	{
		for (int i = 0; i < _viewModel.SubTabItemDataList.Count; i++)
		{
			TabItemData tabItemData = _viewModel.SubTabItemDataList[i];
			TabItem component = _subTabItemPool.Allocate(out var newCreate).GetComponent<TabItem>();
			if (newCreate)
			{
				component.Init(tabItemData);
			}
			else
			{
				component.SetDataContext(tabItemData);
			}
			component.transform.SetSiblingIndex(subTabRoot.childCount - 1);
			component.GetComponent<UIRedPoint>()?.Dispose();
			component.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.HeroCardFrame).SetFuncOnMessage((RedPointMessage msg) => (Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.GetItemList(RoleDecorateEnum.CardFrame) ?? new List<RoleDecorateData>()).Exists((RoleDecorateData p) => p.isNew))
				.Invoke();
		}
	}

	private void InitInfo()
	{
		RefreshSelectInfo();
	}

	private LoopGridViewItem OnGetItemByIndex(LoopGridView arg1, int dataIndex, int row, int column)
	{
		if (_viewModel.CurSubTabEnum == HeroDisplaySetViewModel.SubTabEnum.Frame)
		{
			return GetFrameItem(arg1, dataIndex, row, column);
		}
		return null;
	}

	private LoopGridViewItem GetFrameItem(LoopGridView arg1, int dataIndex, int row, int column)
	{
		List<HeroFrameItemData> frameItemDataList = _viewModel.FrameItemDataList;
		if (dataIndex < 0 || dataIndex >= frameItemDataList.Count)
		{
			return null;
		}
		HeroFrameItemData data = frameItemDataList[dataIndex];
		if (data == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = loopGridView.NewListViewItem("HeroFrameItem");
		HeroFrameItem component = loopGridViewItem.GetComponent<HeroFrameItem>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(data);
		}
		else
		{
			component.RefreshData(data);
		}
		if (_viewModel.CurSelectFrameData != null)
		{
			data.Selected = data.Data.id == _viewModel.CurSelectFrameData.id;
		}
		else if (dataIndex == 0)
		{
			data.OnItemClick();
		}
		loopGridViewItem.GetComponent<UIRedPoint>()?.Dispose();
		loopGridViewItem.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.HeroCardFrame).SetFuncOnMessage((RedPointMessage msg) => (Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.GetItemList(RoleDecorateEnum.CardFrame) ?? new List<RoleDecorateData>()).Find((RoleDecorateData p) => p.id == data.Data.id)?.isNew ?? false)
			.Invoke();
		return loopGridViewItem;
	}

	private void OnSubTabChanged(object sender, InteractionEventArgs e)
	{
		loopGridView.SetListItemCount(_viewModel.GetDisplayDataCount());
		loopGridView.RefreshAllShownItem();
		UpdateUiLayoutBySubTab();
	}

	private void OnDataListChanged(object sender, InteractionEventArgs e)
	{
		HeroDisplaySetViewModel.SubTabEnum subTabEnum = (HeroDisplaySetViewModel.SubTabEnum)e.Context;
		if (_viewModel.CurSubTabEnum == subTabEnum)
		{
			loopGridView.SetListItemCount(_viewModel.GetDisplayDataCount());
			loopGridView.RefreshAllShownItem();
		}
	}

	private void UpdateUiLayoutBySubTab()
	{
		HeroDisplaySetViewModel.SubTabEnum curSubTabEnum = _viewModel.CurSubTabEnum;
		heroFrameSetPart.alpha = ((curSubTabEnum == HeroDisplaySetViewModel.SubTabEnum.Frame) ? 1 : 0);
		heroFrameSetPart.blocksRaycasts = curSubTabEnum == HeroDisplaySetViewModel.SubTabEnum.Frame;
		int displayDataCount = _viewModel.GetDisplayDataCount();
		heroFrameInfoPart.alpha = ((curSubTabEnum == HeroDisplaySetViewModel.SubTabEnum.Frame && displayDataCount > 0) ? 1 : 0);
		heroFrameInfoPart.blocksRaycasts = curSubTabEnum == HeroDisplaySetViewModel.SubTabEnum.Frame && displayDataCount > 0;
	}

	private void RefreshSelectInfo(object sender = null, InteractionEventArgs e = null)
	{
		if (_viewModel.CurSubTabEnum != HeroDisplaySetViewModel.SubTabEnum.Frame || _viewModel.CurSelectFrameData == null)
		{
			return;
		}
		if (!selectedItem.IsInitHandlerCalled)
		{
			selectedItem.Init(new HeroFrameItemData(_viewModel));
		}
		selectedItem.ViewModel.RefreshData(_viewModel.CurSelectFrameData);
		DRHeroCardFrame dataRow = GameEntry.DataTable.GetDataRow<DRHeroCardFrame>(_viewModel.CurSelectFrameData.id);
		if (dataRow == null)
		{
			return;
		}
		((TMP_Text)selectName).text = dataRow.Name;
		((TMP_Text)sourceText).text = dataRow.AppTxt;
		((TMP_Text)descText).text = dataRow.BgsTxt.Replace("\\n", "\n");
		long expireTime = _viewModel.CurSelectFrameData.expireTime;
		if (expireTime < 0)
		{
			expirePart.SetActive(value: false);
			sourcePart.SetActive(value: true);
			return;
		}
		if (expireTime == 0L)
		{
			((TMP_Text)expireText).text = "永久";
			expirePart.SetActive(value: true);
			expireIcon.SetActive(value: false);
			sourcePart.SetActive(value: false);
			return;
		}
		DateTime curServerDateTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerDateTime();
		DateTime dateTime = Utility.DateTime.UnixTimestampToDateTime(expireTime);
		if (DateTime.Compare(curServerDateTime, dateTime) >= 0)
		{
			expirePart.SetActive(value: false);
			return;
		}
		TimeSpan timeSpan = dateTime - curServerDateTime;
		((TMP_Text)expireText).text = $"剩余时间：{timeSpan.Days}天{timeSpan.Hours}小时";
		expirePart.SetActive(value: true);
		expireIcon.SetActive(value: true);
		sourcePart.SetActive(value: false);
	}
}
