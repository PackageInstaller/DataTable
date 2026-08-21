#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using Ase.ECS;
using GameFramework;

namespace Ase;

[Obsolete]
public class EntityBowAwakenInfo
{
	private BaseEntity hitEntity;

	private int hitValue;

	public EntityBowAwakenInfo(BaseEntity hitEntity)
	{
		this.hitEntity = hitEntity;
		hitValue = 0;
	}

	public BaseEntity GetHitEntity()
	{
		return hitEntity;
	}

	public int GetHitEntityID()
	{
		if (hitEntity == null)
		{
			Log.Error("Hit Entity is null");
			return 0;
		}
		return hitEntity.Id;
	}
}
