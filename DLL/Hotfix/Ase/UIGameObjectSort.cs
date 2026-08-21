using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class UIGameObjectSort : MonoBehaviour
{
	public GameObject obj;

	public VerticalLayoutGroup verticalLayoutGroup;

	public void Sort()
	{
		for (int i = 0; i < obj.transform.childCount; i++)
		{
			SetObj(obj.transform.GetChild(i));
		}
		LayoutRebuilder.ForceRebuildLayoutImmediate(obj.transform.GetComponent<RectTransform>());
	}

	private void SetObj(Transform tsf)
	{
		if ((Object)(object)tsf.GetComponent<TextMeshProUGUI>() != null || tsf.GetComponent<Text>() != null)
		{
			LayoutRebuilder.ForceRebuildLayoutImmediate(tsf.GetComponent<RectTransform>());
		}
	}
}
