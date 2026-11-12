using System.Collections;
using AIScript.DynamicLevel;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense.Skill;

public class Skill_Blink_Fire_1 : SkillSimpleBase
{
	private int fireHeatDelta = 30;

	private string areaEffect = "Area_FireWave";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, "FireWave", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Fire");
		PlayAreaEffect(areaEffect, new TSVector2(0, 0));
		foreach (LogicEntity item in CommonUtils.GetTargetsByFactionByTD(_actor, isFriend: false))
		{
			TowerDefenseCharacterActor towerDefenseCharacterActor = item as TowerDefenseCharacterActor;
			if (towerDefenseCharacterActor != null && towerDefenseCharacterActor.IsActive)
			{
				towerDefenseCharacterActor.UpdateFire(fireHeatDelta);
				new PlayFX().Play(_actor, null, TowerDefenseConfig.fbx_Fire_StrongRing, default, towerDefenseCharacterActor.tsTransform.Position, default);
			}
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		_skill?.Clear();
	}
}
