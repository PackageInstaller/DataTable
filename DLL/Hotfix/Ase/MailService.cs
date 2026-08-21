#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class MailService : IMailService
{
	private MailViewModel mailViewModel;

	private Dictionary<long, MailData> mailList;

	private ISubscription<UserNewMailNotify> subscription_NewMailNotify;

	private ISubscription<GetMailListNotify> subscription_GetMailListNotify;

	private bool isMailDataRequested;

	public bool IsMailDataRequested => isMailDataRequested;

	public MailService()
	{
		mailList = new Dictionary<long, MailData>();
		mailViewModel = new MailViewModel();
		mailViewModel.AddService(this);
		subscription_NewMailNotify = Singleton<NetworkSystem>.Instance.Subscribe<UserNewMailNotify>(GetNewMailNotify);
		subscription_GetMailListNotify = Singleton<NetworkSystem>.Instance.Subscribe<GetMailListNotify>(GetMailListNotify);
	}

	private void GetNewMailNotify(UserNewMailNotify messager)
	{
		if (messager.MailData != null && !mailList.ContainsKey(messager.MailData.Lid))
		{
			MailData mailData = MailData.Create(messager.MailData);
			mailList.Add(messager.MailData.Lid, mailData);
			mailViewModel.AddNewMail(mailData);
		}
	}

	private void GetMailListNotify(GetMailListNotify message)
	{
		if (message.Mails == null || message.Mails.Count == 0)
		{
			return;
		}
		for (int i = 0; i < message.Mails.Count; i++)
		{
			PbMailData pbMailData = message.Mails[i];
			if (pbMailData != null && !mailList.ContainsKey(pbMailData.Lid))
			{
				MailData mailData = MailData.Create(pbMailData);
				if (mailData != null)
				{
					mailList.Add(pbMailData.Lid, mailData);
					mailViewModel.AddNewMail(mailData);
				}
			}
		}
	}

	public async UniTask<bool> RequestMailData()
	{
		C2S_GetMailListRequest request = C2S_GetMailListRequest.Create();
		S2C_GetMailListResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2C_GetMailListResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取邮件") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取邮件失败"))
			{
				if (response.Mails != null)
				{
					mailList.Clear();
					foreach (PbMailData mail in response.Mails)
					{
						MailData mailData = MailData.Create(mail);
						if (mailData != null && !mailList.ContainsKey(mailData.MailId))
						{
							mailList.Add(mailData.MailId, mailData);
						}
					}
				}
				isMailDataRequested = true;
				mailViewModel.Init(mailList);
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("获取邮件，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> ReceiveMails()
	{
		new List<MailData>();
		return true;
	}

	public async UniTask<bool> MailRead(long mailId)
	{
		C2S_ReadMailRequest readMailRequest = C2S_ReadMailRequest.Create();
		readMailRequest.Lid = mailId;
		S2C_ReadMailResponse result = null;
		try
		{
			result = await Singleton<NetworkSystem>.Instance.Call<S2C_ReadMailResponse>(readMailRequest);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(result, "读取邮件") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(result.Error, "读取邮件失败"))
			{
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("读取邮件，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			readMailRequest.Dispose();
			result?.Dispose();
		}
		return false;
	}

	public async UniTask<MailAttachmentGetInfo> MailGetAttach(long mailId = 0L)
	{
		C2S_GetMailAttachmentRequest request = C2S_GetMailAttachmentRequest.Create();
		S2C_GetMailAttachmentResponse response = null;
		if (mailId != 0L)
		{
			request.Lid = mailId;
		}
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2C_GetMailAttachmentResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "接收邮件") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "接收邮件失败"))
			{
				Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.SetLevelAndExp(response.Level, response.AccountExp);
				MailAttachmentGetInfo mailAttachmentGetInfo = new MailAttachmentGetInfo
				{
					lids = new List<long>()
				};
				foreach (long successLid in response.SuccessLids)
				{
					if (mailList.ContainsKey(successLid) && mailList[successLid].OnGetAttachment())
					{
						mailAttachmentGetInfo.lids.Add(successLid);
					}
				}
				if (response.ItemGet != null)
				{
					mailAttachmentGetInfo.getList = (await PropHelper.AnalyzeRewardFromServer(response.ItemGet)).ConvertToRewardThings();
				}
				mailAttachmentGetInfo.getErrorList = new List<PropDataBase>();
				if (response.CountLimitItems != null)
				{
					List<ThingBase> list = new List<ThingBase>();
					for (int i = 0; i < response.CountLimitItems.Count; i++)
					{
						list.Add(new ThingBase(response.CountLimitItems[i].Type, response.CountLimitItems[i].Id, response.CountLimitItems[i].Count));
					}
					SettlePbThingBase(list, mailAttachmentGetInfo.getErrorList);
				}
				if (response.PackageLimitItems != null)
				{
					List<ThingBase> list2 = new List<ThingBase>();
					for (int j = 0; j < response.PackageLimitItems.Count; j++)
					{
						list2.Add(new ThingBase(response.PackageLimitItems[j].Type, response.PackageLimitItems[j].Id, response.PackageLimitItems[j].Count));
					}
					SettlePbThingBase(list2, mailAttachmentGetInfo.getErrorList);
				}
				if (response.OpenPacks != null)
				{
					List<MailGiftPack> list3 = new List<MailGiftPack>();
					for (int k = 0; k < response.OpenPacks.Count; k++)
					{
						list3.Add(new MailGiftPack
						{
							mailId = response.OpenPacks[k].Id,
							propId = response.OpenPacks[k].Value
						});
					}
					mailAttachmentGetInfo.getPackList = list3;
				}
				return mailAttachmentGetInfo;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("接收邮件，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<MailAttachmentGetInfo> SendGetPackRequest(List<MailGiftPack> mailGiftPacks)
	{
		OpenMailAttachmentGiftPackRequest request = OpenMailAttachmentGiftPackRequest.Create();
		List<PbLongIntValue> list = new List<PbLongIntValue>();
		for (int i = 0; i < mailGiftPacks.Count; i++)
		{
			list.Add(new PbLongIntValue
			{
				Id = mailGiftPacks[i].mailId,
				Value = mailGiftPacks[i].propId
			});
		}
		request.Ids = list;
		OpenMailAttachmentGiftPackResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<OpenMailAttachmentGiftPackResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "领取邮件礼包") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "领取邮件礼包失败"))
			{
				MailAttachmentGetInfo mailAttachmentGetInfo = new MailAttachmentGetInfo
				{
					lids = new List<long>()
				};
				foreach (long openedLid in response.OpenedLids)
				{
					if (mailList.ContainsKey(openedLid) && mailList[openedLid].OnGetAttachment())
					{
						mailAttachmentGetInfo.lids.Add(openedLid);
					}
				}
				if (response.Rewards != null)
				{
					mailAttachmentGetInfo.getList = (await PropHelper.AnalyzeRewardFromServer(response.Rewards)).ConvertToRewardThings();
				}
				return mailAttachmentGetInfo;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("读取邮件，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<List<long>> MailDelete(long mailId = 0L)
	{
		C2S_DeleteMailRequest request = C2S_DeleteMailRequest.Create();
		if (mailId != 0L)
		{
			request.Lid = mailId;
		}
		S2C_DeleteMailResponse result = null;
		try
		{
			result = await Singleton<NetworkSystem>.Instance.Call<S2C_DeleteMailResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(result, "删除邮件") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(result.Error, "删除邮件失败"))
			{
				foreach (long lid in result.Lids)
				{
					if (mailList.ContainsKey(lid))
					{
						mailList.Remove(lid);
					}
				}
				return result.Lids.ToList();
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("删除邮件，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			result?.Dispose();
		}
		return null;
	}

	public MailViewModel GetMailViewModel()
	{
		return mailViewModel;
	}

	public Dictionary<long, MailData> GetMailDatas()
	{
		List<long> list = new List<long>();
		long num = Singleton<ServiceSystem>.Instance.GetService<ITimeService>()?.GetCurServerTime() ?? 0;
		foreach (KeyValuePair<long, MailData> mail in mailList)
		{
			if (mail.Value.ValidTime - num <= 0)
			{
				list.Add(mail.Key);
			}
		}
		for (int i = 0; i < list.Count; i++)
		{
			mailList.Remove(list[i]);
		}
		list.Clear();
		list = null;
		return mailList;
	}

	private void SettlePbThingBase(List<ThingBase> thingBases, List<PropDataBase> getErrorList)
	{
		if (getErrorList == null)
		{
			getErrorList = new List<PropDataBase>();
		}
		for (int i = 0; i < thingBases.Count; i++)
		{
			if (thingBases[i].ThingType == 1)
			{
				DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(thingBases[i].ThingId);
				if (dataRow != null)
				{
					KnapsackPropData item = new KnapsackPropData(dataRow, (int)thingBases[i].ThingCount);
					getErrorList.Add(item);
				}
			}
			else if (thingBases[i].ThingType == 2)
			{
				EquipmentDataBase equipmentDataBase = ArmourData.CreateArmourData(thingBases[i].ThingId);
				if (equipmentDataBase != null)
				{
					getErrorList.Add(equipmentDataBase);
				}
			}
			else if (thingBases[i].ThingType == 5)
			{
				EquipmentDataBase equipmentDataBase2 = WeaponData.CreateWeaponData(thingBases[i].ThingId);
				if (equipmentDataBase2 != null)
				{
					getErrorList.Add(equipmentDataBase2);
				}
			}
		}
	}
}
