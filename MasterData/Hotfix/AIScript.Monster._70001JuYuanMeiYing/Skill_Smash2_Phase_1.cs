using System.Collections;
using TrueSync;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class Skill_Smash2_Phase_1 : SkillSimpleBase
{
	private string key_smash = "Stage2_Skill07";

	private string evt_CastSkill = "evt_Smash";

	private string areaEffect_Smash = "Area_70001_Skill07";

	private string areaEffect_Ring = "Area_70001_Skill07_Ring";

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, key_smash);
		yield return WaitFrame(23);
		GetEnemy();
		TSVector2 pos = Targetenemy.tsTransform.Position;
		PlayAreaEffect(areaEffect_Smash, pos);
		yield return WaitFrame(47);
		CancelAttack();
		yield return WaitFrame(15);
		PlayAreaEffect(areaEffect_Ring, pos);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName.Equals(evt_CastSkill))
		{
			DispatchCustomEvent(evt_CastSkill, isSelfEvent: false);
		}
	}
}
