using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70061WuYu;

public class Skill2_SummonBigHeadGhost : SkillSimpleBase
{
	private const string ComboKey = "Skill2_SummonBigHeadGhost";

	private const string AreaAttackEvent = "AreaAttack";

	private const string AreaEffectAlias = "AreaEffect_70061WuYu_Skill2_Blast";

	private const string WarningFxAlias = "fx_70061WuYu_base_Attack02_Yujing";

	private const string LoopFxAlias = "fx_70061WuYu_loop_Attack02_Fazhen";

	private static readonly FP WarningFxPlayRate = 1;

	private static readonly FP RadiusP1 = 6;

	private const int PointCountP1 = 2;

	private static readonly FP RadiusP2 = 10;

	private const int PointCountP2 = 3;

	private const int Entry_PointCountP1 = 3;

	private const int Entry_PointCountP2 = 4;

	private int _summonCount;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(0, "Skill2_SummonBigHeadGhost", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("AreaAttack");
		int num = GetLogicTagFpValue(_actor, "Phase").AsInt();
		bool logicTagToggleValue = GetLogicTagToggleValue(_actor, "LoyalServantTagId");
		FP fP;
		int pointCount;
		if (num >= 2)
		{
			fP = RadiusP2;
			pointCount = (logicTagToggleValue ? 4 : 3);
		}
		else
		{
			fP = RadiusP1;
			pointCount = (logicTagToggleValue ? 3 : 2);
		}
		LogicEntity currentPlayer = GetCurrentPlayer();
		TSVector2 playerPos = ((currentPlayer != null) ? currentPlayer.tsTransform.Position : GetPosition());
		FP randomValue = GetRandomValue(0, 360);
		FP fP2 = 360 / pointCount;
		List<TSVector2> points = new List<TSVector2>(pointCount);
		List<FP> angles = new List<FP>(pointCount);
		for (int i = 0; i < pointCount; i++)
		{
			FP fP3 = randomValue + i * fP2;
			TSVector2 tSVector = TSVector2.Rotate(TSVector2.up, fP3).normalized * fP;
			TSVector2 point = playerPos + tSVector;
			point = ClampToEdge(playerPos, point);
			points.Add(point);
			angles.Add(fP3);
		}
		List<long> warningFxIds = new List<long>(pointCount);
		for (int j = 0; j < pointCount; j++)
		{
			Skill2_SummonBigHeadGhost skill2_SummonBigHeadGhost = this;
			float playbackSpeed = WarningFxPlayRate.AsFloat();
			TSVector2 position = points.get_Item(j);
			FP angle = angles.get_Item(j);
			long item = skill2_SummonBigHeadGhost.PlayEffect("fx_70061WuYu_base_Attack02_Yujing", playbackSpeed, default, position, angle);
			warningFxIds.Add(item);
		}
		yield return WaitTime(WarningFxPlayRate * 2);
		for (int k = 0; k < pointCount; k++)
		{
			PlayAreaEffect("AreaEffect_70061WuYu_Skill2_Blast", points.get_Item(k), angles.get_Item(k));
			Skill2_SummonBigHeadGhost skill2_SummonBigHeadGhost2 = this;
			TSVector2 position = points.get_Item(k);
			FP angle = angles.get_Item(k);
			skill2_SummonBigHeadGhost2.PlayEffect("fx_70061WuYu_loop_Attack02_Fazhen", 1f, default, position, angle);
			_summonCount = (_summonCount + 1) % 2;
			int index = ((_summonCount == 1) ? 6 : 2);
			TSVector2 tSVector2 = playerPos - points.get_Item(k);
			TSVector2 spawnDirection = ((tSVector2.magnitude > FP.Zero) ? tSVector2.normalized : TSVector2.up);
			SummonTeammate(index, points.get_Item(k), spawnDirection);
			StopEffect(warningFxIds.get_Item(k));
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private TSVector2 ClampToEdge(TSVector2 center, TSVector2 point)
	{
		AdventureActor actor = _actor;
		if ((object)actor != null && !actor.QueryPositionWalkable(point) && actor.LinecastNavmeshGraph(center, point, out var linecastHitPoint))
		{
			return linecastHitPoint;
		}
		return point;
	}
}
