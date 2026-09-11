using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("获取GameObject", 0)]
[Category("Render/UI")]
[Description("获取GameObject")]
public class GetGameObject : PureFunctionNode<GameObject, GameObject, string>
{
	public override GameObject Invoke(GameObject gameObject, string path)
	{
		return gameObject.transform.Find(path).gameObject;
	}
}
