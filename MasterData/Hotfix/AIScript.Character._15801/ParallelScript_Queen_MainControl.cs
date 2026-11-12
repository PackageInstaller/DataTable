namespace AIScript.Character._15801;

public class ParallelScript_Queen_MainControl : ParallelScript_Summoned_MainControl
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
