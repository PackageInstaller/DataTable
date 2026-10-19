using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Event;
using Bamboo.ECS;
using Fundamental;

namespace ACT.UI;

public class OperateBtnFormDataManager
{
	private List<OperateBtnDisplayData> _displayDatas;

	private string _defaultMotionName;

	public OperateBtnDisplayData CurDisplayData { get; private set; }

	public List<OperateBtnDisplayData> allDisplayDatas => _displayDatas;

	public CustomUICompType BelongBtnType { get; private set; }

	public event Action<OperateBtnDisplayData> OnCdDataChanged;

	public event Action<OperateBtnDisplayData> OnCountDataChanged;

	public event Action<OperateBtnDisplayData, AbilityDurationChangeEvt> OnDurationDataChanged;

	public event Action<OperateBtnDisplayData, AbilityAddEvt> OnDurationAdd;

	public event Action<OperateBtnDisplayData, AbilityRemoveEvt> OnDurationRemoved;

	public event Action<OperateBtnDisplayData> OnEnergyChanged;

	public event Action<OperateBtnDisplayData> OnUltraEnergyChanged;

	public event Action<OperateBtnDisplayData> OnBtnRebindSkill;

	public OperateBtnFormDataManager(Entity entity, List<OperateBtnStateConfigData> formDatas, CustomUICompType belongBtnType)
	{
		_displayDatas = new List<OperateBtnDisplayData>();
		foreach (OperateBtnStateConfigData formData in formDatas)
		{
			_displayDatas.Add(new OperateBtnDisplayData(formData, entity));
		}
		_defaultMotionName = formDatas[0].MotionName;
		CurDisplayData = GetDisplayDataBySkillName(_defaultMotionName);
		BelongBtnType = belongBtnType;
	}

	private OperateBtnDisplayData GetDisplayDataBySkillName(string motionName)
	{
		foreach (OperateBtnDisplayData displayData in _displayDatas)
		{
			if (motionName == displayData.MotionName)
			{
				return displayData;
			}
		}
		return null;
	}

	private void OnRebindSkill(string newMotionName)
	{
		OperateBtnDisplayData displayDataBySkillName = GetDisplayDataBySkillName(newMotionName);
		if (displayDataBySkillName != null)
		{
			CurDisplayData = displayDataBySkillName;
		}
	}

	private bool CanRebindTo(string newMotionName)
	{
		if (CurDisplayData.MotionName != newMotionName)
		{
			return HasSkillForm(newMotionName);
		}
		return false;
	}

	private bool HasSkillForm(string motionName)
	{
		foreach (OperateBtnDisplayData displayData in _displayDatas)
		{
			if (displayData.MotionName == motionName)
			{
				return true;
			}
		}
		return false;
	}

	public bool CanUpdateCd(string cdName)
	{
		if (CurDisplayData.BindSkillInfo == null)
		{
			return false;
		}
		if (!CurDisplayData.ShowCd)
		{
			return false;
		}
		return CurDisplayData.BindSkillInfo.belongSkillName == cdName;
	}

	public bool CanUpdateCount(string cdName)
	{
		if (CurDisplayData.BindSkillInfo == null)
		{
			return false;
		}
		if (!CurDisplayData.ShowCount)
		{
			return false;
		}
		return CurDisplayData.BindSkillInfo.belongSkillName == cdName;
	}

	public void ResetCurDisPlayData()
	{
		CurDisplayData = GetDisplayDataBySkillName(_defaultMotionName);
	}

	public void HandleSkillCdChange(SkillCdChangeEvt skillCdChangeEvt)
	{
		foreach (OperateBtnDisplayData displayData in _displayDatas)
		{
			if (displayData != null && displayData.BindSkillInfo != null && displayData.BindSkillInfo.belongSkillName == skillCdChangeEvt.cdName)
			{
				displayData.BindSkillInfo.UpdateCd(skillCdChangeEvt);
			}
		}
		if (CanUpdateCd(skillCdChangeEvt.cdName))
		{
			OnCdDataChanged?.Invoke(CurDisplayData);
		}
	}

	public void HandleSkillCountChange(SkillCountChangeEvt skillCountChangeEvt)
	{
		foreach (OperateBtnDisplayData displayData in _displayDatas)
		{
			if (displayData != null && displayData.BindSkillInfo != null && displayData.BindSkillInfo.belongSkillName == skillCountChangeEvt.countBindSkillName)
			{
				displayData.BindSkillInfo.UpdateCount(skillCountChangeEvt);
			}
		}
		if (CanUpdateCount(skillCountChangeEvt.countBindSkillName))
		{
			OnCountDataChanged?.Invoke(CurDisplayData);
		}
	}

	private bool HasDurationAbility(string abilityName)
	{
		for (int i = 0; i < _displayDatas.Count; i++)
		{
			OperateBtnDisplayData operateBtnDisplayData = _displayDatas[i];
			if (operateBtnDisplayData.ShowDuration && operateBtnDisplayData.AbilityName == abilityName)
			{
				return true;
			}
		}
		return false;
	}

	public void HandleAbilityDurationChange(AbilityDurationChangeEvt abilityData)
	{
		OnDurationDataChanged?.Invoke(CurDisplayData, abilityData);
	}

	public void HandleAbilityAdd(AbilityAddEvt abilityAddEvt)
	{
		OnDurationAdd?.Invoke(CurDisplayData, abilityAddEvt);
	}

	public void HandleAbilityRemove(AbilityRemoveEvt abilityRemoveEvt)
	{
		OnDurationRemoved?.Invoke(CurDisplayData, abilityRemoveEvt);
	}

	public void HandleEnergyChange(CharacterNormalEnergyChangeEvt energyData)
	{
		foreach (OperateBtnDisplayData displayData in _displayDatas)
		{
			displayData.CurNormalEnergy = energyData.value;
		}
		OnEnergyChanged?.Invoke(CurDisplayData);
	}

	public void HandleUltraEnergyChange(CharacterUltraEnergyUpdateEvt ultraEnergyData)
	{
		foreach (OperateBtnDisplayData displayData in _displayDatas)
		{
			displayData.CurUltraEnergyData.curValue = ultraEnergyData.ultraEnergyVal;
			displayData.CurUltraEnergyData.percent = ultraEnergyData.ultraEnergyPercent;
		}
		OnUltraEnergyChanged?.Invoke(CurDisplayData);
	}

	public void HandleRebindSkillChangeBtnState(RebindSkillBtnEvt rebindSkillBtnEvt)
	{
		Entity entity = rebindSkillBtnEvt.entity;
		if (entity == null)
		{
			return;
		}
		OperateBtnBindSkillInfo bindSkillInfo = CurDisplayData.BindSkillInfo;
		if (bindSkillInfo != null)
		{
			CompMotion compMotion = entity.GetCompMotion();
			if (compMotion != null && (!compMotion.GetSkill(bindSkillInfo.MotionName).config.motions.Contains(rebindSkillBtnEvt.motionName) || !(bindSkillInfo.CurSkilllCd > 0f)) && CanRebindTo(rebindSkillBtnEvt.motionName))
			{
				OnRebindSkill(rebindSkillBtnEvt.motionName);
				OnBtnRebindSkill?.Invoke(CurDisplayData);
			}
		}
	}
}
