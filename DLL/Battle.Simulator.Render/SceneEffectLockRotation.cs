using UnityEngine;

public class SceneEffectLockRotation : MonoBehaviour
{
	private void LateUpdate()
	{
		if (base.transform.rotation != Quaternion.identity)
		{
			base.transform.rotation = Quaternion.identity;
		}
	}
}
