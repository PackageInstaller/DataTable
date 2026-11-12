using System.Collections;
using TrueSync;

namespace AIScript.Monster._50572QiQiuJingLing;

public class Skill_Expansion : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Expansion1to2_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.G };

	private static readonly ComboInputBuffer.ActionKey[] Expansion2to3_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.H };

	private ComboInputBuffer.ActionKey[] Expansion_Combo;

	private FP VolumeLevel;

	private int AnimationGroupIndex;

	private FP Difficulty;

	protected override void OnSkillEnable()
	{
		VolumeLevel = GetLogicTagFpValue(_actor, "VolumeLevel");
		Difficulty = GetLogicTagFpValue(_actor, "Difficulty");
		if (VolumeLevel == 1)
		{
			AnimationGroupIndex = 0;
			Expansion_Combo = Expansion1to2_Combo;
		}
		else
		{
			AnimationGroupIndex = 1;
			Expansion_Combo = Expansion2to3_Combo;
		}
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		SetLogicTagFpValue(_actor, "VolumeLevel", VolumeLevel + 1);
		BeginAttack(1, Expansion_Combo, flushInputedKeys: true);
		if (Difficulty != 1)
		{
			if (VolumeLevel == 1)
			{
				AddBuffToTarget(_actor, 505729901);
			}
			else if (VolumeLevel == 2)
			{
				AddBuffToTarget(_actor, 505729902);
				PlayWwiseSound("mon_50572_charge_explosion_warning");
			}
		}
		yield return WaitTime(0.5);
		ReplaceAnimationGroup(AnimationGroupIndex);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
