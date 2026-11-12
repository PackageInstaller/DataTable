using System.Collections;

namespace AIScript.Monster._Earth._50181ShunYiGuai;

public class Earth_Attack04_Spawn : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack04 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.D,
		ComboInputBuffer.ActionKey._2
	};

	protected override void OnSkillEnable()
	{
		SetHideModelEnable(autoDisableWhenSkillDisable: false);
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		SetSearchedImmunityEnable(autoDisableWhenSkillDisable: false);
		SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetTargetByTeammateIndex(0).get_Item(0);
		if (GetBuffNum(target, 501810002) >= 1)
		{
			AddBuffToTarget(_actor, 501810002);
		}
		if (GetBuffNum(target, 501810001) >= 1)
		{
			AddBuffToTarget(_actor, 501810001);
		}
		yield return WaitFrame(1);
		yield return null;
	}
}
