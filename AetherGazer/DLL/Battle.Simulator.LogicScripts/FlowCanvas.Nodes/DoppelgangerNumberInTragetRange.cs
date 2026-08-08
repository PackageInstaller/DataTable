using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("分身数量(指定范围)", 0)]
[Category("Logic/Spawn")]
[Description("指定范围内的分身数量,怪物类型ID（填0时默认指定所有类型的分身），阵营（选none时默认为指定所有阵营），创建者ID（填0时默认为指定所有创建者）")]
public class DoppelgangerNumberInTragetRange : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<Int3> positionInput = AddValueInput<Int3>("位置");
		ValueInput<int> rangeInput = AddValueInput<int>("半径");
		ValueInput<int> roleIDInput = AddValueInput<int>("怪物类型ID");
		ValueInput<RoleType> campInput = AddValueInput<RoleType>("阵营");
		ValueInput<int> creatorIDInput = AddValueInput<int>("创建者实体ID");
		int num = 0;
		AddValueOutput("数量", () => num);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			List<int> list = FrameListPool<int>.Claim();
			SimPhysics.Overlap(positionInput.value, rangeInput.value, list, (uint)campInput.value);
			num = 0;
			for (int i = 0; i < list.Count; i++)
			{
				SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(list[i]);
				if (simEntityByMultiColliders != null && simEntityByMultiColliders.hasEntityConfig && simEntityByMultiColliders.hasEntityCamp && simEntityByMultiColliders.hasEntityBlackboard && simEntityByMultiColliders.entityBlackboard.var.mRobotType == RobotType.Doppelganger && (roleIDInput.value == 0 || !(simEntityByMultiColliders.ENTITY_CONFIG_ID != roleIDInput.value)) && (campInput.value == RoleType.None || campInput.value == (RoleType)simEntityByMultiColliders.entityCamp.mRoleTypeCamp) && (creatorIDInput.value == 0 || creatorIDInput.value == simEntityByMultiColliders.entityBlackboard.var.creator))
				{
					num++;
				}
			}
			FrameListPool<int>.Release(list);
			output.Call(f);
		});
	}
}
