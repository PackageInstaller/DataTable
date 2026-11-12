using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense.Skill;

public class Skill_BianSuCiKe : TowerMonsterSkillBase
{
	private const string areaEffectKey = "Weapon_50161BianSuCiKe_TD";

	public const string AREA_TAG = "BianSuCiKe_Dark";

	private FP effectRange = 4.6;

	private long _areaEffectId;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_areaEffectId = 0L;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (_areaEffectId != 0L)
		{
			StopAreaEffect(_areaEffectId);
			_areaEffectId = 0L;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, "Skill", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.7);
		TSVector2 areaPos = GetPosition();
		Dispatch_GetGridInfoByPosition(GetPosition(), (GridInfoData grid) =>
		{
			if (grid != null)
			{
				areaPos = grid.position;
			}
		});
		_areaEffectId = ILRuntimeAPI.PlayAreaEffect(_actor, "Weapon_50161BianSuCiKe_TD", areaPos, default, (AreaEffectEntity area) =>
		{
			area.ModifyTag("BianSuCiKe_Dark");
		});
		Dispatch_DarkenLightSourcesInRange(areaPos, effectRange);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		_skill?.Clear();
	}
}
