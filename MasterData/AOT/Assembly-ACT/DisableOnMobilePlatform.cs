using UnityEngine;

public sealed class DisableOnMobilePlatform : MonoBehaviour
{
	private void Awake()
	{
		if (Application.isMobilePlatform)
		{
			gameObject.SetActive(value: false);
		}
	}
}
