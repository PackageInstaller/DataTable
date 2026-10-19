using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT;

public class SharedConditional : ScriptableObject
{
	[SerializeReference]
	public Conditional condition;
}
