using System.Collections.Generic;
using TrueSync.Physics2D;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器特性/Buff添加移除(碰撞触发)")]
public class WeaponFeatureBuffTrigger : WeaponFeature, IDeterministicCollisionListener
{
	[SerializeField]
	public List<BuffConfig> buffConfigs;

	private List<DeterministicCollider> _collisionDetectList = new List<DeterministicCollider>(20);

	public override void OnStart()
	{
		base.OnStart();
		if (attachedWeapon.dtCollider != null)
		{
			attachedWeapon.dtCollider.collisionListener = this;
			attachedWeapon.dtCollider.IgnoreCollision = false;
		}
	}

	public override void OnUpdate()
	{
		base.OnUpdate();
		if (!(attachedWeapon.dtCollider != null))
		{
			return;
		}
		AABB checkBounds = attachedWeapon.dtCollider.ColliderBounds;
		_collisionDetectList.Clear();
		SceneSingleton<DeterministicCollisionManager>.Instance.quadTree.GetColliding(ref checkBounds, _collisionDetectList);
		DeterministicCollider dtCollider = attachedWeapon.dtCollider;
		for (int num = _collisionDetectList.Count - 1; num >= 0; num--)
		{
			DeterministicCollider deterministicCollider = _collisionDetectList.get_Item(num);
			if (deterministicCollider.priority < 0)
			{
				_collisionDetectList.RemoveAt(num);
			}
			else if (dtCollider == deterministicCollider)
			{
				_collisionDetectList.RemoveAt(num);
			}
			else
			{
				ActorHealthInfo logicComponent = deterministicCollider.Entity.GetLogicComponent<ActorHealthInfo>();
				if (logicComponent != null && !logicComponent.isAlive)
				{
					_collisionDetectList.RemoveAt(num);
				}
			}
		}
		_collisionDetectList.Sort((DeterministicCollider a, DeterministicCollider b) => a.priority.CompareTo(b.priority));
		for (int num2 = 0; num2 < _collisionDetectList.Count; num2++)
		{
			SceneSingleton<DeterministicCollisionManager>.Instance.ContactEvaluate(LockStepManager.frameCount, dtCollider, _collisionDetectList.get_Item(num2), duplex: false);
		}
		dtCollider.SeparateWithRemaining(LockStepManager.frameCount);
	}

	public void OnDeterministicCollisionEnter(DeterministicCollider other)
	{
		if (!(other.Entity is AdventureActor adventureActor))
		{
			return;
		}
		foreach (BuffConfig buffConfig in buffConfigs)
		{
			if (adventureActor.CheckTarget(attachedWeapon.owner, buffConfig.buffTargetType))
			{
				adventureActor.buffComponent?.AddBuffs(buffConfig.buffList, attachedWeapon.owner as AdventureActor);
			}
		}
	}

	public void OnDeterministicCollisionStay(DeterministicCollider other)
	{
	}

	public void OnDeterministicCollisionExit(DeterministicCollider other)
	{
		if (!(other.Entity is AdventureActor adventureActor))
		{
			return;
		}
		foreach (BuffConfig buffConfig in buffConfigs)
		{
			if (buffConfig.isRemove && adventureActor.CheckTarget(attachedWeapon.owner, buffConfig.buffTargetType))
			{
				adventureActor.buffComponent?.AddBuffs(buffConfig.buffList, attachedWeapon.owner as AdventureActor);
			}
		}
	}
}
