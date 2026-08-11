using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取实体与空气墙的距离", 0)]
[Description("获取实体与空气墙的最近和最远距离，并返回对应的角度。注意：开销较大，谨慎使用。")]
[Category("✫ DragonLost/Entity")]
public class GetDistanceToWall : ActionTaskBase
{
	[Name("实体Id", 0)]
	[Description("要获取距离的实体的ID")]
	public BBParameter<int> entityId;

	[Name("相对方向列表", 0)]
	[Description("用于检查的相对方向角度列表")]
	public BBParameter<List<float>> angleLists;

	[Name("最近角度", 0)]
	[Description("最近距离对应的角度")]
	public BBParameter<float> closeAngle;

	[Name("最近距离", 0)]
	[Description("与空气墙的最近距离")]
	public BBParameter<float> closeDistance;

	[Name("最远角度", 0)]
	[Description("最远距离对应的角度")]
	public BBParameter<float> farAngle;

	[Name("最远距离", 0)]
	[Description("与空气墙的最远距离")]
	public BBParameter<float> farDistance;

	private Dictionary<float, float> results = new Dictionary<float, float>();

	private List<BoxCollider> walls = new List<BoxCollider>();

	protected override void OnExecute()
	{
		base.OnExecute();
		OnActionFinish();
	}

	private float GetDistance(float angle, List<BoxCollider> walls, BaseEntity entity)
	{
		//IL_0039: Unknown result type (might be due to invalid IL or missing references)
		//IL_003e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0073: Unknown result type (might be due to invalid IL or missing references)
		//IL_0078: Unknown result type (might be due to invalid IL or missing references)
		Vector3 vector = Quaternion.Euler(0f, angle, 0f) * (entity.transform.rotation * Vector3.forward);
		RaycastHit[] array = (RaycastHit[])(object)new RaycastHit[32];
		PhysicsScene physicsScene = entity.GetWorld().GetPhysicsScene();
		((PhysicsScene)(ref physicsScene)).Raycast(entity.transform.position, vector.normalized, array, 100f, -1, (QueryTriggerInteraction)1);
		float num = float.MaxValue;
		RaycastHit[] array2 = array;
		for (int i = 0; i < array2.Length; i++)
		{
			RaycastHit val = array2[i];
			Collider collider = ((RaycastHit)(ref val)).collider;
			BoxCollider val2 = (BoxCollider)(object)((collider is BoxCollider) ? collider : null);
			if ((Object)(object)val2 != null && walls.Contains(val2))
			{
				num = Mathf.Min(num, Vector3.Distance(((RaycastHit)(ref val)).point, ownerEntity.transform.position));
			}
		}
		return num;
	}
}
