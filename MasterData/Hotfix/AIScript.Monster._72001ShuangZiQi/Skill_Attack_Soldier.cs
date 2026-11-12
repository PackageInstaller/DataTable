using System.Collections;
using System.Collections.Generic;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._72001ShuangZiQi;

public class Skill_Attack_Soldier : SkillSimpleBase
{
	private readonly FP scaleTime = 0.5;

	private readonly FP HitFrameTime = 79;

	private string Color;

	private string UpgradeFXName;

	private string ReadyFXName;

	private string TrailFXName;

	private string HitFXName;

	private string WarningEffectName;

	private string ExtraLoopEffectName;

	private string ExtraAttackEffectName;

	private FP DashDistance;

	private FP orginModelScale;

	private FP AttackRadius;

	private FP ScaleLevel;

	private bool isRed;

	private int phase;

	private int lv;

	private int HitDamageID;

	private int JumpTime;

	private AdventureActor summoner;

	private List<int> PastIndexList;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		summoner = logicComponent.SummonActor;
		PastIndexList = new List<int>();
		isRed = GetLogicTagToggleValue(_actor, "Red");
		phase = GetLogicTagFpValue(_actor, "Phase").AsInt();
		lv = GetLogicTagFpValue(_actor, "Level").AsInt();
		ScaleLevel = GetLogicTagFpValue(_actor, "InitialScaleLevel");
		HitDamageID = 72003021 + (int)(long)ScaleLevel - 1;
		ChessInitialize();
		JumpTime = ((lv <= 2) ? Config.JumpTime_ez_List.get_Item(phase - 1) : Config.JumpTime_hd_List.get_Item(phase - 1));
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		bool isRight = (isRed && phase < 3) || (!isRed && phase == 3);
		TSVector2 tSVector = Config.GetCurIndexByPos(_actor.tsTransform.Position);
		orginModelScale = _actor.actorScaleInfo.modelScale;
		AttackRadius = 1 + ScaleLevel;
		for (int i = 0; i < JumpTime; i++)
		{
			int num = Mathf.Clamp(tSVector.x.AsInt() + 1, 0, Config.cellCount - 1);
			int num2 = Mathf.Clamp(tSVector.x.AsInt() - 1, 0, Config.cellCount - 1);
			TSVector2 nextIndex = (isRight ? new TSVector2(num, tSVector.y) : new TSVector2(num2, tSVector.y));
			if (nextIndex == Config.redBossPos || nextIndex == Config.greenBossPos)
			{
				DashDistance = 0;
			}
			else
			{
				DashDistance = 5;
			}
			BeginAttack(1, "Attack", flushInputedKeys: true, forceInterruptAttack: true);
			PlayEffect(TrailFXName);
			TSVector2 position;
			if (lv >= 3)
			{
				int cellIndexByPos = Config.GetCellIndexByPos(GetPosition());
				List<long> logicTagListLongValue = GetLogicTagListLongValue(summoner, "MapGrids_Color");
				GridColor gridColor = (isRed ? GridColor.Red : GridColor.Green);
				if (logicTagListLongValue.get_Item(cellIndexByPos) == (long)gridColor)
				{
					PlayEffect(ReadyFXName);
					Skill_Attack_Soldier skill_Attack_Soldier = this;
					string upgradeFXName = UpgradeFXName;
					position = GetPosition();
					skill_Attack_Soldier.PlayEffect(upgradeFXName, 1f, default, position);
					if (ScaleLevel < 4)
					{
						ScaleLevel += (FP)1;
						AttackRadius = 1 + ScaleLevel;
						HitDamageID++;
					}
					StartCor(SizeUpgrade());
				}
				if (lv >= 4)
				{
					if (DashDistance != 0)
					{
						PastIndexList.Add(cellIndexByPos);
						PlayAreaEffect(ExtraLoopEffectName, Config.GetCellPosByIndex(Config.GetCurIndexByPos(GetPosition())));
					}
					for (int j = 0; j < PastIndexList.Count; j++)
					{
						PlayAreaEffect(ExtraAttackEffectName, Config.GetCellPosByIndex(PastIndexList.get_Item(j)));
					}
				}
			}
			WarningEffectName = "fx_common_base_Fire_YuJing_circular_" + AttackRadius.ToString();
			Skill_Attack_Soldier skill_Attack_Soldier2 = this;
			string warningEffectName = WarningEffectName;
			float duration = (float)HitFrameTime / 60f;
			position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, DashDistance));
			skill_Attack_Soldier2.PlayEarlyWarningEffect(warningEffectName, duration, default, position);
			yield return WaitCustomEvent("Dash");
			BeginDashActorForward(1, 10, DashDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
			SetCloseBlockEnable();
			yield return WaitCustomEvent("HitFrame");
			string fxAlias = "fx_m72003_base_Attack_hit_R" + AttackRadius.ToString() + "m_" + Color;
			Skill_Attack_Soldier skill_Attack_Soldier3 = this;
			TSVector2 position2 = GetPosition();
			FP radius = AttackRadius - 0.25;
			DeterministicShape shapeData = skill_Attack_Soldier3.GetShapeData(DeterministicShape.ShapeType.Circle, position2, default, default, radius);
			Skill_Attack_Soldier skill_Attack_Soldier4 = this;
			FP knockBackForce = 15;
			FP knockBackDistance = 4;
			radius = 0.25;
			FP hitStrenth = 4;
			HitFeatureData hitFeatureData = skill_Attack_Soldier4.GetHitFeatureData(HitBox.FeatureFlag.KnockBack | HitBox.FeatureFlag.Stiff, knockBackForce, knockBackDistance, UseAtttackForward: false, default, null, null, radius, default, default, default, default, default, default, default, default, null, null, null, null, hitStrenth, UseHitBoxPosition: true);
			Skill_Attack_Soldier skill_Attack_Soldier5 = this;
			position = GetPosition();
			skill_Attack_Soldier5.PlayEffect(fxAlias, 1f, default, position);
			AreaHit_Simple(_actor, shapeData, hitFeatureData, HitDamageID, 0, HitBox.HurtAnimType.Large, HitFXName);
			SetCloseBlockDisable();
			RanSe(Config.GetCurIndexByPos(GetPosition()));
			yield return WaitCombo(ComboAttackType.isComboFinish);
			tSVector = nextIndex;
		}
		_actor.DestroySelf();
	}

	private void ChessInitialize()
	{
		if (isRed)
		{
			Color = "red";
		}
		else
		{
			Color = "green";
		}
		UpgradeFXName = "fx_m72003_base_Attack_collect_box5x5_" + Color;
		ReadyFXName = "fx_m72003_base_Attack_collect_" + Color;
		TrailFXName = "fx_m72003_loop_Attack_trail_" + Color;
		HitFXName = "fx_common_hit_" + Color;
		ExtraLoopEffectName = "AreaEffect_72003_ExtraAttackLoopFX_" + Color;
		ExtraAttackEffectName = "AreaEffect_72003_AreaAttack_" + Color;
	}

	private IEnumerator SizeUpgrade()
	{
		FP curScale = 0;
		while (curScale < scaleTime)
		{
			curScale += _actor.LogicDeltaTime;
			if (_actor.actorScaleInfo.modelScale < Config.maxScale)
			{
				_actor.actorScaleInfo.modelScale = orginModelScale + TSMath.Lerp(0, Config.jumpScale, curScale / Config.jumpScale);
			}
			yield return null;
		}
		orginModelScale = _actor.actorScaleInfo.modelScale;
	}

	private void RanSe(TSVector2 Index)
	{
		List<int> intParamList = new List<int> { Config.GetCellIndexByIndex(Index) };
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.eventHashCode = Config.ranseEvt;
		adventureActorCustomEvent.intParamList = intParamList;
		adventureActorCustomEvent.intParam = (isRed ? 1 : 2);
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
	}
}
