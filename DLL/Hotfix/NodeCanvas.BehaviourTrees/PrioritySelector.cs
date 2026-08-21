using System;
using System.Collections.Generic;
using System.Linq;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization.FullSerializer;
using UnityEngine;

namespace NodeCanvas.BehaviourTrees;

[Category("Composites")]
[Description("Used for Utility AI, the Priority Selector executes the child with the highest utility weight. If it fails, the Priority Selector will continue with the next highest utility weight child until one Succeeds, or until all Fail (similar to how a normal Selector does).\n\nEach child branch represents a desire, where each desire has one or more consideration which are all averaged.\nConsiderations are a pair of input value and curve, which together produce the consideration utility weight.")]
[Icon("Priority", false, "")]
[Color("b3ff7f")]
[fsMigrateVersions(new Type[] { typeof(PrioritySelector_0) })]
public class PrioritySelector : BTComposite, IMigratable<PrioritySelector_0>, IMigratable
{
	[Serializable]
	public class Desire
	{
		[fsIgnoreInBuild]
		public string name;

		[fsIgnoreInBuild]
		public bool foldout;

		public List<Consideration> considerations = new List<Consideration>();

		public Consideration AddConsideration(IBlackboard bb)
		{
			Consideration consideration = new Consideration(bb);
			considerations.Add(consideration);
			return consideration;
		}

		public void RemoveConsideration(Consideration consideration)
		{
			considerations.Remove(consideration);
		}

		public float GetCompoundUtility()
		{
			float num = 0f;
			for (int i = 0; i < considerations.Count; i++)
			{
				num += considerations[i].utility;
			}
			return num / (float)considerations.Count;
		}
	}

	[Serializable]
	public class Consideration
	{
		public BBParameter<float> input;

		public BBParameter<AnimationCurve> function;

		public float utility
		{
			get
			{
				if (function.value == null)
				{
					return input.value;
				}
				return function.value.Evaluate(input.value);
			}
		}

		public Consideration(IBlackboard blackboard)
		{
			input = new BBParameter<float>
			{
				value = 1f,
				bb = blackboard
			};
			function = new BBParameter<AnimationCurve>
			{
				bb = blackboard
			};
		}
	}

	[AutoSortWithChildrenConnections]
	public List<Desire> desires;

	private Connection[] orderedConnections;

	private int current;

	void IMigratable<PrioritySelector_0>.Migrate(PrioritySelector_0 model)
	{
		desires = new List<Desire>();
		foreach (BBParameter<float> priority in model.priorities)
		{
			Desire desire = new Desire();
			desires.Add(desire);
			desire.AddConsideration(base.graphBlackboard).input = priority;
		}
	}

	public override void OnChildConnected(int index)
	{
		if (desires == null)
		{
			desires = new List<Desire>();
		}
		if (desires.Count < base.outConnections.Count)
		{
			desires.Insert(index, new Desire());
		}
	}

	public override void OnChildDisconnected(int index)
	{
		desires.RemoveAt(index);
	}

	protected override Status OnExecute(Component agent, IBlackboard blackboard)
	{
		if (base.status == Status.Resting)
		{
			orderedConnections = base.outConnections.OrderBy((Connection c) => desires[base.outConnections.IndexOf(c)].GetCompoundUtility()).ToArray();
		}
		int num = orderedConnections.Length;
		while (num-- > 0)
		{
			base.status = orderedConnections[num].Execute(agent, blackboard);
			if (base.status == Status.Success)
			{
				return Status.Success;
			}
			if (base.status == Status.Running)
			{
				current = num;
				return Status.Running;
			}
		}
		return Status.Failure;
	}

	protected override void OnReset()
	{
		current = 0;
	}
}
