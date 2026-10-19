using ACT.Utility;
using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(Image))]
public class ImageScalerShrink : MonoBehaviour
{
	public Vector2 referenceResolution = new Vector2(2340f, 1080f);

	public float matchWidthOrHeight = 0.5f;

	private RectTransform rectTransform;

	private float screenWidth;

	private float screenHeight;

	private void Start()
	{
		rectTransform = GetComponent<RectTransform>();
		ApplyScale();
	}

	private void Update()
	{
		if (screenWidth != GameUtility.uiCanvas.GetComponent<RectTransform>().sizeDelta.x || screenHeight != GameUtility.uiCanvas.GetComponent<RectTransform>().sizeDelta.y)
		{
			ApplyScale();
		}
	}

	private void ApplyScale()
	{
		screenWidth = GameUtility.uiCanvas.GetComponent<RectTransform>().sizeDelta.x;
		screenHeight = GameUtility.uiCanvas.GetComponent<RectTransform>().sizeDelta.y;
		_ = GameUtility.uiCanvas.GetComponent<RectTransform>().sizeDelta;
		_ = GameUtility.uiCanvas.GetComponent<RectTransform>().sizeDelta;
		float num = screenWidth / referenceResolution.x;
		float num2 = screenHeight / referenceResolution.y;
		float num3 = ((num > num2) ? num : num2);
		rectTransform.localScale = Vector3.one * num3;
	}
}
