using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("随机激活触发器", 0)]
[Category("Logic/Trigger")]
[Description("激活触发器")]
public class RandomEnableTrigger : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> numberInput = AddValueInput<int>("每种数量");
		ValueInput<List<int>> list1Input = AddValueInput<List<int>>("列表1");
		ValueInput<List<int>> list2Input = AddValueInput<List<int>>("列表2");
		ValueInput<List<Int3>> positionsInput = AddValueInput<List<Int3>>("位置");
		ValueInput<List<Int3>> forwardsInput = AddValueInput<List<Int3>>("朝向");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			List<int> value = list1Input.value;
			List<int> value2 = list2Input.value;
			int value3 = numberInput.value;
			int index = (int)DRandom.Random((uint)value.Count);
			int num = value[index];
			int num2 = value2[index];
			List<Int3> value4 = positionsInput.value;
			List<Int3> value5 = forwardsInput.value;
			int num3 = value4.Count - 1;
			for (int i = 0; i < value3; i++)
			{
				SimEntity simEntityByTriggerID = CommonProcessor.GetSimEntityByTriggerID(num);
				if (simEntityByTriggerID != null)
				{
					Blackboard triggerBlackboards = (NScene.GetCurrentScene() as BattleScene).GetTriggerBlackboards(num);
					(triggerBlackboards.GetVariable("TRIGGER_POSITION") as Variable<Int3>).SetValue(value4[i]);
					(triggerBlackboards.GetVariable("TRIGGER_ROTATION") as Variable<Int3>).SetValue(value5[i]);
					if (simEntityByTriggerID.entityTrigger.mEnabled)
					{
						Debug.LogWarning(base.mSimContext.sEntityWorldState.status.mSceneMap.ID + " 激活了已经激活的触发器" + num);
						continue;
					}
					simEntityByTriggerID.entityTrigger.mEnabled = true;
				}
				base.mSimContext.PostEvent(TriggerEnableEvent.Claim(num, enable: true));
				simEntityByTriggerID = CommonProcessor.GetSimEntityByTriggerID(num2);
				if (simEntityByTriggerID != null)
				{
					Blackboard triggerBlackboards2 = (NScene.GetCurrentScene() as BattleScene).GetTriggerBlackboards(num2);
					(triggerBlackboards2.GetVariable("TRIGGER_POSITION") as Variable<Int3>).SetValue(value4[num3 - i]);
					(triggerBlackboards2.GetVariable("TRIGGER_ROTATION") as Variable<Int3>).SetValue(value5[num3 - i]);
					if (simEntityByTriggerID.entityTrigger.mEnabled)
					{
						Debug.LogWarning(base.mSimContext.sEntityWorldState.status.mSceneMap.ID + " 激活了已经激活的触发器" + num2);
						continue;
					}
					simEntityByTriggerID.entityTrigger.mEnabled = true;
				}
				base.mSimContext.PostEvent(TriggerEnableEvent.Claim(num2, enable: true));
			}
			f.Call(output);
		});
	}
}
