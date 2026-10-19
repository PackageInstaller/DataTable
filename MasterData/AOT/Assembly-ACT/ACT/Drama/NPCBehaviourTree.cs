using System;
using ACT.Drama.NPC;
using UnityEngine;
using XNode;

namespace ACT.Drama;

[Serializable]
[CreateAssetMenu(fileName = "New Conversion Graph", menuName = "xNode Examples/NPC Behaviour Tree")]
public class NPCBehaviourTree : NodeGraph
{
	[NonSerialized]
	[HideInInspector]
	public NPCBehaviour behaviour;

	[HideInInspector]
	public BaseNode baseNode;
}
