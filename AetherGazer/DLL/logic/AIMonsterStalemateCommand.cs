public class AIMonsterStalemateCommand : AICommand
{
	public int moveTimeInput;

	public int speedFactorInput;

	public int minWaitTimeInput;

	public int deltaProbabilityInput;

	public int startAngleInput;

	public int endAngleInput;

	public int intervalInput;

	private int probability;

	private int time;

	private AIProcessor.E_Direction direction;

	public override void OnEnter(SimContext simContext, SimEntity entity)
	{
		probability = 0;
		time = 0;
		direction = AIProcessor.E_Direction.Up;
	}

	public override void OnExit(SimContext simContext, SimEntity entity)
	{
	}

	public override AIProcessor.AICommandStatus Running(SimContext simContext, SimEntity entity)
	{
		int creationIndex = entity.creationIndex;
		if (!entity.hasEntityBlackboard)
		{
			return AIProcessor.AICommandStatus.Failed;
		}
		SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(entity.entityBlackboard.var.mAimTarget);
		if (simEntityByMultiColliders == null || !entity.entityBlackboard.var.mHasAimTarget)
		{
			return AIProcessor.AICommandStatus.Failed;
		}
		int num = intervalInput;
		if (num <= 0)
		{
			num = 1000;
		}
		entity.entityBlackboard.var.mIsLookatAimTarget = true;
		time += CommonProcessor.GetLogicConstTick();
		if (direction == AIProcessor.E_Direction.Left || direction == AIProcessor.E_Direction.Right)
		{
			if (time >= moveTimeInput)
			{
				time = 0;
				direction = AIProcessor.E_Direction.Up;
				AIProcessor.StopAIMovement(creationIndex);
				probability = 0;
			}
			else
			{
				Int3 targetPosition = ((direction != AIProcessor.E_Direction.Left) ? (IntMath.GetXZRight(entity.entityPositon.mForward) * 10 + entity.entityPositon.mPosition) : (IntMath.GetXZLeft(entity.entityPositon.mForward) * 10 + entity.entityPositon.mPosition));
				int num2 = speedFactorInput;
				if (entity.entityBlackboard.var.mUseRunMoveCurve)
				{
					num2 = 100;
				}
				AIProcessor.MoveAIDirection(creationIndex, targetPosition, new VFactor(num2, 100L));
			}
		}
		else
		{
			int num3 = (time - minWaitTimeInput) % num;
			if (num3 < CommonProcessor.GetLogicConstTick() && num3 >= 0)
			{
				if (DRandom.Random(100u) < probability)
				{
					StartMove(entity);
				}
				else
				{
					probability += deltaProbabilityInput;
				}
			}
			if (simEntityByMultiColliders != null && simEntityByMultiColliders.hasEntityPositon)
			{
				Int3 vector = simEntityByMultiColliders.entityPositon.mPosition - entity.entityPositon.mPosition;
				Int obj = IntMath.AngleOfVector(vector);
				Int obj2 = IntMath.AngleOfVector(entity.entityPositon.mForward);
				if (obj2 - obj > 180000)
				{
					obj += (Int)360000;
				}
				else if (obj2 - obj < -180000)
				{
					obj2 += (Int)360000;
				}
				bool flag = false;
				if (obj <= obj2 - startAngleInput && obj >= obj2 - endAngleInput)
				{
					flag = true;
				}
				if (!flag)
				{
					StartMove(entity);
				}
			}
		}
		return mStatus;
	}

	public void StartMove(SimEntity entity)
	{
		direction = AIProcessor.ChooseMoveDirection(entity);
		time = 0;
		probability = 0;
	}
}
