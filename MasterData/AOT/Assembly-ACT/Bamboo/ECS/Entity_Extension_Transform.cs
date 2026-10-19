using ACT.Battle;
using ACT.MultiPlayer;
using UnityEngine;

namespace Bamboo.ECS;

public static class Entity_Extension_Transform
{
	public static bool IsFaceLeft(this Entity entity)
	{
		return entity.GetFaceDir() == FaceDir.Left;
	}

	public static bool IsFaceRight(this Entity entity)
	{
		return entity.GetFaceDir() == FaceDir.Right;
	}

	public static bool IsFaceForward(this Entity entity)
	{
		return entity.GetFaceDir() == FaceDir.Forward;
	}

	public static bool IsFaceBack(this Entity entity)
	{
		return entity.GetFaceDir() == FaceDir.Back;
	}

	public static FaceDir GetFaceDir(this Entity entity)
	{
		if (!entity.TryGetCompTransform(out CompTransform component))
		{
			return FaceDir.None;
		}
		return component.FaceDir;
	}

	public static Quaternion GetFaceRotation(this Entity entity)
	{
		if (!entity.TryGetCompTransform(out CompTransform component))
		{
			return Quaternion.identity;
		}
		return component.FaceRotation;
	}

	public static void SetFaceLeft(this Entity entity, bool left)
	{
		entity.SetFaceDir((!left) ? FaceDir.Right : FaceDir.Left);
	}

	public static void SetCarrier(this Entity entity, Entity target, Transform transform, Vector3 offset, Transform center)
	{
		if (entity.TryGetCompTransform(out CompTransform component))
		{
			component.SetCarrier(target, transform, offset, center);
		}
	}
}
