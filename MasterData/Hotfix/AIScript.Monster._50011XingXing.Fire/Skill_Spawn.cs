using System.Collections;
using TrueSync;

namespace AIScript.Monster._50011XingXing.Fire;

public class Skill_Spawn : SkillSimpleBase
{
	private static readonly FP PlayerDistance = 13;

	protected TSVector2 targetPOS;

	protected override void OnSkillEnable()
	{
		SetBattleOutEnable();
	}

	protected override void OnSkillDisable()
	{
		SetLogicTagFpValue(_actor, "ReleaseInterval", 1);
		ShowCenterHpBar();
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetCurrentPlayer();
		if (target != null)
		{
			targetPOS = GetEntityPositionObsoleted(target);
		}
		while (Distance(targetPOS, GetPosition()) >= PlayerDistance)
		{
			if (target != null)
			{
				targetPOS = GetEntityPositionObsoleted(target);
			}
			yield return WaitFrame(10);
		}
	}
}
