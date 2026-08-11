using Ase;
using Ase.ECS;
using UnityEngine;

public class BaseLogicCollider
{
	public BaseEntity BaseEntity;

	public Vector3 CenterOffset;

	public float Radius;

	public float Height;

	public virtual void OnInit()
	{
	}

	public Vector3 GetCenterWorldPosition()
	{
		if (BaseEntity == null || BaseEntity.transform == null)
		{
			return Vector3.zero;
		}
		return TSUtil.TransformPoint(BaseEntity.transform.position, BaseEntity.transform.eulerAngles, Vector3.one, CenterOffset);
	}

	public float GetColliderDistance(BaseLogicCollider logicCollider)
	{
		if (logicCollider == null)
		{
			return 0f;
		}
		return Vector3.Distance(logicCollider.GetCenterWorldPosition(), GetCenterWorldPosition());
	}
}
