using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI.ViewComponent;

public class FeatureBlockCheckerAOT : MonoBehaviour
{
	public int systemType;

	public void Awake()
	{
		if (!LuminApplication.FeatureIsBlocked(systemType))
		{
			return;
		}
		Button component = GetComponent<Button>();
		if ((object)component != null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log($"Button disabled by GM. System id {systemType}");
			}
			component.interactable = false;
		}
		else
		{
			gameObject.SetActive(value: false);
		}
	}
}
