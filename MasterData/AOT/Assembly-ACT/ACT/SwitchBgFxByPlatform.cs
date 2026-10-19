using UnityEngine;

namespace ACT;

public class SwitchBgFxByPlatform : MonoBehaviour
{
	public GameObject PcFx;

	private void OnEnable()
	{
		if ((bool)PcFx)
		{
			PcFx.SetActive(value: false);
		}
	}
}
