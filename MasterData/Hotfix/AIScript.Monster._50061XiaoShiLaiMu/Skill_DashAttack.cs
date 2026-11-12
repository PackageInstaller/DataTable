#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._50061XiaoShiLaiMu;

public class Skill_DashAttack : SkillSimpleBase
{
	private readonly string DashAttack = "DashAttack";

	private readonly int AttackIndex = 2;

	private readonly string FxAlias = "fx_50061_base_birth";

	private readonly float PlayBackSpeed = 0.7f;

	private readonly FP FxPositionY = 0;

	private TSVector2 FxPosition;

	private readonly FP FxAngle = 0;

	private readonly int kILLStateID = 500710520;

	private LogicEntity Target;

	private readonly FP StopDIST = 2;

	private readonly FP FinishTime = 5;

	private FP TraceTime;

	private FP RelativeDIST;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		TraceTime = 0;
		RelativeDIST = 0;
	}

	protected override IEnumerator DoMainLogic()
	{
		Target = GetCurrentPlayer();
		if (Target == null)
		{
			InterruptSkill();
		}
		WaitLookAt(Target, 1, 360);
		BeginTrace(Target, 0.1, -1, 99);
		do
		{
			RelativeDIST = Distance(GetPosition(), GetEntityPositionObsoleted(Target));
			FP relativeDIST = RelativeDIST;
			NovaLogger.Debug("相对距离为" + relativeDIST.ToString());
			if (RelativeDIST <= StopDIST)
			{
				relativeDIST = RelativeDIST;
				NovaLogger.Debug("满足距离跳出" + relativeDIST.ToString());
				break;
			}
			TraceTime += (FP)0.2;
			yield return WaitTime(0.2);
		}
		while (TraceTime < FinishTime);
		StopTrace();
		BeginAttack(AttackIndex, DashAttack);
		FxPosition = GetPosition();
		PlayEffect(FxAlias, PlayBackSpeed, FxPositionY, FxPosition, FxAngle);
		AddBuffToTarget(_actor, kILLStateID);
	}
}
