using System;
using GameFramework;

namespace Ase.ECS;

public class WarningIndicatorStageSwitcher : IReference
{
	private BaseStage _stage;

	public WarningIndicatorEntity entity;

	private WarningIndicatorData _warnData;

	public BaseStage Stage => _stage;

	public void Init(WarningIndicatorData warnData, WarningIndicatorEntity entity)
	{
		this.entity = entity;
		_warnData = warnData;
		_stage = ReferencePool.Acquire<FillStage>();
		_stage.InitStage(this, warnData);
		_stage.SetStageTimer(warnData.timeData.fillTimer);
	}

	public void Update(float dateTime)
	{
		_stage.Update(dateTime);
	}

	public void ChangeStage<T>(float stageTimer) where T : BaseStage
	{
		Type typeFromHandle = typeof(T);
		if (!(_stage.GetType() == typeFromHandle))
		{
			ReferencePool.Release(_stage);
			IReference reference = ReferencePool.Acquire(typeFromHandle);
			_stage = reference as BaseStage;
			_stage.InitStage(this, _warnData);
			_stage.SetStageTimer(stageTimer);
		}
	}

	public void Clear()
	{
	}
}
