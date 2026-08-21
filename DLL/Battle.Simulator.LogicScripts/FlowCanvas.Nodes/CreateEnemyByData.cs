using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("按黑板创建怪物", 0)]
[Category("Logic/Spawn")]
[Description("按黑板创建怪物,视野范围为0表示无限")]
public class CreateEnemyByData : FlowNode
{
	private static void SetBaseAttri(SimEntity entity, int level, int attack, int defend, int hp)
	{
		entity.entityBlackboard.var.mFightLevel = level;
		entity.entityBlackboard.var.mMaxHP = hp;
		entity.entityBlackboard.var.mHP = entity.entityBlackboard.var.mMaxHP;
		AttributeProcessor.SetAttributeWithIntName(entity.entityBlackboard.var.mAttributeID, 3, hp, 0L, 0L);
		AttributeProcessor.SetAttributeWithIntName(entity.entityBlackboard.var.mAttributeID, 1, attack, 0L, 0L);
		AttributeProcessor.SetAttributeWithIntName(entity.entityBlackboard.var.mAttributeID, 2, defend, 0L, 0L);
	}

	public static SimEntity CreateEntity(SimContext mSimContext, int hpInput, int attackInput, int defendInput, int levelInput, int enemyTypeInput, Int3 positionInput, Int3 forwardInput, RoleType campInput, int AIIDInput, int roleIDInput, int viewRangeInput, int sourceSpacePercentInput, List<int> attrIDInput, List<int> attrValueInput, int initIDInput, int skinID, out int entityID)
	{
		RoleConfig config = ConfigHelper.GetInstance().GetConfig<RoleConfig>(roleIDInput);
		Int obj = CommonProcessor.GetWorldState().currentEnemyHPAttributeFactor.i * hpInput / 1000;
		Int obj2 = CommonProcessor.GetWorldState().currentEnemyATKAttributeFactor.i * attackInput / 1000;
		Int obj3 = CommonProcessor.GetWorldState().currentEnemyDEFAttributeFactor.i * defendInput / 1000;
		int num = levelInput;
		_ = CommonProcessor.GetWorldState().mSceneMap;
		int adaptiveEnemyLevel = CommonProcessor.GetWorldState().adaptiveEnemyLevel;
		if (adaptiveEnemyLevel > 0)
		{
			num = adaptiveEnemyLevel;
		}
		monster_standard config2 = ConfigHelper.GetInstance().GetConfig<monster_standard>(num);
		int num2 = 1;
		int attack = 1;
		int defend = 1;
		switch (enemyTypeInput)
		{
		case 0:
			num2 = (config2.Hp1 * new VFactor(obj.i, 1000L)).floorInt;
			attack = (config2.Attack1 * new VFactor(obj2.i, 1000L)).floorInt;
			defend = (config2.Defense1 * new VFactor(obj3.i, 1000L)).floorInt;
			break;
		case 1:
			num2 = (config2.Hp2 * new VFactor(obj.i, 1000L)).floorInt;
			attack = (config2.Attack2 * new VFactor(obj2.i, 1000L)).floorInt;
			defend = (config2.Defense2 * new VFactor(obj3.i, 1000L)).floorInt;
			break;
		case 2:
			num2 = (config2.Hp3 * new VFactor(obj.i, 1000L)).floorInt;
			attack = (config2.Attack3 * new VFactor(obj2.i, 1000L)).floorInt;
			defend = (config2.Defense3 * new VFactor(obj3.i, 1000L)).floorInt;
			break;
		}
		int hpStripCount = (num2 + config2.HpRatio - 1) / config2.HpRatio;
		SimEntity simEntity = SpawnProcessor.SpawnUnit(0L, positionInput, forwardInput, new Int3(0, 1, 0), campInput, AIIDInput, isLocalPlayer: false, roleIDInput, 0, MemberPosition.None, num2, config.Speed, hpStripCount, null, null, skinID);
		simEntity.entityBlackboard.var.mTriggerTarget = AIIDInput;
		simEntity.entityBlackboard.var.mAIID = AIIDInput;
		simEntity.entityBlackboard.var.enemyType = (EnemyType)enemyTypeInput;
		charactor_param config3 = ConfigHelper.GetInstance().GetConfig<charactor_param>(roleIDInput);
		AttributeProcessor.SetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2201, config3.BestDistance, 0L, 0L);
		AttributeProcessor.SetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2202, config3.ApproachDistance, 0L, 0L);
		AttributeProcessor.SetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2013, viewRangeInput, 0L, 0L);
		AttributeProcessor.SetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2170, sourceSpacePercentInput, 0L, 0L);
		for (int i = 0; i < attrIDInput.Count; i++)
		{
			AttributeProcessor.GetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, attrIDInput[i], out var baseValue, out var _, out var tempPlusValue);
			AttributeProcessor.SetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, attrIDInput[i], baseValue, attrValueInput[i], tempPlusValue);
		}
		SetBaseAttri(simEntity, num, attack, defend, num2);
		entityID = simEntity.creationIndex;
		if (mSimContext.GetSimInterface().mInitEnemyEvent != null)
		{
			mSimContext.GetSimInterface().mInitEnemyEvent(entityID, initIDInput);
		}
		if (RoleCampProcessor.IsEnemy((uint)campInput))
		{
			List<GlobalAffix> mGlobalAffixes = CommonProcessor.GetWorldState().mGlobalAffixes;
			for (int j = 0; j < mGlobalAffixes.Count; j++)
			{
				if (simEntity.entityBlackboard.var.enemyType >= mGlobalAffixes[j].targetLevel && mSimContext.GetSimInterface().mAddAffixEvent != null)
				{
					mSimContext.GetSimInterface().mAddAffixEvent(entityID, mGlobalAffixes[j].affixTypeID, mGlobalAffixes[j].affixLevel);
				}
			}
		}
		return simEntity;
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> AIIDInput = AddValueInput<int>("触发器ID");
		ValueInput<Int3> positionInput = AddValueInput<Int3>("位置");
		ValueInput<Int3> forwardInput = AddValueInput<Int3>("朝向");
		ValueInput<RoleType> campInput = AddValueInput<RoleType>("阵营");
		ValueInput<int> roleIDInput = AddValueInput<int>("实体类型ID", "角色ID");
		ValueInput<int> viewRangeInput = AddValueInput<int>("视野范围");
		ValueInput<int> enemyTypeInput = AddValueInput<int>("怪物类型(精英还是boss)");
		ValueInput<int> levelInput = AddValueInput<int>("怪物等级");
		ValueInput<int> attackInput = AddValueInput<int>("攻击");
		ValueInput<int> defendInput = AddValueInput<int>("防御");
		ValueInput<int> hpInput = AddValueInput<int>("生命");
		AddValueInput<int>("血条数").SetDefaultAndSerializedValue(1);
		ValueInput<int> sourceSpacePercentInput = AddValueInput<int>("间层值占血量百分比").SetDefaultAndSerializedValue(60);
		ValueInput<int> initIDInput = AddValueInput<int>("初始化ID");
		ValueInput<List<int>> attrIDInput = AddValueInput<List<int>>("属性ID");
		ValueInput<List<int>> attrValueInput = AddValueInput<List<int>>("属性值");
		ValueInput<int> skinIDInput = AddValueInput<int>("皮肤ID", "skinID");
		int entityID = 0;
		AddValueOutput("实体ID", () => entityID);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			RoleType roleType = campInput.value;
			if (roleType == RoleType.None)
			{
				roleType = RoleType.Enemy;
			}
			CreateEntity(base.mSimContext, hpInput.value, attackInput.value, defendInput.value, levelInput.value, enemyTypeInput.value, positionInput.value, forwardInput.value, roleType, AIIDInput.value, roleIDInput.value, viewRangeInput.value, sourceSpacePercentInput.value, attrIDInput.value, attrValueInput.value, initIDInput.value, skinIDInput.value, out entityID);
			output.Call(f);
		});
	}
}
