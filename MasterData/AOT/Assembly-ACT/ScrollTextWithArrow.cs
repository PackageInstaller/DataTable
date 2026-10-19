using ACT.UI;
using UnityEngine;
using UnityEngine.UI;

public class ScrollTextWithArrow : MonoBehaviour
{
	public ScrollRect scrollRect;

	public GameObject downArrow;

	public ReadableView parentView;

	private void Update()
	{
		if (!(parentView == null) && parentView.rightStickCanScroll)
		{
			float verticalNormalizedPosition = scrollRect.verticalNormalizedPosition;
			downArrow.SetActive(verticalNormalizedPosition > 0.01f);
		}
	}
}
