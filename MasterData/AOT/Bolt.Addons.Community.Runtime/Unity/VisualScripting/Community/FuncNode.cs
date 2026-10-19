namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.Fundamentals.FuncUnit")]
[TypeIcon(typeof(Flow))]
[UnitCategory("Community/Control/Delegates")]
public sealed class FuncNode : DelegateNode
{
	[DoNotSerialize]
	public ValueInput @return;

	public IFunc _func => _delegate as IFunc;

	public FuncNode()
	{
	}

	public FuncNode(IDelegate del)
		: base(del)
	{
	}

	protected override void InitializeDelegate(Flow flow, bool instance = false)
	{
		_func.Initialize(flow, this, () =>
		{
			Flow flow2 = Flow.New(flow.stack.AsReference());
			flow2.Invoke(invoke);
			return flow2.GetValue(@return);
		});
	}

	protected override void Definition()
	{
		base.Definition();
		if (_func != null)
		{
			@return = ValueInput(_func.ReturnType, "return");
		}
	}
}
