using System.Collections;

namespace AIScript.Monster._70061WuYu.BoomGhost;

public class Skill_Dead : SkillSimpleBase
{
	private static readonly string DeadKey = "Death";

	private const int DeadIndex = 0;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (!GetLogicTagToggleValue(_actor, "PerfumeHasAddedTag"))
		{
			PerfumeHelper.AddPerfumeToPlayer(GetCurrentPlayer(), AIScript.Monster._70061WuYu.BoomGhost.Action.PerfumeGain);
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		if (!GetLogicTagToggleValue(_actor, "PerfumeHasAddedTag"))
		{
			_actor.PlayDeathAnim();
			BeginAttack(0, DeadKey, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}
}
