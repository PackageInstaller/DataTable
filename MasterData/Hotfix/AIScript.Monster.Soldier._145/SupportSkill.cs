using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._145;

public class SupportSkill : SkillAdvancedBase
{
	private const string comboTag = "Support";

	private const string eventName_GenerateAreaEffect = "SteelRain";

	private const string areaEffectKey = "AreaEffect_Soldier_145_Support";

	private const string areaEffectKey_Potential2 = "AreaEffect_Soldier_145_MainSkill";

	private const string areaEffectKey_Potential3 = "AreaEffect_Soldier_145_Support_N";

	private static readonly FP areaDistanceMin_Potential2 = 3;

	private static readonly FP areaDistanceMax_Potential2 = 6;

	private const int areaCount_Potential2 = 3;

	public static readonly FP nearSideHalfSpreadAngle = 90;

	private static readonly FP sectorFillRatio = (FP)7 / (FP)10;

	private int _potentialLv;

	private bool _summonRolled;

	private static readonly FP nearSideEpsilonSqr = (FP)1 / (FP)100;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_potentialLv = ((SoldierActor)_actor).GetPotentialLv();
		_summonRolled = false;
	}

	public void OnStart()
	{
		if (_actor.attackTarget == null)
		{
			LogicEntity logicEntity = ((SoldierActor)_actor).soldierAI?.FindNearestConfrontTarget();
			if (logicEntity != null)
			{
				_actor.attackTarget = logicEntity;
				_actor.soldierAttackTarget = logicEntity;
			}
		}
		Action onAnticipationEnd = OnAnticipationEnd;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Support", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnAnticipationEnd()
	{
		if (!_summonRolled)
		{
			_summonRolled = true;
			Action_Summoned.TryPartnerSummon(_actor);
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	private void OnCustomEvent(string eventName)
	{
		if (!string.Equals(eventName, "SteelRain"))
		{
			return;
		}
		TSVector2 tSVector = ((_actor.attackTarget != null) ? _actor.attackTarget.tsTransform.Position : _actor.tsTransform.Position);
		string fxAlias = ((_potentialLv >= 3) ? "AreaEffect_Soldier_145_Support_N" : "AreaEffect_Soldier_145_Support");
		ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, tSVector);
		if (_potentialLv >= 2)
		{
			for (int i = 0; i < 3; i++)
			{
				TSVector2 nearSidePoint = GetNearSidePoint(_actor, tSVector, areaDistanceMin_Potential2, areaDistanceMax_Potential2, nearSideHalfSpreadAngle, i, 3);
				ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_Soldier_145_MainSkill", nearSidePoint, (tSVector - nearSidePoint).GetAngle());
			}
		}
	}

	public static TSVector2 GetNearSidePoint(AdventureActor caster, TSVector2 center, FP minDistance, FP maxDistance, FP halfSpreadAngle, int sectorIndex, int sectorCount)
	{
		TSVector2 tSVector = caster.tsTransform.Position - center;
		TSVector2 v = ((tSVector.LengthSquared() > nearSideEpsilonSqr) ? tSVector.normalized : (-caster.tsTransform.Forward.normalized));
		FP fP = TSRandom.Range(minDistance, maxDistance);
		int num = ((sectorCount <= 0) ? 1 : sectorCount);
		int num2 = (sectorIndex % num + num) % num;
		FP fP2 = halfSpreadAngle * 2 / num;
		FP fP3 = fP2 * (1 - sectorFillRatio) / 2;
		FP degrees = -halfSpreadAngle + fP2 * num2 + fP3 + TSRandom.value * fP2 * sectorFillRatio;
		return center + TSVector2.Rotate(v, degrees) * fP;
	}
}
