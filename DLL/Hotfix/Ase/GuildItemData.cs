using UnityEngine;

namespace Ase;

public class GuildItemData : ItemOptionBase
{
	private bool selected;

	private string icon = "";

	private string name;

	private string memberCount;

	private string level;

	private string cycleActivity;

	private bool clickEnable = true;

	private Color textColorNormal;

	private Color textColorSelected;

	private GuildData guildData;

	protected Vector3 worldPosition;

	public Vector3 WorldPosition => worldPosition;

	public GuildData GuildData => guildData;

	public string Icon
	{
		get
		{
			return icon;
		}
		private set
		{
			Set(ref icon, value, "Icon");
		}
	}

	public bool Selected
	{
		get
		{
			return selected;
		}
		set
		{
			Set(ref selected, value, "Selected");
			RefreshTexts();
		}
	}

	public string Name
	{
		get
		{
			return name;
		}
		private set
		{
			Set(ref name, value, "Name");
		}
	}

	public string MemberCount
	{
		get
		{
			return memberCount;
		}
		private set
		{
			Set(ref memberCount, value, "MemberCount");
		}
	}

	public string Level
	{
		get
		{
			return level;
		}
		private set
		{
			Set(ref level, value, "Level");
		}
	}

	public string CycleActivity
	{
		get
		{
			return cycleActivity;
		}
		set
		{
			Set(ref cycleActivity, value, "CycleActivity");
		}
	}

	public bool ClickEnable
	{
		get
		{
			return clickEnable;
		}
		private set
		{
			Set(ref clickEnable, value, "ClickEnable");
		}
	}

	public GuildItemData()
	{
	}

	public GuildItemData(OptionBase parent)
	{
		base.parent = parent;
	}

	public GuildItemData(OptionBase parent, GuildData guildData, bool clickEnable = true)
	{
		base.parent = parent;
		RefreshData(guildData, clickEnable);
	}

	public void RefreshData(GuildData data, bool clickEnable = true)
	{
		guildData = data;
		ClickEnable = clickEnable;
		Icon = guildData.FlagIcon;
		RefreshTexts();
	}

	public void SetTextColor(Color normal, Color selected)
	{
		textColorNormal = normal;
		textColorSelected = selected;
		RefreshTexts();
	}

	public void OnItemClick()
	{
		parent?.ItemOnClick(this);
	}

	private void RefreshTexts()
	{
		if (guildData != null)
		{
			string text = ColorUtility.ToHtmlStringRGB(Selected ? textColorSelected : textColorNormal);
			Name = "<color=#" + text + ">" + guildData.Name + "</color>";
			MemberCount = $"<color=#{text}>{guildData.MemberCount}/{guildData.MaxMemberCount}</color>";
			Level = $"<color=#{text}>等级:{guildData.Level}</color>";
			CycleActivity = $"<color=#{text}>七日活跃:{guildData.WeeklyActivePoint}</color>";
		}
	}

	public void OnReportBtnClick(Transform transform)
	{
		worldPosition = transform.position;
		parent?.ItemOnClick(new OptionArg(this, "OpenReport"));
	}
}
