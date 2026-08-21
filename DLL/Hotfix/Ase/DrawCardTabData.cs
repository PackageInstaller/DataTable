using UnityEngine;

namespace Ase;

public class DrawCardTabData : OptionBase
{
	private bool isSelected;

	public DrawCardPoolInfo DrawCardPoolInfo;

	private string normalIcon;

	private string selectedIcon;

	private string tag;

	private Color tagColor;

	private bool redPoint;

	public bool IsSelected
	{
		get
		{
			return isSelected;
		}
		private set
		{
			Set(ref isSelected, value, "IsSelected");
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

	public string NormalIcon => normalIcon;

	public string SelectedIcon => selectedIcon;

	public string Tag => tag;

	public Color TagColor => tagColor;

	public DrawCardTabData(OptionBase parent, DrawCardPoolInfo drawCardPoolInfo)
	{
		base.parent = parent;
		DrawCardPoolInfo = drawCardPoolInfo;
		normalIcon = drawCardPoolInfo.NormalIcon;
		selectedIcon = drawCardPoolInfo.SelectedIcon;
		tag = drawCardPoolInfo.Tag;
		ColorUtility.TryParseHtmlString(drawCardPoolInfo.TagColor, out var color);
		tagColor = color;
	}

	public void ItemOnclick()
	{
		RedPointOnClick();
		parent?.ItemOnClick(this);
	}

	public void RedPointOnClick()
	{
		if (RedPoint)
		{
			RedPoint = false;
			Singleton<ServiceSystem>.Instance.GetService<IDrawCardService>().SaveRedPoint(DrawCardPoolInfo.Id);
		}
	}

	public void ChangeSelected(bool value)
	{
		IsSelected = value;
	}
}
