using TrueSync;
using UnityEngine;

[AddComponentMenu("Game/Adventure/Trigger/Trap")]
[RequireComponent(typeof(TrueSyncTransform))]
public class AdventureTrap : LogicEntity, IDeterministicCollisionListener
{
	[Min(0f)]
	public int damageValue;

	[Space]
	public bool moveable;

	public Transform[] waypoints;

	public FP moveSpeed = 2f;

	public Collider collider;

	public DeterministicCollider dtCollider { get; protected set; }

	public TrueSyncWaypointMove move { get; protected set; }

	private void Awake()
	{
		DeterministicCollider deterministicCollider = null;
		this.SetDeterministicCollider(ref collider, ref deterministicCollider);
		dtCollider = deterministicCollider;
		if (dtCollider != null)
		{
			dtCollider.collisionListener = this;
		}
		if (moveable)
		{
			move = AddOrGetLogicComponent<TrueSyncWaypointMove>();
		}
		gameObject.layer = 13;
		if (dtCollider != null)
		{
			dtCollider.layer = 13;
		}
		dtCollider.priority = 3;
		_logger = Singleton<LogManager>.Instance.get_Item("Adventure_Trap");
	}

	protected override void OnLogicUpdate()
	{
		if (moveable && move != null)
		{
			move.Move(LogicDeltaTime);
		}
	}

	public void OnDeterministicCollisionStay(DeterministicCollider other)
	{
		if (other.layer == 8)
		{
			PlayerAdventureActor playerAdventureActor = other.collisionListener as PlayerAdventureActor;
			if (playerAdventureActor != null)
			{
				playerAdventureActor.Damage(this, SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId(), 1);
			}
		}
	}

	public void OnDeterministicCollisionEnter(DeterministicCollider other)
	{
	}

	public void OnDeterministicCollisionExit(DeterministicCollider other)
	{
	}

	protected override void OnActive()
	{
		EnableLogicUpdate();
		tsTransform.Dirty = true;
		if (moveable && move != null)
		{
			move.Setup(waypoints);
			move.moveSpeed = moveSpeed;
		}
	}

	protected override void OnDeactive()
	{
	}
}
