using UnityEngine;

namespace Ase;

public interface IMoverController
{
	void OnInit(object data = null);

	void OnUpdate(float deltaTime);

	void UpdateMovement(out Vector3 goalPosition, out Quaternion goalRotation, float deltaTime);
}
