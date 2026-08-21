using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class BuyPassportViewModel : OptionBase
{
	private List<PassportItemData> passportItemDataList;

	private RollingViewModel rollingViewModel;

	private PassportInfo passportInfo;

	private SimpleCommand gamePlayCmd;

	private bool isPaying;

	private ISubscription<UserPayNotify> userPayNotify;

	public List<PassportItemData> PassportItemDataList => passportItemDataList;

	public RollingViewModel RollingViewModel => rollingViewModel;

	public SimpleCommand GamePlayCmd => gamePlayCmd;

	public BuyPassportViewModel(OptionBase parent, PassportInfo passportInfo)
	{
		base.parent = parent;
		this.passportInfo = passportInfo;
		userPayNotify = Singleton<NetworkSystem>.Instance.Subscribe<UserPayNotify>(OnUserPayNotify);
		passportItemDataList = new List<PassportItemData>();
		DRPassportShow[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRPassportShow>();
		foreach (DRPassportShow drPassportShow in allDataRow)
		{
			passportItemDataList.Add(new PassportItemData(this, drPassportShow, passportInfo.Grade));
		}
		List<string> list = new List<string>();
		DRWeaponShow[] allDataRow2 = GameEntry.DataTable.GetAllDataRow<DRWeaponShow>();
		foreach (DRWeaponShow dRWeaponShow in allDataRow2)
		{
			DRWeapon dataRow = GameEntry.DataTable.GetDataRow<DRWeapon>(dRWeaponShow.Id);
			if (dataRow != null)
			{
				list.Add(dataRow.Icon);
			}
		}
		rollingViewModel = new RollingViewModel(this, list, 1, 2, 0, 0.71f, "BuyPassportWindow");
		gamePlayCmd = new SimpleCommand(OpenGamePlayWindow);
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is PassportItemData passportItemData)
		{
			SendBuyPassport(passportItemData);
		}
		if (obj is OptionArg { Obj: PassportRewardItemData obj2 } optionArg && "OpenProp".Equals(optionArg.OptionName))
		{
			OpenProp(obj2);
		}
	}

	private void OpenProp(PassportRewardItemData data)
	{
		PropDataBase data2 = PropDataBase.CreateByType(data.Type, data.ID);
		OpenViewArg context = new KnapsackItemViewModel(this, data2).OpenPopupWindow(data.Parent);
		openWindowRequest.Raise(context);
	}

	private async void SendBuyPassport(PassportItemData passportItemData)
	{
		if (await Singleton<ServiceSystem>.Instance.GetService<IPassportService>().BuyPassport(passportItemData.PassportId))
		{
			Singleton<ServiceSystem>.Instance.GetService<IPassportService>().ClearReward();
			int num = ((passportItemData.PassportId == 2) ? 99999998 : 99999997);
			int realPrice = passportItemData.RealPrice;
			if (num == 99999997)
			{
				num = ((passportInfo.Grade == 2) ? 99999996 : 99999997);
			}
			OpenSDKPay(realPrice, num, passportItemData.PassportName);
		}
	}

	private void OnUserPayNotify(UserPayNotify notify)
	{
		if (Singleton<NetResponseHandler>.Instance.ValidateErrorCode(notify.Error, "", showToast: false))
		{
			RefreshData();
		}
	}

	private async void RefreshData()
	{
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IPassportService>().SendGetPassportInfoRequest();
		passportInfo = Singleton<ServiceSystem>.Instance.GetService<IPassportService>().GetPassportInfo();
		if (!num)
		{
			return;
		}
		foreach (PassportItemData passportItemData in passportItemDataList)
		{
			passportItemData.SetPrice(passportInfo.Grade);
			if (passportInfo.Grade >= passportItemData.PassportId)
			{
				passportItemData.SetReceived();
			}
			if (passportInfo.Grade >= 2 && passportItemData.PassportId == 3)
			{
				passportItemData.SetPartReceived();
			}
		}
		parent?.ItemOnClick(new OptionArg(this, "BuyPassportSuccess"));
		Context.GetApplicationContext().GetService<IMessenger>()?.Publish(new PassportMessage(this, PassportMsgEnum.BuyPassportGrade));
	}

	private void OpenSDKPay(int payAmount, int productId, string productName)
	{
		if (isPaying)
		{
			return;
		}
		isPaying = true;
		IRoleService service = Singleton<ServiceSystem>.Instance.GetService<IRoleService>();
		if (service != null)
		{
			RoleViewModel roleData = service.GetRoleData();
			PlayerData playerInfo = roleData.PlayerInfo;
			if (Singleton<ServiceSystem>.Instance.GetService<IAccountService>() != null)
			{
				MyGuildData myGuildData = Singleton<ServiceSystem>.Instance.GetService<IGuildService>()?.GetMyGuildData();
				roleData.GetMoneyData();
				PyParams pyParams = new PyParams();
				pyParams.game_Role_Id = playerInfo.Uid.ToString();
				pyParams.amount = payAmount.ToString();
				pyParams.role_name = playerInfo.Name;
				pyParams.product_Id = productId;
				pyParams.sid = Singleton<NetworkSystem>.Instance.IP ?? "";
				pyParams.serverName = Singleton<NetworkSystem>.Instance.ServerName ?? "";
				pyParams.product_name = productName;
				pyParams.vipLevel = playerInfo.Vip.ToString();
				pyParams.roleLevel = playerInfo.Level.ToString();
				pyParams.UnionName = myGuildData?.Name ?? "";
				pyParams.app_Ext1 = MoneyDefinition.GetMoneyCount(RoleMoneyEnum.Voucher).ToString();
				Singleton<ServiceSystem>.Instance.GetService<ISDKService>().Pay(pyParams);
				isPaying = false;
			}
		}
	}

	private void OpenGamePlayWindow()
	{
		gamePlayCmd.Enabled = false;
		GamePlayTipsViewModel userData = new GamePlayTipsViewModel(this, 1001);
		openWindowRequest.Raise(new OpenViewArg(typeof(GamePlayTipsWindow), userData));
		gamePlayCmd.Enabled = true;
	}
}
