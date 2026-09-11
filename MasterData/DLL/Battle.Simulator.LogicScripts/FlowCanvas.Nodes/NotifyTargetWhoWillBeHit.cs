using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("通知将被命中的实体", 0)]
[Category("Logic/Abilities")]
[Description("通知将被命中的实体")]
public class NotifyTargetWhoWillBeHit : FlowNode
{
	private List<int> collisions = new List<int>();

	public static int GetIndex(int logicTime, Timeline timelineConfig)
	{
		int result = -1;
		for (int i = 0; i < timelineConfig.DangerRangeForAIInfoList.Count; i++)
		{
			DangerRangeForAIInfo dangerRangeForAIInfo = timelineConfig.DangerRangeForAIInfoList.get_Item(i);
			if (dangerRangeForAIInfo.Start < logicTime && dangerRangeForAIInfo.Start + dangerRangeForAIInfo.Duration >= logicTime)
			{
				result = i;
				break;
			}
		}
		return result;
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueInput<int>("技能ID");
		FlowOutput output = AddFlowOutput("Out");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityActionAbility)
			{
				output.Call(f);
			}
			else
			{
				Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(entityWithEntityID.entityActionAbility.mAbilityID);
				if (config.DangerRangeForAIInfoList == null || config.DangerRangeForAIInfoList.Count == 0)
				{
					output.Call(f);
				}
				else
				{
					int index = GetIndex(entityWithEntityID.entityActionAbility.mLogicTime, config);
					if (index == -1)
					{
						output.Call(f);
					}
					else
					{
						DangerRangeForAIInfo hitCheckInfo = config.DangerRangeForAIInfoList.get_Item(index);
						collisions.Clear();
						CommonProcessor.TryGetCollisions(entityWithEntityID.entityPositon.mPosition, entityWithEntityID.entityPositon.mForward, entityWithEntityID.entityPositon.mForward, hitCheckInfo, RoleCampProcessor.GetInterestCamp(entityWithEntityID.entityCamp.mRoleTypeCamp), collisions);
						for (int i = 0; i < collisions.Count; i++)
						{
							SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(collisions[i]);
							if (simEntityByMultiColliders != null)
							{
								int attributeIDByEntityID = AttributeProcessor.GetAttributeIDByEntityID(simEntityByMultiColliders.creationIndex);
								AttributeProcessor.SetAttributeWithIntName(attributeIDByEntityID, 2206, entityWithEntityID.creationIndex, 0L, 0L);
								AttributeProcessor.SetAttributeWithIntName(attributeIDByEntityID, 2205, entityWithEntityID.entityActionAbility.mAbilityID, 0L, 0L);
								base.mSimContext.GetSimInterface().mWillBeHitEvent?.Invoke(entityWithEntityID.creationIndex, entityWithEntityID.entityActionAbility.mAbilityID, collisions[i]);
							}
						}
						output.Call(f);
					}
				}
			}
		});
	}
}
