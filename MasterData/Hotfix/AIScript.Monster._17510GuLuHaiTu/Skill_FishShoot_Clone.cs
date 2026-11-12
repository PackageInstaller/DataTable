#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._17510GuLuHaiTu;

public class Skill_FishShoot_Clone : SkillSimpleBase
{
	private int ballCorState;

	private List<TSVector2> spwanPOS = new List<TSVector2>
	{
		new TSVector2(-10, 0),
		new TSVector2(-5, 6),
		new TSVector2(5, 2),
		new TSVector2(10, 7)
	};

	private readonly int bulletNum = 3;

	private string effect_fire = "fx_m17510_base_Skill03_fire";

	private string hitEffect_Water = "fx_common_hit_water_strike";

	private string actionStateTagName = "AcitonFinish";

	private List<LogicEntity> mateList = new List<LogicEntity>();

	private LogicEntity master;

	private List<long> fxWarningList = new List<long>();

	private List<long> fxATKList = new List<long>();

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("咕噜海兔.鱼群冲击.开始");
		ballCorState = 0;
	}

	protected override void OnSkillDisable()
	{
		StopEffects(fxWarningList);
		StopEffects(fxATKList);
		mateList.Clear();
		NovaLogger.Debug("咕噜海兔.鱼群冲击.结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		StartCor(EndCondition());
		master = GetMonsterCloner();
		TSVector2 masterPos = GetEntityPositionObsoleted(master);
		TSVector2 masterForward = GetEntityForward(master);
		for (int i = 0; i < spwanPOS.Count; i++)
		{
			TSVector2 position = TransLocalPosToWorldPos(masterPos, masterForward, spwanPOS.get_Item(i));
			PlayEffect(effect_fire, 0.5f, default, position);
			yield return WaitTime(GetRandomValue(0, 0.3));
		}
		yield return WaitTime(0.7);
		List<TSVector2> bulletSpawnPos = new List<TSVector2>();
		LogicEntity target = GetAttackTarget();
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(target);
		TSVector2 tSVector = new TSVector2(0, GetRandomValue(6, 9));
		for (int j = 0; j < bulletNum; j++)
		{
			TSVector2 relativePoint = RotateTo(tSVector, 360 / bulletNum * j);
			TSVector2 tSVector2 = TransLocalPosToWorldPos(entityPositionObsoleted, tSVector - entityPositionObsoleted, relativePoint);
			if (QueryPositionReachable(target, tSVector2))
			{
				bulletSpawnPos.Add(tSVector2);
				continue;
			}
			tSVector2 = TransLocalPosToWorldPos(TSVector2.zero, tSVector2 - TSVector2.zero, new TSVector2(0, 10));
			bulletSpawnPos.Add(tSVector2);
		}
		for (int i = 0; i < bulletSpawnPos.Count; i++)
		{
			Ball(bulletSpawnPos.get_Item(i), 1.5 - (double)i * 0.5, target);
			yield return WaitTime(0.5);
		}
		while (ballCorState < bulletSpawnPos.Count)
		{
			yield return WaitTime(0.2);
		}
	}

	private IEnumerator EndCondition()
	{
		for (int i = 0; i < 20; i++)
		{
			mateList = GetTargetsByFaction(isFriend: true);
			if (mateList == null || mateList.Count == 0)
			{
				break;
			}
			yield return WaitTime(0.5);
		}
		InterruptSkill();
	}

	private void StopEffects(List<long> effectList)
	{
		for (int i = 0; i < effectList.Count; i++)
		{
			StopEffect(effectList.get_Item(i));
		}
		effectList.Clear();
	}

	private CoroutineNode Ball(TSVector2 spawnPOS, FP waitTime, LogicEntity target)
	{
		return StartCor(BallCor(spawnPOS, waitTime, target));
	}

	private IEnumerator BallCor(TSVector2 spawnPOS, FP waitTime, LogicEntity target)
	{
		long[] chargeFxID = new long[3];
		long[] groundFxID = new long[3];
		long[] spoutFxID = new long[2];
		PlayEffect("fx_common_base_Fire_YuJing_circular_2", 0.6f, 0.7, spawnPOS);
		yield return WaitTime(1.5);
		PlayEffect("fx_m17510_base_Skill03_fish_down", 1.5f, 0.7, spawnPOS);
		yield return WaitTime(0.15);
		groundFxID[0] = PlayEffect("fx_m17510_loop_Skill03_ground", 1f, 0.7, spawnPOS);
		groundFxID[1] = PlayEffect("fx_m17510_loop_Skill03_ground_water", 1f, 0.7, spawnPOS);
		Skill_FishShoot_Clone skill_FishShoot_Clone = this;
		FP radius = 2;
		DeterministicShape shapeData = skill_FishShoot_Clone.GetShapeData(DeterministicShape.ShapeType.Circle, spawnPOS, default, default, radius);
		Skill_FishShoot_Clone skill_FishShoot_Clone2 = this;
		radius = 2;
		HitFeatureData hitFeatureData = skill_FishShoot_Clone2.GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, radius);
		AreaHit_Simple(GetMonsterCloner(), shapeData, hitFeatureData, 17510061, 0.5, HitBox.HurtAnimType.Small, hitEffect_Water);
		yield return WaitTime(waitTime);
		chargeFxID[0] = PlayEffect("fx_m17510_loop_Skill03_charge", 1f, 0.7, spawnPOS);
		chargeFxID[1] = PlayEffect("fx_m17510_loop_Skill03_charge_trail", 1f, 0.7, spawnPOS);
		groundFxID[2] = PlayEffect("fx_m17510_loop_Skill03_charge_ground", 1f, 0.7, spawnPOS);
		chargeFxID[2] = PlayLinkEffect("fx_m17510_loop_Skill03_laser", useCustomSource: true, null, spawnPOS, 2.2, target, default, default, breakWhenLostSourceOrTarget: true, 2f);
		yield return WaitTime(0.75);
		SetLogicTagToggleValue(master, actionStateTagName, value: true);
		yield return WaitTime(0.75);
		PlayEffect("fx_common_base_charge_fire_actor", 1f, 2.2, spawnPOS, default, 2f);
		yield return WaitTime(0.3);
		long[] array = chargeFxID;
		foreach (long id in array)
		{
			StopEffect(id);
		}
		StopEffect(chargeFxID[2]);
		TSVector2 targetPOS = GetEntityPositionObsoleted(target);
		FP angle = GetTSVectToAngle(targetPOS - spawnPOS, 0);
		spoutFxID[0] = PlayEffect("fx_m17510_loop_Skill03_spout", 1f, 0.7, spawnPOS, angle);
		spoutFxID[1] = PlayEffect("fx_m17510_loop_Skill03_spout_ball", 1f, 0.7, spawnPOS, angle);
		for (int j = 0; j < 5; j++)
		{
			shapeData = GetShapeData(DeterministicShape.ShapeType.Rectangle, TransLocalPosToWorldPos(spawnPOS, targetPOS - spawnPOS, new TSVector2(0, 12)), 1.5, 24, default, default, default, angle);
			Skill_FishShoot_Clone skill_FishShoot_Clone3 = this;
			radius = 2;
			hitFeatureData = skill_FishShoot_Clone3.GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, radius);
			AreaHit_Simple(GetMonsterCloner(), shapeData, hitFeatureData, 17510061, 0.25, HitBox.HurtAnimType.Small, hitEffect_Water);
			yield return WaitTime(0.3);
		}
		array = spoutFxID;
		foreach (long id2 in array)
		{
			StopEffect(id2);
		}
		array = groundFxID;
		foreach (long id3 in array)
		{
			StopEffect(id3);
		}
		ballCorState++;
	}
}
