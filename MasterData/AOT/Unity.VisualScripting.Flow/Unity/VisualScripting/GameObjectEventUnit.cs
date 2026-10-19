using System;
using UnityEngine;

namespace Unity.VisualScripting;

public abstract class GameObjectEventUnit<TArgs> : EventUnit<TArgs>, IGameObjectEventUnit, IEventUnit, IUnit, IGraphElementWithDebugData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable, IGraphEventListener
{
	public new class Data : EventUnit<TArgs>.Data
	{
		public GameObject target;
	}

	protected sealed override bool register => true;

	public abstract Type MessageListenerType { get; }

	[DoNotSerialize]
	[PortLabelHidden]
	[PortLabel("Target")]
	[NullMeansSelf]
	public ValueInput target { get; private set; }

	protected virtual string hookName
	{
		get
		{
			throw new InvalidImplementationException($"Missing event hook for '{this}'.");
		}
	}

	public override IGraphElementData CreateData()
	{
		return new Data();
	}

	protected override void Definition()
	{
		base.Definition();
		target = ValueInput<GameObject>("target", null).NullMeansSelf();
	}

	public override EventHook GetHook(GraphReference reference)
	{
		if (!reference.hasData)
		{
			return hookName;
		}
		Data elementData = reference.GetElementData<Data>(this);
		return new EventHook(hookName, elementData.target);
	}

	private void UpdateTarget(GraphStack stack)
	{
		Data elementData = stack.GetElementData<Data>(this);
		bool isListening = elementData.isListening;
		GameObject gameObject = Flow.FetchValue<GameObject>(target, stack.ToReference());
		if (gameObject != elementData.target)
		{
			if (isListening)
			{
				StopListening(stack);
			}
			elementData.target = gameObject;
			if (isListening)
			{
				StartListening(stack, updateTarget: false);
			}
		}
	}

	protected void StartListening(GraphStack stack, bool updateTarget)
	{
		if (updateTarget)
		{
			UpdateTarget(stack);
		}
		Data elementData = stack.GetElementData<Data>(this);
		if (!(elementData.target == null))
		{
			if (UnityThread.allowsAPI && MessageListenerType != null)
			{
				MessageListener.AddTo(MessageListenerType, elementData.target);
			}
			base.StartListening(stack);
		}
	}

	public override void StartListening(GraphStack stack)
	{
		StartListening(stack, updateTarget: true);
	}

	FlowGraph IUnit.get_graph()
	{
		return graph;
	}
}
