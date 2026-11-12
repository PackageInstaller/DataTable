using System.Collections;

namespace AIScript.Monster._50011XingXing.Dark;

public class Skill_MasterSpawn : Skill_Spawn
{
	protected override IEnumerator DoMainLogic()
	{
		base.DoMainLogic();
		SetLogicTagFpValue(_actor, "ReleaseInterval", 1);
		yield break;
	}
}
