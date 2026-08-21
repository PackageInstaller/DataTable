using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("实例化资源WithoutCache", 0)]
[Category("Render/Asset")]
[Description("实例化资源")]
[ExposeAsDefinition]
public class InstantiateAssetWithoutCache : CallableFunctionNode<GameObject, string, Int3, Int3, Int3>
{
	public override GameObject Invoke(string path, Int3 position, Int3 forward, Int3 size)
	{
		GameObject gameObject = Asset.InstantiateWithoutCache(path);
		if (gameObject == null)
		{
			return null;
		}
		gameObject.transform.position = (Vector3)position;
		gameObject.transform.forward = (Vector3)forward;
		gameObject.transform.localScale = (Vector3)size;
		return gameObject;
	}
}
