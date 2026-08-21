#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroSkinTlWindow : UGuiWindow
{
	[SerializeField]
	private List<Button> btnCloses;

	[SerializeField]
	private List<string> skinItemNameList;

	[SerializeField]
	private LoopListView2 skinList;

	[SerializeField]
	private LoopListView2 tlList;

	[SerializeField]
	private RectTransform tlGroupPanel;

	[SerializeField]
	private GameObject skinInfo;

	[SerializeField]
	private TextMeshProUGUI skinName;

	[SerializeField]
	private TextMeshProUGUI skinDesc;

	[SerializeField]
	private Image skinIcon;

	[SerializeField]
	private Button btnSave;

	[SerializeField]
	private GameObject saveGo;

	[SerializeField]
	private GameObject savedGo;

	[SerializeField]
	private GameObject main;

	[SerializeField]
	private GameObject noTl;

	private HeroSkinTlViewModel _viewModel;

	private Dictionary<string, GameObject> _tlGroupPrefabs = new Dictionary<string, GameObject>();

	private bool _loadTlEnabled = true;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<HeroSkinTlViewModel>();
		BindingSet<HeroSkinTlWindow, HeroSkinTlViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((HeroSkinTlWindow v) => v.OpenUguiWindow).To((HeroSkinTlViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind().For((HeroSkinTlWindow v) => v.OnDismissRequest).To((HeroSkinTlViewModel vm) => vm.DismissRequest);
		if (btnCloses != null)
		{
			foreach (Button btnClose in btnCloses)
			{
				if (btnClose != null)
				{
					bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((HeroSkinTlViewModel vm) => vm.Close);
				}
			}
		}
		bindingSet.Bind(skinInfo).For((GameObject v) => v.activeSelf).To((HeroSkinTlViewModel vm) => vm.ShowSkinInfo);
		bindingSet.Bind<TextMeshProUGUI>(skinName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkinTlViewModel vm) => vm.SkinName);
		bindingSet.Bind<TextMeshProUGUI>(skinDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkinTlViewModel vm) => vm.SkinDesc);
		bindingSet.Bind(skinIcon).For((Image v) => v.sprite).To((HeroSkinTlViewModel vm) => vm.SkinIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(saveGo).For((GameObject v) => v.activeSelf).ToExpression((HeroSkinTlViewModel vm) => !vm.SkinSaved);
		bindingSet.Bind(savedGo).For((GameObject v) => v.activeSelf).To((HeroSkinTlViewModel vm) => vm.SkinSaved);
		bindingSet.Bind(btnSave).For((Button v) => v.onClick).To((HeroSkinTlViewModel vm) => vm.SetSkinSaveCmd);
		bindingSet.Bind().For((HeroSkinTlWindow v) => v.RefreshTlList).To((HeroSkinTlViewModel vm) => vm.RefreshTlListRst);
		bindingSet.Bind().For((HeroSkinTlWindow v) => v.LoadTlGroup).To((HeroSkinTlViewModel vm) => vm.LoadTlGroupRst);
		bindingSet.Build();
		skinList.InitListView(_viewModel.SkinList.Count, OnGetSkinItemByIndex);
		tlList.InitListView(_viewModel.TlGroupList.Count, OnGetTlItemByIndex);
		RefreshTlList();
		if (main != null)
		{
			main.SetActive(_viewModel.SkinList.Count > 0);
		}
		if (noTl != null)
		{
			noTl.SetActive(_viewModel.SkinList.Count <= 0);
		}
	}

	private LoopListViewItem2 OnGetSkinItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= _viewModel.SkinList.Count)
		{
			return null;
		}
		string itemPrefabName = "SkinItem";
		if (skinItemNameList != null && skinItemNameList.Count > 0)
		{
			int index2 = (index + skinItemNameList.Count) % skinItemNameList.Count;
			itemPrefabName = skinItemNameList[index2];
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem(itemPrefabName);
		if (loopListViewItem != null)
		{
			HeroSkinTlItem1 component = loopListViewItem.GetComponent<HeroSkinTlItem1>();
			HeroSkinTlItemData1 heroSkinTlItemData = _viewModel.SkinList[index];
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(heroSkinTlItemData);
			}
			else
			{
				component.RefreshData(heroSkinTlItemData);
			}
			if (_viewModel.CurSkinItemData == null)
			{
				if (index == 0)
				{
					heroSkinTlItemData.OnItemClick();
				}
			}
			else
			{
				heroSkinTlItemData.Selected = heroSkinTlItemData.DrSkinMessage.Id == _viewModel.CurSkinItemData.DrSkinMessage.Id;
			}
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetTlItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= _viewModel.TlGroupList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("TlItem2");
		if (loopListViewItem != null)
		{
			HeroSkinTlItem2 component = loopListViewItem.GetComponent<HeroSkinTlItem2>();
			HeroSkinTlItemData2 userData = _viewModel.TlGroupList[index];
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(userData);
			}
			else
			{
				component.RefreshData(userData);
			}
		}
		return loopListViewItem;
	}

	private void RefreshTlList(object sender = null, InteractionEventArgs e = null)
	{
		tlList.SetListItemCount(_viewModel.TlGroupList.Count);
		tlList.RefreshAllShownItem();
	}

	private async void LoadTlGroup(object sender, InteractionEventArgs e)
	{
		if (!_loadTlEnabled || e == null)
		{
			return;
		}
		(int, string) tuple = ((int, string))e.Context;
		int groupId = tuple.Item1;
		string prefab = tuple.Item2;
		_loadTlEnabled = false;
		_tlGroupPrefabs.Values.ToList().ForEach(delegate(GameObject p)
		{
			p.SetActive(value: false);
		});
		GameObject panel = null;
		if (!_tlGroupPrefabs.TryGetValue(prefab, out panel))
		{
			try
			{
				panel = await InstantiateAsync(AssetUtility.GetUIFormAsset(prefab), tlGroupPanel);
				if (panel != null)
				{
					_tlGroupPrefabs.Add(prefab, panel);
				}
			}
			catch (Exception ex)
			{
				Log.Error(ex?.ToString() + ex.StackTrace);
			}
		}
		if (panel == null)
		{
			_loadTlEnabled = true;
			return;
		}
		HeroSkinTlItem3[] componentsInChildren = panel.GetComponentsInChildren<HeroSkinTlItem3>();
		if (componentsInChildren == null)
		{
			_loadTlEnabled = true;
			return;
		}
		List<HeroSkinTlItemData3> list = new List<HeroSkinTlItemData3>();
		List<DRHeroSkinTimeLine> list2 = GameEntry.DataTable.GetDataRows((DRHeroSkinTimeLine p) => p.ListID.Equals(groupId)).ToList();
		HeroSkinTlItem3[] array = componentsInChildren;
		foreach (HeroSkinTlItem3 item in array)
		{
			DRHeroSkinTimeLine dRHeroSkinTimeLine = list2.Find((DRHeroSkinTimeLine p) => p.Id.Equals(item.timelineId));
			if (dRHeroSkinTimeLine != null)
			{
				HeroSkinTlItemData3 heroSkinTlItemData = new HeroSkinTlItemData3(_viewModel, dRHeroSkinTimeLine);
				list.Add(heroSkinTlItemData);
				if (!item.initialized)
				{
					item.Init(heroSkinTlItemData);
				}
				else
				{
					item.RefreshData(heroSkinTlItemData);
				}
			}
		}
		_viewModel.TlItemList = list;
		_viewModel.RefreshTlItemState();
		panel.SetActive(value: true);
		_loadTlEnabled = true;
	}

	protected override void OnDestroy()
	{
		if (_tlGroupPrefabs != null)
		{
			foreach (GameObject item in _tlGroupPrefabs.Values.ToList())
			{
				UnityEngine.Object.DestroyImmediate(item);
			}
			_tlGroupPrefabs.Clear();
			_tlGroupPrefabs = null;
		}
		base.OnDestroy();
	}
}
