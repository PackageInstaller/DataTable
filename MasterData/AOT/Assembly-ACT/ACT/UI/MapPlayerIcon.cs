using ACT.Utility;
using UnityEngine;

namespace ACT.UI;

public class MapPlayerIcon : MonoBehaviour
{
	private float fixedScale;

	private RectTransform areaGrid;

	public void SetPos(Vector2 pos)
	{
		(transform as RectTransform).anchoredPosition = pos;
	}

	public void SetActive(bool active)
	{
		if (!InMapGridRoot(areaGrid, transform.position))
		{
			gameObject.SetActive(value: false);
		}
		else
		{
			gameObject.SetActive(active);
		}
	}

	public void SetFixedScale(float fixedScale, RectTransform grid)
	{
		areaGrid = grid;
		this.fixedScale = fixedScale;
	}

	public void UpdateScale(float mapScale)
	{
		transform.localScale = Vector3.one * (fixedScale / mapScale);
	}

	private bool InMapGridRoot(RectTransform targetGridRoot, Vector3 worldPosition)
	{
		if (targetGridRoot == null)
		{
			return false;
		}
		Vector2 screenPoint = RectTransformUtility.WorldToScreenPoint(GameUtility.uiCamera, worldPosition);
		return RectTransformUtility.RectangleContainsScreenPoint(targetGridRoot, screenPoint, GameUtility.uiCamera);
	}
}
