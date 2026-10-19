using System.Collections.Generic;

namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.Fundamentals.DelegateUnit")]
public abstract class DelegateNode : Unit
{
	[Serialize]
	public IDelegate _delegate;

	[DoNotSerialize]
	public ValueOutput @delegate;

	[DoNotSerialize]
	public ValueOutput Callback;

	public string name;

	[DoNotSerialize]
	public List<ValueOutput> parameters = new List<ValueOutput>();

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlOutput invoke;

	[UnitHeaderInspectable]
	private bool variable;

	private object[] values;

	public DelegateNode()
	{
	}

	public DelegateNode(IDelegate @delegate)
	{
		_delegate = @delegate;
	}

	protected override void Definition()
	{
		isControlRoot = true;
		parameters.Clear();
		invoke = ControlOutput("invoke");
		if (_delegate == null)
		{
			return;
		}
		Callback = ValueOutput(_delegate.GetDelegateType(), "Callback", (Flow flow) =>
		{
			Flow flow2 = Flow.New(flow.stack.AsReference());
			InitializeDelegate(flow2, _delegate.initialized);
			return _delegate.GetDelegate();
		});
		@delegate = ValueOutput(_delegate.GetType(), "delegate", (Flow flow) =>
		{
			Flow flow2 = Flow.New(flow.stack.AsReference());
			InitializeDelegate(flow2, _delegate.initialized);
			return _delegate;
		});
		for (int num = 0; num < _delegate.parameters.Length; num++)
		{
			int index = num;
			parameters.Add(ValueOutput(_delegate.parameters[num].type, _delegate.parameters[num].name, (Flow flow) => values[index]));
		}
	}

	public override void Instantiate(GraphReference instance)
	{
		base.Instantiate(instance);
		if (_delegate != null)
		{
			_delegate.initialized = false;
		}
	}

	public void AssignParameters(Flow flow, params object[] parameters)
	{
		values = parameters;
	}

	protected abstract void InitializeDelegate(Flow flow, bool instance = false);
}
