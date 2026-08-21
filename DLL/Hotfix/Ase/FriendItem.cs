using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class FriendItem : LoopListViewItem2
{
	[SerializeField]
	private Image bg;

	[SerializeField]
	private Image greyBg;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private Image headFrame;

	[SerializeField]
	private Button btn;

	[SerializeField]
	private Text nameText;

	[SerializeField]
	private Text level;

	[SerializeField]
	private Image statePoint;

	[SerializeField]
	private TextMeshProUGUI stateText;

	[SerializeField]
	private Button sendBtn;

	[SerializeField]
	private GameObject canSend;

	[SerializeField]
	private GameObject received;

	[SerializeField]
	private GameObject cantSend;

	[SerializeField]
	private GameObject selectedGo;

	private FriendItemData _viewModel;

	private Material _greyMaterial;

	public FriendItemData ViewModel => _viewModel;

	public void Init(FriendItemData data, Material greyMat)
	{
		_greyMaterial = greyMat;
		_viewModel = data;
		BindingSet<FriendItem, FriendItemData> bindingSet = this.CreateBindingSet(data);
		bindingSet.Bind(bg.gameObject).For((GameObject v) => v.activeSelf).To((FriendItemData vm) => vm.IsOnLine);
		bindingSet.Bind(greyBg.gameObject).For((GameObject v) => v.activeSelf).ToExpression((FriendItemData vm) => !vm.IsOnLine);
		bindingSet.Bind(selectedGo).For((GameObject v) => v.activeSelf).To((FriendItemData vm) => vm.Selected);
		bindingSet.Bind(icon).For((Image v) => v.sprite).To((FriendItemData vm) => vm.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(headFrame).For((Image v) => v.sprite).To((FriendItemData vm) => vm.IconFrame)
			.WithConversion("ItemIcon");
		bindingSet.Bind(nameText).For((Text v) => v.text).To((FriendItemData vm) => vm.Name);
		bindingSet.Bind(nameText).For((Text v) => v.color).To((FriendItemData vm) => vm.TextColor);
		bindingSet.Bind(level).For((Text v) => v.text).To((FriendItemData vm) => vm.Level);
		bindingSet.Bind(level).For((Text v) => v.color).To((FriendItemData vm) => vm.TextColor);
		bindingSet.Bind<TextMeshProUGUI>(stateText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((FriendItemData vm) => vm.State);
		bindingSet.Bind<TextMeshProUGUI>(stateText).For((Expression<Func<TextMeshProUGUI, Color>>)((TextMeshProUGUI v) => ((Graphic)v).color)).To((FriendItemData vm) => vm.StateColor);
		bindingSet.Bind(statePoint).For((Image v) => v.color).To((FriendItemData vm) => vm.StateColor);
		bindingSet.Bind(received).For((GameObject v) => v.activeSelf).ToExpression((FriendItemData vm) => vm.EnergyState == 1);
		bindingSet.Bind(canSend).For((GameObject v) => v.activeSelf).ToExpression((FriendItemData vm) => vm.EnergyState == 2);
		bindingSet.Bind(cantSend).For((GameObject v) => v.activeSelf).ToExpression((FriendItemData vm) => vm.EnergyState == 3);
		bindingSet.Bind(sendBtn).For((Button v) => v.onClick).To((FriendItemData vm) => vm.SendBtnClickCmd);
		bindingSet.Build();
		RefreshMaterials();
	}

	public void Refresh(FriendItemData data)
	{
		_viewModel = data;
		this.SetDataContext(data);
		RefreshMaterials();
	}

	private void RefreshMaterials()
	{
		Material material = ((_viewModel.FriendData.State == 4) ? _greyMaterial : null);
		icon.material = material;
		headFrame.material = material;
	}

	public void SetBtnOnClick(Action<FriendItem> action)
	{
		btn.onClick.RemoveAllListeners();
		btn.onClick.AddListener(delegate
		{
			action?.Invoke(this);
		});
	}

	public void SetSelected(bool selected)
	{
		_viewModel.SetSelected(selected);
	}
}
