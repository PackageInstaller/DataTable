using GameFramework;

namespace Ase.ECS;

public abstract class BaseStage : IReference
{
	protected WarningIndicatorStageSwitcher switcher;

	protected WarningIndicatorTimeData timerData;

	protected WarningIndicatorData warnData;

	protected float timer;

	private float _stageTimer;

	public float Timer => timer;

	public float StageTimer => _stageTimer;

	public virtual void InitStage(WarningIndicatorStageSwitcher switcher, WarningIndicatorData warnData)
	{
		this.switcher = switcher;
		timerData = warnData.timeData;
		this.warnData = warnData;
		timer = 0f;
	}

	public void SetStageTimer(float stageTimer)
	{
		_stageTimer = stageTimer;
	}

	public virtual void Update(float dateTime)
	{
		timer += dateTime;
		if (timer > _stageTimer)
		{
			ChangeStage(switcher);
		}
	}

	protected virtual void ChangeStage(WarningIndicatorStageSwitcher switcher)
	{
		StageOver();
	}

	protected abstract void StageOver();

	public virtual void Clear()
	{
	}
}
