using System.Collections;
using TrueSync;

namespace AIScript.Monster._15510FengNiao;

public class Skill_Spawn_Hardcore : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Spawn_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Y };

	private long LightFXID;

	protected override IEnumerator DoMainLogic()
	{
		SetBattleOutEnable();
		SetHideModelEnable();
		Skill_Spawn_Hardcore skill_Spawn_Hardcore = this;
		TSVector2 position = GetPosition();
		skill_Spawn_Hardcore.PlayEffect("fx_common_base_monster_in_ground", 1f, default, position);
		yield return WaitTime(0.15);
		Skill_Spawn_Hardcore skill_Spawn_Hardcore2 = this;
		position = GetPosition();
		skill_Spawn_Hardcore2.PlayEffect("fx_common_base_monster_in", 1f, default, position);
		SetHideModelDisable();
		BeginAttack(1, Spawn_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.3);
		AddBuffToTarget(_actor, 155109310);
		AddBuffToTarget(_actor, 155109330);
		yield return WaitCustomEvent("LightFXStart");
		LightFXID = PlayEffect("SpawnLightFX");
		foreach (LogicEntity item in GetTargetByTeammateIndex(1))
		{
			SetLogicTagToggleValue(item, "HardcoreP2Start", value: true);
			AdventureActor adventureActor = item as AdventureActor;
			DirectHeal(adventureActor, (int)adventureActor.actorHealthInfo.hpMax);
		}
		ShowCenterHpBar();
		SetBattleOutDisable();
		SetLogicTagFpValue(_actor, "LightDistance", 99);
		SetLogicTagToggleValue(_actor, "FastRecoverFlower", value: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SetLogicTagToggleValue(_actor, "FastRecoverFlower", value: false);
		StopEffect(LightFXID);
		yield return WaitTime(1);
	}
}
