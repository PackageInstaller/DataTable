using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("我要召唤兽(指定出场动作)", 0)]
[Category("Logic/Spawn")]
[Description("创建召唤兽，并指定其出场动作是什么")]
public class INeedSummonedUnitWithAppearAbility : FlowControlNode
{
	private int m_unitID;

	protected override void RegisterPorts()
	{
		ValueInput<int> casterEntityIDVar = AddValueInput<int>("召唤者实体ID", "casterEntityIDVar");
		ValueInput<Int3> spawnPointVar = AddValueInput<Int3>("位置", "spawnPointVar");
		ValueInput<Int3> forwardVar = AddValueInput<Int3>("朝向", "forwardVar").SetDefaultAndSerializedValue(Int3.forward);
		ValueInput<RoleType> campVar = AddValueInput<RoleType>("阵营", "campVar");
		ValueInput<int> roleIDVar = AddValueInput<int>("实体类型ID", "roleIDVar");
		ValueInput<int> appearAbilityIDVar = AddValueInput<int>("出场动作ID", "appearAbilityIDVar");
		ValueInput<int> skinIDInput = AddValueInput<int>("皮肤ID", "skinID");
		FlowOutput output = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			long num = 1L;
			int value = casterEntityIDVar.GetValue();
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
			{
				long mHP = entityWithEntityID.entityBlackboard.var.mHP;
				monster_standard config = ConfigHelper.GetInstance().GetConfig<monster_standard>(entityWithEntityID.entityBlackboard.var.mFightLevel);
				num = (mHP + config.HpRatio - 1) / config.HpRatio;
			}
			SimEntity simEntity = SummonedUnitHelper.CreateSummonedUnit(base.mSimContext, value, spawnPointVar.GetValue(), forwardVar.GetValue(), campVar.GetValue(), roleIDVar.GetValue(), (int)num, 0, skinIDInput.GetValue());
			m_unitID = simEntity.creationIndex;
			simEntity.AddEntityActionAbility(EntityActionStatus.E_ACTIVE, appearAbilityIDVar.value, 0, 0, simEntity.entityBlackboard.var.mAimTarget, 0, newMIsPressing: true, 0, simEntity.creationIndex, newMEnableAbilityMovement: true, 100, 0, 0, 0, newMInUltimateAvoidFrame: false, 0, newMCanBeParry: false, 0);
			output.Call(f);
		});
		AddValueOutput("召唤者实体ID", "EntityID", () => casterEntityIDVar.GetValue());
		AddValueOutput("召唤兽实体ID", "SummonedUnitEntityID", () => m_unitID);
	}
}
