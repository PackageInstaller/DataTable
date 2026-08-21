using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Unity")]
[Description("If 'Try Get Existing' is true, then if there is an existing component of that type already attached to the gameobject, it will be returned instead of adding another instance.")]
public class AddComponent<T> : CallableFunctionNode<T, GameObject, bool> where T : Component
{
	public override T Invoke(GameObject gameObject, bool tryGetExisting)
	{
		T val = null;
		if (gameObject != null)
		{
			if (tryGetExisting)
			{
				val = gameObject.GetComponent<T>();
			}
			if (val == null)
			{
				val = gameObject.AddComponent<T>();
			}
		}
		return val;
	}
}
