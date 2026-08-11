using UnityEngine;

namespace Ase;

public interface IMathTriggerable
{
	bool IsActor { get; }

	GameObject Owner { get; }

	Vector3 Position { get; }

	Bounds Bounds();

	void RegisterAsTriggerable();

	void UnregisterAsTriggerable();
}
