using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class Skill_Boom_Phase_1 : SkillSimpleBase
{
	private string key_Base = "Stage1_Skill03";

	private string areaEffect_Boom = "Area_70001_Skill03_Dot";

	private string evt_Boom = "evt_Boom";

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		GetEnemy();
		TSVector2 targetPos = Targetenemy.tsTransform.Position;
		BeginAttack(1, key_Base);
		yield return WaitCustomEvent("SpawnArea");
		PlayAreaEffect("Area_70001_Skill03_Warn_1", targetPos);
		yield return WaitCustomEvent("SpawnArea");
		PlayAreaEffect("Area_70001_Skill03_Warn_2", targetPos);
		yield return WaitCustomEvent("SpawnArea");
		PlayAreaEffect("Area_70001_Skill03_Warn_3", targetPos);
		yield return WaitFrame(19);
		CancelAttack();
		yield return WaitFrame(11);
		ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_Boom, targetPos);
		yield return WaitFrame(150);
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
		if (eventName.Equals(evt_Boom))
		{
			DispatchCustomEvent(evt_Boom, isSelfEvent: false);
		}
	}
}
