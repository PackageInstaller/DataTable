using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public class MailViewModel : OptionBase
{
	private IMailService service;

	private readonly InteractionRequest refreshMailsRequest;

	private SimpleCommand deleteCmd;

	private SimpleCommand getCmd;

	private List<MailItemViewModel> mailList = new List<MailItemViewModel>();

	private MailDetailViewModel detailViewModel;

	private MailItemViewModel curMailSelected;

	private bool hasNew;

	private bool isEmpty;

	private bool isSelected;

	private bool isOpen;

	private GetPackViewModel getPackViewModel;

	private List<MailGiftPack> giftList;

	private int index;

	private List<MailGiftPack> mailGiftPacks;

	public MailItemViewModel CurMailSelected
	{
		get
		{
			return curMailSelected;
		}
		private set
		{
			Set(ref curMailSelected, value, "CurMailSelected");
			IsSelected = value != null || isEmpty;
		}
	}

	public IInteractionRequest RefreshMailsRequest => refreshMailsRequest;

	public List<MailItemViewModel> MailList
	{
		get
		{
			return mailList;
		}
		set
		{
			Set(ref mailList, value, "MailList");
		}
	}

	public bool IsEmpty
	{
		get
		{
			return isEmpty;
		}
		set
		{
			Set(ref isEmpty, value, "IsEmpty");
		}
	}

	public bool HasNew
	{
		get
		{
			return hasNew;
		}
		set
		{
			Set(ref hasNew, value, "HasNew");
		}
	}

	public bool IsSelected
	{
		get
		{
			return isSelected;
		}
		private set
		{
			Set(ref isSelected, value, "IsSelected");
		}
	}

	public MailDetailViewModel DetailViewModel => detailViewModel;

	public ICommand DeleteCmd => deleteCmd;

	public ICommand GetCmd => getCmd;

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is MailItemViewModel item)
		{
			DealMailItemClick(item);
		}
		else if (obj is MailDetailViewModel)
		{
			DealMailDetailFunc();
		}
		else if (obj is ReceiveItemViewModel receiveItemViewModel)
		{
			if (receiveItemViewModel.PropDataBase.PropTypeEnum == PropTypeEnum.Equipment)
			{
				if (receiveItemViewModel.PropDataBase is ArmourData armourData)
				{
					ArmourPopupViewModel userData = new ArmourPopupViewModel(this, armourData);
					openWindowRequest.Raise(new OpenViewArg(typeof(ArmourPopupSampleView), userData));
				}
			}
			else if (receiveItemViewModel.PropDataBase.PropTypeEnum == PropTypeEnum.SuitBox)
			{
				if (receiveItemViewModel.PropDataBase is ArmourData armourData2)
				{
					RockPopupViewModel userData2 = new RockPopupViewModel(this, armourData2);
					openWindowRequest.Raise(new OpenViewArg(typeof(RockPopupSampleWindow), userData2));
				}
			}
			else
			{
				OpenViewArg openViewArg = receiveItemViewModel.OpenPopupWindow(this);
				if (openViewArg != null)
				{
					openWindowRequest.Raise(openViewArg);
				}
			}
		}
		else if (obj is KnapsackItemViewModel knapsackItemViewModel)
		{
			OpenViewArg openViewArg2 = knapsackItemViewModel.OpenPopupWindow(this);
			if (openViewArg2 != null)
			{
				openWindowRequest.Raise(openViewArg2);
			}
		}
		else if (obj is OptionArg { Obj: GetPackViewModel obj2 } optionArg)
		{
			if (optionArg.OptionName.Equals("Cancel"))
			{
				OnGetPackConfirm(obj2, isConfirm: false);
			}
			else if (optionArg.OptionName.Equals("Confirm"))
			{
				OnGetPackConfirm(obj2, isConfirm: true);
			}
		}
	}

	public MailViewModel()
	{
		refreshMailsRequest = new InteractionRequest();
		deleteCmd = new SimpleCommand(DeleteMails);
		getCmd = new SimpleCommand(GetAttachmentMails);
	}

	public override void OnOpen()
	{
		Dictionary<long, MailData> mailDatas = Singleton<ServiceSystem>.Instance.GetService<IMailService>().GetMailDatas();
		if (mailList == null)
		{
			mailList = new List<MailItemViewModel>();
		}
		else
		{
			mailList.Clear();
		}
		AddMails(mailDatas);
		InitDetail();
		SetCurMailSelected(null);
		UpdateNewState();
		RankMailList();
		isOpen = true;
	}

	public void Init(Dictionary<long, MailData> mailDatas)
	{
		if (mailDatas == null)
		{
			return;
		}
		HasNew = false;
		foreach (KeyValuePair<long, MailData> mailData in mailDatas)
		{
			if (mailData.Value.MailType == MailTypeEnum.Mail_Unread || mailData.Value.MailType == MailTypeEnum.Mail_Attachment)
			{
				HasNew = true;
				break;
			}
		}
	}

	public void AddNewMail(MailData mailData)
	{
		if (isOpen)
		{
			mailList.Add(new MailItemViewModel(this, mailData));
			UpdateNewState();
			RankMailList();
		}
		else
		{
			HasNew = true;
		}
	}

	public void AddService(IMailService service)
	{
		if (this.service == null)
		{
			this.service = service;
		}
	}

	public void AddMails(Dictionary<long, MailData> mailDatas)
	{
		foreach (MailData value in mailDatas.Values)
		{
			mailList.Add(new MailItemViewModel(this, value));
		}
		RankMailList();
	}

	public void MailReceive()
	{
	}

	private async Task<bool> MailRead(long mailId)
	{
		Loading loading = await Loading.Show();
		bool result = await service.MailRead(mailId);
		loading.Dispose();
		return result;
	}

	private async Task<bool> MailDelete(long mailId = 0L)
	{
		Loading loading = await Loading.Show();
		List<long> deleteMailIds = await service.MailDelete(mailId);
		loading.Dispose();
		return DeleteMailByIds(deleteMailIds);
	}

	private async Task MailGetAttachment(long mailId = 0L)
	{
		Loading loading = await Loading.Show();
		try
		{
			MailAttachmentGetInfo mailAttachmentGetInfo = await service.MailGetAttach(mailId);
			if (mailAttachmentGetInfo != null)
			{
				OpenAttachmentGetWindow(mailAttachmentGetInfo.getList);
				OpenGetErrorDialogWindow(mailAttachmentGetInfo.getErrorList);
				OpenAttachmentGiftPackGetWindow(mailAttachmentGetInfo.getPackList);
			}
		}
		catch (Exception)
		{
		}
		loading.Dispose();
	}

	public async void DeleteMails()
	{
		deleteCmd.Enabled = false;
		await MailDelete(0L);
		deleteCmd.Enabled = true;
		UpdateNewState();
	}

	private bool DeleteMailByIds(List<long> deleteMailIds)
	{
		if (deleteMailIds != null)
		{
			for (int num = mailList.Count - 1; num >= 0; num--)
			{
				if (deleteMailIds.Contains(mailList[num].Data.MailId))
				{
					if (curMailSelected != null && curMailSelected.Data.MailId == mailList[num].Data.MailId)
					{
						SetCurMailSelected(null);
					}
					mailList.RemoveAt(num);
				}
			}
			IsEmpty = mailList == null || mailList.Count == 0;
			RankMailList();
			return true;
		}
		return false;
	}

	public async void GetAttachmentMails()
	{
		try
		{
			getCmd.Enabled = false;
			await MailGetAttachment(0L);
			detailViewModel.RefreshAttachmentGotState();
			getCmd.Enabled = true;
			UpdateNewState();
		}
		catch (Exception)
		{
		}
	}

	private void DealMailItemClick(MailItemViewModel item)
	{
		if (SetCurMailSelected(item) && item.IsTypeChanged)
		{
			MailRead(item.Data.MailId);
			item.ResetTypeChanged();
		}
		UpdateNewState();
	}

	private async void DealMailDetailFunc()
	{
		MailData data = detailViewModel.Data;
		if (data.MailType == MailTypeEnum.Mail_Read || data.MailType == MailTypeEnum.Mail_Attachment_Read)
		{
			if (await MailDelete(data.MailId))
			{
				detailViewModel.Reset();
			}
			detailViewModel.EnableFuncCmd();
		}
		else if (data.MailType == MailTypeEnum.Mail_Attachment)
		{
			await MailGetAttachment(data.MailId);
			detailViewModel.RefreshAttachmentGotState();
			detailViewModel.EnableFuncCmd();
		}
		UpdateNewState();
	}

	private void InitDetail()
	{
		if (detailViewModel == null)
		{
			detailViewModel = new MailDetailViewModel(this);
		}
	}

	private void RefreshDetail(MailData mailData)
	{
		detailViewModel.SetData(mailData);
	}

	public void RankMailList()
	{
		List<MailItemViewModel> list = new List<MailItemViewModel>();
		List<MailItemViewModel> list2 = new List<MailItemViewModel>();
		foreach (MailItemViewModel mail in mailList)
		{
			if (mail.Data.MailType == MailTypeEnum.Mail_Attachment || mail.Data.MailType == MailTypeEnum.Mail_Unread)
			{
				list.Add(mail);
			}
			else
			{
				list2.Add(mail);
			}
		}
		list.Sort(delegate(MailItemViewModel x, MailItemViewModel y)
		{
			int num = x.Data.MailType.CompareTo(y.Data.MailType);
			return (num == 0) ? y.Data.SendTime.CompareTo(x.Data.SendTime) : num;
		});
		list2.Sort((MailItemViewModel x, MailItemViewModel y) => y.Data.SendTime.CompareTo(x.Data.SendTime));
		MailList = AddList(list, list2);
		IsEmpty = mailList == null || mailList.Count == 0;
		refreshMailsRequest.Raise();
	}

	private List<MailItemViewModel> AddList(List<MailItemViewModel> temp1, List<MailItemViewModel> temp2)
	{
		foreach (MailItemViewModel item in temp2)
		{
			temp1.Add(item);
		}
		return temp1;
	}

	private bool SetCurMailSelected(MailItemViewModel viewModel)
	{
		if (viewModel != null && curMailSelected == viewModel)
		{
			return false;
		}
		if (viewModel == null)
		{
			if (curMailSelected != null)
			{
				curMailSelected.IsSelected = false;
			}
			CurMailSelected = null;
			detailViewModel.Reset();
		}
		else
		{
			if (curMailSelected != null)
			{
				curMailSelected.IsSelected = false;
			}
			CurMailSelected = viewModel;
			RefreshDetail(curMailSelected.Data);
		}
		return true;
	}

	private void UpdateNewState()
	{
		List<RedPointSave> redPoint = Singleton<ServiceSystem>.Instance.GetService<IRedPointService>().GetRedPoint("Mail", forceLoading: true);
		List<RedPointSave> list = new List<RedPointSave>();
		HasNew = false;
		foreach (MailItemViewModel mail in mailList)
		{
			if (mail.Data.hasLocaled)
			{
				HasNew = HasNew || mail.Data.IsNew;
				continue;
			}
			mail.Data.hasLocaled = true;
			int num = redPoint.FindIndex((RedPointSave p) => p.keyId == mail.Data.MailId);
			if (num < 0)
			{
				if (mail.Data.MailType == MailTypeEnum.Mail_Unread || mail.Data.MailType == MailTypeEnum.Mail_Attachment)
				{
					mail.Data.SetNew(isNew: true);
					HasNew = true;
				}
			}
			else
			{
				mail.Data.SetNew(redPoint[num].isNew);
				HasNew = HasNew || redPoint[num].isNew;
			}
			list.Add(new RedPointSave
			{
				isNew = mail.Data.IsNew,
				keyId = mail.Data.MailId
			});
		}
		Singleton<ServiceSystem>.Instance.GetService<IRedPointService>().SaveRedPoint(list, "Mail");
	}

	private void OpenAttachmentGetWindow(RewardThings attachmentList)
	{
		if (attachmentList != null)
		{
			PropGetViewModel userData = new PropGetViewModel(this, attachmentList);
			openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), userData));
		}
	}

	private void OpenAttachmentGiftPackGetWindow(List<MailGiftPack> giftList)
	{
		if (giftList != null && giftList.Count > 0)
		{
			this.giftList = giftList;
			index = 0;
			OpenAttachmentGiftPackGetWindowByIndex(giftList, index);
		}
	}

	private void OpenAttachmentGiftPackGetWindowByIndex(List<MailGiftPack> giftList, int index)
	{
		if (giftList != null && giftList.Count > index)
		{
			if (getPackViewModel == null)
			{
				getPackViewModel = new GetPackViewModel(this, giftList[index].mailId, giftList[index].propId, OpenMail: true);
				getPackViewModel.SetText(giftList.Count > index + 1);
				openWindowRequest.Raise(new OpenViewArg(typeof(GetPackWindow), getPackViewModel), delegate
				{
					GetPackReward();
				});
			}
			else
			{
				getPackViewModel.RefreshPack(giftList[index].propId, giftList[index].mailId);
				getPackViewModel.SetText(giftList.Count > index + 1);
			}
		}
		else if (getPackViewModel != null)
		{
			getPackViewModel.Close();
		}
	}

	private async void GetPackReward()
	{
		if (mailGiftPacks != null && mailGiftPacks.Count > 0)
		{
			Loading loading = await Loading.Show();
			MailAttachmentGetInfo mailAttachmentGetInfo = await Singleton<ServiceSystem>.Instance.GetService<IMailService>().SendGetPackRequest(mailGiftPacks);
			if (mailAttachmentGetInfo != null)
			{
				if (mailAttachmentGetInfo.getList != null)
				{
					PropGetViewModel userData = new PropGetViewModel(this, mailAttachmentGetInfo.getList);
					openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), userData));
				}
				else
				{
					Toast.ShowInfo("领取奖励发生异常！");
				}
				detailViewModel.SetAttachmentGotState();
			}
			loading.Dispose();
		}
		ResetGiftPack();
	}

	private void ResetGiftPack()
	{
		mailGiftPacks = null;
		getPackViewModel = null;
		giftList = null;
		index = 0;
	}

	private void OnGetPackConfirm(GetPackViewModel getPackViewModel, bool isConfirm)
	{
		if (isConfirm)
		{
			if (mailGiftPacks == null)
			{
				mailGiftPacks = new List<MailGiftPack>();
			}
			mailGiftPacks.Add(new MailGiftPack
			{
				mailId = getPackViewModel.MailId,
				propId = getPackViewModel.SelectedIndex
			});
		}
		index++;
		OpenAttachmentGiftPackGetWindowByIndex(giftList, index);
	}

	private void OpenGetErrorDialogWindow(List<PropDataBase> attachmentGetErrorList)
	{
		if (attachmentGetErrorList != null && attachmentGetErrorList.Count > 0)
		{
			GetErrorDialogViewModel userData = new GetErrorDialogViewModel(this, attachmentGetErrorList);
			openWindowRequest.Raise(new OpenViewArg(typeof(GetErrorDialogWindow), userData));
		}
	}

	public override void Close()
	{
		isOpen = false;
		SetCurMailSelected(null);
		SaveRed();
		base.Close();
	}

	private void SaveRed()
	{
		List<RedPointSave> list = new List<RedPointSave>();
		foreach (MailItemViewModel mail in mailList)
		{
			list.Add(new RedPointSave
			{
				isNew = mail.Data.IsNew,
				keyId = mail.Data.MailId
			});
		}
		Singleton<ServiceSystem>.Instance.GetService<IRedPointService>().SaveRedPoint(list, "Mail");
	}

	public override void Dispose()
	{
		base.Dispose();
		if (detailViewModel != null)
		{
			detailViewModel.Close();
			detailViewModel = null;
		}
		if (curMailSelected != null)
		{
			CurMailSelected = null;
		}
	}
}
