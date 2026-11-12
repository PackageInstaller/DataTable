using AIScript.Monster.Template;
using AIScript.Utils;

namespace AIScript.Monster._72001ShuangZiQi;

public class Parallel_Ball : Parallel
{
	public override void OnStart()
	{
		base.OnStart();
		CommonUtils_MonsterAPI.SetCloseBlockEnable(_actor);
	}

	public override void OnDisable()
	{
		base.OnDisable();
	}
}
