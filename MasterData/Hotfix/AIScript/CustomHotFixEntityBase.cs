#define LOG_ERROR
namespace AIScript;

public class CustomHotFixEntityBase : AIBase
{
	protected CustomHotFixEntity _entity;

	public void OnEnable()
	{
		if (_owner.TryGetComponent<CustomHotFixEntity>(out _entity))
		{
			_actor = _entity.Owner;
		}
		else
		{
			NovaLogger.Error("未找到自定义热更实体组件");
		}
		_entity?.EnableLogicUpdate();
		OnEntityEnable();
	}

	public void OnDisable()
	{
		OnEntityDisable();
	}

	protected virtual void OnEntityEnable()
	{
	}

	protected void Finish()
	{
		_entity?.Finish();
	}

	protected virtual void OnEntityDisable()
	{
	}
}
