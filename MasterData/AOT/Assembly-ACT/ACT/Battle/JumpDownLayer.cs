using UnityEngine;

namespace ACT.Battle;

[DisallowMultipleComponent]
[AddComponentMenu("ACT/Battle/JumpDownLayer")]
public class JumpDownLayer : MonoBehaviour
{
	public static bool Contains(Collider collider)
	{
		JumpDownLayer component;
		if (collider != null)
		{
			return collider.TryGetComponent<JumpDownLayer>(out component);
		}
		return false;
	}
}
