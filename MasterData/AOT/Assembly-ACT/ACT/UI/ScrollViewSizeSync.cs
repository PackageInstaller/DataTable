using UnityEngine;

namespace ACT.UI;

public class ScrollViewSizeSync : MonoBehaviour
{
	[SerializeField]
	private RectTransform maxSizeTarget;

	[SerializeField]
	private RectTransform contentTarget;

	private RectTransform _trans;

	private int _sizeX = -1;

	private int _sizeY = -1;

	private void Start()
	{
		_trans = GetComponent<RectTransform>();
	}

	private void LateUpdate()
	{
		Vector2 size = maxSizeTarget.rect.size;
		Vector2 size2 = contentTarget.rect.size;
		int num = Mathf.CeilToInt(Mathf.Min(size.x, size2.x));
		int num2 = Mathf.CeilToInt(Mathf.Min(size.y, size2.y));
		if (_sizeX != num || _sizeY != num2)
		{
			_sizeX = num;
			_sizeY = num2;
			_trans.sizeDelta = new Vector2(num, num2);
		}
	}
}
