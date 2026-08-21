using UnityEngine;
using UnityEngine.UI;

namespace BloodCard;

public class ShaderCode : MonoBehaviour
{
	private Image image;

	private Material m;

	private CardVisual visual;

	private void Start()
	{
		image = GetComponent<Image>();
		m = new Material(image.material);
		image.material = m;
		visual = GetComponentInParent<CardVisual>();
		string[] array = new string[4] { "REGULAR", "POLYCHROME", "REGULAR", "NEGATIVE" };
		for (int i = 0; i < image.material.enabledKeywords.Length; i++)
		{
			image.material.DisableKeyword(in image.material.enabledKeywords[i]);
		}
		image.material.EnableKeyword("_EDITION_" + array[Random.Range(0, array.Length)]);
	}

	private void Update()
	{
		Vector3 eulerAngles = base.transform.parent.localRotation.eulerAngles;
		float x = eulerAngles.x;
		float y = eulerAngles.y;
		x = ClampAngle(x, -90f, 90f);
		y = ClampAngle(y, -90f, 90f);
		m.SetVector("_Rotation", new Vector2(x.Remap(-20f, 20f, -0.5f, 0.5f), y.Remap(-20f, 20f, -0.5f, 0.5f)));
	}

	private float ClampAngle(float angle, float min, float max)
	{
		if (angle < -180f)
		{
			angle += 360f;
		}
		if (angle > 180f)
		{
			angle -= 360f;
		}
		return Mathf.Clamp(angle, min, max);
	}
}
