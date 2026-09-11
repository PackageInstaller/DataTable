using System;
using System.Collections.Generic;
using Config;
using MessagePack;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("能否被抓取(逻辑)", 0)]
[Category("Logic/Config")]
[Description("判断传入的实体是否能被抓取:\n1.RoleConfig表中配置能被抓取;\n2.指定buff不存在;\nwiki:https://wiki.in.ys4fun.com/pages/viewpage.action?pageId=88180982")]
public class CanBeGrabExcludeSpecifiedBuff : FlowControlNode
{
	public List<int> _blockBuffClassIDList = new List<int> { 101, 103, 104, 111, 112, 113 };

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		_blockBuffClassIDList = options.Resolver.GetFormatter<List<int>>().Deserialize(ref reader, options);
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		options.Resolver.GetFormatter<List<int>>().Serialize(ref writer, _blockBuffClassIDList, options);
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> beGrabEntityIDInput = AddValueInput<int>("被抓取实体ID", "beGrabEntityID");
		ValueInput<int> grabEntityIDInput = AddValueInput<int>("抓取实体ID", "grabEntityID");
		ValueInput<int> abilityIDInput = AddValueInput<int>("AbilityID", "abilityID");
		ValueInput<int> projectileIDInput = AddValueInput<int>("抛掷物ID", "projectileID");
		FlowOutput trueOut = AddFlowOutput("True", "true");
		FlowOutput falseOut = AddFlowOutput("False", "false");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(beGrabEntityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard || !entityWithEntityID.hasEntityConfig || !ConfigHelper.GetInstance().TryGetConfig<RoleConfig>(entityWithEntityID.ENTITY_CONFIG_ID, out var config))
			{
				errorOut.Call(f);
			}
			else
			{
				bool flag = config.CanBeGrab;
				if (!flag)
				{
					falseOut.Call(f);
				}
				else
				{
					if (_blockBuffClassIDList.Count > 0)
					{
						for (int i = 0; i < entityWithEntityID.entityBuff.mBuffClassIDArray.Count; i++)
						{
							int item = entityWithEntityID.entityBuff.mBuffClassIDArray[i];
							if (_blockBuffClassIDList.Contains(item) && !entityWithEntityID.entityBuff.IsInPendingRemoveArray(entityWithEntityID.entityBuff.mBuffID[i]))
							{
								flag = false;
								break;
							}
						}
					}
					ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
					if (simInterface != null && simInterface.mCanBeGrabExtensionEvent != null)
					{
						Action<DamageEventParam, int, bool> mCanBeGrabExtensionEvent = simInterface.mCanBeGrabExtensionEvent;
						entityWithEntityID.entityBlackboard.var.mTempCanBeGrab = flag;
						DamageEventParam arg = new DamageEventParam
						{
							casterID = grabEntityIDInput.value,
							abilityID = abilityIDInput.value,
							thrownID = projectileIDInput.value
						};
						mCanBeGrabExtensionEvent(arg, beGrabEntityIDInput.value, flag);
						flag = entityWithEntityID.entityBlackboard.var.mTempCanBeGrab;
						entityWithEntityID.entityBlackboard.var.mTempCanBeGrab = false;
					}
					if (flag)
					{
						trueOut.Call(f);
					}
					else
					{
						falseOut.Call(f);
					}
				}
			}
		});
	}
}
