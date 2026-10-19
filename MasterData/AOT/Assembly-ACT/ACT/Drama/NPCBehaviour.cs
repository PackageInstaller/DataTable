using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.Drama;

public class NPCBehaviour : MonoBehaviour
{
	public NPCBehaviourTree behaviourTree;

	[NonSerialized]
	[HideInInspector]
	public int contentId;

	[NonSerialized]
	[HideInInspector]
	public bool hideButton;

	[NonSerialized]
	[HideInInspector]
	public List<InteractEvent> interactEvents;

	[NonSerialized]
	[HideInInspector]
	private int normalEventProtity;

	[NonSerialized]
	[HideInInspector]
	public InteractEvent normalEvent;

	[NonSerialized]
	[HideInInspector]
	private int triggerEventProtity;

	[NonSerialized]
	[HideInInspector]
	public InteractEvent triggerEvent;

	[NonSerialized]
	[HideInInspector]
	private int autoEventProtity;

	[NonSerialized]
	[HideInInspector]
	public InteractEvent autoEvent;

	[NonSerialized]
	[HideInInspector]
	public int animatorState;

	[NonSerialized]
	[HideInInspector]
	public int headContentId;

	[NonSerialized]
	[HideInInspector]
	public float showTime;

	[NonSerialized]
	[HideInInspector]
	private int m_swid;

	public void Init(int swid)
	{
		interactEvents = new List<InteractEvent>();
		if (behaviourTree.behaviour != null && m_swid == swid)
		{
			_ = LuminApplication.LogEnabled;
		}
		m_swid = swid;
		behaviourTree.behaviour = this;
	}

	public void Refresh()
	{
		normalEventProtity = int.MaxValue;
		normalEvent = null;
		triggerEventProtity = int.MaxValue;
		triggerEvent = null;
		autoEventProtity = int.MaxValue;
		autoEvent = null;
		interactEvents.Clear();
		hideButton = false;
		headContentId = 0;
		showTime = 0f;
		if (behaviourTree != null && behaviourTree.baseNode != null)
		{
			behaviourTree.baseNode.EnterNode();
		}
	}

	public void AddInteractEvent(InteractEvent interactEvent)
	{
		interactEvents.Add(interactEvent);
		if (interactEvent.interactType == XNodeInteractType.TriggerEnter && interactEvent.priority < triggerEventProtity)
		{
			triggerEventProtity = interactEvent.priority;
			triggerEvent = interactEvent;
		}
		else if (interactEvent.interactType == XNodeInteractType.AutoEnter && interactEvent.priority < autoEventProtity)
		{
			autoEventProtity = interactEvent.priority;
			autoEvent = interactEvent;
		}
		if (interactEvent.priority < normalEventProtity)
		{
			normalEventProtity = interactEvent.priority;
			normalEvent = interactEvent;
		}
		interactEvents.Sort((InteractEvent x, InteractEvent y) => x.priority - y.priority);
	}

	public void Release()
	{
		if (behaviourTree != null)
		{
			UnityEngine.Object.Destroy(behaviourTree);
			behaviourTree = null;
		}
	}
}
