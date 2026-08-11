using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class HeroBreakoutViewModel : OptionBase
{
	private SimpleCommand _breakoutCommand;

	private bool _enoughCoin = true;

	private bool _enoughMaterial = true;

	private HeroModel _heroModel;

	private string _moneyAmount;

	private string _moneyIcon = "";

	private string _tips = "";

	private List<KnapsackItemViewModel> materialDatas;

	private List<PropertyData> propertyChangeDatas;

	private InteractionRequest refreshRequest = new InteractionRequest();

	public InteractionRequest RefreshRequest => refreshRequest;

	public string Tips
	{
		get
		{
			return _tips;
		}
		set
		{
			Set(ref _tips, value, "Tips");
		}
	}

	public string MoneyIcon
	{
		get
		{
			return _moneyIcon;
		}
		set
		{
			Set(ref _moneyIcon, value, "MoneyIcon");
		}
	}

	public string MoneyAmount
	{
		get
		{
			return _moneyAmount;
		}
		set
		{
			Set(ref _moneyAmount, value, "MoneyAmount");
		}
	}

	public HeroModel HeroModel
	{
		get
		{
			return _heroModel;
		}
		set
		{
			Set(ref _heroModel, value, "HeroModel");
		}
	}

	public bool EnoughCoin => _enoughCoin;

	public bool EnoughMaterial => _enoughMaterial;

	public List<PropertyData> PropertyChangeDatas => propertyChangeDatas;

	public List<KnapsackItemViewModel> MaterialDatas => materialDatas;

	public SimpleCommand BreakoutCommand => _breakoutCommand;

	public HeroBreakoutViewModel()
	{
	}

	public HeroBreakoutViewModel(OptionBase parent, HeroModel heroModel)
	{
		base.parent = parent;
		_breakoutCommand = new SimpleCommand(TryBreakout);
		materialDatas = new List<KnapsackItemViewModel>();
		propertyChangeDatas = new List<PropertyData>();
		SetData(heroModel);
	}

	private void SetData(HeroModel heroModel)
	{
		propertyChangeDatas.Clear();
		materialDatas.Clear();
		HeroModel = heroModel;
		_enoughMaterial = true;
		DRHeroStar dataRow = GameEntry.DataTable.GetDataRow((DRHeroStar p) => p.HeroId.Equals(heroModel.Id) && p.TargetStar.Equals(heroModel.StarLevel + 1));
		if (dataRow == null || dataRow.NeedItem.Count != dataRow.ItemNum.Count)
		{
			return;
		}
		NumericalProperty totalProperty = heroModel.TotalProperty;
		float property = totalProperty.GetProperty("Hp");
		float property2 = totalProperty.GetProperty("Defence");
		float property3 = totalProperty.GetProperty("Attack");
		float property4 = totalProperty.GetProperty("HpRadio");
		float property5 = totalProperty.GetProperty("DefenceRadio");
		float property6 = totalProperty.GetProperty("AttackRadio");
		float property7 = totalProperty.GetProperty("FixHp");
		float property8 = totalProperty.GetProperty("FixDefence");
		float property9 = totalProperty.GetProperty("FixAttack");
		float num = (property + ((heroModel.BreakAddHP.Count > dataRow.TargetStar) ? heroModel.BreakAddHP[dataRow.TargetStar] : 0f)) * (1f + property4) + property7;
		float num2 = (property2 + ((heroModel.BreakAddDefense.Count > dataRow.TargetStar) ? heroModel.BreakAddDefense[dataRow.TargetStar] : 0f)) * (1f + property5) + property8;
		float num3 = (property3 + ((heroModel.BreakAddAttack.Count > dataRow.TargetStar) ? heroModel.BreakAddAttack[dataRow.TargetStar] : 0f)) * (1f + property6) + property9;
		propertyChangeDatas.Add(new PropertyData("Hp", "体力", totalProperty.GetTotalProperty("Hp"), num));
		propertyChangeDatas.Add(new PropertyData("Defence", "防御", totalProperty.GetTotalProperty("Defence"), num2));
		propertyChangeDatas.Add(new PropertyData("Attack", "攻击", totalProperty.GetTotalProperty("Attack"), num3));
		DRHeroStar dataRow2 = GameEntry.DataTable.GetDataRow((DRHeroStar p) => p.HeroId.Equals(heroModel.Id) && p.TargetStar.Equals(heroModel.StarLevel + 2));
		Tips = ((dataRow2 == null) ? $"等级上限开放至{heroModel.TotalMaxLevel}级" : $"等级上限开放至{dataRow2.NeedLv}级");
		KnapsackViewModel knapsackViewModel = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetKnapsackViewModel();
		Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData();
		_enoughCoin = dataRow.NeedGold <= MoneyDefinition.GetMoneyCount(RoleMoneyEnum.Coin);
		MoneyIcon = "Coin";
		MoneyAmount = (_enoughCoin ? dataRow.NeedGold.ToString() : $"<color=red>{dataRow.NeedGold}</color>");
		for (int num4 = 0; num4 < dataRow.NeedItem.Count; num4++)
		{
			if (_enoughMaterial)
			{
				KnapsackPropData prop = knapsackViewModel.GetProp(dataRow.NeedItem[num4]);
				_enoughMaterial = prop != null && prop.Amount >= dataRow.ItemNum[num4];
			}
			DRProp dataRow3 = GameEntry.DataTable.GetDataRow<DRProp>(dataRow.NeedItem[num4]);
			if (dataRow3 != null)
			{
				materialDatas.Add(new KnapsackItemViewModel(this, new PropData(dataRow3, dataRow.ItemNum[num4]), showOwner: false, showName: false, showOwnedAndRequiredCount: true));
			}
		}
		refreshRequest.Raise();
	}

	private async void TryBreakout()
	{
		if (!_enoughMaterial || !_enoughCoin)
		{
			Toast.ShowInfo("德拉塔或材料不足，无法突破");
			return;
		}
		_breakoutCommand.Enabled = false;
		Loading loading = await Loading.Show();
		RequestResult result = await Singleton<ServiceSystem>.Instance.GetService<IHeroService>().HeroBreakoutRequest(HeroModel.Id);
		loading.Dispose();
		if (result.success)
		{
			BreakoutSuccessViewModel userData = new BreakoutSuccessViewModel(this, HeroModel, Tips, propertyChangeDatas);
			openWindowRequest.Raise(new OpenViewArg(typeof(BreakoutSuccessWindow), userData), delegate
			{
				if (result.obj is List<KnapsackPropData> { Count: >0 } list)
				{
					openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), new PropGetViewModel(this, list)), delegate
					{
						Close();
					});
				}
				else
				{
					Close();
				}
			});
			parent.ItemOnClick(new OptionArg(HeroModel.Id, "Option_HeroBreakoutSuccess"));
		}
		else if (result.obj != null && result.obj is string obj)
		{
			parent?.ItemOnClick(obj);
			Close();
		}
		else
		{
			_breakoutCommand.Enabled = true;
		}
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is KnapsackItemViewModel knapsackItemViewModel)
		{
			bool allowSkipWindow = true;
			if (parent != null && parent is HeroCultivateViewModel heroCultivateViewModel)
			{
				allowSkipWindow = !heroCultivateViewModel.MultiEnter;
			}
			OpenViewArg openViewArg = knapsackItemViewModel.OpenPopupWindow(this, null, showOutsideMask: true, showOwnCount: true, allowSkipWindow);
			if (openViewArg != null)
			{
				openWindowRequest.Raise(openViewArg);
			}
		}
		else if (obj is OptionArg optionArg && "OnMulti".Equals(optionArg.OptionName))
		{
			parent.ItemOnClick(optionArg);
		}
	}

	public override void RefreshWhenBack(ViewBackArg arg)
	{
		SetData(HeroModel);
	}
}
