#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class HCTDescViewModel : OptionBase
{
	private string btnText = "123";

	private bool isBig = true;

	private string typeName;

	private HCTSkillItemViewModel hctSkillVm;

	private HCTSkillItemViewModel hctNextSkillVm;

	private InteractionRequest updateMaterialRequest;

	protected InteractionRequest refreshCurRequest;

	private InteractionRequest updateAffixRequest;

	private SimpleCommand activeCommand;

	private List<CastingMaterialItemData> materialItemDatas;

	private int goldCount;

	private bool isLackGold;

	private long curGoldCount;

	private bool enableUpgrade;

	private string disableDesc = "456";

	private List<TextItemViewModel> textItemVMs;

	private List<string> smallDescList;

	private string skillTypeName = "";

	private string smallTypeName = "";

	private string smallDesc = "";

	private int smallTinderType;

	private bool isSelf;

	private bool isBigMax;

	private bool isSmallActive;

	public string SkillTypeName
	{
		get
		{
			return skillTypeName;
		}
		private set
		{
			Set(ref skillTypeName, value, "SkillTypeName");
		}
	}

	public string SmallTypeName
	{
		get
		{
			return smallTypeName;
		}
		private set
		{
			Set(ref smallTypeName, value, "SmallTypeName");
		}
	}

	public string SmallDesc
	{
		get
		{
			return smallDesc;
		}
		private set
		{
			Set(ref smallDesc, value, "SmallDesc");
		}
	}

	public bool IsBig
	{
		get
		{
			return isBig;
		}
		private set
		{
			Set(ref isBig, value, "IsBig");
		}
	}

	public bool IsBigMax
	{
		get
		{
			return isBigMax;
		}
		private set
		{
			Set(ref isBigMax, value, "IsBigMax");
		}
	}

	public bool IsSmallActive
	{
		get
		{
			return isSmallActive;
		}
		private set
		{
			Set(ref isSmallActive, value, "IsSmallActive");
		}
	}

	public string BtnText
	{
		get
		{
			return btnText;
		}
		private set
		{
			Set(ref btnText, value, "BtnText");
		}
	}

	public int GoldCount
	{
		get
		{
			return goldCount;
		}
		private set
		{
			Set(ref goldCount, value, "GoldCount");
		}
	}

	public int SmallTinderType
	{
		get
		{
			return smallTinderType;
		}
		private set
		{
			Set(ref smallTinderType, value, "SmallTinderType");
		}
	}

	public bool EnableUpgrade
	{
		get
		{
			return enableUpgrade;
		}
		private set
		{
			Set(ref enableUpgrade, value, "EnableUpgrade");
		}
	}

	public bool IsLackGold
	{
		get
		{
			return isLackGold;
		}
		private set
		{
			Set(ref isLackGold, value, "IsLackGold");
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

	public HCTSkillItemViewModel HCTSkillVm => hctSkillVm;

	public HCTSkillItemViewModel HCTNextSkillVm => hctNextSkillVm;

	public List<string> SmallDescList => smallDescList;

	public string DisableDesc
	{
		get
		{
			return disableDesc;
		}
		private set
		{
			Set(ref disableDesc, value, "DisableDesc");
		}
	}

	public List<TextItemViewModel> TextItemVMs => textItemVMs;

	public List<CastingMaterialItemData> MaterialItemDatas => materialItemDatas;

	public ICommand ActiveCommand => activeCommand;

	public IInteractionRequest RefreshCurRequest => refreshCurRequest;

	public IInteractionRequest UpdateMaterialRequest => updateMaterialRequest;

	public IInteractionRequest UpdateAffixRequest => updateAffixRequest;

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is CastingMaterialItemData obj2)
		{
			parent?.ItemOnClick(obj2);
		}
	}

	public HCTDescViewModel()
	{
	}

	public HCTDescViewModel(OptionBase parent, bool isSelf = true)
	{
		base.parent = parent;
		activeCommand = new SimpleCommand(OnActiveClick);
		materialItemDatas = new List<CastingMaterialItemData>();
		updateMaterialRequest = new InteractionRequest();
		updateAffixRequest = new InteractionRequest();
		refreshCurRequest = new InteractionRequest();
		textItemVMs = new List<TextItemViewModel>();
		IsSelf = isSelf;
	}

	public void OnSkillSelect(HCTPointItemViewModel pointVM, HCTSkillItemViewModel skill, List<string> smallDescList, HeroModel heroModel)
	{
		hctSkillVm = skill;
		this.smallDescList = smallDescList;
		IsBig = pointVM.PointType == HCSPointType.Big;
		if (!isBig)
		{
			SmallTinderType = pointVM.TalentSmall.TinderType;
			SmallTypeName = ((pointVM.TalentSmall.TinderType == 1) ? "技能效果提升" : ((pointVM.TalentSmall.TinderType == 2) ? "属性提升" : "额外战斗效果"));
			SmallDesc = GetSmallDesc(pointVM);
			textItemVMs.Clear();
			if (pointVM.TalentSmall.TinderType == 2)
			{
				for (int i = 0; i < pointVM.TalentSmall.AttributeId.Count; i++)
				{
					int affixId = pointVM.TalentSmall.AttributeId[i];
					float value = pointVM.TalentSmall.AttributeNum[i];
					TextItemViewModel item = SettleDRAffixData(affixId, value);
					textItemVMs.Add(item);
				}
			}
			updateAffixRequest.Raise();
		}
		else
		{
			SkillTypeName = skill.Data.SkillType;
			if (hctNextSkillVm == null || hctNextSkillVm.Data.SkillId != pointVM.SkillId || hctNextSkillVm.Data.Level != pointVM.CurProgress + 1)
			{
				HCTSkillData nextSkillData = heroModel.GetNextSkillData(hctSkillVm.Data);
				if (hctNextSkillVm == null)
				{
					hctNextSkillVm = new HCTSkillItemViewModel(this, nextSkillData);
				}
				else
				{
					hctNextSkillVm.RefreshData(nextSkillData);
				}
			}
		}
		materialItemDatas.Clear();
		for (int j = 0; j < pointVM.PropNeedIds.Count; j++)
		{
			if (pointVM.PropNeedNums.Count <= j)
			{
				Log.Error("燃点或火种表材料配置有误");
				Toast.ShowError("燃点或火种表材料配置有误");
				continue;
			}
			KnapsackPropData knapsackPropData = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetKnapsackViewModel().GetProp(pointVM.PropNeedIds[j]);
			if (knapsackPropData == null)
			{
				knapsackPropData = KnapsackPropData.Create(pointVM.PropNeedIds[j], 0);
			}
			materialItemDatas.Add(new CastingMaterialItemData(this, pointVM.PropNeedNums[j], knapsackPropData));
		}
		updateMaterialRequest.Raise();
		GoldCount = pointVM.GoldCount;
		IsLackGold = pointVM.IsLackGold;
		SetButtonEnable(pointVM.PointType, pointVM.PointState, pointVM.DisableDesc);
	}

	public void OnRefreshMaterials(HCTPointItemViewModel pointVM)
	{
		materialItemDatas.Clear();
		for (int i = 0; i < pointVM.PropNeedIds.Count; i++)
		{
			if (pointVM.PropNeedNums.Count <= i)
			{
				Log.Error("燃点或火种表材料配置有误");
				Toast.ShowError("燃点或火种表材料配置有误");
				continue;
			}
			KnapsackPropData knapsackPropData = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetKnapsackViewModel().GetProp(pointVM.PropNeedIds[i]);
			if (knapsackPropData == null)
			{
				knapsackPropData = KnapsackPropData.Create(pointVM.PropNeedIds[i], 0);
			}
			materialItemDatas.Add(new CastingMaterialItemData(this, pointVM.PropNeedNums[i], knapsackPropData));
		}
		updateMaterialRequest.Raise();
		GoldCount = pointVM.GoldCount;
		IsLackGold = pointVM.IsLackGold;
		SetButtonEnable(pointVM.PointType, pointVM.PointState, pointVM.DisableDesc);
	}

	private string GetSmallDesc(HCTPointItemViewModel pointVM)
	{
		if (pointVM.TalentSmall.TinderType == 1)
		{
			string text = "";
			int bv;
			for (bv = 0; bv < pointVM.TalentSmall.BattleValue.Count; bv++)
			{
				DRCultivateSkillEffect dataRow = GameEntry.DataTable.GetDataRow((DRCultivateSkillEffect p) => p.Id == pointVM.TalentSmall.BattleValue[bv]);
				if (dataRow == null)
				{
					Log.Error($"CultivateSkillEffect表找不到配置Id【{pointVM.TalentSmall.BattleValue[bv]}】,TalentSmall Id【{pointVM.TalentSmall.Id}】");
				}
				else
				{
					text = ((bv <= 0 || string.IsNullOrEmpty(dataRow.SkillEffectDesc)) ? (text + dataRow.SkillEffectDesc) : (text + "\\n" + dataRow.SkillEffectDesc));
				}
			}
			return ReplaceDesc(text);
		}
		if (pointVM.TalentSmall.TinderType == 2)
		{
			return "";
		}
		DRBuff dataRow2 = GameEntry.DataTable.GetDataRow((DRBuff p) => p.Id == pointVM.TalentSmall.BattleBuffId);
		if (dataRow2 == null)
		{
			Log.Error($"Buff表找不到配置Id【{pointVM.TalentSmall.BattleBuffId}】,TalentSmall Id【{pointVM.TalentSmall.Id}】");
			return "";
		}
		return ReplaceDesc(dataRow2.Desc);
	}

	private TextItemViewModel SettleDRAffixData(int affixId, float value)
	{
		DRAffix dataRow = GameEntry.DataTable.GetDataRow<DRAffix>(affixId);
		TextItemViewModel textItemViewModel = new TextItemViewModel(this);
		if (dataRow != null)
		{
			textItemViewModel.Text1 = dataRow.Desc;
			if (dataRow.Type == 1)
			{
				textItemViewModel.Text2 = $"+{Math.Round(value, MidpointRounding.AwayFromZero)}";
			}
			else
			{
				textItemViewModel.Text2 = "+" + Math.Round((decimal)value, 3, MidpointRounding.AwayFromZero).ToString("P1");
			}
		}
		else
		{
			Toast.ShowError($"Affix表找不到配置,Id:【{affixId}】");
		}
		return textItemViewModel;
	}

	public Color GetColor(int index)
	{
		string htmlString = "";
		switch (index)
		{
		case 1:
			htmlString = "#e7b6b1";
			break;
		case 2:
			htmlString = "#bbcab2";
			break;
		case 3:
			htmlString = "#b8cde7";
			break;
		case 4:
			htmlString = "#f493ff";
			break;
		}
		ColorUtility.TryParseHtmlString(htmlString, out var color);
		return color;
	}

	public void OnActiveClick()
	{
		if (EnableUpgrade)
		{
			activeCommand.Enabled = false;
			if (EnableUpgrade)
			{
				parent.ItemOnClick(new OptionArg(null, "OnTalentActive"));
			}
		}
	}

	public void RefreshSkillDesc()
	{
		refreshCurRequest.Raise();
	}

	public void EnableActive()
	{
		activeCommand.Enabled = true;
	}

	public void SetButtonEnable(HCSPointType pointType, StateEnumConfig config, string lockDesc)
	{
		DisableDesc = ((lockDesc == null) ? "" : lockDesc);
		switch (config)
		{
		case StateEnumConfig.Open:
			activeCommand.Enabled = false;
			EnableUpgrade = false;
			BtnText = ((pointType == HCSPointType.Big) ? "最大等级" : "已点亮");
			IsBigMax = pointType == HCSPointType.Big;
			IsSmallActive = pointType == HCSPointType.Small;
			break;
		case StateEnumConfig.Active:
			activeCommand.Enabled = true;
			EnableUpgrade = true;
			BtnText = ((pointType == HCSPointType.Big) ? "升级" : "点亮");
			IsBigMax = false;
			IsSmallActive = false;
			break;
		case StateEnumConfig.Lock:
			activeCommand.Enabled = false;
			EnableUpgrade = false;
			BtnText = "不满足条件";
			IsBigMax = false;
			IsSmallActive = false;
			break;
		case StateEnumConfig.OpenAndDisactive:
			activeCommand.Enabled = false;
			EnableUpgrade = false;
			BtnText = "材料不足";
			IsBigMax = false;
			IsSmallActive = false;
			break;
		}
	}

	private string ReplaceDesc(string desc)
	{
		if (desc != null)
		{
			return desc.Replace("\\n", "\n");
		}
		return desc;
	}
}
