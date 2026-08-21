using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("修改实体朝向", 0)]
[Category("✫ DragonLost/Entity")]
[Description("用于修改实体的朝向角度。")]
public class ChangeEntityRotation : ActionTaskBase
{
	[Name("立即完成", 0)]
	[Description("忽略旋转速度，直接修改实体的朝向到目标角度。")]
	public bool immediately;

	[Name("使用相对角度", 0)]
	[Description("是否使用相对角度进行旋转。")]
	public bool localRotate;

	private EntityRotationComponent rotateComponent;

	[Name("旋转角度", 0)]
	[Description("要旋转的角度值。")]
	public BBParameter<float> rotation;

	[ShowIf("waitUntilFinish", 1)]
	[Name("等待时间", 0)]
	[Description("等待旋转完成的时间。")]
	public float waitTime;

	[Name("等待旋转完成", 0)]
	[Description("是否等待旋转完成。")]
	public bool waitUntilFinish;

	[Name("是否设置旋转速度", 0)]
	[Description("是否设置旋转速度。")]
	public bool IsSetRotateSpeed;

	[Name("旋转速度", 0)]
	[ShowIf("IsSetRotateSpeed", 1)]
	[Description("设置的旋转速度值。")]
	public float RotateSpeed;

	protected override void OnExecute()
	{
		base.OnExecute();
		rotateComponent = ownerEntity.GetComponent<EntityRotationComponent>();
		if (rotateComponent == null)
		{
			OnActionFail();
			return;
		}
		float value = rotation.value;
		float num = ((!(rotation.value > 0f)) ? 1 : (-1));
		value = (value + 180f) % 360f - 180f;
		if (value < -180f)
		{
			value += 360f;
		}
		value = ((Mathf.Abs(value) == 180f) ? (180f * num) : value);
		Vector3 zero = Vector3.zero;
		zero = ((!localRotate) ? (Quaternion.Euler(0f, value, 0f) * Vector3.forward + GetOwnerEntity().transform.position) : (Quaternion.Euler(0f, value, 0f) * (GetOwnerEntity().transform.rotation * Vector3.forward) + GetOwnerEntity().transform.position));
		if (immediately)
		{
			rotateComponent.ImmediatelyRotate(zero);
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance?.WriteAuthorityEntityId($"设置实体朝向 {zero}", ownerEntity);
			}
			OnActionFinish();
			return;
		}
		if (IsSetRotateSpeed)
		{
			rotateComponent.SetTarget(zero, waitTime, immediatelyEnd: true, RotateSpeed);
		}
		else
		{
			rotateComponent.SetTarget(zero, waitTime, immediatelyEnd: true);
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"设置实体朝向 {zero}  waitTime {waitTime}", ownerEntity);
		}
		if (!waitUntilFinish || waitTime == 0f)
		{
			OnActionFinish();
		}
	}

	protected override void OnUpdate()
	{
		if (!waitUntilFinish || !(waitTime > 0f))
		{
			return;
		}
		if (rotateComponent != null)
		{
			if (rotateComponent.RotationFinish)
			{
				if (LockstepData.Instance != null)
				{
					LockstepData.Instance?.WriteAuthorityEntityId("设置实体朝向 结束", ownerEntity);
				}
				OnActionFinish();
			}
		}
		else
		{
			OnActionFail();
		}
	}
}
