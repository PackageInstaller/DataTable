using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70061WuYu;

public class Skill3_SummonMagicGhost : SkillSimpleBase
{
	private const string ComboKey = "Skill3_SummonMagicGhost";

	private const string SummonStartEvent = "SummonStart";

	private const string SphereFxAlias = "fx_70061WuYu_base_Attack03_Sphere";

	private const string SummonFxAlias = "fx_70061WuYu_base_Attack03_zhaohuan";

	private static readonly FP SphereDuration = 1.1;

	private static readonly string[] P1_Set1 = new string[3] { "MageSummon_Set1_Point1_1", "MageSummon_Set1_Point1_2", "MageSummon_Set1_Point1_3" };

	private static readonly string[] P1_Set2 = new string[3] { "MageSummon_Set1_Point2_1", "MageSummon_Set1_Point2_2", "MageSummon_Set1_Point2_3" };

	private static readonly string[] P2_Set1 = new string[4] { "MageSummon_Set2_Point1_1", "MageSummon_Set2_Point1_2", "MageSummon_Set2_Point1_3", "MageSummon_Set2_Point1_4" };

	private static readonly string[] P2_Set2 = new string[4] { "MageSummon_Set2_Point2_1", "MageSummon_Set2_Point2_2", "MageSummon_Set2_Point2_3", "MageSummon_Set2_Point2_4" };

	private static readonly string[] Entry_P1_Set1 = new string[4] { "MageSummon_Set1_Point1_1", "MageSummon_Set1_Point1_2", "MageSummon_Set1_Point1_3", "MageSummon_Set1_Point1_4" };

	private static readonly string[] Entry_P1_Set2 = new string[4] { "MageSummon_Set1_Point2_1", "MageSummon_Set1_Point2_2", "MageSummon_Set1_Point2_3", "MageSummon_Set1_Point2_4" };

	private static readonly string[] Entry_P2_Set1 = new string[5] { "MageSummon_Set2_Point1_1", "MageSummon_Set2_Point1_2", "MageSummon_Set2_Point1_3", "MageSummon_Set2_Point1_4", "MageSummon_Set2_Point1_5" };

	private static readonly string[] Entry_P2_Set2 = new string[5] { "MageSummon_Set2_Point2_1", "MageSummon_Set2_Point2_2", "MageSummon_Set2_Point2_3", "MageSummon_Set2_Point2_4", "MageSummon_Set2_Point2_5" };

	private int _summonCount;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(0, "Skill3_SummonMagicGhost", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("SummonStart");
		int num = GetLogicTagFpValue(_actor, "Phase").AsInt();
		string[] array;
		if (GetLogicTagToggleValue(_actor, "LoyalServantTagId"))
		{
			if (TSRandom.Range(0, 2) != 0)
			{
				array = ((num >= 2) ? Entry_P2_Set2 : Entry_P1_Set2);
			}
			else
			{
				array = ((num >= 2) ? Entry_P2_Set1 : Entry_P1_Set1);
			}
		}
		else if (TSRandom.Range(0, 2) != 0)
		{
			array = ((num >= 2) ? P2_Set2 : P1_Set2);
		}
		else
		{
			array = ((num >= 2) ? P2_Set1 : P1_Set1);
		}
		LogicEntity currentPlayer = GetCurrentPlayer();
		TSVector2 playerPos = ((currentPlayer != null) ? currentPlayer.tsTransform.Position : GetPosition());
		List<TSVector2> points = new List<TSVector2>(array.Length);
		List<long> sphereFxIds = new List<long>(array.Length);
		string[] array2 = array;
		foreach (string name in array2)
		{
			TSVector2 placeHolderPosition = GetPlaceHolderPosition(name);
			points.Add(placeHolderPosition);
			Skill3_SummonMagicGhost skill3_SummonMagicGhost = this;
			TSVector2 position = placeHolderPosition;
			sphereFxIds.Add(skill3_SummonMagicGhost.PlayEffect("fx_70061WuYu_base_Attack03_Sphere", 1f, default, position));
		}
		yield return WaitTime(SphereDuration);
		for (int j = 0; j < points.Count; j++)
		{
			TSVector2 tSVector = points.get_Item(j);
			Skill3_SummonMagicGhost skill3_SummonMagicGhost2 = this;
			TSVector2 position = tSVector;
			skill3_SummonMagicGhost2.PlayEffect("fx_70061WuYu_base_Attack03_zhaohuan", 1f, default, position);
			_summonCount = (_summonCount + 1) % 2;
			int index = ((_summonCount == 1) ? 3 : 5);
			TSVector2 tSVector2 = playerPos - tSVector;
			TSVector2 spawnDirection = ((tSVector2.magnitude > FP.Zero) ? tSVector2.normalized : TSVector2.up);
			SummonTeammate(index, tSVector, spawnDirection);
			StopEffect(sphereFxIds.get_Item(j));
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
