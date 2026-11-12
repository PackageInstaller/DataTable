#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.FateCardTheme;

public class FateCard_EarthFissure : BaseFateCardTheme
{
	private readonly FP cd = 2;

	private readonly string normalPath_Fissure = "FateCard_EarthFissure";

	private readonly FP delay_time = 0.8;

	private readonly int normal_damageId = 986431;

	private readonly string proaPath_Fissure = "FateCard_EarthFissure_A";

	private readonly FP delay_timeA = 0.8;

	private readonly int proA_damageId = 986432;

	private readonly string probPath_Fissure = "FateCard_EarthFissure_B";

	private readonly FP delay_timeB = 0.5;

	private readonly int proB_damageId = 986433;

	private readonly string procPath_Fissure = "FateCard_EarthFissure_C";

	private readonly FP delay_timeC = 0.8;

	private readonly FP delay_timeC_1 = 0.5;

	private readonly int proC_damageId = 986434;

	private readonly int proC_damageId_1 = 986435;

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
		NovaLogger.Debug("FateCard_EarthFissure OnTrigger");
		if (CheckTimeout(cd))
		{
			ShowEarthFissure();
			TriggerTheme();
		}
	}

	private void ShowEarthFissure()
	{
		string fxAlias = normalPath_Fissure;
		FP delay = delay_time;
		int hitId = normal_damageId;
		if (CanExcuteA)
		{
			hitId = proA_damageId;
			fxAlias = proaPath_Fissure;
			delay = delay_timeA;
		}
		if (CanExcuteC)
		{
			delay = delay_timeC;
			hitId = proC_damageId;
		}
		PlayAreaEffect(fxAlias, _actor.tsTransform.Position, hitId);
		if (CanExcuteB)
		{
			CoroutineNode item = StartLogicCoroutine(Show_ProB(delay));
			corList.Add(item);
		}
	}

	private IEnumerator Show_ProB(FP delay)
	{
		yield return StartLogicCoroutine(_actor.WaitForSeconds(delay));
		FP seconds = delay_timeB;
		int id = proB_damageId;
		string area = probPath_Fissure;
		if (CanExcuteC)
		{
			seconds = delay_timeC_1;
			id = proC_damageId_1;
			area = procPath_Fissure;
		}
		PlayAreaEffect(area, _actor.tsTransform.Position, id);
		yield return StartLogicCoroutine(_actor.WaitForSeconds(seconds));
		PlayAreaEffect(area, _actor.tsTransform.Position, id);
	}
}
