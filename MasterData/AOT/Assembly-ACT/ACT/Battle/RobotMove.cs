using System.Collections;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/待修改")]
public class RobotMove : Action
{
	public enum RobotMoveType
	{
		followPlayer,
		followTransform
	}

	public RobotMoveType moveType;

	public SharedTransform followTrans;

	public float posDamping;

	public float ratDamping;

	public Vector3 posOffset;

	public Vector3 rotateOffset;

	public SharedBool stopSimpleMove;

	public SharedBool useRandomFollow;

	public SharedVector3 randomSize;

	private WaitForFixedUpdate m_Wait = new WaitForFixedUpdate();

	public override void OnStart()
	{
		if (useRandomFollow.Value)
		{
			posOffset.x += Random.Range(0f, randomSize.Value.x);
			posOffset.y += Random.Range(0f, randomSize.Value.y);
			posOffset.z += Random.Range(0f, randomSize.Value.z);
		}
		StartCoroutine(SetPos());
	}

	public override void OnEnd()
	{
		stopSimpleMove.Value = true;
		StopCoroutine(SetPos());
	}

	public override TaskStatus OnUpdate()
	{
		return TaskStatus.Running;
	}

	private IEnumerator SetPos()
	{
		while (true)
		{
			yield return m_Wait;
			Entity entity = Owner.ToEntity();
			if (!entity.IsValid)
			{
				break;
			}
			CompProduct compProduct = entity.GetCompProduct();
			if (compProduct == null)
			{
				continue;
			}
			Entity caster = compProduct.caster;
			Vector3 position = entity.GetRootTransform().position;
			if (!MonoECS.instance.running || !entity.IsLogicAvailable() || !entity.IsActive() || !caster.IsValid || stopSimpleMove.Value || !entity.GetCompAI().ActBehaviorTree.enabled)
			{
				continue;
			}
			Vector3 position2 = caster.GetRootTransform().position;
			Transform rootTransform = entity.GetRootTransform();
			_ = Vector3.zero;
			switch (moveType)
			{
			case RobotMoveType.followPlayer:
			{
				stopSimpleMove.Value = false;
				Transform rootTransform2 = caster.GetRootTransform();
				Quaternion quaternion = (caster.IsFaceLeft() ? Quaternion.Euler(rootTransform2.TransformDirection(-rotateOffset)) : Quaternion.Euler(rootTransform2.TransformDirection(rotateOffset)));
				Vector3 position3 = position2 + rootTransform2.TransformDirection(posOffset);
				rootTransform.position = Vector3.Lerp(position, position3, posDamping * Time.deltaTime);
				if (caster.TryGetCompPhysics(out CompPhysics component))
				{
					Quaternion b = component.faceDirRot * quaternion;
					Quaternion localRotation = rootTransform.localRotation;
					rootTransform.localRotation = Quaternion.Lerp(localRotation, b, ratDamping * Time.deltaTime);
				}
				break;
			}
			case RobotMoveType.followTransform:
			{
				Vector3 position3 = followTrans.Value.position;
				rootTransform.position = Vector3.Lerp(position, position3, posDamping * Time.deltaTime);
				break;
			}
			}
		}
	}
}
