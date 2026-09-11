using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("抛掷物通知将被命中的实体", 0)]
[Category("Logic/Abilities")]
[Description("抛掷物通知将被命中的实体")]
public class ThrownNotifyTargetWhoWillBeHit : FlowNode
{
	private List<int> collisions = new List<int>();

	protected override void RegisterPorts()
	{
		ValueInput<int> thrownIDVar = AddValueInput<int>("抛掷物ID");
		ValueInput<int> timelineIDVar = AddValueInput<int>("TimelineID");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			ThrownState thrownState = null;
			ThrownProcessor.TryGetThrown(base.mSimContext, thrownIDVar.GetValue(), out thrownState);
			Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(timelineIDVar.value);
			if (thrownState == null || thrownState.mCreationIndex == 0 || thrownState.mDontCollisionCheck || config == null || config.DangerRangeForAIInfoList == null)
			{
				output.Call(f);
			}
			else
			{
				int index = NotifyTargetWhoWillBeHit.GetIndex(thrownState.mLogicTime, config);
				uint targetLayerMask;
				if (index == -1)
				{
					output.Call(f);
				}
				else if (!CommonProcessor.TryGetTargetLayerMask(thrownState.mCamp, TargetCampType.Enemy, out targetLayerMask))
				{
					output.Call(f);
				}
				else
				{
					DangerRangeForAIInfo hitCheckInfo = config.DangerRangeForAIInfoList.get_Item(index);
					collisions.Clear();
					CommonProcessor.TryGetCollisions(thrownState.mPosition, thrownState.mForward, thrownState.mForward, hitCheckInfo, targetLayerMask, collisions);
					for (int i = 0; i < collisions.Count; i++)
					{
						SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(collisions[i]);
						if (simEntityByMultiColliders != null)
						{
							int attributeIDByEntityID = AttributeProcessor.GetAttributeIDByEntityID(simEntityByMultiColliders.creationIndex);
							AttributeProcessor.SetAttributeWithIntName(attributeIDByEntityID, 2206, thrownIDVar.value, 0L, 0L);
							AttributeProcessor.SetAttributeWithIntName(attributeIDByEntityID, 2205, timelineIDVar.value, 0L, 0L);
							base.mSimContext.GetSimInterface().mWillBeHitEvent?.Invoke(thrownIDVar.value, timelineIDVar.value, collisions[i]);
						}
					}
					output.Call(f);
				}
			}
		});
	}
}
