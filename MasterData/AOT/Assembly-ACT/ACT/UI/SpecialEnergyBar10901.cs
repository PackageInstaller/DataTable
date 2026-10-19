using ACT.Battle;
using ACT.Event;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.UI;

public class SpecialEnergyBar10901 : SpecialEnergyBar
{
	private const string Buff1 = "Role_09_01_Toxin_Tag";

	private const string Buff2 = "Role_09_01_Armor_Destruction_Tag";

	private const string Buff3 = "Role_09_01_Energetic_Tag";

	private const string ConsumeBuff = "Role_09_01_PerfectPotion_Tag";

	[SerializeField]
	private Buff buff1;

	[SerializeField]
	private Buff buff2;

	[SerializeField]
	private Buff buff3;

	private bool _inConsumeBuffState;

	public override void Init(SpecialEnergyBarData energyBarData, CustomUITransform transform, Entity entity)
	{
		base.Init(energyBarData, transform, entity);
		RefreshBuffFromEntity(entity);
	}

	private void RefreshBuffFromEntity(Entity entity)
	{
		ResetBuff(buff1);
		ResetBuff(buff2);
		ResetBuff(buff3);
		_inConsumeBuffState = false;
		CompAbility compAbility = entity.GetCompAbility();
		if (compAbility == null)
		{
			return;
		}
		Ability abilityByName = compAbility.GetAbilityByName("Role_09_01_PerfectPotion_Tag");
		if (abilityByName != null)
		{
			ActivateBuff(buff1);
			ActivateBuff(buff2);
			ActivateBuff(buff3);
			_inConsumeBuffState = true;
			float maxVal = abilityByName.Duration.GetMaxVal(0);
			if (maxVal > 0f)
			{
				float percent = abilityByName.Duration.GetVal(0) / maxVal;
				SetBuffFillAmount(buff1, percent);
				SetBuffFillAmount(buff2, percent);
				SetBuffFillAmount(buff3, percent);
			}
		}
		else
		{
			if (compAbility.HasAbility("Role_09_01_Toxin_Tag"))
			{
				ActivateBuff(buff1);
			}
			if (compAbility.HasAbility("Role_09_01_Armor_Destruction_Tag"))
			{
				ActivateBuff(buff2);
			}
			if (compAbility.HasAbility("Role_09_01_Energetic_Tag"))
			{
				ActivateBuff(buff3);
			}
		}
	}

	private void ResetBuff(Buff buff)
	{
		if (buff != null)
		{
			if (buff.image != null)
			{
				buff.image.fillAmount = 0f;
			}
			if (buff.filled != null)
			{
				buff.filled.SetActive(value: false);
			}
		}
	}

	private void ActivateBuff(Buff buff)
	{
		if (buff != null)
		{
			if (buff.filled != null)
			{
				buff.filled.SetActive(value: true);
			}
			if (buff.image != null)
			{
				buff.image.fillAmount = 1f;
			}
		}
	}

	public override void OnAbilityAdd(AbilityAddEvt abilityAddEvt)
	{
		if (abilityAddEvt.abilityName == "Role_09_01_PerfectPotion_Tag")
		{
			ActivateBuff(buff1);
			ActivateBuff(buff2);
			ActivateBuff(buff3);
			_inConsumeBuffState = true;
		}
		if (!_inConsumeBuffState)
		{
			switch (abilityAddEvt.abilityName)
			{
			case "Role_09_01_Toxin_Tag":
				ActivateBuff(buff1);
				break;
			case "Role_09_01_Armor_Destruction_Tag":
				ActivateBuff(buff2);
				break;
			case "Role_09_01_Energetic_Tag":
				ActivateBuff(buff3);
				break;
			}
		}
	}

	public override void OnAbilityRemove(AbilityRemoveEvt abilityRemoveEvt)
	{
		if (abilityRemoveEvt.abilityName == "Role_09_01_PerfectPotion_Tag")
		{
			ResetBuff(buff1);
			ResetBuff(buff2);
			ResetBuff(buff3);
			_inConsumeBuffState = false;
		}
		if (!_inConsumeBuffState)
		{
			switch (abilityRemoveEvt.abilityName)
			{
			case "Role_09_01_Toxin_Tag":
				ResetBuff(buff1);
				break;
			case "Role_09_01_Armor_Destruction_Tag":
				ResetBuff(buff2);
				break;
			case "Role_09_01_Energetic_Tag":
				ResetBuff(buff3);
				break;
			}
		}
	}

	public override void OnAbilityDurationChange(AbilityDurationChangeEvt abilityDurationChangeEvt)
	{
		if (abilityDurationChangeEvt.abilityName == "Role_09_01_PerfectPotion_Tag")
		{
			SetBuffFillAmount(buff1, abilityDurationChangeEvt.DurationPercent);
			SetBuffFillAmount(buff2, abilityDurationChangeEvt.DurationPercent);
			SetBuffFillAmount(buff3, abilityDurationChangeEvt.DurationPercent);
		}
	}

	private void SetBuffFillAmount(Buff buff, float percent)
	{
		if (buff?.image != null)
		{
			buff.image.fillAmount = percent;
		}
	}
}
