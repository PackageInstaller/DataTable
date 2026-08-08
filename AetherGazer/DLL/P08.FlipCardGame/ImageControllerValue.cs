using System;
using UnityEngine;
using UnityEngine.UI;

[Serializable]
public class ImageControllerValue
{
	[SerializeField]
	public Sprite sprite;

	[SerializeField]
	public float[] color;

	[SerializeField]
	public Color imageColor;

	[SerializeField]
	public Material material;

	public static bool CopyFromComponent(NewControllerValue value, Component target)
	{
		value.controllerProperty = ControllerProperty.Image;
		Image image = target as Image;
		value.objs = new UnityEngine.Object[2];
		if ((value.flag & 1) == 0)
		{
			value.objs[0] = image.sprite;
		}
		if ((value.flag & 2) == 0)
		{
			value.floatValues = new float[4]
			{
				image.color.r,
				image.color.g,
				image.color.b,
				image.color.a
			};
		}
		if ((value.flag & 4) == 0)
		{
			Material material = ((!("Default-UI" != image.material.name)) ? null : image.material);
			value.objs[1] = material;
		}
		return true;
	}

	public static bool PasteTo(NewControllerValue value, Component target, bool isTween, float during, LeanTweenType ease)
	{
		Image image = target as Image;
		if ((value.flag & 1) == 0)
		{
			Sprite sprite = value.objs[0] as Sprite;
			image.sprite = sprite;
		}
		if ((value.flag & 2) == 0)
		{
			Color to = new Color(value.floatValues[0], value.floatValues[1], value.floatValues[2], value.floatValues[3]);
			if (isTween)
			{
				LeanTween.value(image.gameObject, image.color, to, during).setEase(ease).setOnUpdate(delegate(Color c)
				{
					image.color = c;
				});
			}
			else
			{
				image.color = to;
			}
		}
		if ((value.flag & 4) == 0)
		{
			Material material = value.objs[1] as Material;
			image.material = material;
		}
		return true;
	}

	public static bool IsEqualTo(NewControllerValue value, Component target)
	{
		Sprite sprite = value.objs[0] as Sprite;
		bool num = (value.flag & 1) != 0 || sprite == target.GetComponent<Image>().sprite;
		Color color = target.GetComponent<Image>().color;
		float[] floatValues = value.floatValues;
		bool flag = (value.flag & 2) != 0 || (Math.Abs(color.r - floatValues[0]) < 0.0001f && Math.Abs(color.g - floatValues[1]) < 0.0001f && Math.Abs(color.b - floatValues[2]) < 0.0001f && Math.Abs(color.a - floatValues[3]) < 0.0001f);
		Material a = value.objs[1] as Material;
		bool flag2 = (value.flag & 4) != 0 || IsMaterialOK(a, target.GetComponent<Image>().material);
		return num & flag & flag2;
	}

	private static bool IsMaterialOK(Material a, Material b)
	{
		if (a == b)
		{
			return true;
		}
		if (a == null && b != null && (b.name.Equals("Default-UI") || b.name.Equals("Default UI Material")))
		{
			return true;
		}
		if (b == null && a != null && (a.name.Equals("Default-UI") || a.name.Equals("Default UI Material")))
		{
			return true;
		}
		return false;
	}
}
