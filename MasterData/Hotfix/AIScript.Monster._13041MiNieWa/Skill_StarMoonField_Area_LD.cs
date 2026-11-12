#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._13041MiNieWa;

public class Skill_StarMoonField_Area_LD : SkillSimpleBase
{
	private readonly string GroundFx_appear = "Actor/Monster/13041MiNieWa/FX/fx_m13041_loop_skill6_ground";

	private readonly string GroundFx_Disappear = "Actor/Monster/13041MiNieWa/FX/fx_m13041_base_skill6_ground_disappear";

	private readonly string GroundFx_Charge = "Actor/Monster/13041MiNieWa/FX/fx_m13041_loop_skill6_charge";

	private readonly string MineWarning = "Actor/Monster/13041MiNieWa/FX/fx_m13041_base_skill6_ground_warning";

	private readonly string MineATK = "Actor/Monster/13041MiNieWa/FX/fx_m13041_base_skill6_ground_attack";

	private List<long> _Fx = new List<long>();

	private List<LogicEntity> _entities = new List<LogicEntity>();

	private CoroutineNode MaxRunningTime;

	private CoroutineNode CheckPlayer;

	private CoroutineNode AttackPlayer;

	protected override void OnSkillEnable()
	{
		_Fx.Clear();
	}

	protected override void OnSkillDisable()
	{
		_entities.Clear();
		for (int i = 0; i < _Fx.Count; i++)
		{
			StopEffect(_Fx.get_Item(i));
		}
		NovaLogger.Debug("子脚本关闭");
		StopCor(CheckPlayer);
		StopCor(AttackPlayer);
	}

	protected override IEnumerator DoMainLogic()
	{
		MaxRunningTime = StartCor(SkillLimit());
		TSVector2 targetPOS = GetPlaceHolderPosition("BossCenterPoint");
		_Fx.Add(PlayEffect(GroundFx_Charge, 1f, default, targetPOS));
		yield return WaitTime(2.9);
		CheckPlayer = StartCor(MineArea());
		_Fx.Add(PlayEffect(GroundFx_appear, 1f, default, targetPOS));
		yield return WaitTime(20);
		StopCor(CheckPlayer);
		for (int i = 0; i < _Fx.Count; i++)
		{
			StopEffect(_Fx.get_Item(i));
		}
		_Fx.Add(PlayEffect(GroundFx_Disappear, 1f, default, targetPOS));
		yield return WaitTime(3);
		StopCor(MaxRunningTime);
	}

	protected IEnumerator SkillLimit()
	{
		for (int i = 0; i < 25; i++)
		{
			if (GetTargetsByFaction(isFriend: true).Count <= 0)
			{
				InterruptSkill();
				yield return null;
			}
			yield return WaitTime(1);
		}
		InterruptSkill();
		yield return null;
	}

	protected IEnumerator MineArea()
	{
		TSVector2 placeHolderPosition = GetPlaceHolderPosition("BossCenterPoint");
		int num = 15;
		int num2 = 6;
		DeterministicShape ShapeData = GetShapeData(DeterministicShape.ShapeType.Circle, placeHolderPosition, default, default, num, num2);
		for (int i = 0; i < 100; i++)
		{
			_entities.AddRange(GetTargetsFromShape(ShapeData));
			if (_entities.Contains(GetCurrentPlayer()))
			{
				AttackPlayer = StartCor(Mine());
			}
			_entities.Clear();
			yield return WaitTime(0.2);
		}
	}

	protected IEnumerator Mine()
	{
		TSVector2 targetPOS = GetEntityPositionObsoleted(GetCurrentPlayer());
		PlayEffect(MineWarning, 1f, default, targetPOS);
		yield return WaitTime(1);
		PlayEffect(MineATK, 1f, default, targetPOS);
		int num = 1;
		int num2 = 0;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, targetPOS, default, default, num, num2);
		HitFeatureData hitFeatureData = GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, 2);
		LogicEntity monsterCloner = GetMonsterCloner();
		LogicEntity targetByID = GetTargetByID(long.Parse(GetLogicTagStringValue(monsterCloner, "MiniewaID")));
		AreaHit_Simple(targetByID, shapeData, hitFeatureData, 13041060, 0.3, HitBox.HurtAnimType.Small, "Actor/Monster/13041MiNieWa/FX/fx_13041_hit_skill3");
	}
}
