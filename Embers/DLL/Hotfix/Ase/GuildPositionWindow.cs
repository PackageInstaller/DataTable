using System;
using System.Collections.Generic;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GuildPositionWindow : UGuiWindow
{
	[SerializeField]
	private TabItem tabMember;

	[SerializeField]
	private TabItem tabPositionInfo;

	[SerializeField]
	private GameObject memberView;

	[SerializeField]
	private RectTransform masterRoot;

	[SerializeField]
	private TextMeshProUGUI masterCountText;

	[SerializeField]
	private RectTransform viceMasterRoot;

	[SerializeField]
	private TextMeshProUGUI viceMasterCountText;

	[SerializeField]
	private RectTransform excellentMemberRoot;

	[SerializeField]
	private TextMeshProUGUI excellentMemberCountText;

	[SerializeField]
	private PlayerItemBase memberItemTpl;

	[SerializeField]
	private GameObject emptyItemTpl;

	[SerializeField]
	private GameObject positionInfoView;

	[SerializeField]
	private int positionCount = 4;

	[SerializeField]
	private int permissionCount = 9;

	[SerializeField]
	private RectTransform checkGridRoot;

	[SerializeField]
	private Button btnOutside;

	[SerializeField]
	private Button btnClose;

	private GuildPositionViewModel _viewModel;

	private List<PlayerItemBase> _memberItems = new List<PlayerItemBase>();

	private List<GameObject> _emptyItems = new List<GameObject>();

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<GuildPositionViewModel>();
		BindingSet<GuildPositionWindow, GuildPositionViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((GuildPositionWindow v) => v.OnDismissRequest).To((GuildPositionViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((GuildPositionWindow v) => v.OpenUguiWindow).To((GuildPositionViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(btnOutside).For((Button v) => v.onClick).To((GuildPositionViewModel vm) => vm.Close);
		bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((GuildPositionViewModel vm) => vm.Close);
		bindingSet.Bind().For((GuildPositionWindow v) => v.OnTabClick).To((GuildPositionViewModel vm) => vm.TabOnCickRst);
		bindingSet.Build();
		InitTabs();
		InitMemberItems();
		InitCheckGrids();
		OnTabClick();
	}

	private void InitTabs()
	{
		tabMember.Init(new TabItemData(_viewModel, 1));
		tabPositionInfo.Init(new TabItemData(_viewModel, 2));
		if (_viewModel.CurTabIndex == 1)
		{
			tabMember.ViewModel.TabOnClick();
		}
		else if (_viewModel.CurTabIndex == 2)
		{
			tabPositionInfo.ViewModel.TabOnClick();
		}
	}

	private void InitMemberItems()
	{
		for (int i = 0; i < 1; i++)
		{
			if (_viewModel.MasterData != null)
			{
				PlayerItemBase playerItemBase = UnityEngine.Object.Instantiate(memberItemTpl, masterRoot);
				playerItemBase.Init(new PlayerItemBaseData(_viewModel, _viewModel.MasterData));
				playerItemBase.gameObject.SetActive(value: true);
				_memberItems.Add(playerItemBase);
			}
			else
			{
				GameObject gameObject = UnityEngine.Object.Instantiate(emptyItemTpl, masterRoot);
				gameObject.SetActive(value: true);
				_emptyItems.Add(gameObject);
			}
		}
		((TMP_Text)masterCountText).text = ((_viewModel.MasterData != null) ? "1/1" : "0/1");
		for (int j = 0; j < GuildDefinition.GetMaxViceMasterCount(_viewModel.MyGuildData.Level); j++)
		{
			if (_viewModel.ViceMasterData.Count > j)
			{
				PlayerItemBase playerItemBase2 = UnityEngine.Object.Instantiate(memberItemTpl, viceMasterRoot);
				playerItemBase2.Init(new PlayerItemBaseData(_viewModel, _viewModel.ViceMasterData[j]));
				playerItemBase2.gameObject.SetActive(value: true);
				_memberItems.Add(playerItemBase2);
			}
			else
			{
				GameObject gameObject2 = UnityEngine.Object.Instantiate(emptyItemTpl, viceMasterRoot);
				gameObject2.SetActive(value: true);
				_emptyItems.Add(gameObject2);
			}
		}
		((TMP_Text)viceMasterCountText).text = $"{_viewModel.ViceMasterData.Count}/{GuildDefinition.GetMaxViceMasterCount(_viewModel.MyGuildData.Level)}";
		for (int k = 0; k < GuildDefinition.GetMaxExcellentMemberCount(_viewModel.MyGuildData.Level); k++)
		{
			if (_viewModel.ExcellentMemberData.Count > k)
			{
				PlayerItemBase playerItemBase3 = UnityEngine.Object.Instantiate(memberItemTpl, excellentMemberRoot);
				playerItemBase3.Init(new PlayerItemBaseData(_viewModel, _viewModel.ExcellentMemberData[k]));
				playerItemBase3.gameObject.SetActive(value: true);
				_memberItems.Add(playerItemBase3);
			}
			else
			{
				GameObject gameObject3 = UnityEngine.Object.Instantiate(emptyItemTpl, excellentMemberRoot);
				gameObject3.SetActive(value: true);
				_emptyItems.Add(gameObject3);
			}
		}
		((TMP_Text)excellentMemberCountText).text = $"{_viewModel.ExcellentMemberData.Count}/{GuildDefinition.GetMaxExcellentMemberCount(_viewModel.MyGuildData.Level)}";
	}

	private void InitCheckGrids()
	{
		int num = 0;
		for (int i = 0; i < positionCount; i++)
		{
			for (int j = 0; j < permissionCount; j++)
			{
				if (!Enum.IsDefined(typeof(GuildDefinition.GuildPositions), i + 1) || !Enum.IsDefined(typeof(GuildDefinition.GuildPermissions), j) || checkGridRoot.childCount <= num)
				{
					return;
				}
				Transform child = checkGridRoot.GetChild(num);
				if (child != null)
				{
					child.gameObject.SetActive(GuildDefinition.CheckGuildMemberPermission((GuildDefinition.GuildPositions)(i + 1), (GuildDefinition.GuildPermissions)j));
				}
				num++;
			}
		}
	}

	private void OnTabClick(object sender = null, InteractionEventArgs e = null)
	{
		memberView.SetActive(_viewModel.CurTabIndex == 1);
		positionInfoView.SetActive(_viewModel.CurTabIndex == 2);
	}

	protected override void OnDestroy()
	{
		if (_memberItems != null)
		{
			for (int i = 0; i < _memberItems.Count; i++)
			{
				UnityEngine.Object.DestroyImmediate(_memberItems[i]);
				_memberItems[i] = null;
			}
			_memberItems = null;
		}
		if (_emptyItems != null)
		{
			for (int j = 0; j < _emptyItems.Count; j++)
			{
				UnityEngine.Object.DestroyImmediate(_emptyItems[j]);
				_emptyItems[j] = null;
			}
			_emptyItems = null;
		}
		base.OnDestroy();
	}
}
