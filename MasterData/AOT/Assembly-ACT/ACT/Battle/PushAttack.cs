using ACT.Utility;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

[RequireComponent(typeof(BoxCollider))]
[AddComponentMenu("ACT/PushAttack")]
public class PushAttack : MonoBehaviour, IPushCallBack
{
	public bool moveAttack;

	public string attackAbility;

	private Collider m_Collider;

	[HideInInspector]
	public Entity attackSource;

	private void Start()
	{
		m_Collider = GetComponent<Collider>();
	}

	public void OnPush(Entity entity)
	{
		if (entity.IsValid && !string.IsNullOrEmpty(attackAbility))
		{
			Entity entity2 = entity;
			if (attackSource.IsValid && attackSource.IsLogicAvailable())
			{
				entity2 = attackSource;
			}
			DoPush(entity, entity2);
		}
	}

	private void DoPush(Entity target, Entity attackSource)
	{
		if (target.IsValid && target.GetCompAbility() != null)
		{
			if (target.IsCharacter())
			{
				target.GetCompAbility().AddAbility(attackSource, attackAbility, AbilitySource.Ability, default, 1);
			}
			else if (target.IsMonster())
			{
				target.SetTrigger("trap_die");
				target.KillEntity();
			}
		}
	}

	private void FixedUpdate()
	{
		if (!moveAttack)
		{
			return;
		}
		Collider[] cacheColliders = PhysicsUtility.cacheColliders;
		if (Physics.OverlapBoxNonAlloc(m_Collider.bounds.center, m_Collider.bounds.extents, cacheColliders, Quaternion.identity) > 0)
		{
			for (int i = 0; i < cacheColliders.Length && !(cacheColliders[i] == null); i++)
			{
				MonoEntity component = cacheColliders[i].GetComponent<MonoEntity>();
				if (component != null && component.entity.IsBehaveEntity() && !string.IsNullOrEmpty(attackAbility))
				{
					Entity entity = component.entity;
					DoPush(entity, entity);
				}
			}
		}
		PhysicsUtility.Release(cacheColliders);
	}
}
