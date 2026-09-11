using System.Collections.Generic;
using Config;
using UnityEngine;

public class SimShapeProcessor
{
	public static ISimShape CreateFromCollider(GameObject gameObject)
	{
		//IL_002a: Unknown result type (might be due to invalid IL or missing references)
		//IL_003b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0067: Unknown result type (might be due to invalid IL or missing references)
		//IL_006c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0087: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c7: Unknown result type (might be due to invalid IL or missing references)
		Collider component = gameObject.GetComponent<Collider>();
		if ((Object)(object)component == (Object)null)
		{
			return null;
		}
		ISimShape result = null;
		if (component is BoxCollider)
		{
			BoxCollider val = (BoxCollider)(object)((component is BoxCollider) ? component : null);
			result = new SimBox
			{
				Center = (Int3)val.center,
				Size = (Int3)val.size
			};
		}
		else if (component is CapsuleCollider)
		{
			CapsuleCollider val2 = (CapsuleCollider)(object)((component is CapsuleCollider) ? component : null);
			SimSphere simSphere = new SimSphere();
			Vector3 center = val2.center;
			center.y -= val2.height * 0.5f;
			simSphere.Pos = (Int3)center;
			simSphere.Radius = ((Int)val2.radius).i;
			result = simSphere;
		}
		else if (component is SphereCollider)
		{
			SphereCollider val3 = (SphereCollider)(object)((component is SphereCollider) ? component : null);
			result = new SimSphere
			{
				Pos = (Int3)val3.center,
				Radius = ((Int)val3.radius).i
			};
		}
		return result;
	}

	public static SimBox CreateSimBox(int owner, Int3 center, Int3 size, Int3 forward, RoleType layer)
	{
		SimBox simBox = new SimBox
		{
			Center = center,
			Size = size,
			OwnerID = owner,
			Layer = layer
		};
		simBox.UpdateWorldShape(center, forward);
		return simBox;
	}

	public static SimSphere CreateSimSphere(int owner, Int3 center, Int radius, Int height, Int3 forward, RoleType layer)
	{
		SimSphere simSphere = new SimSphere();
		center.y -= (height * VFactor.half).i;
		simSphere.Pos = center;
		simSphere.Radius = radius.i;
		simSphere.OwnerID = owner;
		simSphere.UpdateWorldShape(center, forward);
		simSphere.Layer = layer;
		return simSphere;
	}

	public static bool Intersects(ISimShape lh, ISimShape rh)
	{
		bool result = false;
		if (lh != null && rh != null)
		{
			return lh.Intersects(rh);
		}
		return result;
	}

	public static bool EdgeIntersects(ISimShape lh, ISimShape rh)
	{
		bool result = false;
		if (lh != null && rh != null)
		{
			return lh.EdgeIntersects(rh);
		}
		return result;
	}

	public void HideShape(SimEntity simEntity, bool isHide)
	{
		if (!simEntity.hasEntityBlackboard)
		{
			return;
		}
		simEntity.entityBlackboard.var.mHide = isHide;
		List<ISimShape> list = FrameListPool<ISimShape>.Claim();
		GetAllShape(simEntity, list);
		for (int i = 0; i < list.Count; i++)
		{
			ISimShape simShape = list[i];
			if (simShape != null)
			{
				simShape.IsEnable = isHide;
			}
		}
		FrameListPool<ISimShape>.Release(list);
	}

