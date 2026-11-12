using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._72001ShuangZiQi;

public class Skill_Attack_Knight : SkillSimpleBase
{
	private FP crossAttackDelay = 0;

	private bool isRed;

	private int phase;

	private int lv;

	private string Color;

	private string AttackFX_Start;

	private string DaoGuangFX;

	private string FirstAreaEffect;

	private string OtherAreaEffect;

	private string ChargeFX;

	private string RoadEffect90;

	private TSVector2 TargetPosIndex2;

	private TSVector2 TargetPosIndex1;

	private static readonly (int dx, int dy)[] knightOffsets = new (int, int)[8]
	{
		(2, 1),
		(2, -1),
		(-2, 1),
		(-2, -1),
		(1, 2),
		(1, -2),
		(-1, 2),
		(-1, -2)
	};

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		isRed = GetLogicTagToggleValue(_actor, "Red");
		phase = GetLogicTagFpValue(_actor, "Phase").AsInt();
		lv = GetLogicTagFpValue(_actor, "Level").AsInt();
		ChessInitialize();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		TSVector2 position = GetCurrentPlayer().tsTransform.Position;
		TSVector2 curIndexByPos = Config.GetCurIndexByPos(_actor.tsTransform.Position);
		int num = curIndexByPos.x.AsInt();
		int num2 = curIndexByPos.y.AsInt();
		TargetPosIndex2 = FindBestKnightTarget(num, num2, position);
		FP fP = TargetPosIndex2.x - num;
		FP fP2 = TargetPosIndex2.y - num2;
		if (TSMath.Abs(fP) > TSMath.Abs(fP2))
		{
			TargetPosIndex1 = new TSVector2(num + fP, num2);
		}
		else
		{
			TargetPosIndex1 = new TSVector2(num, num2 + fP2);
		}
		TSVector2 cellPosByIndex = Config.GetCellPosByIndex(num, num2);
		TSVector2 targetPos1 = TransLocalPosToWorldPos(cellPosByIndex, Config.GetCellPosByIndex(TargetPosIndex1) - cellPosByIndex, new TSVector2(0, 5));
		TSVector2 targetPos2 = Config.GetCellPosByIndex(TargetPosIndex2);
		TSVector2 tSVector = TransLocalPosToWorldPos(cellPosByIndex, targetPos1 - cellPosByIndex, new TSVector2(0, 2.5));
		TSVector2 tSVector2 = TransLocalPosToWorldPos(tSVector, targetPos1 - tSVector, new TSVector2(0, 2.5));
		TSVector2 tSVector3 = TransLocalPosToWorldPos(tSVector2, targetPos2 - tSVector2, new TSVector2(0, 3.5));
		BeginAttack(1, "Attack", flushInputedKeys: true, forceInterruptAttack: true);
		Skill_Attack_Knight skill_Attack_Knight = this;
		string attackFX_Start = AttackFX_Start;
		TSVector2 position2 = GetPosition();
		FP angle = 0;
		skill_Attack_Knight.PlayEffect(attackFX_Start, 1f, default, position2, angle);
		BeginLookAtByPos_NotWait(targetPos2, 0.25, 999);
		Skill_Attack_Knight skill_Attack_Knight2 = this;
		string roadEffect = RoadEffect90;
		position2 = tSVector;
		angle = GetTSVectToAngle(targetPos1 - tSVector, 0);
		long roadEffectHandle1 = skill_Attack_Knight2.PlayEffect(roadEffect, 2f, default, position2, angle);
		Skill_Attack_Knight skill_Attack_Knight3 = this;
		string roadEffect2 = RoadEffect90;
		position2 = tSVector3;
		angle = GetTSVectToAngle(targetPos2 - tSVector3, 0);
		long roadEffectHandle2 = skill_Attack_Knight3.PlayEffect(roadEffect2, 2f, default, position2, angle);
		Skill_Attack_Knight skill_Attack_Knight4 = this;
		position2 = targetPos2;
		angle = 0;
		skill_Attack_Knight4.PlayEarlyWarningEffect("fx_warning_square_4side_5x5", 2f, default, position2, angle);
		yield return WaitCustomEvent("Jump");
		SetCloseBlockEnable();
		FP fP3 = 0.2f;
		FP duration = (FP)5 / (FP)21 * fP3;
		FP Jump2Time = (FP)14 / (FP)21 * fP3;
		yield return CrossJump(targetPos1, 0, duration);
		yield return CrossJump(targetPos2, 0, Jump2Time);
		StopEffect(roadEffectHandle1);
		StopEffect(roadEffectHandle2);
		yield return WaitCustomEvent("DaoGuangFX");
		Skill_Attack_Knight skill_Attack_Knight5 = this;
		string daoGuangFX = DaoGuangFX;
		position2 = GetPosition();
		angle = GetRotation();
		skill_Attack_Knight5.PlayEffect(daoGuangFX, 1f, default, position2, angle);
		yield return WaitCustomEvent("HitFrame");
		int curX = TargetPosIndex2.x.AsInt();
		int curY = TargetPosIndex2.y.AsInt();
		PlayAreaEffect(FirstAreaEffect, GetPosition(), 0);
		RanSe(TargetPosIndex2);
		CrossAttack(curX, curY);
		yield return WaitTime(0.1);
		SetCloseBlockDisable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private TSVector2 FindBestKnightTarget(int curX, int curY, TSVector2 playerPos)
	{
		TSVector2 result = new TSVector2(curX, curY);
		FP fP = FP.MaxValue;
		for (int i = 0; i < knightOffsets.Length; i++)
		{
			int num = curX + knightOffsets[i].dx;
			int num2 = curY + knightOffsets[i].dy;
			if (!Config.IsOutOfRange(num, num2) && (num != Config.redBossPos.x.AsInt() || num2 != Config.redBossPos.y.AsInt()) && (num != Config.greenBossPos.x.AsInt() || num2 != Config.greenBossPos.y.AsInt()))
			{
				FP fP2 = TSVector2.Distance(Config.GetCellPosByIndex(num, num2), playerPos);
				if (fP2 < fP)
				{
					fP = fP2;
					result = new TSVector2(num, num2);
				}
			}
		}
		return result;
	}

	private void CrossAttack(int curX, int curY)
	{
		(int, int)[] array = new (int, int)[4]
		{
			(0, 1),
			(0, -1),
			(1, 0),
			(-1, 0)
		};
		for (int i = 0; i < array.Length; i++)
		{
			TSVector2 index = new TSVector2(curX + array[i].Item1, curY + array[i].Item2);
			if (!Config.IsOutOfRange(index))
			{
				TSVector2 cellPosByIndex = Config.GetCellPosByIndex(index);
				PlayAreaEffect(OtherAreaEffect, cellPosByIndex);
				RanSe(index);
			}
		}
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
		AttackFX_Start = "fx_m72003_base_Attack_collect_" + Color;
		DaoGuangFX = "fx_m72006_base_attack_daoguang_" + Color;
		ChargeFX = "fx_m72006_base_attack_xuli02_" + Color;
		OtherAreaEffect = "AreaEffect_72006_AreaAttack_" + Color;
		FirstAreaEffect = "AreaEffect_72006_FirstAttack_" + Color;
		RoadEffect90 = "fx_m72007_loop_warning_" + Color;
	}
}
