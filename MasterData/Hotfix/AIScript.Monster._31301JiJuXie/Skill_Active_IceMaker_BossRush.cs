using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_Active_IceMaker_BossRush : SkillSimpleBase
{
	private static readonly string combo_Active = "Active_BossRush";

	private static readonly string combo_Active_Strong = "Active_Strong_BossRush";

	private static readonly string combo_End = "Idle";

	private static readonly string combo_End1 = "End";

	private static readonly string combo_End2 = "SmallEnd";

	private readonly FP IceMaker_ActiveDuration = 17;

	private readonly string tag1 = "Hard";

	private readonly string tag2 = "Hard2";

	private int phase;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		List<LogicEntity> targetByTeammateIndex = GetTargetByTeammateIndex(0);
		if (targetByTeammateIndex != null && targetByTeammateIndex.Count > 0)
		{
			phase = GetLogicTagFpValue(targetByTeammateIndex.get_Item(0), "Phase").AsInt();
		}
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		string monsterTagValue = GetMonsterTagValue(_actor, 1);
		if (monsterTagValue == tag2)
		{
			string actionKey = ((phase == 3) ? combo_Active_Strong : combo_Active);
			BeginAttack(1, actionKey, flushInputedKeys: true, forceInterruptAttack: true);
			if (phase == 2)
			{
				yield return WaitTime(7.5);
				BeginAttack(2, combo_End, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitTime(7.5);
				BeginAttack(3, combo_End2, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitTime(0.1);
				SetHideModelEnable();
				yield return WaitTime(0.1);
				_actor.ClearSelf();
			}
			else
			{
				yield return WaitTime(8.5);
				BeginAttack(2, combo_End, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitTime(8.5);
				BeginAttack(3, combo_End1, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitTime(0.1);
				SetHideModelEnable();
				yield return WaitTime(0.1);
				_actor.ClearSelf();
			}
		}
		else if (monsterTagValue == tag1)
		{
			if (phase == 2)
			{
				yield return WaitTime(7.5);
				string actionKey2 = ((phase == 3) ? combo_Active_Strong : combo_Active);
				BeginAttack(1, actionKey2, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitTime(7.5);
				CancelAttack();
				yield return WaitTime(0.1);
				SetHideModelEnable();
				yield return WaitTime(0.1);
				_actor.ClearSelf();
			}
			else
			{
				yield return WaitTime(8.5);
				string actionKey3 = ((phase == 3) ? combo_Active_Strong : combo_Active);
				BeginAttack(1, actionKey3, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitTime(8.5);
				CancelAttack();
				yield return WaitTime(0.1);
				SetHideModelEnable();
				yield return WaitTime(0.1);
				_actor.ClearSelf();
			}
		}
		else
		{
			string actionKey4 = ((phase == 3) ? combo_Active_Strong : combo_Active);
			BeginAttack(1, actionKey4, flushInputedKeys: true, forceInterruptAttack: true);
			if (phase == 2)
			{
				yield return WaitTime(15);
			}
			else
			{
				yield return WaitTime(17);
			}
			CancelAttack();
			yield return WaitTime(0.1);
			SetHideModelEnable();
			yield return WaitTime(0.1);
			_actor.ClearSelf();
		}
	}
}
