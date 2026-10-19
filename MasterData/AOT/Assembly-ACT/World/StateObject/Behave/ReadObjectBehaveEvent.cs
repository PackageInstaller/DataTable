using UnityEngine;

namespace World.StateObject.Behave;

[AddComponentMenu("ACT/StateObjectBehave/ReadObjectBehaveEvent")]
public class ReadObjectBehaveEvent : MonoBehaviour
{
	public GameObject highLightEffect;

	public Transform tipTransform;

	public void SetActiveEffect(bool value)
	{
		if (highLightEffect != null)
		{
			highLightEffect.SetActive(value);
		}
	}
}
