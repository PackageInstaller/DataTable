using System;
using UnityEngine;

namespace BehaviorDesigner.Runtime;

[Serializable]
public class NamedVariable : GenericVariable
{
	[SerializeField]
	public string name = "";
}
