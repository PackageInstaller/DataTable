using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("更新锁定目标位置(渲染)", 0)]
[Category("Render/PosAndRot")]
[Description("得到实体位置和朝向")]
public class UpdateLockPosition : CallableActionNode<GameObject, Vector3>
{
	public override void Invoke(GameObject go, Vector3 position)
	{
		if (go != null)
		{
			FaceToTarget component = go.transform.GetComponent<FaceToTarget>();
			if (component != null)
			{
				component.UpdateTargetPosition(position);
			}
		}
	}
}
