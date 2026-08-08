using System.Collections.Generic;
using UnityEngine;

namespace Services;

public interface ILevelColliderService
{
	List<ISimShape> mLevelColliders { get; set; }

	void ScanColliders(List<Collider> colliders);
}
