using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Unity")]
[Description("Get a component attached on an object")]
public class GetComponent<T> : PureFunctionNode<T, GameObject> where T : Component
{
	private T _component;

	public override T Invoke(GameObject gameObject)
	{
		if (gameObject == null)
		{
			return null;
		}
		if (_component == null || _component.gameObject != gameObject)
		{
			_component = gameObject.GetComponent<T>();
		}
		return _component;
	}
}
