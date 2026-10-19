using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class BattleArrowGroup : MonoBehaviour
{
	public enum ArrowType
	{
		Monster,
		Apc
	}

	public CanvasGroup canvasGroup;

	public CanvasGroup multiGroup;

	public CanvasGroup oneGroup;

	public TextMeshProUGUI foldNum;

	public Transform arrowTransform;

	public Image arrowImage;

	public Image multiArrowImage;

	public Sprite monsterArrowSprite;

	public Sprite apcArrowSprite;

	[NonSerialized]
	public float angle;

	public float AngleFromOrigin()
	{
		angle = Mathf.Atan2(transform.position.y, transform.position.x) * 180f / MathF.PI;
		if (angle < 0f)
		{
			angle = 360f + angle;
		}
		return angle;
	}

	public void ArrowAngleReset()
	{
		arrowTransform.rotation = Quaternion.identity;
	}

	public void SetType(ArrowType arrowType)
	{
		switch (arrowType)
		{
		case ArrowType.Monster:
			arrowImage.sprite = monsterArrowSprite;
			multiArrowImage.sprite = monsterArrowSprite;
			break;
		case ArrowType.Apc:
			arrowImage.sprite = apcArrowSprite;
			multiArrowImage.sprite = apcArrowSprite;
			break;
		default:
			throw new ArgumentOutOfRangeException("arrowType", arrowType, null);
		}
	}
}
