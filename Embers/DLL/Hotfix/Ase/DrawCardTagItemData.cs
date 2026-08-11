using UnityEngine;

namespace Ase;

public class DrawCardTagItemData : OptionBase
{
	private Color tagColor;

	private string tagName;

	public Color TagColor
	{
		get
		{
			return tagColor;
		}
		private set
		{
			Set(ref tagColor, value, "TagColor");
		}
	}

	public string TagName
	{
		get
		{
			return tagName;
		}
		private set
		{
			Set(ref tagName, value, "TagName");
		}
	}

	public DrawCardTagItemData(OptionBase parent, string tagName, string colorText)
	{
		base.parent = parent;
		this.tagName = tagName;
		tagColor = GetColor(colorText);
	}

	private Color GetColor(string colorText)
	{
		ColorUtility.TryParseHtmlString("#" + colorText, out var color);
		return color;
	}
}
