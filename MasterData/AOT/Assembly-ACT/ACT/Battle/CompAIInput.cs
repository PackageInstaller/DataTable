namespace ACT.Battle;

public class CompAIInput : EcsComponent
{
	public ActBehaviorTree btree;

	protected override void OnGet()
	{
	}

	protected override void OnRelease()
	{
		btree = null;
	}
}
