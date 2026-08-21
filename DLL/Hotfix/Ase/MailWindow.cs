using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class MailWindow : UGuiWindow
{
	[SerializeField]
	private LoopGridView mailList;

	[SerializeField]
	private Button allGetBtn;

	[SerializeField]
	private Button allDelBtn;

	[SerializeField]
	private GameObject noSelected;

	[SerializeField]
	private GameObject noMails;

	[SerializeField]
	private GameObject main;

	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private Button btnBack1;

	[SerializeField]
	private MailDetailView detailView;

	[SerializeField]
	private RectTransform content;

	[SerializeField]
	private float contentOriY;

	private MailViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<MailViewModel>();
		BindingSet<MailWindow, MailViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((MailWindow v) => v.OnDismissRequest).To((MailViewModel vm) => vm.DismissRequest);
		bindingSet.Bind().For((MailWindow v) => v.OpenUguiWindow).To((MailViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((MailViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(btnBack1).For((Button v) => v.onClick).To((MailViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(allGetBtn).For((Button v) => v.onClick).To((MailViewModel vm) => vm.GetCmd);
		bindingSet.Bind(allDelBtn).For((Button v) => v.onClick).To((MailViewModel vm) => vm.DeleteCmd);
		bindingSet.Bind(noSelected).For((GameObject v) => v.activeSelf).ToExpression((MailViewModel vm) => !vm.IsSelected);
		bindingSet.Bind(noMails).For((GameObject v) => v.activeSelf).ToExpression((MailViewModel vm) => vm.IsEmpty);
		bindingSet.Bind(main).For((GameObject v) => v.activeSelf).ToExpression((MailViewModel vm) => !vm.IsEmpty);
		bindingSet.Bind().For((MailWindow v) => v.RefreshMails).To((MailViewModel vm) => vm.RefreshMailsRequest);
		bindingSet.Build();
	}

	protected override void OnShow()
	{
		base.OnShow();
		viewModel.OnOpen();
		detailView.Init(viewModel.DetailViewModel);
		mailList.InitGridView(viewModel.MailList.Count, OnGetMailItemByIndex);
	}

	private void RefreshMails(object sender, InteractionEventArgs e)
	{
		if (viewModel.MailList != null && mailList.MListViewInited)
		{
			mailList.SetListItemCount(viewModel.MailList.Count);
			mailList.RefreshAllShownItem();
			Vector2 anchoredPosition = content.anchoredPosition;
			content.anchoredPosition = new Vector2(anchoredPosition.x, contentOriY);
		}
	}

	private LoopGridViewItem OnGetMailItemByIndex(LoopGridView gridView, int index, int row, int column)
	{
		if (index < 0 || index >= viewModel?.MailList?.Count)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = gridView.NewListViewItem("MailItem");
		if (loopGridViewItem != null)
		{
			MailItem component = loopGridViewItem.GetComponent<MailItem>();
			if (component == null)
			{
				return null;
			}
			if (!loopGridViewItem.IsInitHandlerCalled)
			{
				loopGridViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.MailList[index]);
			}
			else
			{
				component.RefreshData(viewModel.MailList[index]);
			}
		}
		return loopGridViewItem;
	}

	protected override void OnDismiss()
	{
		base.OnDismiss();
		detailView = null;
	}
}
