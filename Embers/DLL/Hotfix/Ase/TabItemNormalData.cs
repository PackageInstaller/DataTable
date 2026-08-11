using UnityEngine;

namespace Ase;

public class TabItemNormalData : OptionBase
{
	private bool isSelected;

	private string img;

	private int id;

	private string text;

	private bool isShow;

	private bool canOnClick;

	private bool redPoint;

	private Color color;

	private string rarityImg;

	private string markName;

	public string Img
	{
		get
		{
			return img;
		}
		set
		{
			Set(ref img, value, "Img");
		}
	}

	public int ID => id;

	public bool IsSelected
	{
		get
		{
			return isSelected;
		}
		set
		{
			Set(ref isSelected, value, "IsSelected");
		}
	}

	public string Text
	{
		get
		{
			return text;
		}
		set
		{
			Set(ref text, value, "Text");
		}
	}

	public string RarityImg
	{
		get
		{
			return rarityImg;
		}
		set
		{
			Set(ref rarityImg, value, "RarityImg");
		}
	}

	public bool IsShow
	{
		get
		{
			return isShow;
		}
		set
		{
			Set(ref isShow, value, "IsShow");
		}
	}

	public bool CanOnClick
	{
		get
		{
			return canOnClick;
		}
		private set
		{
			Set(ref canOnClick, value, "CanOnClick");
		}
	}

	public bool RedPoint
	{
		get
		{
			return redPoint;
		}
		set
		{
			Set(ref redPoint, value, "RedPoint");
		}
	}

	public string MarkName
	{
		get
		{
			return markName;
		}
		set
		{
			Set(ref markName, value, "MarkName");
		}
	}

	public Color Color
	{
		get
		{
			return color;
		}
		set
		{
			Set(ref color, value, "Color");
		}
	}

	public TabItemNormalData()
	{
	}

	public TabItemNormalData(OptionBase parent, string img, int id = 0, bool isSelected = false, string text = "", string rarityImg = "")
	{
		base.parent = parent;
		Img = img;
		this.id = id;
		this.isSelected = isSelected;
		this.text = text.Replace("\\n", "\n");
		isShow = true;
		canOnClick = true;
		this.rarityImg = rarityImg;
	}

	public void SetCanOnClick(bool value)
	{
		CanOnClick = value;
	}

	public TabItemNormalData(string text, int id = 0, OptionBase parent = null)
	{
		this.text = text.Replace("\\n", "\n");
		this.id = id;
		isShow = true;
		base.parent = parent;
	}

	public void SetSelected(bool value)
	{
		IsSelected = value;
	}

	public void SetColor(string colorText)
	{
		ColorUtility.TryParseHtmlString(colorText, out var color);
		Color = color;
	}

	public void ItemOnclick()
	{
		parent?.ItemOnClick(this);
	}
}
