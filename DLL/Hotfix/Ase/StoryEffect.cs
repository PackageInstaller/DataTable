using UnityEngine;

namespace Ase;

public class StoryEffect : MonoBehaviour
{
	private RectTransform rectTransform;

	public ParticleSystem[] particleSystems;

	public RectTransform RectTransform => rectTransform ?? (rectTransform = GetComponent<RectTransform>());

	public void SetSpeed(float speed)
	{
		//IL_001f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0024: Unknown result type (might be due to invalid IL or missing references)
		if (particleSystems != null && particleSystems.Length != 0)
		{
			ParticleSystem[] array = particleSystems;
			for (int i = 0; i < array.Length; i++)
			{
				MainModule main = array[i].main;
				((MainModule)(ref main)).simulationSpeed = speed;
			}
		}
	}

	public void SetActive(bool active)
	{
		base.gameObject.SetActive(active);
	}
}
