using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CopySelectWindow : CopyPlayUnlockEffectWindow
{
	public Animator animator;

	public string darkAni;

	public string lightAni;

	public RectTransform darkPanel;

	public RectTransform lightPanel;

	public Button btnBack;

	public GameObject lightMask;

	public Button btnLight;

	public GameObject red1;

	public GameObject red2;

	public GameObject darkMask;

	public Button btnDark;

	public Button btnTrain;

	public LoopListView2 lightList;

	public LoopListView2 darkList;

	public ViewSOControl soControl;

	private CopySelectViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<CopySelectViewModel>();
		BindingSet<CopySelectWindow, CopySelectViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((CopySelectWindow v) => v.OnDismissRequest).To((CopySelectViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((CopySelectWindow v) => v.OpenUguiWindow).To((CopySelectViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((CopySelectWindow v) => v.OnOpt).To((CopySelectViewModel vm) => vm.OptRequest);
		bindingSet.Bind(red1).For((GameObject v) => v.activeSelf).To((CopySelectViewModel vm) => vm.Red1.Red);
		bindingSet.Bind(red2).For((GameObject v) => v.activeSelf).To((CopySelectViewModel vm) => vm.Red2.Red);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((CopySelectViewModel vm) => vm.Close);
		bindingSet.Bind(btnLight).For((Button v) => v.onClick).To((CopySelectViewModel vm) => vm.OptCommand)
			.CommandParameter("OpenLight");
		bindingSet.Bind(btnDark).For((Button v) => v.onClick).To((CopySelectViewModel vm) => vm.OptCommand)
			.CommandParameter("OpenDark");
		bindingSet.Bind(btnTrain).For((Button v) => v.onClick).To((CopySelectViewModel vm) => vm.OptCommand)
			.CommandParameter("OpenTrain");
		bindingSet.Build();
		darkMask.SetActive(value: true);
		lightList.InitListView(viewModel.CgroupVms1.Count, OnGetLightItemByIndex);
		darkList.InitListView(viewModel.CgroupVms2.Count, OnGetDarkItemByIndex);
	}

	protected override void OnShow()
	{
		base.OnShow();
		if (viewModel.IsLight)
		{
			SettleOpt("OpenLight");
			darkPanel.gameObject.SetActive(value: false);
			return;
		}
		lightMask.SetActive(value: true);
		darkMask.SetActive(value: false);
		darkPanel.anchorMax = new Vector2(1f, 1f);
		darkPanel.anchorMin = new Vector2(0f, 0f);
		viewModel.EnableOpt(isLight: false);
		lightPanel.gameObject.SetActive(value: false);
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	private void SettleOpt(string optName)
	{
		if ("OpenLight".Equals(optName))
		{
			lightMask.SetActive(value: false);
			darkMask.SetActive(value: true);
			animator.Play(lightAni);
			viewModel.EnableOpt(isLight: true);
			OnOpenPlayAniMask();
		}
		else if ("OpenDark".Equals(optName))
		{
			lightMask.SetActive(value: true);
			darkMask.SetActive(value: false);
			animator.Play(darkAni);
			viewModel.EnableOpt(isLight: false);
			OnOpenPlayAniMask();
		}
		else if ("PlayUnlockEffect".Equals(optName))
		{
			OnOpenPlayAniMask();
		}
	}

	private LoopListViewItem2 OnGetLightItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.CgroupVms1.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("CopyGroupItemView");
		if (loopListViewItem != null)
		{
			CopyGroupItemView component = loopListViewItem.GetComponent<CopyGroupItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.CgroupVms1[index]);
				component.AddSOControl(soControl);
			}
			else
			{
				component.RefreshData(viewModel.CgroupVms1[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetDarkItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.CgroupVms2.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("CopyGroupItemView");
		if (loopListViewItem != null)
		{
			CopyGroupItemView component = loopListViewItem.GetComponent<CopyGroupItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.CgroupVms2[index]);
				component.AddSOControl(soControl);
			}
			else
			{
				component.RefreshData(viewModel.CgroupVms2[index]);
			}
		}
		return loopListViewItem;
	}

	public override bool CheckNeedPlayEffect()
	{
		return viewModel.CheckNeedPlayEffect();
	}

	public override void PlayUnlockEffect()
	{
		viewModel.PlayUnlockEffect();
	}
}
