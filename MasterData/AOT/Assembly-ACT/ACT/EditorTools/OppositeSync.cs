using UnityEngine;

namespace ACT.EditorTools;

[ExecuteInEditMode]
public class OppositeSync : MonoBehaviour
{
	public Transform target;

	private void Update()
	{
		Vector3 position = target.position;
		position.x = 0f - position.x;
		transform.position = position;
		Vector3 eulerAngles = target.rotation.eulerAngles;
		eulerAngles.y = 0f - eulerAngles.y;
		transform.rotation = Quaternion.Euler(eulerAngles);
	}
}
