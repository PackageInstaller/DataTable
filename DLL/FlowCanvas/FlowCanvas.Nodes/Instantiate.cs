using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Unity")]
[Description("Instantiate an object")]
[ExposeAsDefinition]
public class Instantiate<T> : CallableFunctionNode<T, T, Vector3, Quaternion, Transform> where T : Object
{
	public override T Invoke(T original, Vector3 position, Quaternion rotation, Transform parent)
	{
		if (original == null)
		{
			return null;
		}
		return Object.Instantiate(original, position, rotation, parent);
	}
}
