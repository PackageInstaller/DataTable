using System.Collections.Generic;

namespace UnityEngine.Rendering;

public interface IVolume
{
	bool isGlobal { get; set; }

	List<Collider> colliders { get; }
}
