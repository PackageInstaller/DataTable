using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class MaskCircleChange : UIBehaviour
{
	public RectTransform maskTransform;

	[SerializeField]
	private bool isCounterclockwise;

	public void ChangeMaskCircle(float angle)
	{
		maskTransform.localRotation = Quaternion.Euler(0f, 0f, isCounterclockwise ? (angle * -1f) : angle);
	}
}
