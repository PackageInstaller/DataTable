#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.FateCardTheme;

public class FateCard_EarthSpike : BaseFateCardTheme
{
	private readonly FP cd = 2;

	private readonly string areaEeffct_Earth = "FateCard_EarthSpike";

	private readonly int normal_damageId = 986401;

	private readonly FP radius = 2.2;

	private readonly FP bron_delay = 0.35;

	private readonly int proA_damageId = 986402;

	private readonly string prob_areaEeffct_Earth = "FateCard_EarthSpike_B";

	private readonly string areaEeffct_Earth_Boom = "FateCard_EarthSpike_B_1";

	private readonly FP bron_booom_delay = 0.5;

	private readonly int proB_damageId = 986404;

	private readonly int proC_damageId = 986405;

	private readonly int proC_damageId_1 = 986406;

	private List<TSVector2> sVector2s = new List<TSVector2>(4);

	private readonly List<CoroutineNode> corList = new List<CoroutineNode>();

	public override void OnEnable()
	{
		base.OnEnable();
	}

	public override void OnDisable()
	{
		base.OnDisable();
		foreach (CoroutineNode cor in corList)
		{
			StopLogicCoroutine(cor);
		}
		corList.Clear();
	}

	protected override void OnTrigger()
	{
		NovaLogger.Debug("FateCard_EarthSpike OnTrigger");
		if (CheckTimeout(cd) && ShowEarthSpike())
		{
			TriggerTheme();
		}
	}

	private void GetAreaPos(FP _distance, TSVector2 _pos)
	{
		sVector2s.Clear();
		int num = TSRandom.Range(0, 90);
		for (int i = 0; i <= 3; i++)
		{
			int num2 = 90 * i + num;
			TSVector2 item = _pos + TSVector2.Rotate(TSVector2.one, num2).normalized * _distance;
			sVector2s.Add(item);
		}
	}

	private bool ShowEarthSpike()
	{
		LogicEntity attackTarget = _actor.attackTarget;
		attackTarget = attackTarget ?? CommonUtils.SearchNearTargetByCircle(_actor, 10);
		if (attackTarget == null)
		{
			return false;
		}
		PlayAreaEffect(CanExcuteB ? prob_areaEeffct_Earth : areaEeffct_Earth, attackTarget.tsTransform.Position, CanExcuteC ? proC_damageId : normal_damageId);
		if (CanExcuteA)
		{
			CoroutineNode item = StartLogicCoroutine(Show_ProA(attackTarget.tsTransform.Position));
			corList.Add(item);
		}
		if (CanExcuteB)
		{
			CoroutineNode item2 = StartLogicCoroutine(Show_ProB(attackTarget.tsTransform.Position));
			corList.Add(item2);
		}
		return true;
	}

	private IEnumerator Show_ProA(TSVector2 pos)
	{
		yield return StartLogicCoroutine(_actor.WaitForSeconds(bron_delay));
		GetAreaPos(radius, pos);
		for (int i = 0; i < sVector2s.Count; i++)
		{
			PlayAreaEffect(CanExcuteB ? prob_areaEeffct_Earth : areaEeffct_Earth, sVector2s.get_Item(i), proA_damageId);
		}
		yield return StartLogicCoroutine(_actor.WaitForSeconds(bron_delay));
		GetAreaPos(radius * 2, pos);
		for (int j = 0; j < sVector2s.Count; j++)
		{
			PlayAreaEffect(CanExcuteB ? prob_areaEeffct_Earth : areaEeffct_Earth, sVector2s.get_Item(j), proA_damageId);
		}
	}

	private IEnumerator Show_ProB(TSVector2 pos)
	{
		int hitId = proB_damageId;
		if (CanExcuteC)
		{
			hitId = proC_damageId_1;
		}
		yield return StartLogicCoroutine(_actor.WaitForSeconds(bron_booom_delay));
		PlayAreaEffect(areaEeffct_Earth_Boom, pos, hitId);
		if (CanExcuteA)
		{
			yield return StartLogicCoroutine(_actor.WaitForSeconds(bron_delay));
			GetAreaPos(radius, pos);
			for (int i = 0; i < sVector2s.Count; i++)
			{
				PlayAreaEffect(areaEeffct_Earth_Boom, sVector2s.get_Item(i), hitId);
			}
			yield return StartLogicCoroutine(_actor.WaitForSeconds(bron_delay));
			GetAreaPos(radius * 2, pos);
			for (int j = 0; j < sVector2s.Count; j++)
			{
				PlayAreaEffect(areaEeffct_Earth_Boom, sVector2s.get_Item(j), hitId);
			}
		}
	}
}
