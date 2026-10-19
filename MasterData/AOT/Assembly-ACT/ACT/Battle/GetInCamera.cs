using ACT.Utility;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/待定要好好想想的")]
[TaskDescription("当自身在相机内时，判断是否 dis < 距离相机水平边缘的距离，不在相机内则直接返回failure")]
public class GetInCamera : Conditional
{
	public SharedFloat dis;

	private Entity m_Entity;

	private Plane[] m_TempCameraPlanes = new Plane[6];

	private Bounds entityBounds;

	private Vector3 m_LeftViewPoint;

	private Vector3 m_RightViewPoint;

	private bool IsInScreen(Bounds bounds)
	{
		return GeometryUtility.TestPlanesAABB(m_TempCameraPlanes, bounds);
	}

	public override void OnStart()
	{
		m_Entity = ((ActBehaviorTree)Owner).Entity;
		entityBounds.size = m_Entity.GetCompTransform().size;
		m_LeftViewPoint = Vector3.zero;
		m_RightViewPoint = new Vector3(1f, 0f, 0f);
	}

	public override TaskStatus OnUpdate()
	{
		Entity hatred = m_Entity.GetCompHatred().GetHatred();
		if (hatred.GetCompAbility().HasAbility("cantBeAttack") && hatred.IsCharacter())
		{
			return TaskStatus.Failure;
		}
		GeometryUtility.CalculateFrustumPlanes(GameUtility.mainCamera, m_TempCameraPlanes);
		CompTransform compTransform = m_Entity.GetCompTransform();
		Vector3 physicsPosition = compTransform.physicsPosition;
		entityBounds.center = compTransform.center + physicsPosition;
		if (IsInScreen(entityBounds))
		{
			Vector3 vector = GameUtility.mainCamera.WorldToViewportPoint(physicsPosition);
			m_LeftViewPoint.y = (m_RightViewPoint.y = vector.y);
			m_LeftViewPoint.z = (m_RightViewPoint.z = vector.z);
			Vector3 vector2 = GameUtility.mainCamera.ViewportToWorldPoint(m_LeftViewPoint);
			Vector3 vector3 = GameUtility.mainCamera.ViewportToWorldPoint(m_RightViewPoint);
			float num = Mathf.Abs(vector2.x - physicsPosition.x);
			float num2 = Mathf.Abs(vector3.x - physicsPosition.x);
			if (dis.Value < num && dis.Value < num2)
			{
				return TaskStatus.Success;
			}
		}
		return TaskStatus.Failure;
	}
}
