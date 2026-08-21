using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("是否在零时空间中", 0)]
[Category("Logic/Attribute")]
[Description("判断当前是否在零时空间中，并输出一些对应的数据")]
public class IsInUltimateAvoidTime : FlowNode
{
	protected override void RegisterPorts()
	{
		int ultimateAvoidTimeClassID = 100030502;
		int sourceSpaceEntityID = 0;
		FlowOutput trueOutput = AddFlowOutput("true", "true");
		FlowOutput falseOutput = AddFlowOutput("false", "false");
		FlowOutput errorOutput = AddFlowOutput("error", "error");
		int avoidEntityID = 0;
		AddValueOutput("闪避者ID", "avoidEntityID", () => avoidEntityID);
		int attackEntityID = 0;
		AddValueOutput("攻击者ID", "attackEntityID", () => attackEntityID);
		int keepTime = 0;
		AddValueOutput("持续时间", "keepTime", () => keepTime);
		int during = 0;
		AddValueOutput("剩余时间", "during", () => during);
		AddFlowInput("In", "In", delegate(Flow f)
		{
			avoidEntityID = 0;
			attackEntityID = 0;
			keepTime = 0;
			during = 0;
			if (!base.mSimContext.hasEntitySourceSpace)
			{
				Debug.LogError("未进入间层");
				errorOutput.Call(f);
			}
			else
			{
				sourceSpaceEntityID = base.mSimContext.entitySourceSpaceEntity.creationIndex;
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(sourceSpaceEntityID);
				if (entityWithEntityID == null)
				{
					errorOutput.Call(f);
				}
				else if (!entityWithEntityID.hasEntityBuff)
				{
					falseOutput.Call(f);
				}
				else
				{
					for (int i = 0; i < entityWithEntityID.entityBuff.mBuffConfigID.Count; i++)
					{
						if (!entityWithEntityID.entityBuff.IsInPendingRemoveArray(entityWithEntityID.entityBuff.mBuffID[i]) && entityWithEntityID.entityBuff.mBuffClassIDArray[i] == ultimateAvoidTimeClassID)
						{
							avoidEntityID = entityWithEntityID.entityBuff.mBuffParamsArray[i].v1;
							attackEntityID = entityWithEntityID.entityBuff.mBuffParamsArray[i].v2;
							keepTime = entityWithEntityID.entityBuff.mBuffKeepTimeArray[i];
							during = entityWithEntityID.entityBuff.mDuringArray[i];
							trueOutput.Call(f);
							return;
						}
					}
					falseOutput.Call(f);
				}
			}
		});
	}
}
