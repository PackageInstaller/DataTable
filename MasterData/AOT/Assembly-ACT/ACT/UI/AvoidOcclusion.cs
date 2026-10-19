using UnityEngine;

namespace ACT.UI;

public class AvoidOcclusion : MonoBehaviour
{
	public GameObject occlusionPad;

	private void OnEnable()
	{
		occlusionPad.gameObject.SetActive(value: true);
	}

	private void OnDisable()
	{
		occlusionPad.gameObject.SetActive(value: false);
	}
}
