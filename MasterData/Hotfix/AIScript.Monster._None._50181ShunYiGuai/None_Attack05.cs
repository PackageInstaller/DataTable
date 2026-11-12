using System.Collections;

namespace AIScript.Monster._None._50181ShunYiGuai;

public class None_Attack05 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack03 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		GetEnemy();
		Teleport(GetEntityPosition(GetCurrentPlayer()), checkPositionReachable: false);
		BeginLookAt_NotWait(Targetenemy, 4, 240);
		yield return WaitTime(0.6);
		UseMonsterCloneActorCastSkill(5018157);
		yield return WaitTime(1.6);
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
