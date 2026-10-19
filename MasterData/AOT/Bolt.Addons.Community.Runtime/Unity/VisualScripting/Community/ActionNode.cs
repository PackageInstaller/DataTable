namespace Unity.VisualScripting.Community;

[UnitCategory("Community/Control/Delegates")]
[TypeIcon(typeof(Flow))]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.ActionUnit")]
public sealed class ActionNode : DelegateNode
{
	public IAction _action => _delegate as IAction;

	public ActionNode()
	{
	}

	public ActionNode(IDelegate del)
		: base(del)
	{
	}

	protected override void InitializeDelegate(Flow flow, bool instance = false)
	{
		if (instance)
		{
			_action.SetInstance(flow, this, () =>
			{
				Flow.New(flow.stack.ToReference()).Invoke(invoke);
			});
		}
		else
		{
			_action.Initialize(flow, this, () =>
			{
				Flow.New(flow.stack.ToReference()).Invoke(invoke);
			});
		}
	}
}
