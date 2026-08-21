#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Globalization;
using GameFramework;

namespace Ase;

public class TitleItemViewModel : OptionBase
{
	private int titleId;

	private int titleTimeLimitType;

	private string titleTimeLimitVal;

	private string titleIcon;

	private bool isLock;

	private bool isSelect;

	private string desc;

	public int TitleId
	{
		get
		{
			return titleId;
		}
		private set
		{
			Set(ref titleId, value, "TitleId");
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

	public string TitleIcon
	{
		get
		{
			return titleIcon;
		}
		private set
		{
			Set(ref titleIcon, value, "TitleIcon");
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

	public bool IsLock
	{
		get
		{
			return isLock;
		}
		private set
		{
			Set(ref isLock, value, "IsLock");
		}
	}

	public string Desc => desc;

	public override void ItemOnClick(object obj)
	{
	}

	public TitleItemViewModel()
	{
	}

	public TitleItemViewModel(OptionBase parent, int titleId, int titleTimeLimitType, string titleTimeLimitVal, string desc, string titleIcon)
	{
		base.parent = parent;
		this.titleId = titleId;
		this.titleIcon = titleIcon;
		this.titleTimeLimitType = titleTimeLimitType;
		this.titleTimeLimitVal = titleTimeLimitVal;
		this.desc = desc;
	}

	public void OnSelect()
	{
		parent.ItemOnClick(this);
	}

	public void SetSelect(bool isSelect)
	{
		IsSelect = isSelect;
	}

	public void SetLock(bool isLock)
	{
		IsLock = isLock;
	}

	public string GetTimeLimitDesc(long left)
	{
		try
		{
			if (!isLock && (titleTimeLimitType == 2 || titleTimeLimitType == 3) && left >= 0)
			{
				return "有效时间：" + Utility.DateTime.GetLeftDateHourExact(left, "dd\\天hh\\时mm\\分");
			}
			if (titleTimeLimitType == 2)
			{
				if (isLock)
				{
					return "有效时间：" + titleTimeLimitVal + "天";
				}
			}
			else if (titleTimeLimitType == 3 && isLock)
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
}
