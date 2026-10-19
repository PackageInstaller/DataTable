using Bamboo.ECS;
using RootMotion.FinalIK;
using UnityEngine;

namespace ACT.Battle;

public class CompAim : EcsComponent
{
	public Entity aimEntity;

	public string attachPoint;

	public Transform ikOriginTrans;

	public Transform aimTarget;

	public Vector3 aimTargetPosition;

	public bool aiming;

	public bool rotate;

	public bool useIK;

	public AimIK aimIK;

	public bool useLineEffect;

	public MonoLineEffect transformLine;

	public float weight;

	public float rotateSpeed;

	protected override void OnGet()
	{
	}

	protected override void OnRelease()
	{
		aimEntity = default;
		attachPoint = null;
		aiming = false;
		rotate = false;
		weight = 0f;
		if (aimIK != null)
		{
			aimIK.solver.target = null;
			aimIK = null;
		}
		ikOriginTrans = null;
		aimTargetPosition = Vector3.zero;
		aimTarget = null;
		transformLine = null;
		useIK = false;
		useLineEffect = false;
	}

	public void UpdateIKPosition()
	{
		if (aimIK != null && useIK)
		{
			aimIK.solver.IKPosition = aimTargetPosition;
			aimIK.solver.IKPositionWeight = 1f;
		}
	}

	public void SetAimEntity(Entity targetEntity, string attach)
	{
		if (targetEntity.IsValid)
		{
			aimEntity = targetEntity;
			attachPoint = attach;
			if (string.IsNullOrEmpty(attach))
			{
				aimTarget = targetEntity.GetRootTransform();
			}
			else if (!targetEntity.GetMono().TryGetAttachPoint(attach, out aimTarget))
			{
				return;
			}
			aimTargetPosition = aimTarget.position;
		}
	}

	public void SetAimPosition(Vector3 aimPosition)
	{
		aimTargetPosition = aimPosition;
	}

	public Vector3 GetAimPosition()
	{
		if (aimEntity.IsValid)
		{
			if (string.IsNullOrEmpty(attachPoint) || !aimEntity.GetMono().TryGetAttachPoint(attachPoint, out aimTarget))
			{
				aimTarget = aimEntity.GetRootTransform();
			}
			aimTargetPosition = aimTarget?.position ?? Vector3.zero;
		}
		return aimTargetPosition;
	}

	public void ClearAimEntity()
	{
		aimEntity = default;
		aimTarget = null;
	}
}
