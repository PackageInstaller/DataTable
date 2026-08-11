using System;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class FriendItemData : ItemOptionBase
{
	private string icon;

	private string iconFrame;

	private string name;

	private string level;

	private string state;

	private Color stateColor;

	private Color textColor = Color.white;

	private float textAlpha;

	private float stateAlpha;

	private int energyState;

	private bool selected;

	private bool isOnLine;

	private SimpleCommand sendBtnClickCmd;

	private PlayerData friendData;

	public Action EnergyStateChanged;

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

	public string IconFrame
	{
		get
		{
			return iconFrame;
		}
		set
		{
			Set(ref iconFrame, value, "IconFrame");
		}
	}

	public string Name
	{
		get
		{
			return name;
		}
		set
		{
			Set(ref name, value, "Name");
		}
	}

	public string Level
	{
		get
		{
			return level;
		}
		set
		{
			Set(ref level, value, "Level");
		}
	}

	public string State
	{
		get
		{
			return state;
		}
		set
		{
			Set(ref state, value, "State");
		}
	}

	public Color StateColor
	{
		get
		{
			return stateColor;
		}
		set
		{
			Set(ref stateColor, new Color(value.r, value.g, value.b, stateAlpha), "StateColor");
		}
	}

	public float StateAlpha
	{
		get
		{
			return stateAlpha;
		}
		set
		{
			Set(ref stateAlpha, value, "StateAlpha");
			StateColor = new Color(stateColor.r, stateColor.g, stateColor.b, value);
		}
	}

	public Color TextColor
	{
		get
		{
			return textColor;
		}
		set
		{
			Set(ref textColor, new Color(value.r, value.g, value.b, textAlpha), "TextColor");
		}
	}

	public float TextAlpha
	{
		get
		{
			return textAlpha;
		}
		set
		{
			Set(ref textAlpha, value, "TextAlpha");
			TextColor = new Color(textColor.r, textColor.g, textColor.b, value);
		}
	}

	public int EnergyState
	{
		get
		{
			return energyState;
		}
		set
		{
			Set(ref energyState, value, "EnergyState");
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
		}
	}

	public bool IsOnLine
	{
		get
		{
			return isOnLine;
		}
		set
		{
			Set(ref isOnLine, value, "IsOnLine");
		}
	}

	public PlayerData FriendData => friendData;

	public SimpleCommand SendBtnClickCmd => sendBtnClickCmd;

	public FriendItemData()
	{
	}

	public FriendItemData(PlayerData playerData)
	{
		sendBtnClickCmd = new SimpleCommand(OnSendBtnClick);
		friendData = playerData;
		Icon = playerData.Icon;
		IconFrame = $"HeadAdorn{playerData.IconFrame}";
		Name = playerData.Name;
		Level = playerData.Level.ToString();
		if (playerData.EnergyReceiveState == 1)
		{
			EnergyState = 1;
		}
		else if (playerData.EnergySendState == 1)
		{
			EnergyState = 3;
		}
		else if (playerData.EnergySendState == 2)
		{
			EnergyState = 2;
		}
		IsOnLine = playerData.State != 4;
		UpdateStateColorAndAlpha();
	}

	public void RefreshEnergyState()
	{
		if (friendData != null)
		{
			if (friendData.EnergyReceiveState == 1)
			{
				EnergyState = 1;
			}
			else if (friendData.EnergySendState == 1)
			{
				EnergyState = 3;
			}
			else if (friendData.EnergySendState == 2)
			{
				EnergyState = 2;
			}
		}
	}

	public void SetSelected(bool s)
	{
		Selected = s;
		UpdateStateColorAndAlpha();
	}

	private void UpdateStateColorAndAlpha()
	{
		string htmlString = "#ffffff";
		string htmlString2 = "#ffffff";
		float num = 1f;
		float num2 = 1f;
		if (friendData.State == 1)
		{
			State = "在线";
			htmlString2 = (selected ? "#000000" : "#dad2cd");
			htmlString = "#55906c";
			num2 = 1f;
			num = 0.8f;
		}
		else if (friendData.State == 4)
		{
			State = "离线";
			htmlString2 = (selected ? "#000000" : "#ffffff");
			htmlString = (selected ? "#000000" : "#ffffff");
			num2 = (selected ? 1f : 0.2f);
			num = (selected ? 0.8f : 0.2f);
		}
		else if (friendData.State == 2)
		{
			State = "组队中";
			htmlString2 = (selected ? "#000000" : "#dad2cd");
			htmlString = "#c48359";
			num2 = 1f;
			num = 0.8f;
		}
		else if (friendData.State == 3)
		{
			State = "战斗中";
			htmlString2 = (selected ? "#000000" : "#dad2cd");
			htmlString = "#d77467";
			num2 = 1f;
			num = 0.8f;
		}
		else if (friendData.State == 5)
		{
			State = "结算中";
			htmlString2 = (selected ? "#000000" : "#dad2cd");
			htmlString = "#99806a";
			num2 = 1f;
			num = 0.8f;
		}
		ColorUtility.TryParseHtmlString(htmlString, out var color);
		ColorUtility.TryParseHtmlString(htmlString2, out var color2);
		StateAlpha = num;
		TextAlpha = num2;
		StateColor = color;
		TextColor = color2;
	}

	private async void OnSendBtnClick()
	{
		sendBtnClickCmd.Enabled = false;
		if (EnergyState == 1)
		{
			Loading loading = await Loading.Show();
			bool num = await Singleton<ServiceSystem>.Instance.GetService<ISocialService>().RequestGetFriendSendEnergy(friendData.Uid);
			loading.Dispose();
			if (num)
			{
				EnergyState = ((friendData.EnergySendState == 1) ? 3 : 2);
				EnergyStateChanged?.Invoke();
			}
			sendBtnClickCmd.Enabled = true;
		}
		else if (EnergyState == 2)
		{
			Loading loading = await Loading.Show();
			bool num2 = await Singleton<ServiceSystem>.Instance.GetService<ISocialService>().RequestSendFriendEnergy(friendData.Uid);
			loading.Dispose();
			if (num2)
			{
				EnergyState = 3;
				EnergyStateChanged?.Invoke();
			}
			sendBtnClickCmd.Enabled = true;
		}
		else
		{
			sendBtnClickCmd.Enabled = true;
		}
	}
}
