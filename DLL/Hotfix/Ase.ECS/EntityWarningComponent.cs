using System.Collections.Generic;

namespace Ase.ECS;

public class EntityWarningComponent : BaseComponent
{
	private Dictionary<int, WarningIndicatorEntity> _warningIndicatorEntities;

	public override void OnInit(object data)
	{
		base.OnInit(data);
		_warningIndicatorEntities = new Dictionary<int, WarningIndicatorEntity>();
	}

	public void CreateWarnIndicator(WarningIndicatorEntity warningIndicatorEntity)
	{
		if (!_warningIndicatorEntities.ContainsKey(warningIndicatorEntity.Id))
		{
			_warningIndicatorEntities.Add(warningIndicatorEntity.Id, warningIndicatorEntity);
		}
	}

	public void RemoveWarnIndicator(WarningIndicatorEntity warningIndicatorEntity)
	{
		if (_warningIndicatorEntities.ContainsKey(warningIndicatorEntity.Id))
		{
			_warningIndicatorEntities.Remove(warningIndicatorEntity.Id);
		}
	}

	public void StopWarningIndicator(bool isForce)
	{
		foreach (WarningIndicatorEntity value in _warningIndicatorEntities.Values)
		{
			value?.Stop(isForce);
		}
		_warningIndicatorEntities.Clear();
	}

	public override void OnEntityRelease()
	{
		base.OnEntityRelease();
		StopWarningIndicator(isForce: true);
	}

	public override void OnDispose()
	{
		base.OnDispose();
		_warningIndicatorEntities.Clear();
	}
}
