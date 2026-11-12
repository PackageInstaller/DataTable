using System.Collections;
using System.Runtime.CompilerServices;
using TrueSync;

namespace AIScript.Monster._13051GaoDa;

public class Skill_Strafe : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] actionKeys_both = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)1802659152,
		(ComboInputBuffer.ActionKey)1701336156,
		(ComboInputBuffer.ActionKey)1180657005
	};

	private static readonly ComboInputBuffer.ActionKey[] actionKeys_left = new ComboInputBuffer.ActionKey[3];

	private static readonly ComboInputBuffer.ActionKey[] actionKeys_right;

	private static readonly ComboInputBuffer.ActionKey[] actionKeys_Another;

	private ComboInputBuffer.ActionKey[] actionKeys;

	private int cooperateType;

	private FP Difficulty;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		int num = (int)(long)_actor.logicVariable.GetLogicTagValue("skillType");
		cooperateType = (int)(long)_actor.logicVariable.GetLogicTagValue("cooperateType");
		switch (num)
		{
		case 0:
			actionKeys = actionKeys_both;
			break;
		case 1:
			actionKeys = actionKeys_left;
			break;
		case 2:
			actionKeys = actionKeys_right;
			break;
		}
		if (cooperateType != 0)
		{
			actionKeys = actionKeys_Another;
		}
		Difficulty = GetLogicTagFpValue(_actor, "Difficulty");
	}

	protected override void OnSkillDisable()
	{
		if (GetTargetByTeammateIndex(4).Count > 0)
		{
			SetLogicTagStringValue(GetTargetByTeammateIndex(4).get_Item(0), "AttackMessage", "");
			SetLogicTagStringValue(GetTargetByTeammateIndex(5).get_Item(0), "AttackMessage", "");
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, actionKeys, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(0.5);
		if (Difficulty == 1)
		{
			yield return WaitTime(2);
		}
		else
		{
			yield return WaitTime(1);
		}
	}

	private IEnumerator SendMessageToPhantom(int index, string message)
	{
		if (GetTargetByTeammateIndex(4).Count * GetTargetByTeammateIndex(5).Count != 0)
		{
			SetLogicTagStringValue(GetTargetByTeammateIndex(index).get_Item(0), "AttackMessage", message);
			yield return WaitTime(0.2);
			SetLogicTagStringValue(GetTargetByTeammateIndex(index).get_Item(0), "AttackMessage", "");
		}
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (Difficulty == 3 && cooperateType != 0)
		{
			if (eventName == "LeftPhantomAttack")
			{
				StartCor(SendMessageToPhantom(4, "LeftPhantomAttack"));
			}
			else if (eventName == "RightPhantomAttack")
			{
				StartCor(SendMessageToPhantom(5, "RightPhantomAttack"));
			}
		}
	}

	static Skill_Strafe()
	{
		//IL_002d: Field data (rva=0x5b0) could not be found in any section!
		//IL_002d: Field data (rva=0x5b0) could not be found in any section!
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._11047585FE102FBB5CADB42446612A578D88C6EF5ED076BB7AC360C4F9E4373D));
		actionKeys_right = array;
		actionKeys_Another = new ComboInputBuffer.ActionKey[6]
		{
			(ComboInputBuffer.ActionKey)1935879731,
			(ComboInputBuffer.ActionKey)16777216,
			(ComboInputBuffer.ActionKey)889192448,
			(ComboInputBuffer.ActionKey)1936933212,
			(ComboInputBuffer.ActionKey)1551070309,
			(ComboInputBuffer.ActionKey)1600352851
		};
	}
}
