using System.Collections.Generic;
using NodeCanvas.Framework;
using UnityEngine;

namespace NodeCanvas.BehaviourTrees;

internal class PrioritySelector_0 : BTComposite
{
	[SerializeField]
	public List<BBParameter<float>> priorities;
}
