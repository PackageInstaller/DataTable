using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("我要召唤兽(倍率)", 0)]
[Category("Logic/Spawn")]
[Description("创建召唤兽,并将召唤者的属性拷贝给召唤兽")]
public class INeedSummonedUnit2 : FlowControlNode
{
	private int m_unitID;

	protected override void RegisterPorts()
	{
		ValueInput<int> casterEntityIDVar = AddValueInput<int>("召唤者实体ID", "casterEntityIDVar");
		ValueInput<Int3> spawnPointVar = AddValueInput<Int3>("位置", "spawnPointVar");
		ValueInput<Int3> forwardVar = AddValueInput<Int3>("朝向", "forwardVar").SetDefaultAndSerializedValue(Int3.forward);
		ValueInput<RoleType> campVar = AddValueInput<RoleType>("阵营", "campVar");
		ValueInput<int> roleIDVar = AddValueInput<int>("实体类型ID", "roleIDVar");
		ValueInput<Int> attackFactorInput = AddValueInput<Int>("攻击比例", "attackFactorInput").SetDefaultAndSerializedValue(1000);
		ValueInput<Int> defendFactorInput = AddValueInput<Int>("防御比例", "defendFactorInput").SetDefaultAndSerializedValue(1000);
		ValueInput<bool> useMaxHpInput = AddValueInput<bool>("使用最大血量", "useMaxHp").SetDefaultAndSerializedValue(v: true);
		ValueInput<long> hpfactorInput = AddValueInput<long>("血量比例", "hpfactorInput").SetDefaultAndSerializedValue(1000L);
		ValueInput<EnemyType> enemyTyepVar = AddValueInput<EnemyType>("怪物类型", "enemyTyepVar").SetDefaultAndSerializedValue(EnemyType.Other);
		ValueInput<int> skinIDInput = AddValueInput<int>("皮肤ID", "skinID");
		FlowOutput output = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			int value = casterEntityIDVar.GetValue();
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(value);
			long num = 1L;
			long num2 = 1L;
			long num3 = 1L;
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
			{
				num2 = entityWithEntityID.entityBlackboard.var.mMaxHP;
				num3 = (useMaxHpInput.GetValue() ? num2 : entityWithEntityID.entityBlackboard.var.mHP) * hpfactorInput.value / 1000;
				monster_standard config = ConfigHelper.GetInstance().GetConfig<monster_standard>(entityWithEntityID.entityBlackboard.var.mFightLevel);
				num = (num3 + config.HpRatio - 1) / config.HpRatio;
			}
			num3 = ((num3 < 1) ? 1 : num3);
			SimEntity simEntity = SummonedUnitHelper.CreateSummonedUnit(base.mSimContext, value, spawnPointVar.GetValue(), forwardVar.GetValue(), campVar.GetValue(), roleIDVar.GetValue(), (int)num, 0, skinIDInput.GetValue());
			simEntity.entityBlackboard.var.mMaxHP = num3;
			simEntity.entityBlackboard.var.mHP = num3;
			AttributeProcessor.GetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 1, out var baseValue, out var plusValue, out var tempPlusValue);
			AttributeProcessor.SetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 1, baseValue * attackFactorInput.value.i / 1000, plusValue, tempPlusValue);
			AttributeProcessor.GetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2, out baseValue, out plusValue, out tempPlusValue);
			AttributeProcessor.SetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2, baseValue * defendFactorInput.value.i / 1000, plusValue, tempPlusValue);
			simEntity.entityBlackboard.var.enemyType = enemyTyepVar.GetValue();
			m_unitID = simEntity.creationIndex;
			RoleConfig config2 = ConfigHelper.GetInstance().GetConfig<RoleConfig>(simEntity.ENTITY_CONFIG_ID);
			bool flag = ConfigHelper.GetInstance().TryGetConfig<AbilityConfig>(config2.Appear, out var config3);
			if (flag)
			{
				flag = config3.CanBeParry;
			}
			simEntity.AddEntityActionAbility(EntityActionStatus.E_ACTIVE, config2.Appear, 0, 0, simEntity.entityBlackboard.var.mAimTarget, 0, newMIsPressing: true, 0, simEntity.creationIndex, newMEnableAbilityMovement: true, 100, 0, 0, 0, newMInUltimateAvoidFrame: false, 0, flag, 0);
			output.Call(f);
		});
		AddValueOutput("召唤者实体ID", "EntityID", () => casterEntityIDVar.GetValue());
		AddValueOutput("召唤兽实体ID", "SummonedUnitEntityID", () => m_unitID);
	}
}
