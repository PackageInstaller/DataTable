using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class CashPaymentViewModel : OptionBase
{
	private DRProp prop;

	private bool paying;

	private List<PayItemViewModel> itemList;

	private InteractionRequest refreshPayItemDatas = new InteractionRequest();

	private ISubscription<UserInfoMessage> subscription_UserInfo;

	public List<PayItemViewModel> ItemList => itemList;

	public InteractionRequest RefreshPayItemDatas => refreshPayItemDatas;

	public CashPaymentViewModel()
	{
	}

	public CashPaymentViewModel(OptionBase parent)
	{
		base.parent = parent;
		itemList = new List<PayItemViewModel>();
		subscription_UserInfo = Context.GetApplicationContext().GetService<IMessenger>().Subscribe<UserInfoMessage>(OnUserInfoNotify);
		prop = GameEntry.DataTable.GetDataRow<DRProp>(9006);
		DRPay[] dataRows = GameEntry.DataTable.GetDataRows((DRPay p) => p.Show);
		if (dataRows != null)
		{
			long firstPay = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().FirstPay;
			for (int num = 0; num < dataRows.Length; num++)
			{
				bool isFirst = (int)((float)firstPay / Mathf.Pow(2f, dataRows[num].Id - 1)) % 2 == 0;
				itemList.Add(new PayItemViewModel(this, dataRows[num], isFirst, (prop == null) ? "钻石" : prop.Name));
			}
		}
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is OptionArg optionArg && "OnPay".Equals(optionArg.OptionName))
		{
			OnPay((PayItemViewModel)optionArg.Obj);
		}
	}

	private void OnUserInfoNotify(UserInfoMessage msg)
	{
		if (msg == null || msg.MessageType != UserInfoMessage.MsgTypeEnum.ChargeDataChanged)
		{
			return;
		}
		long firstPay = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().FirstPay;
		if (itemList == null)
		{
			return;
		}
		foreach (PayItemViewModel item in itemList)
		{
			bool isFirst = (int)((float)firstPay / Mathf.Pow(2f, item.Id - 1)) % 2 == 0;
			item.UpdateFirst(isFirst);
		}
	}

	protected override void Dispose(bool disposing)
	{
		subscription_UserInfo?.Dispose();
		subscription_UserInfo = null;
		base.Dispose(disposing);
	}

	private async void OnPay(PayItemViewModel payItem)
	{
		if (!paying)
		{
			paying = true;
			if (!CheckRealNameType(payItem))
			{
				paying = false;
			}
			else if (prop == null)
			{
				Toast.ShowError("付费钻石配置异常！");
				paying = false;
			}
			else
			{
				OpenSDKPay(payItem.Price, payItem.Id, "商店充值");
			}
		}
	}

	private void OpenSDKPay(int payAmount, int productId, string productName)
	{
		ShopDefinition.OpenSDKPay(payAmount, productId, productName);
		paying = false;
	}

	private bool CheckRealNameType(PayItemViewModel payItem)
	{
		return true;
	}
}
