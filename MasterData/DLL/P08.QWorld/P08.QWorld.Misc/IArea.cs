using UnityEngine;

namespace P08.QWorld.Misc;

public interface IArea
{
	bool IsInArea(Vector3 localPos);
}
