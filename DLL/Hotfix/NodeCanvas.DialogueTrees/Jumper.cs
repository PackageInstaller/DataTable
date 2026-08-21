using NodeCanvas.Framework;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization.FullSerializer;
using UnityEngine;

namespace NodeCanvas.DialogueTrees;

[Name("JUMP", 0)]
[Description("Select a target node to jump to.\nFor your convenience in identifying nodes in the dropdown, please give a Tag name to the nodes you want to use in this way.")]
[Category("Control")]
[Icon("Set", false, "")]
[Color("6ebbff")]
public class Jumper : DTNode, IHaveNodeReference, IGraphElement
{
	[fsSerializeAs("_sourceNodeUID")]
	public NodeReference<DTNode> _targetNode;

	INodeReference IHaveNodeReference.targetReference => _targetNode;

	private DTNode target => _targetNode?.Get(base.graph);

	public override int maxOutConnections => 0;

	public override bool requireActorSelection => false;

	protected override Status OnExecute(Component agent, IBlackboard bb)
	{
		if (target == null)
		{
			return Error("Target Node of Jumper node is null");
		}
		base.DLGTree.EnterNode(target);
		return Status.Success;
	}
}
