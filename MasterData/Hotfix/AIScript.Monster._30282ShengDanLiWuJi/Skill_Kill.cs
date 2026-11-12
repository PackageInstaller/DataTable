using System.Collections;

namespace AIScript.Monster._30282ShengDanLiWuJi;

public class Skill_Kill : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Z };

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack1, flushInputedKeys: true, forceInterruptAttack: true);
		SetCloseBlockEnable();
		yield return WaitTime(2);
		_actor.ClearSelf();
	}
}
