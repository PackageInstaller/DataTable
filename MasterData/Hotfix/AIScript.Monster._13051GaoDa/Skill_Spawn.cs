using System.Collections;

namespace AIScript.Monster._13051GaoDa;

public class Skill_Spawn : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		yield return null;
		SetLogicTagToggleValue(_actor, "IsHardcore", value: false);
		ModelNodeShow("body_chushou", isShow: false);
		ShowCenterHpBar();
		if (_actor.dataID == GetTeammateIdByIndex(0))
		{
			yield return WaitTime(0.05);
		}
	}
}
