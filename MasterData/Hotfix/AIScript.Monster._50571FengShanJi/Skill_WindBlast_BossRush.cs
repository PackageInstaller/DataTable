using System.Collections;
using TrueSync;

namespace AIScript.Monster._50571FengShanJi;

public class Skill_WindBlast_BossRush : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] WindBlast_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.K };

	private readonly float ZoneFXSizeP1 = 0.8f;

	private readonly float ZoneFXSizeP2 = 1.2f;

	private readonly float GroundFXSizeP1 = 1.2f;

	private readonly float GroundFXSizeP2 = 1.44f;

	private readonly FP LoopWaitTimeP1 = 0.5;

	private readonly FP LoopWaitTimeP2 = 1.5;

	private FP Phase;

	private long ZoneFX;

	private long WindBallFX;

	private long WindBallArea;

	private float ZoneFXSize;

	private float GroundFXSize;

	private FP LoopWaitTime;

	private FP WindBallGroundFXPosition;

	private string WindBallGroundAreaEffectName;

	private string WindBallDrawAreaEffectName;

	private bool IsUpdate;

	protected override void OnSkillEnable()
	{
		Phase = GetLogicTagFpValue(_actor, "BattleStage");
		if (Phase == 2)
		{
			IsUpdate = false;
		}
		else
		{
			IsUpdate = true;
		}
		if (!IsUpdate)
		{
			ZoneFXSize = ZoneFXSizeP1;
			GroundFXSize = GroundFXSizeP1;
			LoopWaitTime = LoopWaitTimeP1;
			WindBallGroundFXPosition = 1;
			WindBallGroundAreaEffectName = "AreaEffect_WindBall_GroundAttack_1_BossRush";
			WindBallDrawAreaEffectName = "AreaEffect_WindBall";
		}
		else
		{
			ZoneFXSize = ZoneFXSizeP2;
			GroundFXSize = GroundFXSizeP2;
			LoopWaitTime = LoopWaitTimeP2;
			WindBallGroundFXPosition = 1.2;
			WindBallGroundAreaEffectName = "AreaEffect_WindBall_GroundAttack_2_BossRush";
			WindBallDrawAreaEffectName = "AreaEffect_WindBall_Plus";
		}
	}

	protected override void OnSkillDisable()
	{
		StopEffect(WindBallFX);
		StopEffect(ZoneFX);
		StopAreaEffect(WindBallArea);
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return BeginLookAt(GetAttackTarget(), 0, 200);
		BeginAttack(1, WindBlast_Combo, flushInputedKeys: true);
		yield return WaitCustomEvent("ZoneFXStart");
		WaitLookAt_NoWait(GetAttackTarget(isUpToDate: true), 999, 60);
		Skill_WindBlast_BossRush skill_WindBlast_BossRush = this;
		Skill_WindBlast_BossRush skill_WindBlast_BossRush2 = this;
		TSVector2 position = GetPosition();
		float zoneFXSize = ZoneFXSize;
		skill_WindBlast_BossRush.ZoneFX = skill_WindBlast_BossRush2.PlayEffect("ZoneFX", 1f, default, position, default, zoneFXSize);
		WindBallArea = PlayAreaEffect(WindBallDrawAreaEffectName, GetPosition(), GetRotation());
		yield return WaitCustomEvent("BallFXStart");
		Skill_WindBlast_BossRush skill_WindBlast_BossRush3 = this;
		Skill_WindBlast_BossRush skill_WindBlast_BossRush4 = this;
		position = GetPosition();
		FP rotation = GetRotation();
		skill_WindBlast_BossRush3.WindBallFX = skill_WindBlast_BossRush4.PlayEffect("WindBallFX", 1f, default, position, rotation);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		if (IsUpdate)
		{
			BeginLookAtMonsterTarget(999, 50);
		}
		yield return WaitTime(LoopWaitTime);
		StopWaitLookAt();
		PlayAreaEffect(WindBallGroundAreaEffectName, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 3.7)));
		yield return WaitTime(0.32);
		CancelAttack();
		yield return WaitCustomEvent("ZoneEndFX");
		Skill_WindBlast_BossRush skill_WindBlast_BossRush5 = this;
		position = GetPosition();
		zoneFXSize = ZoneFXSize;
		skill_WindBlast_BossRush5.PlayEffect("ZoneEndFX", 1f, default, position, default, zoneFXSize);
		yield return WaitCustomEvent("StopFX");
		StopEffect(WindBallFX);
		StopEffect(ZoneFX);
		StopAreaEffect(WindBallArea);
		yield return WaitCustomEvent("WindBallGroundFX");
		Skill_WindBlast_BossRush skill_WindBlast_BossRush6 = this;
		position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, -2 * WindBallGroundFXPosition));
		rotation = GetRotation();
		zoneFXSize = GroundFXSize;
		skill_WindBlast_BossRush6.PlayEffect("WindBallGroundFX", 1f, default, position, rotation, zoneFXSize);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
