using System;
using GameFramework.Runtime.Proxy;
using UnityEngine;

namespace GameFramework.Runtime;

public class InteractionTargetProxy : TargetProxyBase, IObtainable
{
	protected readonly EventHandler<InteractionEventArgs> handler;

	public override Type Type => typeof(EventHandler<InteractionEventArgs>);

	public override BindingMode DefaultMode => BindingMode.OneWayToSource;

	public InteractionTargetProxy(object target, IInteractionAction interactionAction)
		: base(target)
	{
		handler = delegate(object sender, InteractionEventArgs args)
		{
			if (!(target is Behaviour { isActiveAndEnabled: false }))
			{
				interactionAction.OnRequest(sender, args);
			}
		};
	}

	public object GetValue()
	{
		return handler;
	}

	public TValue GetValue<TValue>()
	{
		return (TValue)GetValue();
	}
}
