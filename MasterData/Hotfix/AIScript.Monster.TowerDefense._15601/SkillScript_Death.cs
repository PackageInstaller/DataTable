using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._15601;

public class SkillScript_Death : SkillSimpleBase
{
	private int keyIndex1 = 1;

	private string key_dead = "Dead";

	private int keyIndex2 = 2;

	private string key_dash = "Run";

	private string evt_boom = "Boom";

	private string areaEffect_Boom = "AreaEffect_Base";

	private int hasP3 = CommonHelper.StringToHash("hasP3");

	private const int perkId_1 = 1560101;

	private FP MostRadius = 4;

	private string areaEffect_Boom_1 = "AreaEffect_P1";

	private const int perkId_3 = 1560103;

	private string areaEffect_Boom_3 = "AreaEffect_P3";

	private string areaEffect_Boom_1_3 = "AreaEffect_P3+1";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		_actor.PlayDeathAnim();
		BeginAttack(keyIndex1, key_dead, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Dash");
		LogicEntity monsterTarget = _actor.monsterTarget;
		if (monsterTarget != null && GetPerk(1560101))
		{
			yield return BeginLookAt(monsterTarget, 0);
			FP fP = TSMath.Min(MostRadius, GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true));
			FP speed = fP / 0.35f;
			BeginDashActorForward(keyIndex2, speed, fP, 360, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: true, triggerFriendStop: false);
			yield return WaitDashFinish();
		}
		yield return WaitCustomEvent(evt_boom);
		bool num = GetPerk(1560103) && _actor.CheckTag(hasP3);
		string fxAlias = areaEffect_Boom;
		if (GetPerk(1560101))
		{
			fxAlias = areaEffect_Boom_1;
		}
		if (num)
		{
			fxAlias = areaEffect_Boom_3;
		}
		if (num && GetPerk(1560101))
		{
			fxAlias = areaEffect_Boom_1_3;
		}
		ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, _actor.tsTransform.Position);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
