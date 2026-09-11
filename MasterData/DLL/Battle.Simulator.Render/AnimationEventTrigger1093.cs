using UnityEngine;

public class AnimationEventTrigger1093 : MonoBehaviour
{
	public GameObject[] Power;

	public void OnMegerPlayComplete()
	{
		if (Power != null)
		{
			for (int i = 0; i < Power.Length; i++)
			{
				Power[i].SetActive(value: false);
			}
			base.gameObject.SetActive(value: false);
		}
	}
}
