using System.Collections;

namespace AIScript.Monster._30931HaSaNa;

public class Skill_Spawn_Device : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
		yield return null;
		if (_actor.dataID == GetTeammateIdByIndex(1))
		{
			SetLogicTagFpValue(_actor, "TeammateID", 1);
		}
		else if (_actor.dataID == GetTeammateIdByIndex(2))
		{
			SetLogicTagFpValue(_actor, "TeammateID", 2);
		}
		else if (_actor.dataID == GetTeammateIdByIndex(3))
		{
			SetLogicTagFpValue(_actor, "TeammateID", 3);
		}
		else if (_actor.dataID == GetTeammateIdByIndex(4))
		{
			SetLogicTagFpValue(_actor, "TeammateID", 4);
		}
	}
}
