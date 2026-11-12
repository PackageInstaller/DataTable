using System.Collections;
using TrueSync;

namespace AIScript.Monster._30271ShengDanQieChe;

public class Skill04_CallGiftMachine : SkillSimpleBase
{
	private string Call = "Call";

	private LogicEntity Targetenemy;

	private TSVector2 DropPosition;

	protected override IEnumerator DoMainLogic()
	{
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.2, 720);
		BeginAttack(1, Call, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("T1");
		GetEnemy();
		DropPosition = TransLocalPosToWorldPos(new TSVector2(0, 0), GetEntityPosition(Targetenemy), new TSVector2(0, 8));
		if (GetBuffNum(_actor, 302710003) >= 1)
		{
			SummonTeammate(5, DropPosition, DropPosition);
		}
		else
		{
			SummonTeammate(4, DropPosition, DropPosition);
		}
		yield return WaitTime(3);
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}
}
