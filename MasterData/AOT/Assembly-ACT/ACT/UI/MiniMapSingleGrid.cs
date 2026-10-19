using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class MiniMapSingleGrid : MonoBehaviour
{
	public Image image;

	public void Init(RectTransform parent, float sideLength, Vector2 anchoredPos, Sprite sprite, Material mat)
	{
		transform.SetParent(parent);
		(transform as RectTransform).sizeDelta = Vector2.one * sideLength;
		RectTransform obj = transform as RectTransform;
		obj.anchoredPosition3D = Vector3.zero;
		obj.anchoredPosition = anchoredPos;
		obj.localScale = Vector3.one;
		image.sprite = sprite;
		image.material = mat;
	}

	public void UnInit()
	{
		image.sprite = null;
	}
}
