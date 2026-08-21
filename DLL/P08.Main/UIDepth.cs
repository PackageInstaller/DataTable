using UnityEngine;
using UnityEngine.UI;

public class UIDepth : MonoBehaviour
{
	public int order;

	public bool isUI = true;

	public bool raycast;

	private void Start()
	{
		if (isUI)
		{
			Canvas canvas = GetComponent<Canvas>();
			if (canvas == null)
			{
				canvas = base.gameObject.AddComponent<Canvas>();
			}
			canvas.overrideSorting = true;
			canvas.sortingOrder = order;
			if (raycast)
			{
				base.gameObject.AddComponent<GraphicRaycaster>();
			}
		}
		else
		{
			Renderer[] componentsInChildren = GetComponentsInChildren<Renderer>();
			for (int i = 0; i < componentsInChildren.Length; i++)
			{
				componentsInChildren[i].sortingOrder = order;
			}
		}
	}
}
