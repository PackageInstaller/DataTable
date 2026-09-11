using System;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置触发器位置和朝向(过时)", 0)]
[Category("Logic/Trigger")]
[Description("设置指定ID触发器位置和朝向")]
public class SetTriggerPosAndRot : CallableActionNode<int, Int3, Int3>
{
	public override void Invoke(int triggerID, Int3 position, Int3 forward)
	{
		try
		{
			SimEntity simEntityByTriggerID = CommonProcessor.GetSimEntityByTriggerID(triggerID);
			CommonProcessor.SetTriggerEntityBlackboardVariable(simEntityByTriggerID, "TRIGGER_POSITION", position);
			CommonProcessor.SetTriggerEntityBlackboardVariable(simEntityByTriggerID, "TRIGGER_ROTATION", forward);
		}
		catch (Exception)
		{
			Debug.Log("设置失败, 设置触发器位置和朝向");
		}
	}
}
