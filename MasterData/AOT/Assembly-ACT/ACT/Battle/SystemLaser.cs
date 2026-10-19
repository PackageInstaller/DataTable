using Bamboo.ECS;

namespace ACT.Battle;

public class SystemLaser : EntitySystem
{
	private Filter _filter;

	private EntityAction<CompLaser> _fixedUpdateLaserAction;

	private EntityAction<CompLaser> _updateLaserAction;

	public override Filter MajorFilter => _filter;

	protected override void OnCreate()
	{
		_filter = World.NewFilter().All<CompLaser>().Build();
		_fixedUpdateLaserAction = FixedUpdateLaser;
		_updateLaserAction = UpdateLaser;
	}

	public override void FixedUpdate()
	{
		_filter.ForEach(_fixedUpdateLaserAction);
	}

	private void FixedUpdateLaser(Entity entity, CompLaser compLaser)
	{
		foreach (RuntimeLaser laser in compLaser.Lasers)
		{
			laser.FixedUpdate();
		}
	}

	public override void Update()
	{
		_filter.ForEachStable(_updateLaserAction);
	}

	private void UpdateLaser(Entity entity, CompLaser compLaser)
	{
		foreach (RuntimeLaser laser in compLaser.Lasers)
		{
			laser.Update();
		}
	}
}
