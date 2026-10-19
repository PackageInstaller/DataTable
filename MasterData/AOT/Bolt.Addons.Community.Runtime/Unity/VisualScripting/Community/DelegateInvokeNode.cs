using System.Collections.Generic;

namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.Fundamentals.DelegateInvokeUnit")]
public abstract class DelegateInvokeNode<TDelegateInterface> : Unit where TDelegateInterface : IDelegate
{
	[Serialize]
	public TDelegateInterface _delegate;

	[DoNotSerialize]
	public ValueInput @delegate;

	[DoNotSerialize]
	[PortLabelHidden]
	public ControlInput enter;

	[DoNotSerialize]
	[PortLabelHidden]
	public ControlOutput exit;

	[DoNotSerialize]
	public List<ValueInput> parameters = new List<ValueInput>();

	protected virtual bool isPure => false;

	public DelegateInvokeNode()
	{
	}

	public DelegateInvokeNode(TDelegateInterface @delegate)
	{
		_delegate = @delegate;
	}

	protected override void Definition()
	{
		parameters.Clear();
		if (!isPure)
		{
			enter = ControlInput("enter", (Flow flow) =>
			{
				List<object> list = new List<object>();
				flow.GetValue<TDelegateInterface>(@delegate);
				for (int i = 0; i < parameters.Count; i++)
				{
					list.Add(flow.GetValue(parameters[i]));
				}
				Invoke(flow, list);
				return exit;
			});
			exit = ControlOutput("exit");
		}
		if (_delegate != null)
		{
			@delegate = ValueInput(_delegate.GetType(), "delegate");
			for (int num = 0; num < _delegate.parameters.Length; num++)
			{
				parameters.Add(ValueInput(_delegate.parameters[num].type, _delegate.parameters[num].name));
			}
		}
		if (!isPure)
		{
			Succession(enter, exit);
			if (@delegate != null)
			{
				Requirement(@delegate, enter);
			}
			for (int num2 = 0; num2 < parameters.Count; num2++)
			{
				Requirement(parameters[num2], enter);
			}
		}
	}

	protected abstract void Invoke(Flow flow, List<object> values);
}
