public class AIMonsterCommonApproachCommand : AICommand
{
	public int originInput;

	public int delayIncrementTimeInput;

	public int incrementInput;

	public int incrementIntervalInput;

	public int resetTimeInput;

	private int flag;

	private int _resetTime;

	private int _incrementRate;

	private int _delayIncrementTime;

	private int _incrementIntervalTime;

	private bool _delayComplete;

	private bool _isTrue;

	public override void OnEnter(SimContext simContext, SimEntity entity)
	{
		flag = 0;
		_resetTime = 0;
		_incrementRate = 0;
		_delayIncrementTime = 0;
		_incrementIntervalTime = 0;
		_delayComplete = false;
		_isTrue = false;
	}

	public override void OnExit(SimContext simContext, SimEntity entity)
	{
	}

	public override AIProcessor.AICommandStatus Running(SimContext simContext, SimEntity entity)
	{
		if (entity == null || !entity.hasEntityBlackboard)
		{
			return AIProcessor.AICommandStatus.Failed;
		}
		int creationIndex = entity.creationIndex;
		AttributeProcessor.GetAttributeWithIntName(entity.entityBlackboard.var.mAttributeID, 2201, out var baseValue, out var _, out var _);
		if (flag == 0)
		{
			if (AIProcessor.IsTargetInRange(entity, (int)baseValue))
			{
				Invoke(entity, continueInput: true);
				AIProcessor.StopAIMovement(creationIndex);
				mStatus = AIProcessor.AICommandStatus.Success;
			}
			else
			{
				flag = 1;
			}
		}
		else if (AIProcessor.IsTargetInRange(entity, (int)baseValue))
		{
			Invoke(entity, continueInput: false);
			flag = 0;
			AIProcessor.StopAIMovement(creationIndex);
			mStatus = AIProcessor.AICommandStatus.Success;
		}
		else if (Invoke(resetTimeInput, delayIncrementTimeInput, incrementInput, incrementIntervalInput, originInput))
		{
			AIProcessor.StopAIMovement(creationIndex);
		}
		else
		{
			entity.entityBlackboard.var.mIsLookatAimTarget = true;
			Int3 targetPosition = AIProcessor.GetTargetPosition(entity);
			AIProcessor.MoveAIDirection(creationIndex, targetPosition, VFactor.one);
		}
		return mStatus;
	}

	public static void Invoke(SimEntity entity, bool continueInput)
	{
		AttributeProcessor.SetAttributeWithIntName(entity.entityBlackboard.var.mAttributeID, 2209, 1L, 0L, 0L);
	}

	public bool Invoke(int resetTimeInput, int delayIncrementTimeInput, int incrementInput, int incrementIntervalInput, int originInput)
	{
		int logicConstTick = CommonProcessor.GetLogicConstTick();
		if (_isTrue)
		{
			_resetTime += logicConstTick;
			if (_resetTime >= resetTimeInput)
			{
				_resetTime = 0;
				_incrementRate = 0;
				_delayIncrementTime = 0;
				_incrementIntervalTime = 0;
				_delayComplete = false;
				_isTrue = false;
			}
			return true;
		}
		if (!_delayComplete)
		{
			_delayIncrementTime += logicConstTick;
			if (_delayIncrementTime >= delayIncrementTimeInput)
			{
				_incrementRate += incrementInput;
				_delayIncrementTime = delayIncrementTimeInput;
				_delayComplete = true;
			}
		}
		else
		{
			_incrementIntervalTime += logicConstTick;
			if (_incrementIntervalTime >= incrementIntervalInput)
			{
				_incrementRate += incrementInput;
				_incrementIntervalTime = 0;
				int num = (int)DRandom.Random(100u);
				int num2 = IntMath.Clamp(originInput + _incrementRate, 0, 100);
				_isTrue = num <= num2;
			}
		}
		return _isTrue;
	}
}
