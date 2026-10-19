using ACT.Battle.Configs;
using ACT.Utility;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class TrajectoryCollider : MonoBehaviour, IColliderEntityRef
{
	public Entity entity;

	private Collider myCollider;

	public bool defaultActive = true;

	private void Start()
	{
		if (myCollider == null)
		{
			myCollider = GetComponent<Collider>();
		}
	}

	private void OnDestroy()
	{
		RemoveEntityRef();
	}

	public MonoEntity GetMonoEntity()
	{
		return entity.GetMono();
	}

	public (bool, FindTargetResult) FindResult(Vector3 anchor, Vector3 touchForward)
	{
		myCollider.ClosestPoint(anchor);
		return (false, default);
	}

	public void RemoveEntityRef()
	{
		if (myCollider != null)
		{
			PhysicsUtility.RemoveEntityRef(myCollider);
		}
	}

	public void Init(Entity en)
	{
		entity = en;
	}
}
