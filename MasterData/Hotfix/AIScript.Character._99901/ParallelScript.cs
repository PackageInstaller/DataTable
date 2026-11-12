namespace AIScript.Character._99901;

public class ParallelScript : ParallelBase
{
	public override void OnEnable()
	{
		base.OnEnable();
		_actor.DisableMovementAgent();
		_actor.EnableImmuneControl();
		_actor.EnableUnparalleled();
		_actor.EnableSearchedImmunity();
		(_actor as PlayerAdventureActor)?.ShowBlood(isShow: false);
	}

	public override void OnDisable()
	{
		base.OnDisable();
	}
}
