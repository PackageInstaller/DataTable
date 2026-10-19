using ACT.Battle;
using TMPro;
using UnityEngine;

public class FovMonitor : MonoBehaviour
{
	public TextMeshProUGUI fovValue;

	public TextMeshProUGUI fovScale;

	private void Update()
	{
		if (Camera.main != null)
		{
			fovValue.text = Camera.main.fieldOfView.ToString();
		}
		if (CinemachineDynamicFOVBrain.Instance != null)
		{
			fovScale.text = CinemachineDynamicFOVBrain.FovScaler.ToString();
		}
	}
}
