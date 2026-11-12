#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._10501BanShenShu;

public class Skill_Weeds_CloneActor : SkillSimpleBase
{
	private LogicEntity masterEntity;

	private const int stateID01 = 105010000;

	private const int stateID02 = 105010001;

	private const int stateID03 = 105010002;

	private int stateID;

	private static readonly string Fx_L_Warning = "fx_m10501_loop_Skill8_warning_l";

	private static readonly string Fx_L_Ground = "fx_m10501_loop_Skill8_ground_l";

	private static readonly string Fx_R_Warning = "fx_m10501_loop_Skill8_warning_r";

	private static readonly string Fx_R_Ground = "fx_m10501_loop_Skill8_ground_r";

	private TSVector2 LeftHitPOS = new TSVector2(10, 6.25);

	private TSVector2 RightHitPOS = new TSVector2(-10, 6.25);

	private CoroutineNode TimeLimit;

	private int AttackTimes;

	private long fx_Warning;

	private long fx_Ground;

	private TSVector2 SelfPOS;

	private TSVector2 LeftAttackPOS;

	private TSVector2 RightAttackPOS;

	private DeterministicShape Shape;

	private HitFeatureData HitData;

	private FP Width = 18;

	private FP Length = 30;

	private FP Rotation = 0;

	private List<long> FxList = new List<long>();

	protected override void OnSkillEnable()
	{
		AttackTimes = 0;
	}

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("半身树分身技能结束");
		if (masterEntity != null)
		{
			SetLogicTagToggleValue(masterEntity, "skillIsRunning", value: false);
		}
		AttackTimes = 0;
		StopCor(TimeLimit);
		for (int i = 0; i < FxList.Count; i++)
		{
			StopEffect(FxList.get_Item(i));
		}
		FxList.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		masterEntity = GetMonsterCloner();
		List<BuffEntity> buffFromTarget = GetBuffFromTarget(masterEntity, 0, 105010000);
		stateID = buffFromTarget.get_Item(0).buffConfig.Id;
		TimeLimit = StartCor(AttackTime());
		SetLogicTagToggleValue(masterEntity, "skillIsRunning", value: true);
		yield return StartCor(Attack());
		StopCor(TimeLimit);
	}

	protected IEnumerator AttackTime()
	{
		List<LogicEntity> list = GetTargetsByFaction(isFriend: true);
		bool flag = true;
		for (int i = 0; i < 15; i++)
		{
			if (list != null && list.Count > 0)
			{
				for (int j = 0; j < list.Count; j++)
				{
					if (list.get_Item(j) == GetMonsterCloner())
					{
						flag = false;
					}
				}
				if (flag)
				{
					InterruptSkill();
					yield return null;
				}
				yield return WaitTime(1);
				flag = true;
				list.Clear();
				list = GetTargetsByFaction(isFriend: true);
				continue;
			}
			InterruptSkill();
			yield break;
		}
		InterruptSkill();
		yield return null;
	}

	protected IEnumerator Attack()
	{
		HitData = GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, 2);
		SelfPOS = GetEntityPositionObsoleted(masterEntity);
		if ((int)(long)GetRandomValue(0, 2, isInt: true) == 0)
		{
			NovaLogger.Debug("随机左刀");
			LeftAttackPOS = TransLocalPosToWorldPos(SelfPOS, GetEntityForward(masterEntity), LeftHitPOS);
			Shape = GetShapeData(DeterministicShape.ShapeType.Rectangle, LeftAttackPOS, Width, Length, default, default, default, Rotation);
			fx_Warning = PlayEffect(Fx_L_Warning, 1f, default, SelfPOS, 90);
			FxList.Add(fx_Warning);
			yield return WaitTime(0.2);
			PlayWwiseSound("mon_10010_general_attack_start");
			yield return WaitTime(0.8);
			fx_Ground = PlayEffect(Fx_L_Ground, 1f, default, SelfPOS, 90);
			FxList.Add(fx_Ground);
			yield return WaitTime(0.2);
			PlayWwiseSound("mon_10010_general_attack_end");
			yield return WaitTime(0.8);
		}
		else
		{
			NovaLogger.Debug("随机右刀");
			RightAttackPOS = TransLocalPosToWorldPos(SelfPOS, GetEntityForward(masterEntity), RightHitPOS);
			Shape = GetShapeData(DeterministicShape.ShapeType.Rectangle, RightAttackPOS, Width, Length, default, default, default, Rotation);
			fx_Warning = PlayEffect(Fx_R_Warning, 1f, default, SelfPOS, -90);
			FxList.Add(fx_Warning);
			yield return WaitTime(0.2);
			PlayWwiseSound("mon_10010_general_attack_start");
			yield return WaitTime(0.8);
			fx_Ground = PlayEffect(Fx_R_Ground, 1f, default, SelfPOS, -90);
			FxList.Add(fx_Ground);
			yield return WaitTime(0.2);
			PlayWwiseSound("mon_10010_general_attack_end");
			yield return WaitTime(0.8);
		}
		for (int i = 0; i < 5; i++)
		{
			AreaHit_Simple(_actor, Shape, HitData, 1050130, 1, HitBox.HurtAnimType.Small);
			yield return WaitTime(1.1);
		}
		StopEffect(fx_Warning);
		yield return WaitTime(0.3);
		StopEffect(fx_Ground);
		PlayWwiseSound("mon_10010_general_attack_diappear");
		yield return WaitTime(0.1);
	}
}
