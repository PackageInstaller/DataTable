using ACT.Battle;
using ACT.Event;
using Bamboo.ECS;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public abstract class EnergyBar : UIBehaviour
{
	private EnergyWidget[] _widgets;

	private EnergyBarData _data;

	public virtual void Init(EnergyBarData energyBarData, CustomUITransform transform, Entity entity)
	{
		_data = energyBarData;
		SetTransform(transform);
		_widgets = GetComponentsInChildren<EnergyWidget>();
		CompAbility compAbility = entity.GetCompAbility();
		if (compAbility != null)
		{
			UpdateEnergy(compAbility.EnergyValue, 0f, compAbility.MaxNormalEnergy);
		}
		_data.OnEnergyValChanged += OnEnergyValChange;
		_data.OnSkillCdChanged += OnSkillCdChange;
		_data.OnSkillCountChanged += OnSkillCountChange;
		_data.OnAbilityAdded += OnAbilityAdd;
		_data.OnAbilityRemoved += OnAbilityRemove;
		_data.OnAbilityStackChanged += OnAbilityStackChange;
		_data.OnAbilityDurationChanged += OnAbilityDurationChange;
		_data.OnActiveChanged += OnActive;
	}

	public virtual void UnInit()
	{
		_widgets = null;
		if (_data != null)
		{
			_data.OnEnergyValChanged -= OnEnergyValChange;
			_data.OnSkillCdChanged -= OnSkillCdChange;
			_data.OnSkillCountChanged -= OnSkillCountChange;
			_data.OnAbilityAdded -= OnAbilityAdd;
			_data.OnAbilityRemoved -= OnAbilityRemove;
			_data.OnAbilityStackChanged -= OnAbilityStackChange;
			_data.OnActiveChanged -= OnActive;
			_data = null;
		}
	}

	public virtual void RefreshDisplay(Entity eb)
	{
		CompAbility compAbility = eb.GetCompAbility();
		OnBattleChange(compAbility.EnergyValue, 0f, compAbility.MaxNormalEnergy);
	}

	public void OnUpdateScheme(CustomUITransform transform)
	{
		SetTransform(transform);
	}

	private void SetTransform(CustomUITransform transform)
	{
		(base.transform as RectTransform).anchoredPosition = transform.Pos;
	}

	public void SetActive(bool active)
	{
		gameObject.SetActive(active);
	}

	private void UpdateEnergy(float curVal, float min, float max)
	{
		float num = (max - min) / (float)_widgets.Length;
		float num2 = (curVal - min) / num;
		int num3 = Mathf.FloorToInt(num2);
		for (int i = 0; i < _widgets.Length; i++)
		{
			if (i < num3)
			{
				_widgets[i].UpdateVal(1f);
			}
			else if (i == num3)
			{
				_widgets[i].UpdateVal(num2 % 1f);
			}
			else if (i > num3)
			{
				_widgets[i].UpdateVal(0f);
			}
		}
	}

	private void OnBattleChange(float curVal, float min, float max)
	{
		float num = (max - min) / (float)_widgets.Length;
		float num2 = (curVal - min) / num;
		int num3 = Mathf.FloorToInt(num2);
		for (int i = 0; i < _widgets.Length; i++)
		{
			if (i < num3)
			{
				_widgets[i].OnBattleChange(1f);
			}
			else if (i == num3)
			{
				_widgets[i].OnBattleChange(num2 % 1f);
			}
			else if (i > num3)
			{
				_widgets[i].OnBattleChange(0f);
			}
		}
	}

	public virtual void OnEnergyValChange(CharacterNormalEnergyChangeEvt characterUltraEnergyUpdateEvt)
	{
		UpdateEnergy(characterUltraEnergyUpdateEvt.value, characterUltraEnergyUpdateEvt.min, characterUltraEnergyUpdateEvt.max);
	}

	public virtual void OnAbilityAdd(AbilityAddEvt abilityAddEvt)
	{
	}

	public virtual void OnAbilityRemove(AbilityRemoveEvt abilityRemoveEvt)
	{
	}

	public virtual void OnAbilityStackChange(AbilityStackChangeEvt abilityStackChangeEvt)
	{
	}

	public virtual void OnAbilityDurationChange(AbilityDurationChangeEvt abilityDurationChangeEvt)
	{
	}

	public void OnSkillCdChange(SkillCdChangeEvt skillCdChangeEvt)
	{
	}

	public void OnSkillCountChange(SkillCountChangeEvt skillCountChangeEvt)
	{
	}

	public void OnActive(CharacterNormalEnergyActiveChangeEvt characterNormalEnergyActiveChangeEvt)
	{
		gameObject.SetActive(characterNormalEnergyActiveChangeEvt.active);
	}
}
