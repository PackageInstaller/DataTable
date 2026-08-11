using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class MailItem : UGuiView
{
	[SerializeField]
	private GameObject red;

	[SerializeField]
	private GameObject unread;

	[SerializeField]
	private GameObject read;

	[SerializeField]
	private GameObject attachment;

	[SerializeField]
	private GameObject selected;

	[SerializeField]
	private GameObject selectedArrow;

	[SerializeField]
	private TextMeshProUGUI title;

	[SerializeField]
	private TextMeshProUGUI leftTimeText;

	[SerializeField]
	private TextMeshProUGUI leftTimeText2;

	[SerializeField]
	private GameObject leftTimeSelected;

	[SerializeField]
	private Button mailItemBtn;

	[SerializeField]
	private RectTransform item;

	[SerializeField]
	private Animation animation;

	private bool playAni;

	private bool isinit;

	private Vector2 oriPos;

	private Vector2 offsetPos;

	private MailItemViewModel viewModel;

	public void Init(MailItemViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<MailItem, MailItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind().For((MailItem v) => v.Dismiss).To((MailItemViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(red).For((GameObject v) => v.activeSelf).To((MailItemViewModel vm) => vm.Data.IsNew);
		bindingSet.Bind<TextMeshProUGUI>(title).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((MailItemViewModel vm) => vm.Data.MailTitle);
		bindingSet.Bind<TextMeshProUGUI>(leftTimeText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((MailItemViewModel vm) => vm.Data.LeftTime);
		bindingSet.Bind<TextMeshProUGUI>(leftTimeText2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((MailItemViewModel vm) => vm.Data.LeftTime);
		bindingSet.Bind(unread).For((GameObject v) => v.activeSelf).ToExpression((MailItemViewModel vm) => (int)vm.Data.MailType == 1 || (int)vm.Data.MailType == 3);
		bindingSet.Bind(read).For((GameObject v) => v.activeSelf).ToExpression((MailItemViewModel vm) => (int)vm.Data.MailType == 3 || (int)vm.Data.MailType == 2);
		bindingSet.Bind(attachment).For((GameObject v) => v.activeSelf).ToExpression((MailItemViewModel vm) => (int)vm.Data.MailType == 0 || (int)vm.Data.MailType == 2);
		bindingSet.Bind(selected).For((GameObject v) => v.activeSelf).ToExpression((MailItemViewModel vm) => vm.IsSelected);
		bindingSet.Bind(selectedArrow).For((GameObject v) => v.activeSelf).ToExpression((MailItemViewModel vm) => vm.IsSelected);
		bindingSet.Bind(mailItemBtn).For((Button v) => v.onClick).To((MailItemViewModel vm) => vm.OnClick);
		bindingSet.Build();
		oriPos = item.anchoredPosition;
		isinit = true;
	}

	private void Dismiss(object sender, InteractionEventArgs e)
	{
		this.ClearAllBindings();
		viewModel.Dispose();
	}

	public void RefreshData(MailItemViewModel viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
	}
}
