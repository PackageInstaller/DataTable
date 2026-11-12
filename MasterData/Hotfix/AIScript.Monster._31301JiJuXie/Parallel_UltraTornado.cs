using AIScript.Monster.Template;
using AIScript.Utils;

namespace AIScript.Monster._31301JiJuXie;

public class Parallel_UltraTornado : Parallel
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
