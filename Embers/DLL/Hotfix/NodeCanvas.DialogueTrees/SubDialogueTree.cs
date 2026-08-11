using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization.FullSerializer;
using UnityEngine;

namespace NodeCanvas.DialogueTrees;

[Name("Sub Dialogue Tree", 0)]
[Description("Execute a Sub Dialogue Tree. When that Dialogue Tree is finished, this node will continue either in Success or Failure if it has any connections. Useful for making reusable and self-contained Dialogue Trees.")]
[DropReferenceType(typeof(DialogueTree))]
[Icon("Dialogue", false, "")]
public class SubDialogueTree : DTNodeNested<DialogueTree>, IUpdatable, IGraphElement
{
	[SerializeField]
	[ExposeField]
	private BBParameter<DialogueTree> _subTree;

	[fsSerializeAs("actorParametersMap")]
	private Dictionary<string, string> _actorParametersMap;

	public override int maxOutConnections => 2;

	public override DialogueTree subGraph
	{
		get
		{
			return _subTree.value;
		}
		set
		{
			_subTree.value = value;
		}
	}

	public override BBParameter subGraphParameter => _subTree;

	protected override Status OnExecute(Component agent, IBlackboard bb)
	{
		if (subGraph == null)
		{
			return Error("No Sub Dialogue Tree assigned!");
		}
		base.currentInstance = (DialogueTree)this.CheckInstance();
		this.TryWriteAndBindMappedVariables();
		TryWriteMappedActorParameters();
		base.currentInstance.StartGraph((base.finalActor is Component) ? ((Component)base.finalActor) : base.finalActor.transform, bb.parent, base.FrozenFrameIsPauseTree, Graph.UpdateMode.Manual, OnSubDialogueFinish);
		return Status.Running;
	}

	private void OnSubDialogueFinish(bool success)
	{
		this.TryReadAndUnbindMappedVariables();
		base.status = (success ? Status.Success : Status.Failure);
		base.DLGTree.Continue((!success) ? 1 : 0);
	}

	void IUpdatable.Update()
	{
		if (base.currentInstance != null && base.status == Status.Running)
		{
			base.currentInstance.UpdateGraph();
		}
	}

	private void TryWriteMappedActorParameters()
	{
		if (_actorParametersMap == null)
		{
			return;
		}
		foreach (KeyValuePair<string, string> item in _actorParametersMap)
		{
			DialogueTree.ActorParameter parameterByID = base.currentInstance.GetParameterByID(item.Key);
			DialogueTree.ActorParameter parameterByID2 = base.DLGTree.GetParameterByID(item.Value);
			if (parameterByID != null && parameterByID2 != null)
			{
				base.currentInstance.SetActorReference(parameterByID.name, parameterByID2.actor);
			}
		}
	}
}
