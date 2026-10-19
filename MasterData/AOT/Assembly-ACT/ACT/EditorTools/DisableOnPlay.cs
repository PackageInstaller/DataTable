using UnityEngine;

namespace ACT.EditorTools;

public class DisableOnPlay : MonoBehaviour
{
	private void Awake()
	{
		gameObject.SetActive(value: false);
	}
}
