using System.Collections;
using TrueSync;

namespace AIScript.Monster._50081DaShiLaiMu;

public class Skill_Spawn : SkillSimpleBase
{
	private static readonly FP PlayerDistance = 13;

	protected TSVector2 targetPosition;

	protected override void OnSkillEnable()
	{
		SetBattleOutEnable();
	}

	protected override void OnSkillDisable()
	{
		ShowCenterHpBar();
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetCurrentPlayer();
		if (target != null)
		{
			targetPosition = GetEntityPositionObsoleted(target);
		}
		while (Distance(targetPosition, GetPosition()) >= PlayerDistance)
		{
			if (target != null)
			{
				targetPosition = GetEntityPositionObsoleted(target);
			}
			yield return WaitFrame(10);
		}
	}
}
