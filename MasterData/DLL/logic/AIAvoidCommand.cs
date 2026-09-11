using Config;

public class AIAvoidCommand : AICommand
{
	public bool mIsSingleClick = true;

	public int mAvoidBackProbability;

	private Int3 avoidDir;

	internal override void Reset()
	{
		base.Reset();
		avoidDir = Int3.zero;
	}

	protected override void OnTimeout()
	{
		base.OnTimeout();
		mStatus = AIProcessor.AICommandStatus.Success;
	}

	public static int GetIndex(int logicTime, Timeline timelineConfig)
	{
		int result = -1;
		for (int num = timelineConfig.DangerRangeForAIInfoList.Count - 1; num >= 0; num--)
		{
			DangerRangeForAIInfo dangerRangeForAIInfo = timelineConfig.DangerRangeForAIInfoList.get_Item(num);
			if (dangerRangeForAIInfo.Start < logicTime)
			{
				result = num;
				break;
			}
		}
		return result;
	}

	public override void OnEnter(SimContext simContext, SimEntity entity)
	{
		AttributeProcessor.GetAttributeWithIntName(entity.entityBlackboard.var.mAttributeID, 2206, out var baseValue, out var plusValue, out var tempPlusValue);
		AttributeProcessor.GetAttributeWithIntName(entity.entityBlackboard.var.mAttributeID, 2205, out var baseValue2, out plusValue, out tempPlusValue);
		if (baseValue2 == 0L || baseValue == 0L)
		{
			return;
		}
		Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>((int)baseValue2);
		avoidDir = Int3.zero;
		RangeType rangeType = RangeType.None;
		int num = 0;
		int num2 = 0;
		Int3 @int = Int3.zero;
		int num3 = 0;
		if (baseValue > 0)
		{
			SimEntity entityWithEntityID = simContext.GetEntityWithEntityID((int)baseValue);
			if (entityWithEntityID != null && config != null && entityWithEntityID.hasEntityActionAbility)
			{
				@int = entityWithEntityID.entityPositon.mPosition;
				num3 = GetIndex(entityWithEntityID.entityActionAbility.mLogicTime, config);
			}
		}
		else if (baseValue < 0)
		{
			ThrownState thrownState = null;
			ThrownProcessor.TryGetThrown(simContext, (int)baseValue, out thrownState);
			if (thrownState != null && thrownState.mCreationIndex != 0 && !thrownState.mDontCollisionCheck)
			{
				@int = thrownState.mPosition;
				num3 = GetIndex(thrownState.mLogicTime, config);
			}
		}
		if (num3 != -1)
		{
			DangerRangeForAIInfo dangerRangeForAIInfo = config.DangerRangeForAIInfoList.get_Item(num3);
			rangeType = dangerRangeForAIInfo.RangeType;
			num = dangerRangeForAIInfo.Width;
			num2 = dangerRangeForAIInfo.Length;
		}
		uint num4 = DRandom.Random(100u);
		if (num4 <= mAvoidBackProbability && mAvoidBackProbability != 0)
		{
			avoidDir = Int3.zero;
		}
		else if (rangeType != RangeType.None)
		{
			avoidDir = entity.entityPositon.mPosition - @int;
			if (RangeType.Sector == rangeType)
			{
				uint num5 = DRandom.Random(10u);
				if (num5 >= 7)
				{
					avoidDir = IntMath.GetXZLeft(avoidDir);
				}
				if (num5 < 3)
				{
					avoidDir = IntMath.GetXZRight(avoidDir);
				}
			}
			else if (RangeType.Rectangle == rangeType && num < num2)
			{
				if (DRandom.Random(10u) > 5)
				{
					avoidDir = IntMath.GetXZLeft(avoidDir);
				}
				else
				{
					avoidDir = IntMath.GetXZRight(avoidDir);
				}
			}
		}
		if (mIsSingleClick)
		{
			if (entity.hasEntityActionManualInput)
			{
				entity.ReplaceEntityActionManualInput(EntityActionStatus.E_ACTIVE, 6, TimeHelper.Now(), newMCanDestroy: true, newMIsPressing: false);
			}
			else
			{
				entity.AddEntityActionManualInput(EntityActionStatus.E_ACTIVE, 6, TimeHelper.Now(), newMCanDestroy: true, newMIsPressing: false);
			}
		}
	}

	public override void OnExit(SimContext simContext, SimEntity entity)
	{
		AttributeProcessor.SetAttributeWithIntName(entity.entityBlackboard.var.mAttributeID, 2206, 0L, 0L, 0L);
		AttributeProcessor.SetAttributeWithIntName(entity.entityBlackboard.var.mAttributeID, 2205, 0L, 0L, 0L);
	}

	public override AIProcessor.AICommandStatus Running(SimContext simContext, SimEntity entity)
	{
		RoleConfig config = ConfigHelper.GetInstance().GetConfig<RoleConfig>(entity.ENTITY_CONFIG_ID);
		bool flag = entity.hasEntityActionAbility && config.AvoidAbility.Contains(entity.entityActionAbility.mAbilityID);
		if (!flag && avoidDir != Int3.zero && IntMath.Abs(IntMath.AngleOfVector(avoidDir) - IntMath.AngleOfVector(-entity.entityPositon.mForward)) > 20000)
		{
			AIProcessor.MoveAIDirection(entity.creationIndex, entity.entityPositon.mPosition + avoidDir, VFactor.one);
		}
		else if (entity.hasEntityActionMoveDirection)
		{
			AIProcessor.StopAIMovement(entity.creationIndex);
		}
		if (flag)
		{
			if (!mIsSingleClick)
			{
				if (entity.hasEntityActionManualInput)
				{
					entity.ReplaceEntityActionManualInput(EntityActionStatus.E_ACTIVE, 6, TimeHelper.Now(), newMCanDestroy: true, newMIsPressing: false);
				}
				else
				{
					entity.AddEntityActionManualInput(EntityActionStatus.E_ACTIVE, 6, TimeHelper.Now(), newMCanDestroy: true, newMIsPressing: false);
				}
			}
			Timeline config2 = ConfigHelper.GetInstance().GetConfig<Timeline>(entity.entityActionAbility.mAbilityID);
			if (entity.entityActionAbility.mLogicTime >= config2.Duration - CommonProcessor.GetConfigInterval())
			{
				mStatus = AIProcessor.AICommandStatus.Success;
			}
		}
		else if (entity.hasEntityActionManualInput)
		{
			entity.ReplaceEntityActionManualInput(EntityActionStatus.E_ACTIVE, 6, TimeHelper.Now(), newMCanDestroy: true, newMIsPressing: false);
		}
		else
		{
			entity.AddEntityActionManualInput(EntityActionStatus.E_ACTIVE, 6, TimeHelper.Now(), newMCanDestroy: true, newMIsPressing: false);
		}
		return mStatus;
	}
}
