using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("范围内是否有指定标签实体", 0)]
[Category("Logic/PosAndRot")]
[Description("对指定范围进行检查,标签为【BOSS】【精英】【小怪】【其他】,如果有设定范围的敌人,则走【存在】分支,否则走【不存在】")]
public class HasEnemyTypeInRange : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput hadOutput = AddFlowOutput("存在", "hadOutput");
		FlowOutput nonOutput = AddFlowOutput("不存在", "nonOutput");
		ValueInput<List<EnemyType>> checkEnemyTypeListVar = AddValueInput<List<EnemyType>>("敌人类型", "checkEnemyTypeListVar");
		ValueInput<RoleType> targetRoleTypeInput = AddValueInput<RoleType>("目标类型", "targetRoleTypeInput");
		ValueInput<Int3> originCenterPosVar = AddValueInput<Int3>("起始判定中心", "originCenterPosVar");
		ValueInput<Int3> centerPosOffsetVar = AddValueInput<Int3>("判定中心偏移量", "centerPosOffsetVar");
		ValueInput<Int3> forwardVar = AddValueInput<Int3>("朝向", "forwardVar");
		ValueInput<RangeType> rangeTypeVar = AddValueInput<RangeType>("范围类型", "rangeTypeVar");
		ValueInput<int> radiusVar = AddValueInput<int>("半径(毫米)", "radiusVar");
		ValueInput<int> angleVar = AddValueInput<int>("角度", "angleVar");
		ValueInput<int> lengthVar = AddValueInput<int>("长(毫米)", "lengthVar");
		ValueInput<int> widthVar = AddValueInput<int>("宽(毫米)", "widthVar");
		ValueInput<int> heightVar = AddValueInput<int>("高(毫米)", "heightVar");
		ValueInput<HitHeight> heightInput = AddValueInput<HitHeight>("覆盖的高度标签").SetDefaultAndSerializedValue((HitHeight)(-1));
		AddFlowInput("In", delegate(Flow f)
		{
			bool flag = false;
			List<int> list = FrameListPool<int>.Claim();
			if (CommonProcessor.TryGetCollisions(base.mSimContext, rangeTypeVar.GetValue(), originCenterPosVar.GetValue(), forwardVar.GetValue(), centerPosOffsetVar.GetValue(), radiusVar.GetValue(), angleVar.GetValue(), new Int3(widthVar.GetValue(), heightVar.GetValue(), lengthVar.GetValue()), list, (uint)targetRoleTypeInput.value))
			{
				for (int i = 0; i < list.Count; i++)
				{
					SimEntity simEntity = CommonProcessor.GetSimEntityByMultiColliders(list[i]);
					if (CommonProcessor.TryGetAliveRole(base.mSimContext, simEntity.creationIndex, out simEntity))
					{
						HitHeight curHitHeight = ConfigProcessor.GetCurHitHeight(simEntity);
						if ((curHitHeight == HitHeight.None || heightInput.value.HasFlag(curHitHeight)) && simEntity != null && simEntity.hasEntityBlackboard && checkEnemyTypeListVar.value != null && checkEnemyTypeListVar.value.Contains(simEntity.entityBlackboard.var.enemyType))
						{
							flag = true;
							break;
						}
					}
				}
			}
			FrameListPool<int>.Release(list);
			if (flag)
			{
				hadOutput.Call(f);
			}
			else
			{
				nonOutput.Call(f);
			}
		});
	}
}
