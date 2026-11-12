public class DormActorFSM_Hide(DormActor actor, int state) : DormActorFSM(actor, state)
{
	private float hoverHeight = 0.2f;

	public override void OnEnter(object data = null)
	{
		base.OnEnter(data);
		actor.StopMove();
		actor.DisableMovment();
		actor.StopLogic();
		actor.Hide();
	}

	public override void OnExit()
	{
		actor.EnableMovment();
		actor.Visible();
		actor.ResumeLogic();
		base.OnExit();
	}
}
