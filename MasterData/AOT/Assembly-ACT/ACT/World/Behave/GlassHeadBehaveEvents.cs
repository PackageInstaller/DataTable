using System;
using ACT.Battle;
using ACT.World.Asset;
using ACT.World.StateObject;
using UnityEngine;
using UnityEngine.Animations;

namespace ACT.World.Behave;

public class GlassHeadBehaveEvents : MonoBehaviour
{
	[NonSerialized]
	public InteractObjectData data;

	public InteractObject interactObject;

	public Animator animator;

	public ParentConstraint constraint;

	public Rigidbody rig;

	public BoxCollider trigger;

	private float fallVelocity;

	private float recallVelocity;

	private Vector3 targetPos;

	private Vector3 recallPos;

	private Vector3 m_Bottom;

	private bool isSetParent;

	private ConstraintSource m_Source;

	private Vector3 p = new Vector3(0f, -10f, 0f);

	private Vector3 target;

	private Vector3 currTargetPos;

	public void Init()
	{
	}

	private bool IsFalling()
	{
		if (Physics.Raycast(transform.position, Vector3.down, out var _, 0.51f, BattleConsts.enviromentMask))
		{
			return false;
		}
		return true;
	}

	public void OnTriggerEnter(Collider other)
	{
		if ((bool)other.gameObject.GetComponent<MonoEntity>() && LuminApplication.LogEnabled)
		{
			Debug.Log("碰到人了");
		}
	}

	public void FixedUpdate()
	{
		RaycastHit hitInfo3;
		if (isSetParent)
		{
			RaycastHit hitInfo2;
			if (Physics.Raycast(transform.position, Vector3.left, out var _, 0.51f, BattleConsts.enviromentMask))
			{
				isSetParent = false;
				constraint.RemoveSource(0);
				constraint.constraintActive = false;
			}
			else if (Physics.Raycast(transform.position, Vector3.right, out hitInfo2, 0.51f, BattleConsts.enviromentMask))
			{
				isSetParent = false;
				constraint.RemoveSource(0);
				constraint.constraintActive = false;
			}
		}
		else if (IsFalling())
		{
			if (isSetParent)
			{
				isSetParent = false;
				constraint.RemoveSource(0);
				constraint.constraintActive = false;
			}
		}
		else if (Physics.Raycast(transform.position, Vector3.down, out hitInfo3, 0.51f, BattleConsts.enviromentMask) && !isSetParent && !rig.isKinematic && (bool)hitInfo3.transform.GetComponentInChildren<Rigidbody>())
		{
			ConstraintSource source = (m_Source = new ConstraintSource
			{
				sourceTransform = hitInfo3.transform,
				weight = 1f
			});
			constraint.AddSource(source);
			Vector3 value = source.sourceTransform.InverseTransformPoint(transform.position);
			constraint.SetTranslationOffset(0, value);
			constraint.constraintActive = true;
			isSetParent = true;
		}
		if (Vector3.Distance(transform.position, targetPos) <= 0.05f && !rig.isKinematic)
		{
			rig.isKinematic = true;
			isSetParent = false;
			constraint.RemoveSource(0);
			constraint.constraintActive = false;
		}
	}
}
