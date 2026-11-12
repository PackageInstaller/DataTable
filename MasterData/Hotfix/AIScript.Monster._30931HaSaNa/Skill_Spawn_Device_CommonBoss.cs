using System.Collections;

namespace AIScript.Monster._30931HaSaNa;

public class Skill_Spawn_Device_CommonBoss : SkillSimpleBase
{
	private LogicEntity BossActor;

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
		while (GetTargetByTeammateIndex(0).Count + GetTargetByTeammateIndex(5).Count == 0)
		{
			yield return null;
		}
		if (GetTargetByTeammateIndex(0).Count > 0)
		{
			BossActor = GetTargetByTeammateIndex(0).get_Item(0);
			SetLogicTagFpValue(_actor, "BossTeammateID", 0);
		}
		else if (GetTargetByTeammateIndex(5).Count > 0)
		{
			BossActor = GetTargetByTeammateIndex(5).get_Item(0);
			SetLogicTagFpValue(_actor, "BossTeammateID", 5);
		}
		SetLogicTagFpValue(_actor, "Difficulty", GetLogicTagFpValue(BossActor, "Difficulty"));
	}
}
