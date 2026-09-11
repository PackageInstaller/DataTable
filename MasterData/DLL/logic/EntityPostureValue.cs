using Entitas;

[IgnoreClone]
[Sim]
public class EntityPostureValue : IComponent
{
	public int deltaValue;

	public int value;

	public int maxValue;

	public BreakState state;

	public int curTime;

	public int breakCDTime;

	public int breakMaxTime;

	public int delayTime;

	public int intervalTime;

	public uint cantBreakFlag;

	public int damageType;

	private void exampleHit(int hit)
	{
		if (hit > 0 && state != BreakState.breakCDState && state != BreakState.breakState)
		{
			curTime = delayTime;
			state = BreakState.delay;
			if (cantBreakFlag == 0)
			{
				value -= hit;
			}
		}
	}

	private void exampleTick(int deltaTime, bool isPause)
	{
		if (isPause)
		{
			return;
		}
		curTime -= deltaTime;
		if (value <= 0)
		{
			value = 0;
			state = BreakState.breakState;
			curTime = breakMaxTime;
		}
		if (curTime > 0)
		{
			return;
		}
		switch (state)
		{
		case BreakState.breakState:
			state = BreakState.breakCDState;
			curTime = breakCDTime;
			value = maxValue;
			break;
		case BreakState.breakCDState:
			state = BreakState.delay;
			curTime = delayTime;
			break;
		case BreakState.tick:
		case BreakState.delay:
			state = BreakState.tick;
			curTime += intervalTime;
			value += deltaValue;
			if (value > maxValue)
			{
				value = maxValue;
			}
			break;
		}
	}
}
