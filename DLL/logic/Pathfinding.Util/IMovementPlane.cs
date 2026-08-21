using UnityEngine;

namespace Pathfinding.Util;

public interface IMovementPlane
{
	Vector2 ToPlane(Vector3 p);

	Vector2 ToPlane(Vector3 p, out float elevation);

	Vector3 ToWorld(Vector2 p, float elevation = 0f);

	Int2 ToPlane(Int3 p);

	Int2 ToPlane(Int3 p, out Int elevation);
}
