using System.Collections.Generic;
using System.Text;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class HeroGrowRarityInfoViewModel : OptionBase
{
	private int _heroId;

	private int _optType;

	private int _point;

	private string _seatIcon1 = "";

	private string _seatName1;

	private string _seatIcon2 = "";

	private string _seatName2;

	private string _pointIcon = "";

	private string _effectDesc;

	private string _affixNames;

	private string _affixValues;

	private KnapsackItemViewModel _costPropData;

	private string _buttonText;

	private Color _buttonTextColor;

	private int _buttonState;

	private bool isSelf;

	private DRHeroSeat _drHeroSeat;

	private HeroGrowRarityItemData.ItemStateEnum _itemState;

	private SimpleCommand lightCmd;

	public HeroGrowRarityItemData.ItemStateEnum ItemState
	{
		get
		{
			return _itemState;
		}
		set
		{
			Set(ref _itemState, value, "ItemState");
		}
	}

	public int HeroId
	{
		get
		{
			return _heroId;
		}
		private set
		{
			Set(ref _heroId, value, "HeroId");
		}
	}

	public int OptType
	{
		get
		{
			return _optType;
		}
		private set
		{
			Set(ref _optType, value, "OptType");
		}
	}

	public int Point
	{
		get
		{
			return _point;
		}
		private set
		{
			_point = value;
		}
	}

	public string SeatIcon1
	{
		get
		{
			return _seatIcon1;
		}
		set
		{
			Set(ref _seatIcon1, value, "SeatIcon1");
		}
	}

	public string SeatName1
	{
		get
		{
			return _seatName1;
		}
		set
		{
			Set(ref _seatName1, value, "SeatName1");
		}
	}

	public string SeatIcon2
	{
		get
		{
			return _seatIcon2;
		}
		set
		{
			Set(ref _seatIcon2, value, "SeatIcon2");
		}
	}

	public string SeatName2
	{
		get
		{
			return _seatName2;
		}
		set
		{
			Set(ref _seatName2, value, "SeatName2");
		}
	}

	public string PointIcon
	{
		get
		{
			return _pointIcon;
		}
		set
		{
			Set(ref _pointIcon, value, "PointIcon");
		}
	}

	public string EffectDesc
	{
		get
		{
			return _effectDesc;
		}
		set
		{
			Set(ref _effectDesc, value.Replace("\\n", "\n"), "EffectDesc");
		}
	}

	public string AffixNames
	{
		get
		{
			return _affixNames;
		}
		set
		{
			Set(ref _affixNames, value, "AffixNames");
		}
	}

	public string AffixValues
	{
		get
		{
			return _affixValues;
		}
		set
		{
			Set(ref _affixValues, value, "AffixValues");
		}
	}

	public int ButtonState
	{
		get
		{
			return _buttonState;
		}
		set
		{
			Set(ref _buttonState, value, "ButtonState");
		}
	}

	public string ButtonText
	{
		get
		{
			return _buttonText;
		}
		set
		{
			Set(ref _buttonText, value, "ButtonText");
		}
	}

	public Color ButtonTextColor
	{
		get
		{
			return _buttonTextColor;
		}
		set
		{
			Set(ref _buttonTextColor, value, "ButtonTextColor");
		}
	}

	public bool IsSelf
	{
		get
		{
			return isSelf;
		}
		set
		{
			Set(ref isSelf, value, "IsSelf");
		}
	}

	public KnapsackItemViewModel CostPropData => _costPropData;

	public SimpleCommand LightCmd => lightCmd;

	public HeroGrowRarityInfoViewModel()
	{
	}

	public HeroGrowRarityInfoViewModel(OptionBase parent, bool isSelf = true)
	{
		base.parent = parent;
		lightCmd = new SimpleCommand(OnLightBtnClick);
		IsSelf = isSelf;
		_costPropData = new KnapsackItemViewModel(this, showOwner: false, showName: false, showOwnedAndRequiredCount: true);
	}

	public void Hide()
	{
		parent?.ItemOnClick(new OptionArg(this, "Hide"));
	}

	public void Refresh(DRHeroSeat drHeroSeat, HeroGrowRarityItemData.ItemStateEnum itemState, int optType, int point = 0)
	{
		_drHeroSeat = drHeroSeat;
		ItemState = itemState;
		HeroId = drHeroSeat.HeroId;
		OptType = optType;
		Point = point;
		RefreshIconAndName();
		RefreshDesc();
		RefreshCostProp();
		RefreshButton();
	}

	private void RefreshIconAndName()
	{
		if (OptType == 1)
		{
			switch (Point)
			{
			case 1:
				PointIcon = _drHeroSeat.PropIcon1;
				break;
			case 2:
				PointIcon = _drHeroSeat.PropIcon2;
				break;
			case 3:
				PointIcon = _drHeroSeat.PropIcon3;
				break;
			case 4:
				PointIcon = _drHeroSeat.PropIcon4;
				break;
			}
		}
		else if (OptType == 2)
		{
			DRHeroSeat dataRow = GameEntry.DataTable.GetDataRow((DRHeroSeat p) => p.HeroId == _drHeroSeat.HeroId && p.TargetSeat == _drHeroSeat.TargetSeat - 1);
			if (dataRow != null)
			{
				SeatIcon1 = $"Hero_Seat_{dataRow.TargetSeat}";
				SeatName1 = dataRow.SeatName;
			}
			SeatIcon2 = $"Hero_Seat_{_drHeroSeat.TargetSeat}";
			SeatName2 = _drHeroSeat.SeatName;
		}
	}

	private void RefreshDesc()
	{
		StringBuilder stringBuilder = new StringBuilder();
		StringBuilder stringBuilder2 = new StringBuilder();
		if (OptType == 1)
		{
			List<int> list = new List<int>();
			List<float> list2 = new List<float>();
			switch (Point)
			{
			case 1:
				list = _drHeroSeat.Prop1;
				list2 = _drHeroSeat.PropValue1;
				break;
			case 2:
				list = _drHeroSeat.Prop2;
				list2 = _drHeroSeat.PropValue2;
				break;
			case 3:
				list = _drHeroSeat.Prop3;
				list2 = _drHeroSeat.PropValue3;
				break;
			case 4:
				list = _drHeroSeat.Prop4;
				list2 = _drHeroSeat.PropValue4;
				break;
			}
			for (int i = 0; i < list.Count; i++)
			{
				DRAffix dataRow = GameEntry.DataTable.GetDataRow<DRAffix>(list[i]);
				if (dataRow != null)
				{
					float num = ((list2.Count > i) ? list2[i] : 0f);
					string text = ((dataRow.Type == 2) ? NumericalExtension.GetOuterDisplayPercentValue(num) : NumericalExtension.GetOuterDisplayValue(num));
					stringBuilder.AppendLine(dataRow.Desc);
					stringBuilder2.AppendLine(text ?? "");
				}
			}
			EffectDesc = string.Empty;
		}
		else if (OptType == 2)
		{
			List<float> list3 = new List<float>();
			List<float> list4 = new List<float>();
			List<float> list5 = new List<float>();
			DRHeroInfo dataRow2 = GameEntry.DataTable.GetDataRow<DRHeroInfo>(HeroId);
			if (dataRow2 != null)
			{
				list3 = dataRow2.GrowAttack;
				list4 = dataRow2.GrowDefense;
				list5 = dataRow2.GrowHP;
			}
			int targetSeat = _drHeroSeat.TargetSeat;
			float num2 = ((list3.Count > targetSeat - 1) ? list3[targetSeat - 1] : 0f);
			float num3 = ((list3.Count > targetSeat) ? list3[targetSeat] : 0f);
			float num4 = ((list4.Count > targetSeat - 1) ? list4[targetSeat - 1] : 0f);
			float num5 = ((list4.Count > targetSeat) ? list4[targetSeat] : 0f);
			float num6 = ((list5.Count > targetSeat - 1) ? list5[targetSeat - 1] : 0f);
			float num7 = ((list5.Count > targetSeat) ? list5[targetSeat] : 0f);
			if (num3 > num2 || num5 > num4 || num7 > num6)
			{
				stringBuilder.AppendLine("<align=left><color=#686563><size=24>·基础属性成长提升</size></color></align>");
				stringBuilder2.AppendLine();
			}
			if (num3 > num2)
			{
				stringBuilder.AppendLine("攻击成长");
				stringBuilder2.AppendLine("+" + NumericalExtension.GetOuterDisplayValue(num3 - num2));
			}
			if (num5 > num4)
			{
				stringBuilder.AppendLine("防御成长");
				stringBuilder2.AppendLine("+" + NumericalExtension.GetOuterDisplayValue(num5 - num4));
			}
			if (num7 > num6)
			{
				stringBuilder.AppendLine("生命成长");
				stringBuilder2.AppendLine("+" + NumericalExtension.GetOuterDisplayValue(num7 - num6));
			}
			if (_drHeroSeat.UpProp.Count > 0)
			{
				stringBuilder.AppendLine("<align=left><color=#686563><size=24>·基础属性提升</size></color></align>");
				stringBuilder2.AppendLine();
				for (int j = 0; j < _drHeroSeat.UpProp.Count; j++)
				{
					DRAffix dataRow3 = GameEntry.DataTable.GetDataRow<DRAffix>(_drHeroSeat.UpProp[j]);
					if (dataRow3 != null)
					{
						float num8 = ((_drHeroSeat.UpPropValue.Count > j) ? _drHeroSeat.UpPropValue[j] : 0f);
						string text2 = ((dataRow3.Type == 2) ? NumericalExtension.GetOuterDisplayPercentValue(num8) : NumericalExtension.GetOuterDisplayValue(num8));
						stringBuilder.AppendLine(dataRow3.Desc);
						stringBuilder2.AppendLine(text2 ?? "");
					}
				}
			}
			StringBuilder stringBuilder3 = new StringBuilder();
			for (int k = 0; k < _drHeroSeat.UpBattleValue.Count; k++)
			{
				int skillEffectId = _drHeroSeat.UpBattleValue[k];
				DRCultivateSkillEffect dataRow4 = GameEntry.DataTable.GetDataRow((DRCultivateSkillEffect p) => p.Id == skillEffectId);
				if (dataRow4 != null)
				{
					stringBuilder3.AppendLine(dataRow4.SkillEffectDesc);
				}
			}
			EffectDesc = stringBuilder3.ToString();
		}
		AffixNames = stringBuilder.ToString();
		AffixValues = stringBuilder2.ToString();
	}

	private void RefreshCostProp()
	{
		DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(_drHeroSeat.NeedItem);
		if (dataRow != null)
		{
			int amount = 0;
			if (OptType == 1)
			{
				amount = ((_drHeroSeat.ItemNum.Count >= Point) ? _drHeroSeat.ItemNum[Point - 1] : 0);
			}
			else if (OptType == 2)
			{
				amount = _drHeroSeat.UpItemNum;
			}
			_costPropData.Refresh(new PropData(dataRow, amount));
		}
	}

	private void RefreshButton()
	{
		bool flag = ItemState == HeroGrowRarityItemData.ItemStateEnum.Enough;
		ButtonState = (flag ? 1 : 0);
		if (IsSelf)
		{
			if (flag)
			{
				ButtonText = ((OptType == 1) ? "激活" : "突破");
				ButtonTextColor = Color.white;
			}
			else if (ItemState == HeroGrowRarityItemData.ItemStateEnum.Lighted)
			{
				ButtonText = ((OptType == 1) ? "已激活" : "已突破");
				ButtonTextColor = Color.gray;
			}
			else if (ItemState == HeroGrowRarityItemData.ItemStateEnum.Lock)
			{
				ButtonText = "需先激活前置";
				ButtonTextColor = Color.gray;
			}
			else if (ItemState == HeroGrowRarityItemData.ItemStateEnum.NotEnough)
			{
				ButtonText = "道具不足";
				ButtonTextColor = Color.gray;
			}
		}
		else if (flag || ItemState == HeroGrowRarityItemData.ItemStateEnum.Lock || ItemState == HeroGrowRarityItemData.ItemStateEnum.NotEnough)
		{
			ButtonText = ((OptType == 1) ? "未激活" : "未突破");
			ButtonTextColor = Color.gray;
		}
		else if (ItemState == HeroGrowRarityItemData.ItemStateEnum.Lighted)
		{
			ButtonText = ((OptType == 1) ? "已激活" : "已突破");
			ButtonTextColor = Color.gray;
		}
	}

	private void OnLightBtnClick()
	{
		if (ButtonState == 1)
		{
			lightCmd.Enabled = false;
			parent.ItemOnClick(new OptionArg(this, "Light"));
		}
	}

	public void OnLightFinish(bool success)
	{
		lightCmd.Enabled = true;
		Hide();
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is KnapsackItemViewModel obj2)
		{
			parent.ItemOnClick(obj2);
		}
	}
}
