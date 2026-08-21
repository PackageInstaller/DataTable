using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("根据与目标的距离创建抛掷物", 0)]
[Category("Logic/抛掷物/事件")]
[Description("根据是否有目标，目否是否在范围内来创建抛掷物\n无目标距离：特指无目标情况下，抛掷物会在输入实体正前方多远处直接生成\n有目标时，会根据技能定义的射程（配表）来判断是否在范围内\n- 若实体与目标最近碰撞盒的距离小于等于技能射程，将在目标root点生成抛掷物\n- 否则，将在实体正前方【技能射程】处直接生成抛掷物\n\nError：输入的技能Id在public_skill表中无定义、实体不存在、实体没有黑板时\nNoTarget：实体没有瞄准目标、实体瞄准的目标生命值小于等于0时\nOUT：正常输出")]
public class SpawnThrownWithTargetDistance : FlowNode
{
	private const int ERROR = 0;

	private const int NO_TARGET = 1;

	private const int OUT_OF_RANGE = 2;

	private const int IN_RANGE = 4;

	private static int _resultCode;

	private int _thrownID;

	private int _lockTargetID;

	private ThrownState _thrownState;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "Origin");
		ValueInput<int> abilityIDInput = AddValueInput<int>("技能ID", "abilityID");
		ValueInput<int> thrownTimelineIDInput = AddValueInput<int>("抛掷物TimelineID", "ThrownTimelineID");
		ValueInput<int> sourceThrownTimelineIDInput = AddValueInput<int>("根源TimelineID", "SourceThrownTimelineID");
		ValueInput<int> noTargetDistanceInput = AddValueInput<int>("无目标距离", "noTargetDistance");
		AddValueOutput("抛掷物ID", () => _thrownID);
		AddValueOutput("目标实体ID", () => _lockTargetID);
		FlowOutput successDistanceOutput = AddFlowOutput("OUT");
		FlowOutput failedDistanceOutput = AddFlowOutput("Error");
		FlowOutput noTargetOutput = AddFlowOutput("NoTarget");
		AddFlowInput("IN", delegate(Flow f)
		{
			_thrownID = CheckDistanceAndSpawnThrown(base.mSimContext, entityIDInput.value, abilityIDInput.value, thrownTimelineIDInput.value, sourceThrownTimelineIDInput.value, noTargetDistanceInput.value, out _lockTargetID, out _thrownState);
			if (_resultCode == 1)
			{
				noTargetOutput.Call(f);
			}
			else if (_thrownID == 0)
			{
				failedDistanceOutput.Call(f);
			}
			else
			{
				successDistanceOutput.Call(f);
			}
		});
	}

	private static int CheckDistanceAndSpawnThrown(SimContext simContext, int entityID, int abilityID, int thrownTimelineID, int sourceTimelineTimelineID, int noTargetDistance, out int targetID, out ThrownState thrownState)
	{
		targetID = 0;
		thrownState = null;
		public_skill config = ConfigHelper.GetInstance().GetConfig<public_skill>(abilityID);
		if (config == null)
		{
			_resultCode = 0;
			return 0;
		}
		SimEntity entityWithEntityID = simContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null)
		{
			_resultCode = 0;
			return 0;
		}
		SimEntity simEntity = null;
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
		{
			simEntity = CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID.entityBlackboard.var.mAimTarget);
			if (simEntity == null || !simEntity.hasEntityBlackboard || simEntity.entityBlackboard.var.mHP <= 0)
			{
				simEntity = null;
			}
		}
		if (!INeedSpawnThrown.TryGetAttributeID(simContext, 0, entityID, out var attributeID))
		{
			_resultCode = 0;
			return 0;
		}
		if (simEntity == null)
		{
			_resultCode = 1;
			Int3 positionInGraphWithoutTangentMove = CommonProcessor.GetPositionInGraphWithoutTangentMove(entityWithEntityID.entityPositon.mPosition, entityWithEntityID.entityPositon.mPosition + entityWithEntityID.entityPositon.mForward * noTargetDistance / 1000f);
			return ThrownProcessor.SpawnThrown(simContext, entityID, 0, 0, positionInGraphWithoutTangentMove, entityWithEntityID.entityPositon.mForward, thrownTimelineID, useCommon: true, entityID, sourceTimelineTimelineID, attributeID, out thrownState);
		}
		targetID = simEntity.creationIndex;
		AIProcessor.GetNearestCollisionData(entityWithEntityID, simEntity, RoleCampProcessor.GetInterestCamp(entityWithEntityID.entityCamp.mRoleTypeCamp), out var minDistance);
		if (minDistance <= config.Range)
		{
			_resultCode = 2;
			return ThrownProcessor.SpawnThrown(simContext, entityID, 0, 0, simEntity.entityPositon.mPosition, entityWithEntityID.entityPositon.mForward, thrownTimelineID, useCommon: true, entityID, sourceTimelineTimelineID, attributeID, out thrownState);
		}
		_resultCode = 4;
		Int3 positionInGraphWithoutTangentMove2 = CommonProcessor.GetPositionInGraphWithoutTangentMove(entityWithEntityID.entityPositon.mPosition, entityWithEntityID.entityPositon.mPosition + entityWithEntityID.entityPositon.mForward * config.Range / 1000f);
		return ThrownProcessor.SpawnThrown(simContext, entityID, 0, 0, positionInGraphWithoutTangentMove2, entityWithEntityID.entityPositon.mForward, thrownTimelineID, useCommon: true, entityID, sourceTimelineTimelineID, attributeID, out thrownState);
	}
}
