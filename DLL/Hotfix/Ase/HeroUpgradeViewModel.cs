using System;
using System.Collections.Generic;
using System.Linq;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class HeroUpgradeViewModel : OptionBase
{
	private SimpleCommand confirmCmd;

	private InteractionRequest<float> fixSliderRequest;

	private List<int> expItemIds;

	private KnapsackViewModel knapsackViewModel;

	private long coinDataAmount;

	private List<KnapsackItemViewModel> expItemDatas = new List<KnapsackItemViewModel>();

	private List<KnapsackItemViewModel> expReturnItemDatas = new List<KnapsackItemViewModel>();

	private KnapsackItemViewModel curSelected;

	private int useCount;

	private int useCountMin;

	private int useCountMax;

	private bool canAdd;

	private bool canDec;

	private float useFillAmount;

	private float useFillAmountMin;

	private MoneyData moneyData;

	private int coinNeed;

	private HeroModel heroModel;

	private string showName;

	private float levelExpFillCur;

	private float levelExpFillAdd;

	private List<DRHeroGrade> expNeedList = new List<DRHeroGrade>();

	private int levelMaxConfig;

	private int levelAdd;

	private int expAdd;

	private int expMax;

	private int expLeft;

	private int exp2MaxLevelNeed;

	private bool isLevelMax;

	private Dictionary<string, PropertyData> propertyDatas;

	public HeroModel HeroModel
	{
		get
		{
			return heroModel;
		}
		private set
		{
			Set(ref heroModel, value, "HeroModel");
		}
	}

	public string ShowName => showName;

	public int LevelAdd
	{
		get
		{
			return levelAdd;
		}
		private set
		{
			Set(ref levelAdd, value, "LevelAdd");
		}
	}

	public int ExpAdd
	{
		get
		{
			return expAdd;
		}
		private set
		{
			Set(ref expAdd, value, "ExpAdd");
		}
	}

	public int ExpMax
	{
		get
		{
			return expMax;
		}
		private set
		{
			Set(ref expMax, value, "ExpMax");
		}
	}

	public bool IsLevelMax
	{
		get
		{
			return isLevelMax;
		}
		private set
		{
			Set(ref isLevelMax, value, "IsLevelMax");
		}
	}

	public float LevelExpFillCur
	{
		get
		{
			return levelExpFillCur;
		}
		private set
		{
			Set(ref levelExpFillCur, value, "LevelExpFillCur");
		}
	}

	public float LevelExpFillAdd
	{
		get
		{
			return levelExpFillAdd;
		}
		private set
		{
			Set(ref levelExpFillAdd, value, "LevelExpFillAdd");
		}
	}

	public long CoinDataAmount
	{
		get
		{
			return coinDataAmount;
		}
		private set
		{
			Set(ref coinDataAmount, value, "CoinDataAmount");
		}
	}

	public int CoinNeed
	{
		get
		{
			return coinNeed;
		}
		private set
		{
			Set(ref coinNeed, value, "CoinNeed");
		}
	}

	public int UseCount
	{
		get
		{
			return useCount;
		}
		private set
		{
			Set(ref useCount, value, "UseCount");
			SetExpAdd();
		}
	}

	public float UseFillAmount
	{
		get
		{
			return useFillAmount;
		}
		set
		{
			if (value < useFillAmountMin)
			{
				fixSliderRequest.Raise(useFillAmountMin);
			}
			else if (useCountMax == 0)
			{
				Set(ref useFillAmount, 1f, "UseFillAmount");
				fixSliderRequest.Raise(1f);
				SetUseCount();
			}
			else
			{
				Set(ref useFillAmount, value, "UseFillAmount");
				SetUseCount();
			}
		}
	}

	public bool CanAdd
	{
		get
		{
			return canAdd;
		}
		private set
		{
			Set(ref canAdd, value, "CanAdd");
		}
	}

	public bool CanDec
	{
		get
		{
			return canDec;
		}
		private set
		{
			Set(ref canDec, value, "CanDec");
		}
	}

	public int UseCountMax => useCountMax;

	public float UseFillAmountMin => useFillAmountMin;

	public ICommand ConfirmCmd => confirmCmd;

	public List<KnapsackItemViewModel> ExpItemDatas => expItemDatas;

	public IInteractionRequest FixSliderRequest => fixSliderRequest;

	public override void ItemOnClick(object obj)
	{
		if (obj is KnapsackItemViewModel cur)
		{
			SetCurSelected(cur);
		}
	}

	public HeroUpgradeViewModel()
	{
	}

	public HeroUpgradeViewModel(OptionBase parent, HeroModel heroModel)
	{
		this.heroModel = heroModel;
		showName = heroModel.Name;
		base.parent = parent;
		fixSliderRequest = new InteractionRequest<float>();
		confirmCmd = new SimpleCommand(Confirm);
		levelMaxConfig = Singleton<OuterSystem>.Instance.GetConstantConfigInt(Constant.ConstantConfig.MaxLevelHero, 40);
		DRProp[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRProp>();
		expItemIds = new List<int>();
		DRProp[] array = allDataRow;
		foreach (DRProp dRProp in array)
		{
			if (dRProp.UseType == null || dRProp.UseType.Count <= 0)
			{
				continue;
			}
			foreach (int item in dRProp.UseType)
			{
				if (item == 1)
				{
					expItemIds.Add(dRProp.Id);
				}
			}
		}
		knapsackViewModel = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetKnapsackViewModel();
		for (int j = 0; j < expItemIds.Count; j++)
		{
			KnapsackPropData prop = knapsackViewModel.GetProp(expItemIds[j]);
			if (prop != null)
			{
				expItemDatas.Add(new KnapsackItemViewModel(this, prop));
			}
			else
			{
				expItemDatas.Add(new KnapsackItemViewModel(this, KnapsackPropData.Create(expItemIds[j], 0)));
			}
		}
		moneyData = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetMoneyData();
		coinDataAmount = MoneyDefinition.GetMoneyCount(RoleMoneyEnum.Coin);
		DRHeroGrade[] allDataRow2 = GameEntry.DataTable.GetAllDataRow<DRHeroGrade>();
		for (int k = 0; k < heroModel.CurMaxLevel; k++)
		{
			expNeedList.Add(allDataRow2[k]);
		}
		Init();
	}

	public void InitPropertyList()
	{
		List<string> obj = new List<string> { "Attack", "Hp", "Defence" };
		propertyDatas = new Dictionary<string, PropertyData>();
		foreach (string item in obj)
		{
			PropertyData value = new PropertyData(item);
			propertyDatas.Add(item, value);
		}
	}

	public void GetPropertyList(bool SetOld)
	{
		NumericalProperty totalProperty = heroModel.TotalProperty;
		if (SetOld)
		{
			propertyDatas["Attack"].Value1 = totalProperty.GetTotalProperty("Attack");
			propertyDatas["Hp"].Value1 = totalProperty.GetTotalProperty("Hp");
			propertyDatas["Defence"].Value1 = totalProperty.GetTotalProperty("Defence");
		}
		else
		{
			propertyDatas["Attack"].Value2 = totalProperty.GetTotalProperty("Attack");
			propertyDatas["Hp"].Value2 = totalProperty.GetTotalProperty("Hp");
			propertyDatas["Defence"].Value2 = totalProperty.GetTotalProperty("Defence");
		}
	}

	public void SetExpCur()
	{
		ExpMax = ((heroModel.Level < heroModel.CurMaxLevel) ? expNeedList[heroModel.Level].NeedExp : 0);
		LevelExpFillCur = ((expMax == 0) ? 0f : ((float)heroModel.Exp * 1f / (float)expMax));
	}

	public void SetExpAdd()
	{
		ExpAdd = ((PropData)curSelected.PropDataBase).Ex1 * useCount;
		LevelExpFillAdd = ((expMax == 0) ? 0f : ((heroModel.Exp + expAdd > expMax) ? 1f : ((float)(heroModel.Exp + expAdd) * 1f / (float)expMax)));
		CalLevelAdd();
		IsLevelMax = heroModel.Level + LevelAdd >= heroModel.CurMaxLevel;
	}

	private void CalLevelAdd()
	{
		int num = (int)heroModel.Exp + expAdd;
		int num2 = 0;
		int num3 = 0;
		float num4 = 0f;
		float num5 = 0f;
		for (int i = heroModel.Level; i < heroModel.CurMaxLevel; i++)
		{
			num5 = (float)expNeedList[i].NeedGold * 1f / (float)expNeedList[i].NeedExp;
			if (num >= expNeedList[i].NeedExp)
			{
				num2++;
				num -= expNeedList[i].NeedExp;
				num4 = ((i != heroModel.Level) ? (num4 + (float)expNeedList[i].NeedGold) : ((heroModel.Exp != 0L) ? (num4 + num5 * (float)(expNeedList[i].NeedExp - (int)heroModel.Exp)) : (num4 + (float)expNeedList[i].NeedGold)));
				continue;
			}
			num4 = ((num2 <= 0) ? (num4 + (float)(num - (int)heroModel.Exp) * num5) : (num4 + (float)num * num5));
			break;
		}
		LevelAdd = num2;
		num3 = ((heroModel.Level + levelAdd >= heroModel.CurMaxLevel) ? (expAdd - num) : expAdd);
		CoinNeed = ((num3 > 0) ? Mathf.CeilToInt(num4) : 0);
		expLeft = ((expAdd - num3 > 0) ? (expAdd - num3) : 0);
	}

	private void Init()
	{
		InitPropertyList();
		exp2MaxLevelNeed = GetExp2MaxLevelNeed();
		SetDefaultExpItem();
		SetExpItemActive();
		SetExpCur();
		SetExpAdd();
	}

	private void Refresh(KnapsackItemViewModel cur)
	{
		SetExpItemActive();
		exp2MaxLevelNeed = GetExp2MaxLevelNeed();
		SetCurSelected(cur, forceSet: true);
		SetExpCur();
		SetExpAdd();
	}

	private void SetCurSelected(KnapsackItemViewModel cur, bool forceSet = false)
	{
		if (curSelected == null || forceSet || cur != curSelected)
		{
			if (curSelected != null)
			{
				curSelected.IsSelected = false;
			}
			curSelected = cur;
			curSelected.IsSelected = true;
			CalExpItemCountRange();
			UseFillAmount = CalUseFillAmount((curSelected.PropDataBase.Amount != 0) ? 1 : 0);
		}
	}

	private void CalExpItemCountRange()
	{
		if (curSelected.PropDataBase.Amount == 0)
		{
			useCountMin = 0;
			useCountMax = 0;
			useFillAmountMin = 0f;
			return;
		}
		useCountMin = ((exp2MaxLevelNeed > 0) ? 1 : 0);
		int ex = ((PropData)curSelected.PropDataBase).Ex1;
		useCountMax = ((exp2MaxLevelNeed % ex == 0) ? (exp2MaxLevelNeed / ex) : (exp2MaxLevelNeed / ex + 1));
		if (useCountMax > curSelected.PropDataBase.Amount)
		{
			useCountMax = curSelected.PropDataBase.Amount;
		}
		useFillAmountMin = ((useCountMax == 0) ? 0f : ((float)useCountMin * 1f / (float)useCountMax));
	}

	private float CalUseFillAmount(int useCount)
	{
		if (useCountMax != 0)
		{
			return (float)useCount * 1f / (float)useCountMax;
		}
		return 0f;
	}

	private void SetUseCount(int i = -1)
	{
		if (i == -1)
		{
			UseCount = Mathf.Clamp((int)(useFillAmount * (float)useCountMax), useCountMin, useCountMax);
		}
		else
		{
			UseCount = i;
		}
		CanDec = useCount > useCountMin;
		CanAdd = useCount < useCountMax;
	}

	public async void Confirm()
	{
		if (coinNeed > MoneyDefinition.GetMoneyCount(RoleMoneyEnum.Coin) || useCount <= 0 || curSelected == null || heroModel.Level >= heroModel.CurMaxLevel)
		{
			return;
		}
		confirmCmd.Enabled = false;
		if (expLeft > 0)
		{
			int num = expLeft;
			List<KnapsackItemViewModel> list = expItemDatas.OrderBy((KnapsackItemViewModel p) => ((PropData)p.PropDataBase).Ex1).Reverse().ToList();
			List<KnapsackPropData> list2 = new List<KnapsackPropData>();
			foreach (KnapsackItemViewModel item in list)
			{
				PropData propData = (PropData)item.PropDataBase;
				if (propData.UseType == null || propData.UseType.Count <= 0)
				{
					continue;
				}
				foreach (int item2 in propData.UseType)
				{
					if (item2 == 7)
					{
						int ex = propData.Ex1;
						if (ex != 0 && ex <= num)
						{
							int num2 = num / ex;
							list2.Add(KnapsackPropData.Create(item.PropDataBase.Id, num2));
							num -= num2 * ex;
						}
						break;
					}
				}
			}
			if (list2.Count > 0)
			{
				ExpPropReturnViewModel returnViewModel = new ExpPropReturnViewModel(this, list2);
				openWindowRequest.Raise(new OpenViewArg(typeof(ExpPropReturnWindow), returnViewModel), delegate
				{
					if (returnViewModel.result)
					{
						RequestUpgrade();
					}
					else
					{
						confirmCmd.Enabled = true;
					}
				});
				return;
			}
		}
		RequestUpgrade();
	}

	private async void RequestUpgrade()
	{
		if (heroModel == null || curSelected == null)
		{
			return;
		}
		int levelOld = heroModel.Level;
		List<PbItemBase> propList = new List<PbItemBase>();
		PbItemBase pbItemBase = new PbItemBase();
		pbItemBase.ItemType = 1;
		pbItemBase.ItemCount = useCount;
		pbItemBase.ItemId = curSelected.PropDataBase.Id;
		propList.Add(pbItemBase);
		GetPropertyList(SetOld: true);
		Loading loading = await Loading.Show();
		try
		{
			RequestResult requestResult = await Singleton<ServiceSystem>.Instance.GetService<IHeroService>().HeroUpgradeNew(propList, heroModel);
			loading.Dispose();
			if (requestResult != null && requestResult.success)
			{
				if (heroModel.Level != levelOld)
				{
					GetPropertyList(SetOld: false);
					UpgradeSuccessViewModel userData = new UpgradeSuccessViewModel(this, heroModel, levelOld, propertyDatas.Values.ToList());
					bool hasReturnProp = false;
					PropGetViewModel propGetViewModel = null;
					if (requestResult.obj != null && requestResult.obj is List<KnapsackPropData> { Count: >0 } list)
					{
						propGetViewModel = new PropGetViewModel(this, list);
						hasReturnProp = true;
					}
					openWindowRequest.Raise(new OpenViewArg(typeof(UpgradeSuccessWindow), userData), delegate
					{
						if (hasReturnProp)
						{
							openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), propGetViewModel), delegate
							{
								confirmCmd.Enabled = true;
								OnChildViewClose();
							});
						}
						else
						{
							confirmCmd.Enabled = true;
						}
					});
					parent.ItemOnClick(new OptionArg(heroModel.Id, "Option_HeroUpgradeSuccess"));
					if (!hasReturnProp)
					{
						OnChildViewClose();
					}
					else
					{
						base.IsVisible = false;
					}
				}
				else
				{
					confirmCmd.Enabled = true;
				}
				if (parent != null)
				{
					Refresh(curSelected);
					CoinDataAmount = MoneyDefinition.GetMoneyCount(RoleMoneyEnum.Coin);
					parent.ItemOnClick(this);
				}
			}
			else
			{
				Toast.ShowInfo("烬天使升级失败，请重试！");
				parent.ItemOnClick(requestResult.obj);
				confirmCmd.Enabled = true;
				Close();
			}
		}
		catch (Exception)
		{
			loading.Dispose();
		}
	}

	private void OnChildViewClose()
	{
		if (heroModel.Level == heroModel.CurMaxLevel)
		{
			Close();
		}
	}

	public void AddProp()
	{
		if (useCount < useCountMax)
		{
			int num = useCount + 1;
			UseFillAmount = CalUseFillAmount(num);
			SetUseCount(num);
		}
	}

	public void DecProp()
	{
		if (useCount > 1)
		{
			int num = useCount - 1;
			UseFillAmount = CalUseFillAmount(num);
			SetUseCount(num);
		}
	}

	private int GetExp2MaxLevelNeed()
	{
		int num = 0;
		for (int i = heroModel.Level; i < heroModel.CurMaxLevel; i++)
		{
			num += expNeedList[i].NeedExp;
		}
		if (num < (int)heroModel.Exp)
		{
			return 0;
		}
		return num - (int)heroModel.Exp;
	}

	private void SetDefaultExpItem()
	{
		bool flag = false;
		foreach (KnapsackItemViewModel expItemData in expItemDatas)
		{
			if (expItemData.PropDataBase.Amount > 0)
			{
				flag = true;
				break;
			}
		}
		int index = 0;
		if (!flag)
		{
			for (int i = 0; i < expItemDatas.Count; i++)
			{
				if (((PropData)expItemDatas[i].PropDataBase).Ex1 < ((PropData)expItemDatas[index].PropDataBase).Ex1)
				{
					index = i;
				}
			}
			SetCurSelected(expItemDatas[index]);
			return;
		}
		index = 0;
		for (int j = 0; j < expItemDatas.Count; j++)
		{
			if (expItemDatas[j].PropDataBase.Amount > 0 && ((PropData)expItemDatas[j].PropDataBase).Ex1 > ((PropData)expItemDatas[index].PropDataBase).Ex1)
			{
				index = j;
			}
		}
		SetCurSelected(expItemDatas[index]);
	}

	private void SetExpItemActive()
	{
		foreach (KnapsackItemViewModel expItemData in ExpItemDatas)
		{
			expItemData.IsActive = expItemData.PropDataBase.Amount > 0;
		}
	}
}
