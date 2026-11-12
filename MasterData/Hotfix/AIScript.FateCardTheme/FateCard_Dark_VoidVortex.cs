#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.FateCardTheme;

public class FateCard_Dark_VoidVortex : BaseFateCardTheme
{
	private readonly FP cd = 5;

	private readonly string normalPath_VoidVortex = "FateCard_Dark_VoidVortex";

	private readonly FP end_time = 3.2;

	private readonly int count_max = 3;

	private readonly int normal_damageId = 986581;

	private readonly string proaPath_VoidVortex = "FateCard_Dark_VoidVortex_A";

	private readonly string proaPath_VoidVortex_2 = "FateCard_Dark_VoidVortex_A_1";

	private readonly FP end_timeA = 3.2;

	private readonly int proA_damageId = 986582;

	private readonly int proA_damageId_2 = 986583;

	private readonly string probPath_VoidVortex = "FateCard_Dark_VoidVortex_B";

	private readonly FP end_timeB = 3.2;

	private readonly int proB_damageId = 986584;

	private readonly string procPath_VoidVortex = "FateCard_Dark_VoidVortex_C";

	private readonly string procPath_VoidVortex_2 = "FateCard_Dark_VoidVortex_C_1";

	private readonly FP end_timeC = 3.2;

	private readonly int proC_damageId = 986585;

	private readonly int proC_damageId_1 = 986586;

	private readonly List<CoroutineNode> corList = new List<CoroutineNode>();

	private readonly List<long> areaList = new List<long>();

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("AREA_EFFECT_FINISH", OnAreaFinish);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_FINISH", OnAreaFinish);
		foreach (CoroutineNode cor in corList)
		{
			StopLogicCoroutine(cor);
		}
		corList.Clear();
		areaList.Clear();
	}

	protected override void OnTrigger()
	{
		NovaLogger.Debug("FateCard_Dark_VoidVortex OnTrigger");
		if (areaList.Count < count_max && CheckTimeout(cd) && OnExcute())
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
		FP delay = end_time;
		string fxAlias = normalPath_VoidVortex;
		int hitId = normal_damageId;
		if (CanExcuteA)
		{
			hitId = proA_damageId;
			delay = end_timeA;
			fxAlias = proaPath_VoidVortex;
		}
		if (CanExcuteB)
		{
			hitId = proB_damageId;
			delay = end_timeB;
			fxAlias = probPath_VoidVortex;
		}
		if (CanExcuteC)
		{
			hitId = proC_damageId;
			delay = end_timeC;
			fxAlias = procPath_VoidVortex;
		}
		long num = PlayAreaEffect(fxAlias, attackTarget.tsTransform.Position, hitId);
		if (num > 0)
		{
			areaList.Add(num);
		}
		if (CanExcuteA)
		{
			CoroutineNode item = StartLogicCoroutine(Show_ProA(delay, attackTarget.tsTransform.Position));
			corList.Add(item);
		}
		return true;
	}

	private IEnumerator Show_ProA(FP _delay, TSVector2 pos)
	{
		yield return StartLogicCoroutine(_actor.WaitForSeconds(_delay));
		string fxAlias = proaPath_VoidVortex_2;
		if (CanExcuteC)
		{
			fxAlias = procPath_VoidVortex_2;
		}
		PlayAreaEffect(fxAlias, pos, CanExcuteC ? proC_damageId_1 : proA_damageId_2);
	}

	private void OnAreaFinish(IEvent evt)
	{
		AdventureAreaEffectFinishEvent adventureAreaEffectFinishEvent = evt as AdventureAreaEffectFinishEvent;
		if (areaList.Contains(adventureAreaEffectFinishEvent.entityID))
		{
			areaList.Remove(adventureAreaEffectFinishEvent.entityID);
		}
	}
}
