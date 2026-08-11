using UnityEngine;

namespace Ase;

public interface IMathTrigger
{
	GameObject Owner { get; }

	bool Dynamic { get; set; }

	Vector3 center { get; set; }

	Vector3 Position { get; set; }

	Quaternion Rotation { get; set; }

	Vector3 Scale { get; set; }

	bool Vaild { get; }

	bool Contains(Vector3 point);

	bool Intersects(Bounds bounds);

	Bounds Bounds();

	void RegisterToSystem();

	void UnregisterFromSystem();
}