	public static void UpdateShapeWorldPosition(SimEntity simEntity)
	{
		if (!simEntity.hasEntityShape)
		{
			return;
		}
		Int3 @int = Int3.zero;
		if (simEntity.entityShape.mOffset != Int3.zero)
		{
			@int = IntMath.TransformDirection(simEntity.entityPositon.mForward, simEntity.entityShape.mOffset);
		}
		simEntity.entityShape.mShape.UpdateWorldShape(simEntity.entityPositon.mPosition + @int, simEntity.entityPositon.mForward);
		if (simEntity.FindChildrenTag(SimEntity.Tag.MultiColliders, out var children))
		{
			for (int i = 0; i < children.Count; i++)
			{
				SimEntity simEntity2 = children[i];
				@int = Int3.zero;
				if (simEntity2.entityShape.mOffset != Int3.zero)
				{
					@int = IntMath.TransformDirection(simEntity.entityPositon.mForward, simEntity2.entityShape.mOffset);
				}
				simEntity2.entityShape.mShape.UpdateWorldShape(simEntity.entityPositon.mPosition + @int, simEntity.entityPositon.mForward);
			}
		}
		if (!simEntity.FindChildrenTag(SimEntity.Tag.Combination, out var children2))
		{
			return;
		}
		SimSphere simSphere = null;
		if (children2 == null)
		{
			return;
		}
		for (int j = 0; j < children2.Count; j++)
		{
			@int = IntMath.TransformDirection(simEntity.entityPositon.mForward, children2[j].entityBlackboard.var.LocalPositionOfCombination);
			children2[j].entityPositon.mPosition = simEntity.entityPositon.mPosition + @int;
			if (children2[j].entityShape.GetShape() is SimSphere simSphere2)
			{
				simSphere2.UpdateWorldShape(children2[j].entityPositon.mPosition, simEntity.entityPositon.mForward);
			}
		}
	}

	public static void UpdateShapeWorldPositionByConfig(SimContext simContext, SimEntity simEntity, ShapeInfo shapeInfo)
	{
		if (simEntity.hasEntityLocalPlayer)
		{
			return;
		}
		SimSphere simSphere = null;
		Int3 zero = Int3.zero;
		for (int i = 0; i < shapeInfo.ShapeItemInfoList.Count; i++)
		{
			ShapeItemInfo shapeItemInfo = shapeInfo.ShapeItemInfoList.get_Item(i);
			SimEntity simEntity2 = simEntity.FindChildAndSelf(SimEntity.Tag.MultiColliders, shapeItemInfo.ShapePartType);
			if (simEntity2 == null)
			{
				continue;
			}
			bool flag = shapeItemInfo.Enable;
			if (simEntity.hasEntityBlackboard)
			{
				flag = flag && !simEntity.entityBlackboard.var.mHide;
			}
			flag = flag && !simEntity2.entityShape.mShapePartInfo.hide;
			simEntity2.entityShape.SetEnable(flag);
			simEntity2.entityShape.mOffset = new Int3(shapeItemInfo.Offset.X, shapeItemInfo.Offset.Y, shapeItemInfo.Offset.Z);
			if (simEntity2.entityShape.GetShape() is SimSphere simSphere2)
			{
				zero = ((!(simEntity2.entityShape.mOffset != Int3.zero)) ? Int3.zero : IntMath.TransformDirection(simEntity.entityPositon.mForward, simEntity2.entityShape.mOffset));
				if (simSphere2.Radius != shapeItemInfo.Size)
				{
					simSphere2.Radius = shapeItemInfo.Size;
				}
				simSphere2.UpdateWorldShape(simEntity.entityPositon.mPosition + zero, simEntity.entityPositon.mForward);
			}
		}
		if (!simEntity.FindChildrenTag(SimEntity.Tag.Combination, out var children) || children == null)
		{
			return;
		}
		for (int j = 0; j < children.Count; j++)
		{
			zero = IntMath.TransformDirection(simEntity.entityPositon.mForward, children[j].entityBlackboard.var.LocalPositionOfCombination);
			children[j].entityPositon.mPosition = simEntity.entityPositon.mPosition + zero;
			if (children[j].entityShape.GetShape() is SimSphere simSphere3)
			{
				simSphere3.UpdateWorldShape(children[j].entityPositon.mPosition, simEntity.entityPositon.mForward);
			}
		}
	}

	public static ShapeInfo GetShapeInfo(int timelineID, int logicTime)
	{
		Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(timelineID);
		ShapeInfo shapeInfo = null;
		for (int i = 0; i < config.ShapeInfoList.Count; i++)
		{
			int start = shapeInfo.Start;
			int num = start + shapeInfo.Duration;
			if (logicTime >= start && logicTime <= num)
			{
				shapeInfo = config.ShapeInfoList.get_Item(i);
				break;
			}
		}
		return shapeInfo;
	}

