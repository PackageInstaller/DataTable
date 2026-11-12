using System.Collections;
using TrueSync;

namespace AIScript.Monster._50011XingXing.Earth;

public class Skill_Spawn : SkillScript_Base
{
	private static readonly FP PlayerDistance = 13;

	protected TSVector2 targetPOS;

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
		SetLogicTagToggleValue(_actor, "IsEnhanced", value: false);
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
