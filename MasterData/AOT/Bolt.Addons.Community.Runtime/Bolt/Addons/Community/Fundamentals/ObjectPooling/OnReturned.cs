using Unity.VisualScripting;
using UnityEngine;

namespace Bolt.Addons.Community.Fundamentals.ObjectPooling;

[UnitCategory("Events/Community/ObjectPooling")]
[UnitTitle("OnReturned")]
public class OnReturned : EventUnit<PoolData>
{
	[PortLabelHidden]
	[DoNotSerialize]
	public ValueInput Pool;

	[DoNotSerialize]
	public ValueOutput Result;

	protected override bool register => true;

	public override EventHook GetHook(GraphReference reference)
	{
		return ObjectPoolEvents.OnReturned;
	}

	protected override void Definition()
	{
		base.Definition();
		Pool = ValueInput<CustomObjectPool>("Pool", null);
		Result = ValueOutput<GameObject>("Result");
	}

	protected override bool ShouldTrigger(Flow flow, PoolData args)
	{
		if (args.pool == flow.GetValue<CustomObjectPool>(Pool))
		{
			flow.SetValue(Result, args.arg);
			return true;
		}
		return false;
	}
}
