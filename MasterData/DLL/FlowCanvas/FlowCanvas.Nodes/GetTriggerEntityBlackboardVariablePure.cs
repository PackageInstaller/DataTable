using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("获取触发器黑板变量(pure)", 0)]
[Category("Logic/Trigger")]
[Description("获取触发器实体的黑板变量")]
public class GetTriggerEntityBlackboardVariablePure<T> : PureFunctionNode<T, int, string>
{
	public override T Invoke(int triggerID, string variableName)
	{
		SimEntity simEntityByTriggerID = CommonProcessor.GetSimEntityByTriggerID(triggerID);
		if (simEntityByTriggerID == null)
		{
			Debug.Log("触发器实体为空,不应该为空的");
		}
		return CommonProcessor.GetTriggerEntityBlackboardVariable<T>(simEntityByTriggerID, variableName);
	}
}
