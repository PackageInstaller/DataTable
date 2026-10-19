using System;

namespace Unity.VisualScripting;

[UnitCategory("Control")]
[UnitOrder(17)]
[UnitFooterPorts(ControlOutputs = true)]
public sealed class TryCatch : Unit
{
	[PortLabelHidden]
	[DoNotSerialize]
	public ControlInput enter { get; private set; }

	[DoNotSerialize]
	public ControlOutput @try { get; private set; }

	[DoNotSerialize]
	public ControlOutput @catch { get; private set; }

	[DoNotSerialize]
	public ControlOutput @finally { get; private set; }

	[DoNotSerialize]
	public ValueOutput exception { get; private set; }

	[Serialize]
	[Inspectable]
	[UnitHeaderInspectable]
	[TypeFilter(new Type[] { typeof(Exception) }, Matching = TypesMatching.AssignableToAll)]
	[TypeSet(TypeSet.SettingsAssembliesTypes)]
	public Type exceptionType { get; set; } = typeof(Exception);

	public override bool canDefine
	{
		get
		{
			if (exceptionType != null)
			{
				return typeof(Exception).IsAssignableFrom(exceptionType);
			}
			return false;
		}
	}

	protected override void Definition()
	{
		enter = ControlInput("enter", Enter);
		@try = ControlOutput("try");
		@catch = ControlOutput("catch");
		@finally = ControlOutput("finally");
		exception = ValueOutput(exceptionType, "exception");
		Assignment(enter, exception);
		Succession(enter, @try);
		Succession(enter, @catch);
		Succession(enter, @finally);
	}

	public ControlOutput Enter(Flow flow)
	{
		if (flow.isCoroutine)
		{
			throw new NotSupportedException("Coroutines cannot catch exceptions.");
		}
		try
		{
			flow.Invoke(@try);
		}
		catch (Exception ex)
		{
			if (!exceptionType.IsInstanceOfType(ex))
			{
				throw;
			}
			flow.SetValue(exception, ex);
			flow.Invoke(@catch);
		}
		finally
		{
			flow.Invoke(@finally);
		}
		return null;
	}
}
