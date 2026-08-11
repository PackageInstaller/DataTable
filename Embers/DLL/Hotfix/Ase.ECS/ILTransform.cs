using UnityEngine;

namespace Ase.ECS;

public interface ILTransform
{
	Vector3 position { get; set; }

	Vector3 localScale { get; set; }

	Quaternion rotation { get; set; }

	Vector3 eulerAngles { get; set; }
}
