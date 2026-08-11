#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class PlayerNameChangeViewModel : PlayerNameSetViewModelBase
{
	private InteractionRequest<string> optRequest;

	private PropDataBase changeNameCard;

	private int propId;

	public PropDataBase ChangeNameCard
	{
		get
		{
			return changeNameCard;
		}
		private set
		{
			Set(ref changeNameCard, value, "ChangeNameCard");
		}
	}

	public IInteractionRequest OptRequest => optRequest;

	public PlayerNameChangeViewModel(OptionBase parent)
		: base(parent)
	{
		optRequest = new InteractionRequest<string>();
		propId = PropHelper.GetChangeNameCardId();
		GetChangeNameCard();
	}

	private void GetChangeNameCard()
	{
		if (propId <= 0)
		{
			Log.Error("改名卡Id未配置！请检查");
		}
		PropDataBase prop = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetKnapsackViewModel().GetProp(propId, emptyCreate: true);
		if (changeNameCard == null)
		{
			ChangeNameCard = prop;
		}
		else if (changeNameCard.Amount == 0)
		{
			ChangeNameCard = prop;
			optRequest.Raise("Refresh");
		}
	}

	protected override async void Confirm()
	{
		confirmCommand.Enabled = false;
		try
		{
			if (changeNameCard != null && changeNameCard.Amount > 0)
			{
				if (ValidateName())
				{
					if (Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Name.Equals(nameInput))
					{
						Toast.ShowInfo("名字和原来一样！");
						confirmCommand.Enabled = true;
						return;
					}
					IAsyncResult<int> result = AlertDialog.Show("提醒", "确定将您的名称改为【" + nameInput + "】吗？", "确定", "取消");
					result.Callbackable().OnCallback(async delegate
					{
						if (result.Result == -1 && await ChangeName(nameInput))
						{
							Toast.ShowInfo("改名成功");
							Close();
						}
						confirmCommand.Enabled = true;
					});
				}
			}
			else
			{
				DRExchangeShop dataRow = GameEntry.DataTable.GetDataRow((DRExchangeShop p) => p.ExchangeProp == propId);
				int constantConfigInt = Singleton<OuterSystem>.Instance.GetConstantConfigInt(Constant.ConstantConfig.ChangeNameCardExchangeRatio, 600);
				PropDataBase targetProp = PropDataBase.CreateByType(PropTypeEnum.Prop, propId);
				PropDataBase propDataBase;
				if (dataRow != null)
				{
					propDataBase = PropDataBase.CreateByType(PropTypeEnum.Coin, 9002);
					propDataBase.Amount = (int)MoneyDefinition.GetMoneyCount(RoleMoneyEnum.Diamond);
				}
				else
				{
					propDataBase = PropDataBase.CreateByType(PropTypeEnum.Coin, 9002);
					propDataBase.Amount = (int)MoneyDefinition.GetMoneyCount(RoleMoneyEnum.Diamond);
				}
				PropExcViewModel userData = new PropExcViewModel(this, targetProp, constantConfigInt, propDataBase, 1);
				openWindowRequest.Raise(new OpenViewArg(typeof(PropExcNoSliderView), userData, delegate
				{
					GetChangeNameCard();
					confirmCommand.Enabled = true;
				}));
			}
		}
		catch (Exception ex)
		{
			Log.Error("改名发生异常 " + ex.Message + " / " + ex.StackTrace);
			confirmCommand.Enabled = true;
		}
		confirmCommand.Enabled = true;
	}

	private async UniTask<bool> ChangeName(string name)
	{
		Loading loading = await Loading.Show();
		IAccountService.ChangeRoleResult obj = await Singleton<ServiceSystem>.Instance.GetService<IAccountService>().ChangeName(name);
		loading.Dispose();
		return obj.Code == 0;
	}
}
