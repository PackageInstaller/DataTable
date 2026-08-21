#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;

namespace Ase;

public class HCTSkillItemViewModel : OptionBase
{
	private string name;

	private string desc;

	private string coolingText;

	private string consumeText;

	private bool showCooling;

	private bool isCoolingChange;

	private bool isConsumeChange;

	private string descNext;

	private HCTSkillData data;

	private List<HCTSkillItemViewModel> deriveVMs;

	private List<TextItemViewModel> upgradeDataList;

	private bool isSelect;

	public HCTSkillData Data
	{
		get
		{
			return data;
		}
		private set
		{
			Set(ref data, value, "Data");
		}
	}

	public bool IsSelect
	{
		get
		{
			return isSelect;
		}
		private set
		{
			Set(ref isSelect, value, "IsSelect");
		}
	}

	public bool ShowCooling
	{
		get
		{
			return showCooling;
		}
		private set
		{
			Set(ref showCooling, value, "ShowCooling");
		}
	}

	public string Name
	{
		get
		{
			return name;
		}
		private set
		{
			Set(ref name, value, "Name");
		}
	}

	public string Desc
	{
		get
		{
			return desc;
		}
		private set
		{
			Set(ref desc, value, "Desc");
		}
	}

	public string DescNext
	{
		get
		{
			return descNext;
		}
		private set
		{
			Set(ref descNext, value, "DescNext");
		}
	}

	public string CoolingText
	{
		get
		{
			return coolingText;
		}
		private set
		{
			Set(ref coolingText, value, "CoolingText");
		}
	}

	public string ConsumeText
	{
		get
		{
			return consumeText;
		}
		private set
		{
			Set(ref consumeText, value, "ConsumeText");
		}
	}

	public bool IsCoolingChange
	{
		get
		{
			return isCoolingChange;
		}
		private set
		{
			Set(ref isCoolingChange, value, "IsCoolingChange");
		}
	}

	public bool IsConsumeChange
	{
		get
		{
			return isConsumeChange;
		}
		private set
		{
			Set(ref isConsumeChange, value, "IsConsumeChange");
		}
	}

	public List<TextItemViewModel> UpgradeDataList => upgradeDataList;

	public HCTSkillItemViewModel()
	{
	}

	public HCTSkillItemViewModel(OptionBase parent, HCTSkillData data)
	{
		base.parent = parent;
		this.data = data;
		SetCoolingConsumeDesc();
	}

	public HCTSkillItemViewModel(OptionBase parent)
	{
		base.parent = parent;
	}

	public void OnSkillClick()
	{
		parent.ItemOnClick(this);
	}

	public void SetSelect(bool isSelect)
	{
		IsSelect = isSelect;
	}

	public void RefreshData(HCTSkillData data)
	{
		Data = data;
		IsSelect = false;
		SetCoolingConsumeDesc();
	}

	public void RefreshDataSelf()
	{
		if (data != null && data.HasProperty())
		{
			RefreshData(data);
		}
	}

	private void SetCoolingConsumeDesc()
	{
		if (data == null)
		{
			return;
		}
		if (data != null)
		{
			Desc = data.GetDesc();
		}
		DescNext = data.GetDescNext();
		CoolingText = $"{data.GetSkillCooling()}";
		if (data == null)
		{
			ConsumeText = "";
			Log.Error("找不到技能数据！");
		}
		else
		{
			if (data.SkillConsumeKeyName == null)
			{
				return;
			}
			string text = "";
			for (int i = 0; i < data.SkillConsumeKeyName.Count; i++)
			{
				if (!(data.SkillConsumeVal[i] <= 0f))
				{
					if (i > 0)
					{
						text += "&";
					}
					text += $"<color=#7cace1>{data.SkillConsumeVal[i]}</color>{data.SkillConsumeKeyName[i]}";
				}
			}
			ConsumeText = text;
			IsCoolingChange = data.IsChangeCooling;
			IsConsumeChange = data.IsChangeConsume;
			ShowCooling = true;
			if (!isCoolingChange && data.GetSkillCooling() <= 0f)
			{
				ShowCooling = false;
			}
		}
	}

	public void RefreshData(HeroSkillTypeEnum skillTypeEnum, string typeName, string name, string desc, string icon = "")
	{
		if (data == null)
		{
			Data = HCTSkillData.CreatePassive(skillTypeEnum, typeName, name, icon);
		}
		else
		{
			Data.RefreshPassive(skillTypeEnum, typeName, name, icon);
		}
		Desc = desc;
		ShowCooling = false;
	}

	public void RefreshIconSkin(int skinConfigId, string skinSuffix, int heroId)
	{
		if (data != null)
		{
			Data.RefreshIconSkin(skinConfigId, skinSuffix, heroId);
		}
	}

	public List<HCTSkillItemViewModel> GetSkillDerives()
	{
		if (deriveVMs != null)
		{
			deriveVMs.Clear();
		}
		else
		{
			deriveVMs = new List<HCTSkillItemViewModel>();
		}
		if (data.DeriveSkills == null)
		{
			return deriveVMs;
		}
		for (int i = 0; i < data.DeriveSkills.Count; i++)
		{
			if (!data.SkillHideDesc(data.DeriveSkills[i]))
			{
				HCTSkillItemViewModel item = new HCTSkillItemViewModel(this, data.DeriveSkills[i]);
				deriveVMs.Add(item);
			}
		}
		return deriveVMs;
	}
}
