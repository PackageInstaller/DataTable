using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public class InitVelocity
{
	public Vector3 initSpeed;

	public bool useLocalCoordinate;

	public bool useOwnerAim;

	[Tooltip("如果要使用挂点瞄准,填写挂点,不填就是用Aim IK做瞄准")]
	public string attachPoint;

	public bool useAimPosition;

	public bool useRotationDirection;

	public bool useDefaultVelocity;

	public Vector3 GetVelocity(Entity eb, Ability ability)
	{
		bool flag = false;
		Vector3 toDirection = Vector3.zero;
		CompVelocity compVelocity = eb.GetCompVelocity();
		CompProduct compProduct = eb.GetCompProduct();
		CompTransform compTransform = eb.GetCompTransform();
		if (useDefaultVelocity)
		{
			return compVelocity.velocity;
		}
		if (useOwnerAim)
		{
			CompAim component;
			if (!string.IsNullOrEmpty(attachPoint))
			{
				toDirection = ability.caster.GetMono().GetAttachPointAll(attachPoint).GetForward();
				flag = true;
			}
			else if (compProduct.productOwner.TryGetCompAim(out component) && component.aiming)
			{
				toDirection = component.aimTargetPosition - component.ikOriginTrans.position;
				component.rotate = false;
				flag = true;
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning(ability.config.name + "启用了瞄准方向,但是没有匹配到可用的瞄准点");
			}
		}
		if (useOwnerAim & flag)
		{
			return Quaternion.FromToRotation(Vector3.forward, toDirection) * initSpeed;
		}
		CompAim compAim = eb.GetCompAim();
		if (useAimPosition)
		{
			toDirection = compAim.aimTargetPosition - compTransform.physicsPosition;
			return Quaternion.FromToRotation(Vector3.forward, toDirection) * initSpeed;
		}
		if (useRotationDirection)
		{
			return compTransform.rotation * initSpeed;
		}
		if (useLocalCoordinate)
		{
			return compTransform.rotation * initSpeed;
		}
		Entity productOwner = compProduct.productOwner;
		CompTransform compTransform2 = productOwner.GetCompTransform();
		if (!productOwner.TryGetCompPhysics(out CompPhysics component2))
		{
			return compTransform2.rotation * initSpeed;
		}
		return component2.faceDirRot * initSpeed;
	}
}
