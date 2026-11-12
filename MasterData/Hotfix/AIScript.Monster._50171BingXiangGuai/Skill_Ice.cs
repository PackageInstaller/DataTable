#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50171BingXiangGuai;

public class Skill_Ice : SkillSimpleBase
{
	private readonly string combo_key = "GeneralAtk";

	private readonly FP radius_max = 12;

	private readonly int num_max = 8;

	private readonly FP radius = 6;

	private readonly int num = 3;

	private readonly FP time_wait = 2;

	private readonly string area_Show = "IceCube_wait";

	private readonly string area_Boom = "IceCube_action";

	private readonly FP time_shifang = 1;

	private readonly FP ice_r = 3;

	private readonly FP ice_r_w = 3;

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("Skill_Ice==OnSkillEnable");
	}

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("Skill_Ice==OnSkillDisable");
	}

	private List<TSVector2> CalculatePositions(int n, FP radius)
	{
		List<TSVector2> list = new List<TSVector2>();
		if (n <= 0 || radius <= 0)
		{
			return list;
		}
		FP fP = TSMath.Pi * 2 / n;
		for (int i = 0; i < n; i++)
		{
			FP value = i * fP;
			FP x = radius * TSMath.Cos(value);
			FP y = radius * TSMath.Sin(value);
			list.Add(new TSVector2(x, y));
		}
		return list;
	}

	private int getPosIndex(AdventureActor target)
	{
		FP fP = TSVector2.Distance(target.tsTransform.Position, TSVector2.zero);
		if (fP >= radius_max - ice_r_w)
		{
			return 3;
		}
		if (fP > ice_r)
		{
			return 2;
		}
		return 1;
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, combo_key, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		if (activedPlayerActor == null)
		{
			yield break;
		}
		List<TSVector2> pos_nei = CalculatePositions(this.num, radius);
		List<TSVector2> pos_wai = CalculatePositions(num_max, radius_max);
		if (Parallel_1.pointAreaId > 0)
		{
			int posIndex = getPosIndex(activedPlayerActor);
			if (activedPlayerActor.actorInfo.attackType == HotfixEnum.characterAttackType.MELEE)
			{
				if (posIndex == 2)
				{
					StopAreaEffect(Parallel_1.pointAreaId);
					PlayAreaEffect(area_Boom, TSVector2.zero);
					Parallel_1.pointAreaId = 0L;
					for (int i = 0; i < Parallel_1.dicWai.Count; i++)
					{
						StopAreaEffect(Parallel_1.dicWai.get_Item(i));
						PlayAreaEffect(area_Boom, pos_wai.get_Item(i));
					}
					Parallel_1.dicWai.Clear();
					yield return WaitTime(time_wait);
					for (int j = 0; j < Parallel_1.dicNei.Count; j++)
					{
						StopAreaEffect(Parallel_1.dicNei.get_Item(j));
						PlayAreaEffect(area_Boom, pos_nei.get_Item(j));
					}
					Parallel_1.dicNei.Clear();
				}
				else
				{
					for (int k = 0; k < Parallel_1.dicNei.Count; k++)
					{
						StopAreaEffect(Parallel_1.dicNei.get_Item(k));
						PlayAreaEffect(area_Boom, pos_nei.get_Item(k));
					}
					Parallel_1.dicNei.Clear();
					yield return WaitTime(time_wait);
					StopAreaEffect(Parallel_1.pointAreaId);
					PlayAreaEffect(area_Boom, TSVector2.zero);
					Parallel_1.pointAreaId = 0L;
					for (int l = 0; l < Parallel_1.dicWai.Count; l++)
					{
						StopAreaEffect(Parallel_1.dicWai.get_Item(l));
						PlayAreaEffect(area_Boom, pos_wai.get_Item(l));
					}
					Parallel_1.dicWai.Clear();
				}
			}
			else if (posIndex == 2)
			{
				for (int m = 0; m < Parallel_1.dicNei.Count; m++)
				{
					StopAreaEffect(Parallel_1.dicNei.get_Item(m));
					PlayAreaEffect(area_Boom, pos_nei.get_Item(m));
				}
				Parallel_1.dicNei.Clear();
				yield return WaitTime(time_wait);
				StopAreaEffect(Parallel_1.pointAreaId);
				PlayAreaEffect(area_Boom, TSVector2.zero);
				Parallel_1.pointAreaId = 0L;
				for (int n = 0; n < Parallel_1.dicWai.Count; n++)
				{
					StopAreaEffect(Parallel_1.dicWai.get_Item(n));
					PlayAreaEffect(area_Boom, pos_wai.get_Item(n));
				}
				Parallel_1.dicWai.Clear();
			}
			else
			{
				StopAreaEffect(Parallel_1.pointAreaId);
				PlayAreaEffect(area_Boom, TSVector2.zero);
				Parallel_1.pointAreaId = 0L;
				for (int num = 0; num < Parallel_1.dicWai.Count; num++)
				{
					StopAreaEffect(Parallel_1.dicWai.get_Item(num));
					PlayAreaEffect(area_Boom, pos_wai.get_Item(num));
				}
				Parallel_1.dicWai.Clear();
				yield return WaitTime(time_wait);
				for (int num2 = 0; num2 < Parallel_1.dicNei.Count; num2++)
				{
					StopAreaEffect(Parallel_1.dicNei.get_Item(num2));
					PlayAreaEffect(area_Boom, pos_nei.get_Item(num2));
				}
				Parallel_1.dicNei.Clear();
			}
			CancelAttack();
		}
		else
		{
			long pointAreaId = PlayAreaEffect(area_Show, TSVector2.zero);
			Parallel_1.pointAreaId = pointAreaId;
			for (int num3 = 0; num3 < pos_nei.Count; num3++)
			{
				pointAreaId = PlayAreaEffect(area_Show, pos_nei.get_Item(num3));
				Parallel_1.dicNei.Add(pointAreaId);
			}
			for (int num4 = 0; num4 < pos_wai.Count; num4++)
			{
				pointAreaId = PlayAreaEffect(area_Show, pos_wai.get_Item(num4));
				Parallel_1.dicWai.Add(pointAreaId);
			}
			yield return WaitTime(time_shifang);
			CancelAttack();
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
