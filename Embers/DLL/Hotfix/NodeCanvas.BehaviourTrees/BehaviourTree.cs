using System;
using NodeCanvas.Framework;
using UnityEngine;

namespace NodeCanvas.BehaviourTrees;

[GraphInfo(packageName = "NodeCanvas", docsURL = "https://nodecanvas.paradoxnotion.com/documentation/", resourcesURL = "https://nodecanvas.paradoxnotion.com/downloads/", forumsURL = "https://nodecanvas.paradoxnotion.com/forums-page/")]
[CreateAssetMenu(menuName = "ParadoxNotion/NodeCanvas/Behaviour Tree Asset")]
public class BehaviourTree : Graph
{
	[Serializable]
	private class DerivedSerializationData
	{
		public bool repeat;

		public float updateInterval;
	}

	[NonSerialized]
	public bool repeat;

	[NonSerialized]
	public float updateInterval;

	private float intervalCounter;

	private Status _rootStatus = Status.Resting;

	public Status rootStatus
	{
		get
		{
			return _rootStatus;
		}
		private set
		{
			if (_rootStatus != value)
			{
				_rootStatus = value;
				if (onRootStatusChanged != null)
				{
					onRootStatusChanged(this, value);
				}
			}
		}
	}

	public override Type baseNodeType => typeof(BTNode);

	public override bool requiresAgent => true;

	public override bool requiresPrimeNode => true;

	public override bool isTree => true;

	public override bool allowBlackboardOverrides => true;

	public sealed override bool canAcceptVariableDrops => false;

	public static event Action<BehaviourTree, Status> onRootStatusChanged;

	public override object OnDerivedDataSerialization()
	{
		return new DerivedSerializationData
		{
			repeat = repeat,
			updateInterval = updateInterval
		};
	}

	public override void OnDerivedDataDeserialization(object data)
	{
		if (data is DerivedSerializationData)
		{
			repeat = ((DerivedSerializationData)data).repeat;
			updateInterval = ((DerivedSerializationData)data).updateInterval;
		}
	}

	protected override void OnGraphStarted()
	{
		base.OnGraphStarted();
		intervalCounter = updateInterval;
		rootStatus = base.primeNode.status;
	}

	protected override void OnGraphUpdate()
	{
		if (intervalCounter >= updateInterval)
		{
			intervalCounter = 0f;
			if (Tick(base.agent, base.blackboard) != Status.Running && !repeat)
			{
				Stop(rootStatus == Status.Success);
			}
		}
		if (updateInterval > 0f)
		{
			intervalCounter += base.deltaTime;
		}
	}

	private Status Tick(Component agent, IBlackboard blackboard)
	{
		if (rootStatus != Status.Running)
		{
			base.primeNode.Reset();
		}
		return rootStatus = base.primeNode.Execute(agent, blackboard);
	}

	protected override void OnGraphStopped(bool isExecuteStopLogic)
	{
		DoSometingForAllConnectNode(delegate(Node node)
		{
			if (node is ActionNode actionNode)
			{
				actionNode.action?.OnGraphStopLogic(isExecuteStopLogic);
			}
		});
		base.OnGraphStopped(isExecuteStopLogic);
	}

	protected void DoSometingForAllConnectNode(Action<Node> nodeAction)
	{
		nodeAction(base.primeNode);
		ForeachAllLinkConnection(base.primeNode, nodeAction);
	}

	private void ForeachAllLinkConnection(Node root, Action<Node> nodeAction)
	{
		foreach (Connection outConnection in root.outConnections)
		{
			nodeAction(outConnection.targetNode);
			ForeachAllLinkConnection(outConnection.targetNode, nodeAction);
		}
	}
}
