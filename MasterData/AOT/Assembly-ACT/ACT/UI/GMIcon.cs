using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class GMIcon : LuminSerializedMonoBehaviour
{
	public Image image;

	public TextMeshProUGUI text;

	public Vector3 pos;

	public Dictionary<string, Sprite> type2Sprite = new Dictionary<string, Sprite>();

	public void Init(string type)
	{
		if (type2Sprite.TryGetValue(type, out var value))
		{
			image.sprite = value;
			text.text = type;
		}
	}

	public void SetPos(Vector2 pos)
	{
		(transform as RectTransform).anchoredPosition = pos;
	}

	public void LogPos()
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"{text.text} 图标位置 {pos}");
		}
	}
}
