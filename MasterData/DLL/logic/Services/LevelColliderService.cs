using System.Collections.Generic;
using Config;
using UnityEngine;

namespace Services;

public class LevelColliderService : ILevelColliderService, IService
{
	public const int obstacleLayer = 10;

	public List<ISimShape> mLevelColliders { get; set; }

	public void Shutdown()
	{
		mLevelColliders.Clear();
	}

	public void ScanColliders(List<Collider> colliders)
	{
		if (colliders == null || colliders.Count == 0)
		{
			Debug.LogError((object)"此地图不存在碰撞器！（如果策划没有配置，忽略！）");
			return;
		}
		colliders.Sort(delegate(Collider x, Collider y)
		{
			int num2 = 0;
			string name = ((Object)x).name;
			string name2 = ((Object)y).name;
			return string.Compare(name, name2);
		});
		if (colliders != null)
		{
			Debug.Log((object)("====================场景内存在的碰撞器有：======================>>>" + colliders.Count));
		}
		if (colliders == null || colliders.Count <= 0)
		{
			return;
		}
		if (mLevelColliders == null)
		{
			mLevelColliders = new List<ISimShape>(colliders.Count);
		}
		for (int num = 0; num < colliders.Count; num++)
		{
			if (((Component)colliders[num]).gameObject.layer == 10)
			{
				ISimShape simShape = CreateFromCollider(colliders[num]);
				if (simShape != null)
				{
					mLevelColliders.Add(simShape);
				}
			}
		}
	}

	public ISimShape CreateFromCollider(Collider component)
	{
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		//IL_0029: Unknown result type (might be due to invalid IL or missing references)
		//IL_0040: Unknown result type (might be due to invalid IL or missing references)
		//IL_0046: Unknown result type (might be due to invalid IL or missing references)
		//IL_004b: Unknown result type (might be due to invalid IL or missing references)
		//IL_005b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0088: Unknown result type (might be due to invalid IL or missing references)
		//IL_008d: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e9: Unknown result type (might be due to invalid IL or missing references)
		//IL_0115: Unknown result type (might be due to invalid IL or missing references)
		//IL_0143: Unknown result type (might be due to invalid IL or missing references)
		//IL_014a: Unknown result type (might be due to invalid IL or missing references)
		//IL_014f: Unknown result type (might be due to invalid IL or missing references)
		//IL_015f: Unknown result type (might be due to invalid IL or missing references)
		ISimShape simShape = null;
		if (component is BoxCollider)
		{
			BoxCollider val = (BoxCollider)(object)((component is BoxCollider) ? component : null);
			simShape = new SimBox
			{
				Center = (Int3)val.center,
				Size = (Int3)val.size
			};
			simShape.UpdateWorldShape((Int3)(((Component)component).transform.position + val.center), (Int3)((Component)component).transform.forward);
		}
		else if (component is CapsuleCollider)
		{
			CapsuleCollider val2 = (CapsuleCollider)(object)((component is CapsuleCollider) ? component : null);
			SimSphere simSphere = new SimSphere();
			Vector3 center = val2.center;
			center.y -= val2.height * 0.5f;
			simSphere.Pos = (Int3)center;
			simSphere.Radius = ((Int)val2.radius).i;
			simShape = simSphere;
			simShape.UpdateWorldShape((Int3)(((Component)component).transform.position + center), (Int3)((Component)component).transform.forward);
		}
		else if (component is SphereCollider)
		{
			SphereCollider val3 = (SphereCollider)(object)((component is SphereCollider) ? component : null);
			simShape = new SimSphere
			{
				Pos = (Int3)val3.center,
				Radius = ((Int)val3.radius).i
			};
			simShape.UpdateWorldShape((Int3)(((Component)component).transform.position + val3.center), (Int3)((Component)component).transform.forward);
		}
		else
		{
			Debug.LogError((object)("逻辑层不支持此类碰撞器,请删除！~~~:" + ((Object)((Component)component).gameObject).name + ":" + (object)component));
		}
		if (simShape != null)
		{
			simShape.Layer = RoleType.Bunker;
		}
		return simShape;
	}

	public ISimShape CreateFromCollider(GameObject gameObject)
	{
		Collider component = gameObject.GetComponent<Collider>();
		if ((Object)(object)component == (Object)null)
		{
			return null;
		}
		return CreateFromCollider(component);
	}
}
