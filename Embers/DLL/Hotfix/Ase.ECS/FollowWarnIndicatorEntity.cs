#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;

namespace Ase.ECS;

public class FollowWarnIndicatorEntity : WarningIndicatorEntity
{
	private FollowWarningIndicatorData _data;

	private BaseEntity _followEntity;

	public BaseEntity FollowEntity => _followEntity;

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		_data = userData as FollowWarningIndicatorData;
		if (_data != null)
		{
			_followEntity = world.GetSystem<EntitySystem>().GetEntity(_data.FollowEntityId);
		}
		else
		{
			Log.Error("追踪预警圈错误:数据为空!");
		}
	}

	public override void OnUpdate(float deltaTime)
	{
		base.OnUpdate(deltaTime);
		if (_followEntity == null || !_followEntity.IsSurvival)
		{
			Stop(isForce: true);
		}
	}

	public override void OnEntityRelease()
	{
		base.OnEntityRelease();
		_followEntity = null;
	}
}
