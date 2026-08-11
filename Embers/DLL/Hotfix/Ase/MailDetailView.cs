using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class MailDetailView : UGuiView
{
	[SerializeField]
	private GameObject dataRoot;

	[SerializeField]
	private TextMeshProUGUI mailTitle;

	[SerializeField]
	private TextMeshProUGUI sendTime;

	[SerializeField]
	private TextMeshProUGUI mailContent;

	[SerializeField]
	private Button btnFuncGet;

	[SerializeField]
	private Button btnFuncDelete;

	[SerializeField]
	private GameObject attachmentRoot;

	[SerializeField]
	private LoopListView2 attachmentList;

	private HyperlinkText hyperlinkText;

	private MailDetailViewModel viewModel;

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<MailDetailViewModel>(userData);
		BindingSet<MailDetailView, MailDetailViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind().For((MailDetailView v) => v.Dismiss).To((MailDetailViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(dataRoot).For((GameObject v) => v.activeSelf).ToExpression((MailDetailViewModel vm) => vm.Data.MailId != 0);
		bindingSet.Bind(attachmentRoot).For((GameObject v) => v.activeSelf).ToExpression((MailDetailViewModel vm) => (int)vm.Data.MailType == 0 || (int)vm.Data.MailType == 2);
		bindingSet.Bind<TextMeshProUGUI>(sendTime).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((MailDetailViewModel vm) => vm.Data.SendTimeDate);
		bindingSet.Bind<TextMeshProUGUI>(mailTitle).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((MailDetailViewModel vm) => vm.Data.MailTitle);
		bindingSet.Bind<TextMeshProUGUI>(mailContent).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((MailDetailViewModel vm) => vm.Data.MailContent);
		bindingSet.Bind(btnFuncGet.gameObject).For((GameObject v) => v.activeSelf).ToExpression((MailDetailViewModel vm) => (int)vm.Data.MailType == 0);
		bindingSet.Bind(btnFuncDelete.gameObject).For((GameObject v) => v.activeSelf).ToExpression((MailDetailViewModel vm) => (int)vm.Data.MailType != 0);
		bindingSet.Bind(btnFuncGet).For((Button v) => v.onClick).To((MailDetailViewModel vm) => vm.FuncCmd);
		bindingSet.Bind(btnFuncDelete).For((Button v) => v.onClick).To((MailDetailViewModel vm) => vm.FuncCmd);
		bindingSet.Bind().For((MailDetailView v) => v.RefreshAttachmentList).To((MailDetailViewModel vm) => vm.RefreshAttachmentRequest);
		bindingSet.Bind().For((MailDetailView v) => v.RefreshMailUrl).To((MailDetailViewModel vm) => vm.RefreshMailUrlRequest);
		bindingSet.Build();
		hyperlinkText = ((Component)(object)mailContent).GetComponent<HyperlinkText>();
	}

	private void RefreshMailUrl(object sender, InteractionEventArgs e)
	{
		LayoutRebuilder.ForceRebuildLayoutImmediate(((TMP_Text)mailContent).rectTransform);
		if (((TMP_Text)mailContent).text.Contains("<link="))
		{
			hyperlinkText.SetOnLinkClickAction(OnLinkClick);
		}
	}

	private void Dismiss(object sender, InteractionEventArgs e)
	{
		this.ClearAllBindings();
		viewModel.Dispose();
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<MailDetailViewModel>(userData);
		this.SetDataContext(viewModel);
	}

	private void OnLinkClick(string link)
	{
		if (!string.IsNullOrEmpty(link))
		{
			long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Uid;
			link = $"{link}?user_id={uid}&mail_id={viewModel.Data.MailId}";
			string text = GameEntry.Web.OpenWebViewWithUid(link, ((Component)(object)GameEntry.UI.Canvas).GetComponent<RectTransform>(), useToolBar: true, null, null);
			if (!string.IsNullOrEmpty(text))
			{
				Toast.ShowInfo(text);
			}
		}
	}

	private void RefreshAttachmentList(object sender, InteractionEventArgs e)
	{
		if (!attachmentList.IsInited)
		{
			attachmentList.InitListView(viewModel.AttachmentList.Count, OnGetAttachmentItemByIndex);
			return;
		}
		attachmentList.SetListItemCount(viewModel.AttachmentList.Count);
		attachmentList.RefreshAllShownItem();
	}

	private LoopListViewItem2 OnGetAttachmentItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.AttachmentList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("MailAttachmentItem");
		if (loopListViewItem != null)
		{
			ReceiveItemView component = loopListViewItem.GetComponent<ReceiveItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.AttachmentList[index]);
			}
			else
			{
				component.RefreshData(viewModel.AttachmentList[index]);
			}
		}
		return loopListViewItem;
	}
}
