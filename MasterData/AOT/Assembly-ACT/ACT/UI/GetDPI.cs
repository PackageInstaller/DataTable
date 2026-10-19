using UnityEngine;
using UnityEngine.Device;
using UnityEngine.Localization.Components;
using UnityEngine.Localization.SmartFormat.PersistentVariables;

namespace ACT.UI;

public class GetDPI : MonoBehaviour
{
	public LocalizeStringEvent text;

	public async void UpDateText(float selected)
	{
		float num = 0.5f + 0.05f * selected;
		(text.StringReference["0"] as IntVariable).Value = (int)((float)UnityEngine.Device.Screen.width * num);
		(text.StringReference["1"] as IntVariable).Value = (int)((float)UnityEngine.Device.Screen.height * num);
	}
}
