using System;
using GameFramework;

namespace Ase.ECS;

public class WarningIndicatorEntity : BaseEntity
{
	private WarningIndicatorData _data;

	public WarningIndicatorStageSwitcher Switcher;

	public WarningIndicatorData Data => _data;

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		_data = userData as WarningIndicatorData;
		Switcher = ReferencePool.Acquire<WarningIndicatorStageSwitcher>();
		Switcher.Init(_data, this);
	}

	public override void OnFixedUpdate(WorldUpdateType type, float deltaTime)
	{
		base.OnFixedUpdate(type, deltaTime);
		Switcher?.Update(deltaTime);
	}

	public void OnEntityOver()
	{
		_data.commonData.Creator.GetComponent<EntityWarningComponent>()?.RemoveWarnIndicator(this);
		DoEntityDead();
	}

	public void Stop(bool isForce)
	{
		if (_data.commonData.SkillStop | isForce)
		{
			Switcher.ChangeStage<DieStage>(0.4f);
		}
	}

	protected override Type[] GetEntityComps()
	{
		return new Type[1] { typeof(WarningEntityViewComponent) };
	}

	public override Type GetEntityView()
	{
		return typeof(WarningIndicatorView);
	}

	public override void OnDispose()
	{
		ReferencePool.Release(Data);
		ReferencePool.Release(Switcher);
	}
}