	public static void GetAllShape(SimEntity simEntity, List<EntityShape> shapes)
	{
		if (simEntity.hasEntityLocalPlayer)
		{
			return;
		}
		if (simEntity.hasEntityShape && simEntity.entityShape.mShape.IsEnable)
		{
			shapes.Add(simEntity.entityShape);
		}
		if (!simEntity.FindChildrenTag(SimEntity.Tag.MultiColliders, out var children))
		{
			return;
		}
		for (int i = 0; i < children.Count; i++)
		{
			if (children[i].hasEntityShape && children[i].entityShape.mShape.IsEnable)
			{
				shapes.Add(children[i].entityShape);
			}
		}
	}

	public static void GetAllShape(SimEntity simEntity, List<ISimShape> shapes)
	{
		if (simEntity.hasEntityLocalPlayer)
		{
			return;
		}
		if (simEntity.hasEntityShape && simEntity.entityShape.mShape.IsEnable)
		{
			shapes.Add(simEntity.entityShape.mShape);
		}
		if (simEntity.FindChildrenTag(SimEntity.Tag.MultiColliders, out var children))
		{
			for (int i = 0; i < children.Count; i++)
			{
				if (children[i].hasEntityShape && children[i].entityShape.mShape.IsEnable)
				{
					shapes.Add(children[i].entityShape.mShape);
				}
			}
		}
		if (!simEntity.FindChildrenTag(SimEntity.Tag.Combination, out var children2))
		{
			return;
		}
		for (int j = 0; j < children2.Count; j++)
		{
			if (children2[j].hasEntityShape && children2[j].entityShape.mShape.IsEnable)
			{
				shapes.Add(children2[j].entityShape.mShape);
			}
		}
	}

	public static void GetAllShapeWithUnable(SimEntity simEntity, List<EntityShape> shapes)
	{
		if (simEntity.hasEntityLocalPlayer)
		{
			return;
		}
		if (simEntity.hasEntityShape)
		{
			shapes.Add(simEntity.entityShape);
		}
		if (!simEntity.FindChildrenTag(SimEntity.Tag.MultiColliders, out var children))
		{
			return;
		}
		for (int i = 0; i < children.Count; i++)
		{
			if (children[i].hasEntityShape)
			{
				shapes.Add(children[i].entityShape);
			}
		}
	}

	public static void GetAllShapeWithUnable(SimEntity simEntity, List<ISimShape> shapes)
	{
		if (simEntity.hasEntityLocalPlayer)
		{
			return;
		}
		if (simEntity.hasEntityShape)
		{
			shapes.Add(simEntity.entityShape.mShape);
		}
		if (simEntity.FindChildrenTag(SimEntity.Tag.MultiColliders, out var children))
		{
			for (int i = 0; i < children.Count; i++)
			{
				if (children[i].hasEntityShape)
				{
					shapes.Add(children[i].entityShape.mShape);
				}
			}
		}
		if (!simEntity.FindChildrenTag(SimEntity.Tag.Combination, out var children2))
		{
			return;
		}
		for (int j = 0; j < children2.Count; j++)
		{
			if (children2[j].hasEntityShape)
			{
				shapes.Add(children2[j].entityShape.mShape);
			}
		}
	}

	public static int GetShapePartType(SimContext simContext, ISimShape shape)
	{
		if (simContext != null)
		{
			SimEntity entityWithEntityID = simContext.GetEntityWithEntityID(shape.OwnerID);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityShape)
			{
				return entityWithEntityID.entityShape.GetPart();
			}
		}
		return 0;
	}

	public static void EnableShapes(SimEntity simEntity, bool show)
	{
		if (simEntity == null)
		{
			return;
		}
		if (simEntity.hasEntityShape)
		{
			simEntity.entityShape.SetEnable(show);
		}
		if (simEntity.mChildren == null)
		{
			return;
		}
		foreach (KeyValuePair<int, List<SimEntity>> mChild in simEntity.mChildren)
		{
			List<SimEntity> value = mChild.Value;
			if (value == null)
			{
				continue;
			}
			foreach (SimEntity item in value)
			{
				if (item.hasEntityShape)
				{
					item.entityShape.SetEnable(show);
				}
			}
		}
	}
}
