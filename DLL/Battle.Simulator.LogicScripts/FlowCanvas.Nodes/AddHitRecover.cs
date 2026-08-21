using Config;
using ParadoxNotion.Design;
using Pathfinding;

namespace FlowCanvas.Nodes;

[Name("添加受击状态", 0)]
[Category("Logic/Buff")]
[Description("添加指定受击状态    None = 0, FloatUp = 1,    FloatDown = 2,    HitAir = 4,    HitFloor = 8,    GetUp = 16,    HitReocver = 32")]
public class AddHitRecover : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("受击者");
		ValueInput<int> attackIDInput = AddValueInput<int>("攻击者");
		ValueInput<int> distanceInput = AddValueInput<int>("距离");
		ValueInput<int> hitStatusInput = AddValueInput<int>("状态值");
		ValueInput<bool> useHitInput = AddValueInput<bool>("使用hit击飞");
		ValueInput<int> abilityIDInput = AddValueInput<int>("攻击技能ID");
		ValueInput<int> hitIndexInput = AddValueInput<int>("hit下标");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput output = AddFlowOutput("Out");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(attackIDInput.value);
			E_HitRecoverStatus value = (E_HitRecoverStatus)hitStatusInput.value;
			_ = entityWithEntityID.entityConfig.mConfig;
			int hitRecoverActionID = AbilitiesProcessor.GetHitRecoverActionID(entityWithEntityID, value);
			AbilitiesProcessor.GetTimelineDuration(entityWithEntityID, hitRecoverActionID, value);
			Int3 mForward = entityWithEntityID2.entityPositon.mForward;
			entityWithEntityID.entityPositon.mForward = -mForward;
			if (entityWithEntityID2 != null)
			{
				int groundY = 0;
				entityWithEntityID.entityPositon.mPosition = entityWithEntityID2.entityPositon.mPosition;
				Int3 delta = PathUtilities.Move(entityWithEntityID2.entityPositon.mPosition, entityWithEntityID2.entityPositon.mForward * distanceInput.value, ref groundY);
				MovementProcessor.ModifyPosition(entityWithEntityID, delta);
			}
			entityWithEntityID.entityBlackboard.var.mHitRecoverIndex = 0;
			if (useHitInput.value)
			{
				int value2 = abilityIDInput.value;
				int value3 = hitIndexInput.value;
				HitCheckInfo hitCheckInfo = ConfigHelper.GetInstance().GetConfig<Timeline>(value2).HitTimeList.get_Item(value3);
				if (!entityWithEntityID.hasEntityHitRecover)
				{
					entityWithEntityID.AddEntityHitRecover(E_HitRecover.OnEnter, 0, hitRecoverActionID, -mForward, mForward, hitCheckInfo.HorizontalSpeed, hitCheckInfo.HorizontalAcceleratedASpeed, hitCheckInfo, 0, newMEnableMovement: true, 0, value, 0, value2, value3, hitCheckInfo.HorizontalSpeedOnFloat, 0, 100, 1, 0, entityWithEntityID2.creationIndex, Int3.zero);
				}
				else
				{
					entityWithEntityID.ReplaceEntityHitRecover(E_HitRecover.OnEnter, 0, hitRecoverActionID, -mForward, mForward, hitCheckInfo.HorizontalSpeed, hitCheckInfo.HorizontalAcceleratedASpeed, hitCheckInfo, 0, newMEnableMovement: true, 0, value, 0, value2, value3, hitCheckInfo.HorizontalSpeedOnFloat, 0, 100, 1, 0, entityWithEntityID2.creationIndex, Int3.zero);
				}
			}
			else if (!entityWithEntityID.hasEntityHitRecover)
			{
				entityWithEntityID.AddEntityHitRecover(E_HitRecover.OnEnter, 0, hitRecoverActionID, -mForward, mForward, 0, 0, null, 0, newMEnableMovement: true, 0, value, 0, hitRecoverActionID, 0, 0, 0, 100, 1, 0, entityWithEntityID2.creationIndex, Int3.zero);
			}
			else
			{
				entityWithEntityID.ReplaceEntityHitRecover(E_HitRecover.OnEnter, 0, hitRecoverActionID, -mForward, mForward, 0, 0, null, 0, newMEnableMovement: true, 0, value, 0, hitRecoverActionID, 0, 0, 0, 100, 1, 0, entityWithEntityID2.creationIndex, Int3.zero);
			}
			if (entityWithEntityID.hasEntityBlackboard)
			{
				entityWithEntityID.entityBlackboard.var.mBeHitAbilitiID = abilityIDInput.value;
				entityWithEntityID.entityBlackboard.var.mBeHitIndex = hitIndexInput.value;
			}
			BuffProcessor.RemoveInputMovementAndAbility(entityWithEntityID);
			output.Call(f);
		});
	}
}
