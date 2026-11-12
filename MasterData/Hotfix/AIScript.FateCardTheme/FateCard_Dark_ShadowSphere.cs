#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.FateCardTheme;

public class FateCard_Dark_ShadowSphere : BaseFateCardTheme
{
	private readonly FP cd = 2;

	private readonly string normalPath_Sphere = "FateCard_Dark_ShadowSphere";

	private readonly int normal_damageId = 986551;

	private readonly int count_a = 3;

	private readonly FP delay_timeA = 0.1;

	private readonly int proA_damageId = 986552;

	private readonly string probPath_Spheree = "FateCard_Dark_ShadowSphere_B";

	private readonly int proB_damageId = 986553;

	private readonly int proC_damageId = 986554;

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
		NovaLogger.Debug("FateCard_Dark_ShadowSphere OnTrigger");
		if (CheckTimeout(cd) && OnExcute())
		{
			TriggerTheme();
		}
	}

	private bool OnExcute()
	{
		TSVector2 dirction = _actor.tsTransform.Forward;
		if (_actor.attackTarget != null)
		{
			dirction = (_actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position).normalized;
		}
		string text = normalPath_Sphere;
		int num = normal_damageId;
		if (CanExcuteA)
		{
			num = proA_damageId;
		}
		if (CanExcuteB)
		{
			num = proB_damageId;
			text = probPath_Spheree;
		}
		if (CanExcuteC)
		{
			num = proC_damageId;
			text = probPath_Spheree;
		}
		ILRuntimeAPI.Shoot(text, _actor, _actor.tsTransform.Position, dirction).ResetHitID(num);
		if (CanExcuteA)
		{
			CoroutineNode item = StartLogicCoroutine(Show_ProA(text, num));
			corList.Add(item);
		}
		return true;
	}

	private IEnumerator Show_ProA(string windBladePath, int hitID)
	{
		for (int i = 0; i < count_a - 1; i++)
		{
			yield return StartLogicCoroutine(_actor.WaitForSeconds(delay_timeA));
			TSVector2 dirction = _actor.tsTransform.Forward;
			if (_actor.attackTarget != null)
			{
				dirction = (_actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position).normalized;
			}
			ILRuntimeAPI.Shoot(windBladePath, _actor, _actor.tsTransform.Position, dirction).ResetHitID(hitID);
		}
	}
}
