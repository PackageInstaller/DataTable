#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Globalization;
using GameFramework;

namespace Ase;

public class AvatarItemViewModel : OptionBase
{
	private int state;

	private string icon;

	private int iconId;

	private int iconFrameId;

	private bool isSelect;

	private string desc;

	private int titleTimeLimitType;

	private string titleTimeLimitVal;

	public int State
	{
		get
		{
			return state;
		}
		private set
		{
			Set(ref state, value, "State");
		}
	}

	public string Icon
	{
		get
		{
			return icon;
		}
		set
		{
			Set(ref icon, value, "Icon");
		}
	}

	public int IconId => iconId;

	public int IconFrameId
	{
		get
		{
			return iconFrameId;
		}
		set
		{
			Set(ref iconFrameId, value, "IconFrameId");
		}
	}

	public bool IsSelect
	{
		get
		{
			return isSelect;
		}
		private set
		{
			Set(ref isSelect, value, "IsSelect");
		}
	}

	public int TitleTimeLimitType
	{
		get
		{
			return titleTimeLimitType;
		}
		private set
		{
			Set(ref titleTimeLimitType, value, "TitleTimeLimitType");
		}
	}

	public string TitleTimeLimitVal => titleTimeLimitVal;

	public string Desc => desc;

	public override void ItemOnClick(object obj)
	{
	}

	public AvatarItemViewModel()
	{
	}

	public AvatarItemViewModel(OptionBase parent, int iconId, int iconFrameId, string desc, int titleTimeLimitType, string titleTimeLimitVal)
	{
		base.parent = parent;
		this.iconId = iconId;
		icon = PlayerDataBase.GetIcon(iconId);
		this.iconFrameId = iconFrameId;
		this.desc = desc;
		this.titleTimeLimitType = titleTimeLimitType;
		this.titleTimeLimitVal = titleTimeLimitVal;
	}

	public string GetTimeLimitDesc(long left)
	{
		try
		{
			if (state == 0 && (titleTimeLimitType == 2 || titleTimeLimitType == 3) && left >= 0)
			{
				return "有效时间：" + Utility.DateTime.GetLeftDateHourExact(left, "dd\\天hh\\时mm\\分");
			}
			if (titleTimeLimitType == 2)
			{
				if (state != 0)
				{
					return "有效时间：" + titleTimeLimitVal + "天";
				}
			}
			else if (titleTimeLimitType == 3 && state != 0)
			{
				string format = "yyyy.MM.dd";
				CultureInfo invariantCulture = CultureInfo.InvariantCulture;
				DateTime dateTime = DateTime.ParseExact(titleTimeLimitVal, format, invariantCulture);
				string text = "yyyy年M月d日";
				string text2 = dateTime.ToString(text);
				return "有效至：" + text2;
			}
		}
		catch (Exception ex)
		{
			Log.Error("获取有效时间异常！" + titleTimeLimitVal + " " + ex.Message + " / " + ex.StackTrace);
		}
		return "";
	}

	public void OnSelect()
	{
		parent.ItemOnClick(this);
	}

	public void SetSelect(bool isSelect)
	{
		IsSelect = isSelect;
	}

	public void SetState(int state)
	{
		State = state;
	}

	public void SetIconId(int iconId)
	{
		this.iconId = iconId;
		Icon = PlayerDataBase.GetIcon(iconId);
	}
}
