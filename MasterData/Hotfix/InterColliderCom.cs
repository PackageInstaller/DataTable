using Pathfinding;
using TrueSync;
using UnityEngine;

public class InterColliderCom : LogicEntity, IDeterministicCollisionListener
{
	protected InteractiveBase _owner;

	protected DeterministicCollider dtCollider;

	protected NavmeshCut navmeshCut;

	protected DeterministicMovementBlocker determinBloacker;

	protected TrueSyncTransform tsTran;

	protected override void OnInit()
	{
		_owner = transform.parent.GetComponent<InteractiveBase>();
		if (_owner == null)
		{
			return;
		}
		DeterministicCollider deterministicCollider = null;
		Collider collider = null;
		this.SetDeterministicCollider(ref collider, ref deterministicCollider);
		dtCollider = deterministicCollider;
		if (dtCollider != null)
		{
			dtCollider.collisionListener = this;
			dtCollider.layer = 10;
			dtCollider.priority = 4;
			dtCollider.IgnoreCollision = false;
		}
		if (!(navmeshCut != null))
		{
			navmeshCut = _owner.transform.GetComponentInChildren<NavmeshCut>();
			determinBloacker = _owner.transform.GetComponentInChildren<DeterministicMovementBlocker>();
			if (!(determinBloacker == null))
			{
				tsTran = determinBloacker.GetComponent<TrueSyncTransform>();
				tsTran.RefreshTsPos();
			}
		}
	}

	protected override void OnActive()
	{
		if (tsTran != null)
		{
			tsTran.OnActive();
		}
		if (navmeshCut != null && !navmeshCut.gameObject.activeSelf)
		{
			navmeshCut.gameObject.SetActive(value: true);
		}
	}

	protected override void OnDeactive()
	{
	}

	public void SetMeshCollider(bool active)
	{
		if (dtCollider != null)
		{
			dtCollider.IgnoreCollision = active;
		}
	}

	public void SyncPosition(Vector3 position)
	{
		transform.position = position;
		tsTransform.Position = new TSVector2(position.x, position.z);
		tsTransform.PositionY = position.y;
	}

	public void SetNavmeshCut(bool active)
	{
		if (navmeshCut != null)
		{
			navmeshCut.gameObject.SetActive(active);
		}
		if (determinBloacker != null)
		{
			determinBloacker.enabled = active;
		}
	}

	public void OnDeterministicCollisionEnter(DeterministicCollider other)
	{
		PlayerAdventureActor playerAdventureActor = other?.GetComponent<PlayerAdventureActor>();
		if (!(playerAdventureActor == null) && !(playerAdventureActor != SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor))
		{
			_owner._actor = playerAdventureActor;
			_owner.FireUiEvent(_owner.getUIActiveState());
		}
	}

	public void OnDeterministicCollisionStay(DeterministicCollider other)
	{
	}

	public void OnDeterministicCollisionExit(DeterministicCollider other)
	{
		PlayerAdventureActor playerAdventureActor = other?.GetComponent<PlayerAdventureActor>();
		if (!(playerAdventureActor == null) && !(playerAdventureActor != SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor))
		{
			_owner._actor.ExitInteractive();
			_owner._actor = null;
			_owner.FireUiEvent();
		}
	}
}
