using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class MailDetailViewModel : OptionBase
{
	private MailData empty;

	private List<ReceiveItemViewModel> attachmentList;

	private readonly InteractionRequest refreshAttachmentRequest;

	private readonly InteractionRequest refreshMailUrlRequest;

	private SimpleCommand funcCmd;

	private MailData data;

	public MailData Data
	{
		get
		{
			return data;
		}
		private set
		{
			if (Set(ref data, value, "Data") && data != null && data.MailId != 0L && (data.MailType == MailTypeEnum.Mail_Attachment || data.MailType == MailTypeEnum.Mail_Attachment_Read))
			{
				RefreshAttachmentList();
			}
		}
	}

	public List<ReceiveItemViewModel> AttachmentList => attachmentList;

	public IInteractionRequest RefreshAttachmentRequest => refreshAttachmentRequest;

	public IInteractionRequest RefreshMailUrlRequest => refreshMailUrlRequest;

	public ICommand FuncCmd => funcCmd;

	public override void ItemOnClick(object obj)
	{
		if (obj is ReceiveItemViewModel)
		{
			parent.ItemOnClick(obj);
		}
	}

	public MailDetailViewModel()
	{
	}

	public MailDetailViewModel(OptionBase parent)
	{
		base.parent = parent;
		attachmentList = new List<ReceiveItemViewModel>();
		refreshAttachmentRequest = new InteractionRequest();
		refreshMailUrlRequest = new InteractionRequest();
		empty = MailData.CreateEmpty();
		funcCmd = new SimpleCommand(OnFunc);
	}

	public void Reset()
	{
		Data = empty;
	}

	public void SetData(MailData data)
	{
		Data = data;
		refreshMailUrlRequest.Raise();
	}

	public void OnFunc()
	{
		if (Data.MailId != 0L)
		{
			funcCmd.Enabled = false;
			parent.ItemOnClick(this);
		}
	}

	public void EnableFuncCmd()
	{
		funcCmd.Enabled = true;
	}

	public void RefreshAttachmentList()
	{
		attachmentList.Clear();
		foreach (PropDataBase attachment in data.AttachmentList)
		{
			if (attachment != null)
			{
				PropDataBase propDataBase = attachment;
				ReceiveItemViewModel receiveItemViewModel = new ReceiveItemViewModel(propDataBase, this);
				receiveItemViewModel.SetGot(data.MailType == MailTypeEnum.Mail_Attachment_Read);
				attachmentList.Add(receiveItemViewModel);
				if (data.MailType == MailTypeEnum.Mail_Attachment_Read)
				{
					receiveItemViewModel.SetGot(isGot: true);
				}
			}
		}
		refreshAttachmentRequest.Raise();
	}

	public void RefreshAttachmentGotState()
	{
		if (data.MailType != MailTypeEnum.Mail_Attachment_Read)
		{
			return;
		}
		foreach (ReceiveItemViewModel attachment in attachmentList)
		{
			attachment.SetGot(isGot: true);
		}
	}

	public void SetAttachmentGotState()
	{
		data.SetAttachmentGotState();
		foreach (ReceiveItemViewModel attachment in attachmentList)
		{
			attachment.SetGot(isGot: true);
		}
	}

	public override void Dispose()
	{
		base.Dispose();
		if (attachmentList != null)
		{
			for (int i = 0; i < attachmentList.Count; i++)
			{
				attachmentList[i].Close();
			}
			attachmentList.Clear();
			attachmentList = null;
		}
	}
}
