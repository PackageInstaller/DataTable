namespace AIScript.Character._15501;

public class RelaxState : IState
{
	private int relaxBeginEvt = CommonHelper.StringToHash("Relax_Begin");

	public override void Enter()
	{
		base.Enter();
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.eventHashCode = relaxBeginEvt;
		adventureActorCustomEvent.sender = _actor;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
	}

	public override void ForceExit()
	{
		Exit();
	}

	public void NormalExit()
	{
		Exit();
	}

	public override void Update()
	{
		base.Update();
		if (_actor.attackTarget != null)
		{
			NormalExit();
		}
	}
}
