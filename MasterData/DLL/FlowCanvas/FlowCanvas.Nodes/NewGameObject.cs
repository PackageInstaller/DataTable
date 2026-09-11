using System;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Utilities/Constructors")]
[Obsolete]
public class NewGameObject : CallableFunctionNode<GameObject, string, Vector3, Quaternion>
{
	public override GameObject Invoke(string name, Vector3 position, Quaternion rotation)
	{
		GameObject gameObject = new GameObject(name);
		gameObject.transform.position = position;
		gameObject.transform.rotation = rotation;
		return gameObject;
	}
}
