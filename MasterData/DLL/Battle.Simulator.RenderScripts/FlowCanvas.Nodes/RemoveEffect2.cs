using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("移除特效(单个)", 0)]
[Category("Render/函数")]
[Description("移除特效")]
public class RemoveEffect2 : CallableActionNode<GameObject>
{
	public override void Invoke(GameObject effect)
	{
		PooledAsset.DestroyOrReturn(effect);
	}
}
