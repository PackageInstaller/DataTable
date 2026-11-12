using System.Collections;
using TrueSync;

namespace AIScript.Monster._30281ShengDanTaLou;

public class Skill_01 : SkillSimpleBase
{
	private string Attack_L = "Skill01_L";

	private string Attack_R = "Skill01_R";

	private string Attack;

	private TSVector2 FxPosition;

	private TSVector2 FxOffsetPosition;

	private long Effect01;

	private long Area01;

	private long Area02;

	private long Area03;

	private long Area04;

	protected override void OnSkillEnable()
	{
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) <= 0)
		{
			Attack = Attack_R;
			FxOffsetPosition = new TSVector2(2.2, 2.8);
		}
		else
		{
			Attack = Attack_L;
			FxOffsetPosition = new TSVector2(-2.2, 2.8);
		}
	}

	protected override void OnSkillDisable()
	{
		ResetBlockPriority();
		StopAreaEffect(Area01);
		StopAreaEffect(Area02);
		StopAreaEffect(Area03);
		StopAreaEffect(Area04);
		StopEffect(Effect01);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(GetCurrentPlayer(), 3, 25);
		yield return WaitCustomEvent("TurnEnd");
		StopWaitLookAt();
		SetBlockPriorityToStatic();
		FxPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), FxOffsetPosition);
		if (GetMonsterTagValue(_actor, 1) != "Lv1")
		{
			StartCor(SpawnArea02());
		}
		else
		{
			StartCor(SpawnArea01());
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator SpawnArea01()
	{
		Area01 = PlayAreaEffect("Area_30281_Skill01_1", FxPosition);
		yield return WaitFrame(30);
		Area02 = PlayAreaEffect("Area_30281_Skill01_LoopEffect", FxPosition);
		yield return WaitCustomEvent("LoopEnd");
		CancelAttack();
		Area03 = PlayAreaEffect("Area_30281_Skill01_2", FxPosition);
		StopAreaEffect(Area02);
	}

	protected IEnumerator SpawnArea02()
	{
		Area01 = PlayAreaEffect("Area_30281_Skill01_1", FxPosition);
		yield return WaitFrame(30);
		Effect01 = PlayEffect("Effect_Skill01_BigArea", 1.32f, default, FxPosition, default, 1.3f);
		Area02 = PlayAreaEffect("Area_30281_Skill01_LoopEffect", FxPosition);
		yield return WaitCustomEvent("LoopEnd");
		CancelAttack();
		yield return WaitFrame(19);
		Area04 = PlayAreaEffect("Area_30281_Skill01_3", FxPosition);
		StopAreaEffect(Area02);
	}
}
