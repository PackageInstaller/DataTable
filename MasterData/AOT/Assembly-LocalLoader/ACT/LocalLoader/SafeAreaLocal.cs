using UnityEngine;

namespace ACT.LocalLoader;

public class SafeAreaLocal : MonoBehaviour
{
	private RectTransform _rectTransform;

	public void SetAnchors(float offectX, float offectY)
	{
		if (_rectTransform == null)
		{
			_rectTransform = GetComponent<RectTransform>();
		}
		_rectTransform.anchorMin = new Vector2(offectX, offectY);
		_rectTransform.anchorMax = new Vector2(1f - offectX, 1f - offectY);
	}
}
