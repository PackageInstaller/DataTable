using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("启用碰撞（ID）(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("关闭碰撞")]
public class DisableCollisionByID : CallableActionNode<int, bool>
{
	public override void Invoke(int simEntityID, bool isEnable)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(simEntityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityShape)
		{
			entityWithEntityID.entityBlackboard.var.mHide = !isEnable;
			Invoke(base.parentNode.mSimContext, entityWithEntityID);
		}
	}

	public static void Invoke(SimContext pSimContext, SimEntity pSimEntity)
	{
		if (pSimEntity.hasEntityActionAbility)
		{
			int mLogicTime = pSimEntity.entityActionAbility.mLogicTime;
			Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(pSimEntity.entityActionAbility.mAbilityID);
			for (int i = 0; i < config.ShapeInfoList.Count; i++)
			{
				ShapeInfo shapeInfo = config.ShapeInfoList.get_Item(i);
				if (mLogicTime >= shapeInfo.Start && mLogicTime < shapeInfo.Start + shapeInfo.Duration)
				{
					SimShapeProcessor.UpdateShapeWorldPositionByConfig(pSimContext, pSimEntity, shapeInfo);
				}
			}
		}
		else if (pSimEntity.hasEntityHitRecover)
		{
			int mHitRecoverTime = pSimEntity.entityHitRecover.mHitRecoverTime;
			Timeline config2 = ConfigHelper.GetInstance().GetConfig<Timeline>(pSimEntity.entityHitRecover.mHitRecoverActionID);
			for (int j = 0; j < config2.ShapeInfoList.Count; j++)
			{
				ShapeInfo shapeInfo2 = config2.ShapeInfoList.get_Item(j);
				int start = shapeInfo2.Start;
				int num = start + shapeInfo2.Duration;
				if (mHitRecoverTime >= start && mHitRecoverTime <= num)
				{
					SimShapeProcessor.UpdateShapeWorldPositionByConfig(pSimContext, pSimEntity, shapeInfo2);
					break;
				}
			}
		}
		else if (pSimEntity.hasEntityActionMoveDirection && pSimEntity.entityActionMoveDirection.mMoveID != 0)
		{
			int mLogicTime2 = pSimEntity.entityActionMoveDirection.mLogicTime;
			Timeline config3 = ConfigHelper.GetInstance().GetConfig<Timeline>(pSimEntity.entityActionMoveDirection.mMoveID);
			for (int k = 0; k < config3.ShapeInfoList.Count; k++)
			{
				ShapeInfo shapeInfo3 = config3.ShapeInfoList.get_Item(k);
				int start2 = shapeInfo3.Start;
				int num2 = start2 + shapeInfo3.Duration;
				if (mLogicTime2 >= start2 && mLogicTime2 <= num2)
				{
					SimShapeProcessor.UpdateShapeWorldPositionByConfig(pSimContext, pSimEntity, shapeInfo3);
					break;
				}
			}
		}
		else
		{
			Timeline config4 = ConfigHelper.GetInstance().GetConfig<Timeline>((pSimEntity.entityConfig.mConfig as RoleConfig).Idle);
			for (int l = 0; l < config4.ShapeInfoList.Count; l++)
			{
				SimShapeProcessor.UpdateShapeWorldPositionByConfig(pSimContext, pSimEntity, config4.ShapeInfoList.get_Item(l));
			}
		}
	}
}
