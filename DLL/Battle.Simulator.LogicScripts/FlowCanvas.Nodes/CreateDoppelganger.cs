using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("创建分身", 0)]
[Category("Logic/Spawn")]
[Description("创建分身,攻防血填的是倍率")]
public class CreateDoppelganger : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		int resID = 0;
		AddValueOutput("被创建的实体ID", () => resID);
		ValueInput<Int3> positionInput = AddValueInput<Int3>("位置");
		ValueInput<Int3> forwardInput = AddValueInput<Int3>("朝向");
		ValueInput<EnemyType> typeInput = AddValueInput<EnemyType>("类型");
		ValueInput<Int> attackFactorInput = AddValueInput<Int>("攻击比例");
		ValueInput<Int> defendFactorInput = AddValueInput<Int>("防御比例");
		ValueInput<Int> hpfactorInput = AddValueInput<Int>("血量比例");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			int mAIID = entityWithEntityID.entityBlackboard.var.mAIID;
			RoleConfig config = ConfigHelper.GetInstance().GetConfig<RoleConfig>(entityWithEntityID.ENTITY_CONFIG_ID);
			SimEntity simEntity = SpawnProcessor.SpawnUnit(0L, positionInput.value, forwardInput.value, new Int3(0, 1, 0), (RoleType)entityWithEntityID.entityCamp.mRoleTypeCamp, mAIID, isLocalPlayer: false, entityWithEntityID.ENTITY_CONFIG_ID, 0, MemberPosition.None, 1, config.Speed, entityWithEntityID.entityBlackboard.var.mHpStripCount);
			long mMaxHP = entityWithEntityID.entityBlackboard.var.mMaxHP;
			simEntity.entityBlackboard.var.mMaxHP = ((mMaxHP < 1) ? 1 : mMaxHP);
			long num = entityWithEntityID.entityBlackboard.var.mHP * hpfactorInput.value.i / 1000;
			simEntity.entityBlackboard.var.mHP = ((num < 1) ? 1 : num);
			AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 1, out var baseValue, out var plusValue, out var tempPlusValue);
			AttributeProcessor.SetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 1, baseValue * attackFactorInput.value.i / 1000, plusValue, tempPlusValue);
			AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2, out baseValue, out plusValue, out tempPlusValue);
			AttributeProcessor.SetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2, baseValue * defendFactorInput.value.i / 1000, plusValue, tempPlusValue);
			simEntity.entityBlackboard.var.mTriggerTarget = entityWithEntityID.entityBlackboard.var.mTriggerTarget;
			simEntity.entityBlackboard.var.mAIID = entityWithEntityID.entityBlackboard.var.mAIID;
			simEntity.entityBlackboard.var.enemyType = ((typeInput.value == EnemyType.Other) ? entityWithEntityID.entityBlackboard.var.enemyType : typeInput.value);
			charactor_param config2 = ConfigHelper.GetInstance().GetConfig<charactor_param>(entityWithEntityID.ENTITY_CONFIG_ID);
			AttributeProcessor.SetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2201, config2.BestDistance, 0L, 0L);
			AttributeProcessor.SetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2202, config2.ApproachDistance, 0L, 0L);
			AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2013, out var baseValue2, out var _, out var _);
			AttributeProcessor.SetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2013, baseValue2, 0L, 0L);
			resID = simEntity.creationIndex;
			simEntity.entityBlackboard.var.creator = entityWithEntityID.creationIndex;
			simEntity.entityBlackboard.var.mRobotType = RobotType.Doppelganger;
			output.Call(f);
		});
	}
}
