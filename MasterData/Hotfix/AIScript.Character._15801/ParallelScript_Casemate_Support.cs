namespace AIScript.Character._15801;

public class ParallelScript_Casemate_Support : ParallelScript_Summoned
{
	public override void OnEnable()
	{
		base.OnEnable();
	}

	protected override void OnBattleReady()
	{
		base.OnBattleReady();
		DestroySelf();
	}

	public override void OnDisable()
	{
		base.OnDisable();
	}
}
