using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器特性/命中时触发区域效果")]
[DisallowMultipleComponent]
public class WeaponFeatureHitTriggerArea : WeaponFeature
{
	public enum TriggerPositionType
	{
		Self,
		Target
	}

	public GameObject areaEffectPrefab;

	public int maxTriggerCount = -1;

	public bool triggerWithMonster;

	public bool triggerWithPlayer;

	public bool triggerWithDestructibleObstacle;

	public bool triggerWithObstacle;

	public TriggerPositionType triggerPositionType;

	private int _maxTriggerCount;

	private int _triggerCount;

	public override void OnStart()
	{
		base.OnStart();
		_maxTriggerCount = maxTriggerCount;
	}

	public override void OnActive()
	{
		base.OnActive();
		_triggerCount = 0;
	}

	private void Exceute(LogicEntity target)
	{
		if (!HaveTriggerCount())
		{
			return;
		}
		AdventureActor component = attachedWeapon.owner.GetComponent<AdventureActor>();
		if (!(areaEffectPrefab == null) && !(component == null))
		{
			TSVector2 targetPosition = TSVector2.zero;
			FP defaultPositionY = FP.Zero;
			switch (triggerPositionType)
			{
			case TriggerPositionType.Self:
				targetPosition = attachedWeapon.tsTransform.Position;
				defaultPositionY = attachedWeapon.tsTransform.PositionY;
				break;
			case TriggerPositionType.Target:
				targetPosition = target.tsTransform.Position;
				defaultPositionY = target.tsTransform.PositionY;
				break;
			}
			FP terrainHeight = CommonHelper.GetTerrainHeight(targetPosition, defaultPositionY);
			Vector3 spawnPosition = new Vector3((float)targetPosition.x, (float)terrainHeight, (float)targetPosition.y);
			SceneSingleton<AreaEffectManager>.Instance.PlayAreaEffect(component, areaEffectPrefab, spawnPosition, attachedWeapon.transform.rotation);
			_triggerCount++;
		}
	}

	private bool HaveTriggerCount()
	{
		if (maxTriggerCount >= 0)
		{
			return _triggerCount < _maxTriggerCount;
		}
		return true;
	}

	public override bool OnHitActor(LogicEntity actor, ref DeterministicRaycastHit raycastHit)
	{
		if (!(actor is MonsterAdventureActor))
		{
			if (!(actor is PlayerAdventureActor))
			{
				if (actor is DestructibleStateSingle && triggerWithDestructibleObstacle)
				{
					Exceute(actor);
				}
			}
			else if (triggerWithPlayer)
			{
				Exceute(actor);
			}
		}
		else if (triggerWithMonster)
		{
			Exceute(actor);
		}
		return base.OnHitActor(actor, ref raycastHit);
	}

	public override bool OnHitObstacle(AdventureObstacle obstacle, ref DeterministicRaycastHit raycastHit)
	{
		if (triggerWithObstacle)
		{
			Exceute(obstacle);
		}
		return base.OnHitObstacle(obstacle, ref raycastHit);
	}
}
