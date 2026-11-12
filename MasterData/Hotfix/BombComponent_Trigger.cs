using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器组件/炸弹_触发组件(目前仅炸弹可用)")]
[RequireComponent(typeof(AdventureBomb))]
[DisallowMultipleComponent]
public class BombComponent_Trigger : LogicMonoComponent, IBombComponent, IDeterministicCollisionListener
{
	public enum TriggerType
	{
		Enter,
		Exit
	}

	public TriggerType triggerType;

	protected AdventureBomb _context;

	public bool KeepAlive { get; set; } = true;

	public void Setup()
	{
		_context = Entity as AdventureBomb;
		if (!(_context == null) && _context.dtCollider != null)
		{
			_context.dtCollider.collisionListener = this;
			_context.dtCollider.priority = 3;
			_context.dtCollider.IgnoreCollision = false;
		}
	}

	public void Reset(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP))
	{
		KeepAlive = true;
	}

	public void Finish()
	{
	}

	public override void OnDeactive()
	{
		base.OnDeactive();
		_context = null;
	}

	public void OnDeterministicCollisionEnter(DeterministicCollider other)
	{
		if (triggerType == TriggerType.Enter)
		{
			Trigger(other);
		}
	}

	public void OnDeterministicCollisionStay(DeterministicCollider other)
	{
	}

	public void OnDeterministicCollisionExit(DeterministicCollider other)
	{
		if (triggerType == TriggerType.Exit)
		{
			Trigger(other);
		}
	}

	protected void Trigger(DeterministicCollider other)
	{
		if (!(_context == null) && KeepAlive && other.Entity is AdventureActor entityB && _context.owner.IsConfrontWith(entityB))
		{
			KeepAlive = false;
		}
	}
}
