using UnityEngine;

public class WeaponFeature : MonoBehaviour
{
	public int initLevel = 1;

	[HideInInspector]
	public bool finishAttachedWeapon;

	public AdventureBulletBase attachedWeapon { get; protected set; }

	public int level { get; protected set; }

	public virtual int maxLevel => 99;

	public virtual void OnActive()
	{
		attachedWeapon = GetComponent<AdventureBulletBase>();
		finishAttachedWeapon = false;
	}

	public virtual void OnDeactive()
	{
		level = 0;
		attachedWeapon = null;
		finishAttachedWeapon = false;
	}

	public virtual void OnStart()
	{
	}

	public virtual void OnUpdate()
	{
	}

	public virtual bool OnEnd()
	{
		return false;
	}

	public virtual void UpgradeLevel()
	{
		if (level < maxLevel)
		{
			level++;
		}
		else
		{
			level = maxLevel;
		}
	}

	public bool CheckEntitySearchable(LogicEntity entity)
	{
		if (entity == null)
		{
			return false;
		}
		AdventureActor adventureActor = entity as AdventureActor;
		if (adventureActor == null)
		{
			return false;
		}
		if (!adventureActor.IsSearchableByEnemy(attachedWeapon.owner as AdventureActor))
		{
			return adventureActor.IsSearchableByFriend(attachedWeapon.owner as AdventureActor);
		}
		return true;
	}

	public virtual bool OnHitActor(LogicEntity actor, ref DeterministicRaycastHit raycastHit)
	{
		return false;
	}

	public virtual bool OnHitShield(AdventureWeapon shield, ref DeterministicRaycastHit raycastHit)
	{
		return false;
	}

	public virtual bool OnHitObstacle(AdventureObstacle obstacle, ref DeterministicRaycastHit raycastHit)
	{
		return false;
	}
}
