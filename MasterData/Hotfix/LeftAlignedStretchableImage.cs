using UnityEngine;

public class LeftAlignedStretchableImage : MonoBehaviour
{
	public string targetParentName = "----SafeAreaRoot----";

	private RectTransform rectTransform;

	private float originalWidth;

	private float safeAreaRootWidth;

	private float uiOriginalX = 2160f;

	private void Start()
	{
		Transform current = base.transform;
		Transform transform = FindParentWithName(current, targetParentName);
		if (transform != null)
		{
			safeAreaRootWidth = transform.GetComponent<RectTransform>().sizeDelta.x;
		}
		else
		{
			safeAreaRootWidth = 2160f;
		}
		rectTransform = GetComponent<RectTransform>();
		originalWidth = rectTransform.sizeDelta.x;
		float num = safeAreaRootWidth - uiOriginalX;
		rectTransform.sizeDelta = new Vector2(originalWidth + num / 2f, rectTransform.sizeDelta.y);
		int left = (int)num / 2;
		NovaAPI.SetLayoutGroupPadding(base.transform.parent.gameObject, left, 0, 0, 0);
	}

	private Transform FindParentWithName(Transform current, string name)
	{
		if (current == null)
		{
			return null;
		}
		if (current.parent != null)
		{
			if (current.parent.name == name)
			{
				return current.parent;
			}
			return FindParentWithName(current.parent, name);
		}
		return null;
	}
}
