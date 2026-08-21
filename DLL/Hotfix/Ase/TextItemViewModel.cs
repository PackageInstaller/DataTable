using UnityEngine;

namespace Ase;

public class TextItemViewModel : OptionBase
{
	private string text1;

	private string text2;

	private Color colorType;

	private int active;

	public int ActiveState
	{
		get
		{
			return active;
		}
		set
		{
			active = value;
		}
	}

	public string Text1
	{
		get
		{
			return text1;
		}
		set
		{
			Set(ref text1, value, "Text1");
		}
	}

	public string Text2
	{
		get
		{
			return text2;
		}
		set
		{
			Set(ref text2, value, "Text2");
		}
	}

	public Color ColorType
	{
		get
		{
			return colorType;
		}
		set
		{
			Set(ref colorType, value, "ColorType");
		}
	}

	public override void ItemOnClick(object obj)
	{
	}

	public TextItemViewModel()
	{
	}

	public TextItemViewModel(OptionBase parent)
	{
		base.parent = parent;
	}
}
