using System.Collections;

namespace AIScript.Monster._50171BingXiangGuai_IceCube;

public class KillMyself : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		yield return WaitFrame(1);
		_actor.DestroySelf();
	}
}
