#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.FateCardTheme;

public class FateCard_Dark_DarkBurst : BaseFateCardTheme
{
	private readonly FP cd = 2;

	private readonly string normalPath_Burst = "FateCard_DarkBurst";

	private readonly int normal_damageId = 986521;

	private readonly string proaPath_Burst = "FateCard_DarkBurst_A";

	private readonly string proaPath_Burst_2 = "FateCard_DarkBurst_A_1";

	private readonly FP delay_timeA = 0.8;

	private readonly int proA_damageId = 986522;

	private readonly int proA_damageId_2 = 986523;

	private readonly string probPath_Burst = "FateCard_DarkBurst_B";

	private readonly string probPath_Burst_2 = "FateCard_DarkBurst_B_2";

	private readonly FP delay_timeB = 0.2;

	private readonly int proB_damageId = 986524;

	private readonly int proB_damageId_2 = 986525;

	private readonly string procPath_Burst = "FateCard_DarkBurst_C";

	private readonly string procPath_Burst_2 = "FateCard_DarkBurst_C_2";

	private readonly string procPath_Burst_3 = "FateCard_DarkBurst_C_1";

	private readonly FP delay_timeC = 0.2;

	private readonly FP delay_timeC_2 = 0.6;

	private readonly int proC_damageId = 986526;

	private readonly int proC_damageId_2 = 986528;

	private readonly int proC_damageId_3 = 986527;

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
		NovaLogger.Debug("FateCard_Dark_DarkBurst OnTrigger");
		if (CheckTimeout(cd) && OnExcute())
		{
			TriggerTheme();
		}
	}

	private bool OnExcute()
	{
		LogicEntity attackTarget = _actor.attackTarget;
		attackTarget = attackTarget ?? CommonUtils.SearchNearTargetByCircle(_actor, 10);
		if (attackTarget == null)
		{
			return false;
		}
		string fxAlias = normalPath_Burst;
		int hitId = normal_damageId;
		if (CanExcuteA)
		{
			hitId = proA_damageId;
			fxAlias = proaPath_Burst;
		}
		if (CanExcuteB)
		{
			hitId = proB_damageId;
			fxAlias = probPath_Burst;
		}
		if (CanExcuteC)
		{
			hitId = proC_damageId;
			fxAlias = procPath_Burst;
		}
		PlayAreaEffect(fxAlias, attackTarget.tsTransform.Position, hitId);
		if (CanExcuteC)
		{
			CoroutineNode item = StartLogicCoroutine(Show_ProC(attackTarget.tsTransform.Position));
			corList.Add(item);
		}
		else if (CanExcuteB)
		{
			CoroutineNode item2 = StartLogicCoroutine(Show_ProB(attackTarget.tsTransform.Position));
			corList.Add(item2);
		}
		else if (CanExcuteA)
		{
			CoroutineNode item3 = StartLogicCoroutine(Show_ProA(attackTarget.tsTransform.Position));
			corList.Add(item3);
		}
		return true;
	}

	private IEnumerator Show_ProA(TSVector2 pos)
	{
		yield return StartLogicCoroutine(_actor.WaitForSeconds(delay_timeA));
		PlayAreaEffect(proaPath_Burst_2, pos, proA_damageId_2);
	}

	private IEnumerator Show_ProB(TSVector2 pos)
	{
		yield return StartLogicCoroutine(_actor.WaitForSeconds(delay_timeB));
		PlayAreaEffect(probPath_Burst_2, pos, proB_damageId_2);
	}

	private IEnumerator Show_ProC(TSVector2 pos)
	{
		yield return StartLogicCoroutine(_actor.WaitForSeconds(delay_timeC));
		PlayAreaEffect(procPath_Burst_2, pos, proC_damageId_2);
		yield return StartLogicCoroutine(_actor.WaitForSeconds(delay_timeC_2));
		PlayAreaEffect(procPath_Burst_3, pos, proC_damageId_3);
	}
}
