using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("回收资源", 0)]
[Category("Render/Asset")]
[Description("回收资源")]
[ExposeAsDefinition]
public class DestroyAsset : CallableActionNode<GameObject, float>
{
	public override void Invoke(GameObject obj, float time)
	{
		if (!(obj == null))
		{
			if (obj.activeSelf)
			{
				PooledAsset.DestroyOrReturn(obj, time);
			}
			else
			{
				obj.GetComponent<PooledAsset>().Return();
			}
		}
	}
}
