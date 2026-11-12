using AIScript.Monster.Template;
using AIScript.Utils;

namespace AIScript.Monster._72001ShuangZiQi;

public class Parallel_General : Parallel
{
	public override void OnStart()
	{
		base.OnStart();
		CommonUtils_MonsterAPI.SetUnparalleledEnable(_actor);
	}

	public override void OnDisable()
	{
		base.OnDisable();
	}
}
