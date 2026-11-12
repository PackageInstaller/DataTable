using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi_Mainline;

public class Skill_SilkPierce : SkillSimpleBase
{
	private const string combo_SilkPierce = "SilkPierce";

	private const string warningAlias = "fx_warning_square_3side_2x30";

	private const string silkAlias = "fx_m72011_base_RangedAttack_end";

	private FP totalAngle = 90;

	private static readonly int[] phantomMonsterIds = new int[6] { 1869366879, 1550606706, 1769235265, 1663987311, 115, 1 };

	private static readonly int[] phantomInitCastCounts;

	private static readonly int[] phantomMaxCounts;

	private FP summonInterval = 0.5f;

	private FP summonInnerRadius = 6;

	private FP summonOuterRadius = 8;

	private FP summonMinSpacing = 5;

	private const int summonMaxRetry = 20;

	private const string castCountTag = "SilkPierceCastCount";

	private FP turnTime = 0.5;

	private FP warningTime = 1.8f;

	private long fx_warn_1;

	private long fx_warn_2;

	private long fx_warn_3;

	private long fx_warn_4;

	private long fx_warn_5;

	private bool finished;

	private int _summonLevel;

	private int _phantomId;

	private CoroutineNode spawnPhantomsCor;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		finished = false;
		_summonLevel = (int)(long)GetLogicTagFpValue(_actor, Common_73001.SummonLevel_Tag);
		_phantomId = Common_73001.GetMonsterIdByLevel(_summonLevel, phantomMonsterIds);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopEffect(fx_warn_1);
		StopEffect(fx_warn_2);
		StopEffect(fx_warn_3);
		StopEffect(fx_warn_4);
		StopEffect(fx_warn_5);
		StopSpawnCoroutines();
		if (!finished)
		{
			ClearOwnerBullet();
			ClearActors(GetTargetByDataID(_phantomId));
		}
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		StopSpawnCoroutines();
		ClearOwnerBullet();
		ClearActors(GetTargetByDataID(_phantomId));
	}

	private void StopSpawnCoroutines()
	{
		if (spawnPhantomsCor != null)
		{
			StopCor(spawnPhantomsCor);
			spawnPhantomsCor = null;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetAttackTarget();
		TSVector2 entityPosition = GetEntityPosition(target);
		Skill_SilkPierce skill_SilkPierce = this;
		FP radius = 10.5f;
		FP innerRadius = 7;
		DeterministicShape shapeData = skill_SilkPierce.GetShapeData(DeterministicShape.ShapeType.Circle, entityPosition, default, default, radius, innerRadius);
		TSVector2 telepos = Common_73001.ClampToCenter(GetShapeRandomPoint(shapeData, _actor, isReachable: true), 10);
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) <= 5)
		{
			BeginAttack(1, "Teleport", flushInputedKeys: true);
			yield return WaitCustomEvent("TeleportStart");
			Teleport(telepos);
			yield return WaitTime(0.1f);
			BeginLookAt_NotWait(target, 0.2, 1000);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else
		{
			BeginLookAt_NotWait(GetAttackTarget(), turnTime, GetRotSpdInSkill());
			yield return WaitTime(turnTime);
		}
		BeginAttack(2, "SilkPierce", flushInputedKeys: true);
		BeginLookAt_NotWait(target, 2, 300);
		yield return WaitTime(0.2);
		int monsterIdByLevel = Common_73001.GetMonsterIdByLevel(_summonLevel, phantomInitCastCounts);
		int monsterIdByLevel2 = Common_73001.GetMonsterIdByLevel(_summonLevel, phantomMaxCounts);
		int castCount = (int)(long)GetLogicTagFpValue(_actor, "SilkPierceCastCount");
		castCount = ((castCount >= monsterIdByLevel2) ? monsterIdByLevel2 : castCount);
		spawnPhantomsCor = StartCor(SpawnPhantoms(monsterIdByLevel + castCount + 1));
		yield return spawnPhantomsCor;
		StopLookAt();
		SetLogicTagFpValue(_actor, "SilkPierceCastCount", castCount + 1);
		FP entityAngle = GetEntityAngle(_actor);
		Skill_SilkPierce skill_SilkPierce2 = this;
		Skill_SilkPierce skill_SilkPierce3 = this;
		float duration = (float)warningTime;
		TSVector2 position = GetPosition();
		innerRadius = entityAngle;
		skill_SilkPierce2.fx_warn_1 = skill_SilkPierce3.PlayEarlyWarningEffect("fx_warning_square_3side_2x30", duration, default, position, innerRadius);
		Skill_SilkPierce skill_SilkPierce4 = this;
		Skill_SilkPierce skill_SilkPierce5 = this;
		float duration2 = (float)warningTime;
		position = GetPosition();
		innerRadius = entityAngle;
		skill_SilkPierce4.fx_warn_2 = skill_SilkPierce5.PlayEarlyWarningEffect("fx_warning_square_3side_2x30", duration2, default, position, innerRadius);
		Skill_SilkPierce skill_SilkPierce6 = this;
		Skill_SilkPierce skill_SilkPierce7 = this;
		float duration3 = (float)warningTime;
		position = GetPosition();
		innerRadius = entityAngle;
		skill_SilkPierce6.fx_warn_3 = skill_SilkPierce7.PlayEarlyWarningEffect("fx_warning_square_3side_2x30", duration3, default, position, innerRadius);
		Skill_SilkPierce skill_SilkPierce8 = this;
		Skill_SilkPierce skill_SilkPierce9 = this;
		float duration4 = (float)warningTime;
		position = GetPosition();
		innerRadius = entityAngle;
		skill_SilkPierce8.fx_warn_4 = skill_SilkPierce9.PlayEarlyWarningEffect("fx_warning_square_3side_2x30", duration4, default, position, innerRadius);
		Skill_SilkPierce skill_SilkPierce10 = this;
		Skill_SilkPierce skill_SilkPierce11 = this;
		float duration5 = (float)warningTime;
		position = GetPosition();
		innerRadius = entityAngle;
		skill_SilkPierce10.fx_warn_5 = skill_SilkPierce11.PlayEarlyWarningEffect("fx_warning_square_3side_2x30", duration5, default, position, innerRadius);
		BeginRotateEffect(fx_warn_1, -40, 40);
		BeginRotateEffect(fx_warn_2, -20, 20);
		BeginRotateEffect(fx_warn_4, 20, 20);
		BeginRotateEffect(fx_warn_5, 40, 40);
		yield return WaitTime(warningTime - 0.1);
		CancelAttack();
		finished = true;
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator SpawnPhantoms(int n)
	{
		if (n <= 0)
		{
			yield break;
		}
		TSVector2 targetPos = GetEntityPosition(GetAttackTarget());
		Skill_SilkPierce skill_SilkPierce = this;
		FP radius = summonOuterRadius;
		FP innerRadius = summonInnerRadius;
		DeterministicShape shape = skill_SilkPierce.GetShapeData(DeterministicShape.ShapeType.Circle, targetPos, default, default, radius, innerRadius);
		List<TSVector2> placed = new List<TSVector2>(n);
		FP minSpacingSq = summonMinSpacing * summonMinSpacing;
		for (int i = 0; i < n; i++)
		{
			TSVector2 tSVector = default;
			for (int j = 0; j < 20; j++)
			{
				TSVector2 shapeRandomPoint = GetShapeRandomPoint(shape, _actor, isReachable: true);
				bool flag = false;
				foreach (TSVector2 item in placed)
				{
					if (TSVector2.DistanceSquared(shapeRandomPoint, item) < minSpacingSq)
					{
						flag = true;
						break;
					}
				}
				if (!flag)
				{
					tSVector = shapeRandomPoint;
					break;
				}
				if (j == 19)
				{
					tSVector = shapeRandomPoint;
				}
			}
			placed.Add(tSVector);
			TSVector2 spawnDirection = targetPos - tSVector;
			SummonMonster(_phantomId, 0, tSVector, spawnDirection);
			if (i < n - 1)
			{
				yield return WaitTime(summonInterval);
			}
		}
	}

	static Skill_SilkPierce()
	{
		//IL_0022: Field data (rva=0x6b8) could not be found in any section!
		//IL_0022: Field data (rva=0x6b8) could not be found in any section!
		int[] array = new int[6];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._2D042961A7B3FC02A7E9CED3697C3185AF3767179C597B8BB771E3C4CBFE5D35));
		phantomInitCastCounts = array;
		phantomMaxCounts = new int[6] { 1547829248, 1702064961, 1398567796, 1214210930, 1768322159, 1918131320 };
	}
}
