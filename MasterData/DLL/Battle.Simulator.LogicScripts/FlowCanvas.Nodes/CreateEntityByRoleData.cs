using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("创建实体(已过时)", 0)]
[Category("Logic/Spawn")]
[Description("创建实体,通过实体参数设置")]
public class CreateEntityByRoleData : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<Int3> spawnPoint = AddValueInput<Int3>("位置");
		ValueInput<Int3> forward = AddValueInput<Int3>("朝向");
		ValueInput<RoleType> camp = AddValueInput<RoleType>("阵营");
		ValueInput<int> aiID = AddValueInput<int>("AI ID");
		ValueInput<int> roleID = AddValueInput<int>("roleID");
		ValueInput<int> hp = AddValueInput<int>("hp");
		ValueInput<int> speed = AddValueInput<int>("移动速度");
		AddValueInput<int>("暴击率");
		ValueInput<int> attack = AddValueInput<int>("攻击力");
		ValueInput<int> defend = AddValueInput<int>("防御力");
		int entityID = 0;
		AddValueOutput("entityID", () => entityID);
		FlowOutput output = AddFlowOutput("out");
		AddFlowInput("in", delegate(Flow f)
		{
			ConfigHelper.GetInstance().GetConfig<RoleConfig>(roleID.value);
			SimEntity simEntity = SpawnProcessor.SpawnUnit(0L, spawnPoint.value, forward.value, new Int3(0, 1, 0), camp.value, aiID.value, isLocalPlayer: false, roleID.value, 0, MemberPosition.None, hp.value, speed.value);
			simEntity.entityBlackboard.var.mMaxHP = hp.value;
			AttributeProcessor.SetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 1, attack.value, 0L, 0L);
			AttributeProcessor.SetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2, defend.value, 0L, 0L);
			entityID = simEntity.creationIndex;
			f.Call(output);
		});
	}
}
