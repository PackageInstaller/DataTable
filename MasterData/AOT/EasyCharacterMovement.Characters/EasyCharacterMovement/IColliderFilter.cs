using UnityEngine;

namespace EasyCharacterMovement;

public interface IColliderFilter
{
	bool Filter(Collider otherCollider);
}
