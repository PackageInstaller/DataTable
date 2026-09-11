using UnityEngine;

namespace Pathfinding.Util;

public interface ITransform
{
	Vector3 Transform(Vector3 position);

	Vector3 InverseTransform(Vector3 position);
}
