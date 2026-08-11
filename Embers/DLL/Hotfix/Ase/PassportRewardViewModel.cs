using System;
using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class PassportRewardViewModel : OptionBase
{
	private PassportInfo passportInfo;

	private List<PassportLevelItemData> passportLevelItemDataList;

	private PassportLevelItemData importLevelItemData;

	private bool showGetAllReward;

	private InteractionRequest refreshImportItemRequest;

	private PassportLevelItemData curLevelItemData;

	private SimpleCommand btnGetAllRewardCmd;

	private bool buyPassport;

	private bool buyPassportTip;

	private string buyPassportText;

	private bool isGetAllReward;

	public List<PassportLevelItemData> PassportLevelItemDataList => passportLevelItemDataList;

	public PassportLevelItemData ImportLevelItemData
	{
		get
		{
			return importLevelItemData;
		}
		set
		{
			Set(ref importLevelItemData, value, "ImportLevelItemData");
		}
	}

	public PassportInfo PassportInfo
	{
		get
		{
			return passportInfo;
		}
		set
		{
			Set(ref passportInfo, value, "PassportInfo");
		}
	}

	public bool ShowGetAllReward
	{
		get
		{
			return showGetAllReward;
		}
		set
		{
			Set(ref showGetAllReward, value, "ShowGetAllReward");
		}
	}

	public bool BuyPassport
	{
		get
		{
			return buyPassport;
		}
		set
		{
			Set(ref buyPassport, value, "BuyPassport");
		}
	}

	public bool BuyPassportTip
	{
		get
		{
			return buyPassportTip;
		}
		set
		{
			Set(ref buyPassportTip, value, "BuyPassportTip");
		}
	}

	public string BuyPassportText
	{
		get
		{
			return buyPassportText;
		}
		set
		{
			Set(ref buyPassportText, value, "BuyPassportText");
		}
	}

	public InteractionRequest RefreshImportItemRequest => refreshImportItemRequest;

	public SimpleCommand BtnGetAllRewardCmd => btnGetAllRewardCmd;

	public PassportRewardViewModel(OptionBase parent, PassportInfo passportInfo)
	{
		base.parent = parent;
		CheckBuyPassport(passportInfo);
		refreshImportItemRequest = new InteractionRequest();
		btnGetAllRewardCmd = new SimpleCommand(BtnGetAllReward);
		passportLevelItemDataList = new List<PassportLevelItemData>();
		LoadRewardData();
		SetGrade(passportInfo.Grade);
		SetLevel(passportInfo.Level);
		foreach (PassportLevelItemData passportLevelItemData in passportLevelItemDataList)
		{
			if (passportLevelItemData.PassportRewardItemDataList[0].IsImportant)
			{
				importLevelItemData = passportLevelItemData;
				break;
			}
		}
		SetImportItem(passportInfo.Level - 1);
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is OptionArg optionArg)
		{
			if (optionArg.Obj is PassportLevelItemData data)
			{
				curLevelItemData = data;
				OpenPackWindow(data);
			}
			else if (optionArg.Obj is GetPackViewModel getPackViewModel)
			{
				if (optionArg.OptionName.Equals("Cancel"))
				{
					getPackViewModel.Close();
					OpenRewardWindow();
				}
				else if (optionArg.OptionName.Equals("Confirm"))
				{
					getPackViewModel.Close();
					if (isGetAllReward)
					{
						BtnGetAllReward();
						return;
					}
					curLevelItemData?.SetReceived();
					OpenRewardWindow();
				}
			}
			else if (optionArg.Obj is BuyPassportViewModel && optionArg.OptionName.Equals("BuyPassportSuccess"))
			{
				passportInfo = Singleton<ServiceSystem>.Instance.GetService<IPassportService>().GetPassportInfo();
				SetGrade(passportInfo.Grade);
				SetLevel(passportInfo.Level);
				parent?.ItemOnClick(new OptionArg(this, "BuyPassportSuccess"));
			}
		}
		else if (obj is OpenViewArg obj2)
		{
			parent?.ItemOnClick(obj2);
		}
	}

	private void OpenPackWindow(PassportLevelItemData data)
	{
		Vector2 packIdValue = Singleton<ServiceSystem>.Instance.GetService<IPassportService>().GetPackIdValue();
		if (packIdValue != Vector2.zero)
		{
			List<int> list = new List<int>();
			list.Add((int)packIdValue.y);
			List<int> list2 = new List<int>();
			list2.Add((int)packIdValue.x);
			GetPackViewModel userData = new GetPackViewModel(this, list, list2);
			Action callback = delegate
			{
				data.SetIsSending(value: false);
			};
			OpenViewArg obj = new OpenViewArg(typeof(GetPackWindow), userData, "Default", isOpenWindow: true, "DEFAULT", callback);
			parent?.ItemOnClick(obj);
		}
		else
		{
			OpenRewardWindow(data);
		}
	}

	private void OpenRewardWindow(PassportLevelItemData data = null)
	{
		List<PropDataBase> rewardList = Singleton<ServiceSystem>.Instance.GetService<IPassportService>().GetRewardList();
		List<PropDataBase> packReward = Singleton<ServiceSystem>.Instance.GetService<IPassportService>().GetPackReward();
		rewardList.AddRange(packReward);
		if (rewardList.Count > 0)
		{
			PropGetViewModel propGetViewModel = new PropGetViewModel(this, rewardList);
			propGetViewModel.MergeProp();
			Action callback = delegate
			{
				data?.SetIsSending(value: false);
			};
			OpenViewArg obj = new OpenViewArg(typeof(PropGetWindow), propGetViewModel, "Default", isOpenWindow: true, "DEFAULT", callback);
			parent?.ItemOnClick(obj);
			curLevelItemData?.SetReceived();
		}
		RefreshRewardItem();
		CheckGetAllBtn();
		Singleton<ServiceSystem>.Instance.GetService<IPassportService>().ClearReward();
	}

	private void LoadRewardData()
	{
		int num = GameEntry.DataTable.GetDataRows((DRPassportReward p) => p.Grade == 1).Length;
		passportLevelItemDataList.Clear();
		for (int num2 = 0; num2 < num; num2++)
		{
			PassportLevelItemData passportLevelItemData = new PassportLevelItemData(this, num2 + 1, passportInfo.Level);
			SetRewardReceived(passportLevelItemData, 0, passportInfo.Reward);
			SetRewardReceived(passportLevelItemData, 1, passportInfo.Reward);
			SetRewardReceived(passportLevelItemData, 2, passportInfo.Reward);
			passportLevelItemDataList.Add(passportLevelItemData);
		}
		CheckGetAllBtn();
	}

	private void SetRewardReceived(PassportLevelItemData passportLevelItemData, int index, List<int> checkReward)
	{
		int passportRewardItemId = passportLevelItemData.GetPassportRewardItemId(index);
		if (passportRewardItemId != 0)
		{
			int index2 = passportRewardItemId - 1;
			bool isReceived = UiConvert.BitwiseConvert.Bitwise(checkReward, index2);
			passportLevelItemData.SetPassportRewardItemByIndex(index, isReceived);
		}
	}

	private void RefreshRewardItem()
	{
		passportInfo = Singleton<ServiceSystem>.Instance.GetService<IPassportService>().GetPassportInfo();
		foreach (PassportLevelItemData passportLevelItemData in passportLevelItemDataList)
		{
			int passportRewardItemId = passportLevelItemData.GetPassportRewardItemId(0);
			bool isReceived = UiConvert.BitwiseConvert.Bitwise(passportInfo.Reward, passportRewardItemId - 1);
			passportLevelItemData.SetPassportRewardItemReceivedByIndex(0, isReceived);
			int passportRewardItemId2 = passportLevelItemData.GetPassportRewardItemId(1);
			bool isReceived2 = UiConvert.BitwiseConvert.Bitwise(passportInfo.Reward, passportRewardItemId2 - 1);
			passportLevelItemData.SetPassportRewardItemReceivedByIndex(1, isReceived2);
			int passportRewardItemId3 = passportLevelItemData.GetPassportRewardItemId(2);
			if (passportRewardItemId3 != 0)
			{
				bool isReceived3 = UiConvert.BitwiseConvert.Bitwise(passportInfo.Reward, passportRewardItemId3 - 1);
				passportLevelItemData.SetPassportRewardItemReceivedByIndex(2, isReceived3);
			}
		}
	}

	public void SetImportItem(int index, bool needFix = false)
	{
		if (index <= 0)
		{
			index = 1;
		}
		if (needFix)
		{
			index += 3;
		}
		if (index >= passportLevelItemDataList.Count)
		{
			index = passportLevelItemDataList.Count;
		}
		for (int i = index - 1; i < passportLevelItemDataList.Count; i++)
		{
			if (passportLevelItemDataList[i].PassportRewardItemDataList[0].IsImportant)
			{
				importLevelItemData = passportLevelItemDataList[i];
				break;
			}
		}
		refreshImportItemRequest.Raise();
	}

	public void SetGrade(int grade)
	{
		foreach (PassportLevelItemData passportLevelItemData in passportLevelItemDataList)
		{
			passportLevelItemData.SetGrade(grade);
		}
		CheckGetAllBtn();
	}

	public void SetLevel(int level)
	{
		foreach (PassportLevelItemData passportLevelItemData in passportLevelItemDataList)
		{
			passportLevelItemData.SetLevelLock(passportLevelItemData.Level <= level, passportInfo.Grade, passportInfo.Level);
		}
		CheckGetAllBtn();
	}

	private void CheckGetAllBtn()
	{
		ShowGetAllReward = false;
		foreach (PassportLevelItemData passportLevelItemData in passportLevelItemDataList)
		{
			foreach (PassportRewardItemData passportRewardItemData in passportLevelItemData.PassportRewardItemDataList)
			{
				if (!passportRewardItemData.IsEmpty && passportRewardItemData.RedPoint && !passportRewardItemData.IsReceived)
				{
					ShowGetAllReward = true;
					parent?.ItemOnClick("RedPoint");
					return;
				}
			}
		}
		parent?.ItemOnClick("RedPoint");
	}

	private async void BtnGetAllReward()
	{
		if (ShowGetAllReward && await Singleton<ServiceSystem>.Instance.GetService<IPassportService>().SendGetRewardRequest(-1, clearReward: false))
		{
			isGetAllReward = true;
			Vector2 packIdValue = Singleton<ServiceSystem>.Instance.GetService<IPassportService>().GetPackIdValue();
			if (packIdValue != Vector2.zero)
			{
				List<int> list = new List<int>();
				list.Add((int)packIdValue.y);
				List<int> list2 = new List<int>();
				list2.Add((int)packIdValue.x);
				GetPackViewModel userData = new GetPackViewModel(this, list, list2);
				parent?.ItemOnClick(new OpenViewArg(typeof(GetPackWindow), userData));
			}
			else
			{
				isGetAllReward = false;
				OpenRewardWindow();
			}
		}
	}

	public void OpenPassportWindow()
	{
		passportInfo = Singleton<ServiceSystem>.Instance.GetService<IPassportService>().GetPassportInfo();
		BuyPassportViewModel userData = new BuyPassportViewModel(this, passportInfo);
		OpenViewArg obj = new OpenViewArg(typeof(BuyPassportWindow), userData);
		parent?.ItemOnClick(obj);
	}

	public void CheckBuyPassport(PassportInfo passportInfo)
	{
		this.passportInfo = passportInfo;
		BuyPassport = !GameEntry.BuiltinData.OpenTestFlight && this.passportInfo.Grade <= 2;
		BuyPassportTip = this.passportInfo.Grade < 2;
		string text = GameEntry.DataTable.GetDataRow<DRPassportShow>(2)?.PassportName;
		string text2 = GameEntry.DataTable.GetDataRow<DRPassportShow>(3)?.PassportName;
		BuyPassportText = ((this.passportInfo.Grade <= 1) ? ("购买" + text) : ("购买" + text2));
	}
}
