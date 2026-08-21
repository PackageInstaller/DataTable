using System;
using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class ChatBubbleSetViewModel : OptionBase
{
	private List<ChatBubbleItemData> _bubbleItemDataList = new List<ChatBubbleItemData>();

	private RoleDecorateData _curSelectBubbleData;

	private bool _haveExpireTime;

	private string _expireTimeText;

	private string _bubbleName;

	private string _bubbleDesc;

	private Color _contentColor1 = Color.white;

	private Color _contentColor2 = Color.white;

	private string _bubbleContent;

	private string _btnText;

	private bool _btnApplyMask;

	private bool _showBtn;

	private InteractionRequest _refreshBubblePrefabRst = new InteractionRequest();

	private SimpleCommand _applyCmd;

	public List<ChatBubbleItemData> BubbleItemDataList => _bubbleItemDataList;

	public RoleDecorateData CurSelectBubbleData
	{
		get
		{
			return _curSelectBubbleData;
		}
		set
		{
			Set(ref _curSelectBubbleData, value, "CurSelectBubbleData");
		}
	}

	public bool HaveExpireTime
	{
		get
		{
			return _haveExpireTime;
		}
		set
		{
			Set(ref _haveExpireTime, value, "HaveExpireTime");
		}
	}

	public string ExpireTimeText
	{
		get
		{
			return _expireTimeText;
		}
		set
		{
			Set(ref _expireTimeText, value, "ExpireTimeText");
		}
	}

	public string BubbleName
	{
		get
		{
			return _bubbleName;
		}
		set
		{
			Set(ref _bubbleName, value, "BubbleName");
		}
	}

	public string BubbleDesc
	{
		get
		{
			return _bubbleDesc;
		}
		set
		{
			Set(ref _bubbleDesc, value, "BubbleDesc");
		}
	}

	public Color ContentColor1
	{
		get
		{
			return _contentColor1;
		}
		set
		{
			Set(ref _contentColor1, value, "ContentColor1");
		}
	}

	public Color ContentColor2
	{
		get
		{
			return _contentColor2;
		}
		set
		{
			Set(ref _contentColor2, value, "ContentColor2");
		}
	}

	public string BubbleContent
	{
		get
		{
			return _bubbleContent;
		}
		set
		{
			Set(ref _bubbleContent, value, "BubbleContent");
		}
	}

	public string BtnText
	{
		get
		{
			return _btnText;
		}
		set
		{
			Set(ref _btnText, value, "BtnText");
		}
	}

	public bool BtnApplyMask
	{
		get
		{
			return _btnApplyMask;
		}
		set
		{
			Set(ref _btnApplyMask, value, "BtnApplyMask");
		}
	}

	public bool ShowBtn
	{
		get
		{
			return _showBtn;
		}
		set
		{
			Set(ref _showBtn, value, "ShowBtn");
		}
	}

	public InteractionRequest RefreshBubblePrefabRst => _refreshBubblePrefabRst;

	public SimpleCommand ApplyCmd => _applyCmd;

	public ChatBubbleSetViewModel()
	{
	}

	public ChatBubbleSetViewModel(OptionBase parent)
	{
		base.parent = parent;
		_applyCmd = new SimpleCommand(SendApplyRst);
		RefreshBubbleData();
	}

	private void RefreshBubbleData()
	{
		_bubbleItemDataList.Clear();
		List<RoleDecorateData> list = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().ItemList[RoleDecorateEnum.ChatBubble];
		foreach (DRChatBox config in GameEntry.DataTable.GetAllDataRow<DRChatBox>().ToList())
		{
			bool got = true;
			RoleDecorateData roleDecorateData = list.Find((RoleDecorateData p) => p.id == config.Id);
			if (roleDecorateData == null)
			{
				roleDecorateData = new RoleDecorateData
				{
					id = config.Id,
					expireTime = -1L,
					DecorateType = RoleDecorateEnum.ChatBubble
				};
				got = false;
			}
			_bubbleItemDataList.Add(new ChatBubbleItemData(this, roleDecorateData, got));
		}
		_bubbleItemDataList.Sort(delegate(ChatBubbleItemData a, ChatBubbleItemData b)
		{
			int num = (a.Applied ? 1 : (-1));
			int value = (b.Applied ? 1 : (-1));
			int num2 = ((!a.ActiveMask) ? 1 : (-1));
			int value2 = ((!b.ActiveMask) ? 1 : (-1));
			return -num.CompareTo(value) * 10000 - num2.CompareTo(value2) * 1000 - a.Rarity.CompareTo(b.Rarity) * 100 + a.Config.Sort.CompareTo(b.Config.Sort) * 10 - a.Config.Id.CompareTo(b.Config.Id);
		});
	}

	private void OnBubbleItemClick(ChatBubbleItemData itemData)
	{
		_bubbleItemDataList.ForEach(delegate(ChatBubbleItemData p)
		{
			p.Selected = p.Data.id == itemData.Data.id;
		});
		CurSelectBubbleData = itemData.Data;
		DRChatBox dataRow = GameEntry.DataTable.GetDataRow<DRChatBox>(itemData.Data.id);
		if (dataRow == null)
		{
			return;
		}
		if (CurSelectBubbleData.expireTime > 0)
		{
			DateTime curServerDateTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerDateTime();
			DateTime dateTime = Utility.DateTime.UnixTimestampToDateTime(CurSelectBubbleData.expireTime);
			if (DateTime.Compare(curServerDateTime, dateTime) >= 0)
			{
				HaveExpireTime = false;
			}
			else
			{
				TimeSpan timeSpan = dateTime - curServerDateTime;
				ExpireTimeText = $"剩余时间：{timeSpan.Days}天{timeSpan.Hours}小时";
				HaveExpireTime = true;
			}
		}
		else
		{
			HaveExpireTime = false;
		}
		BubbleName = dataRow.Name;
		int num = Singleton<ServiceSystem>.Instance.GetService<IBFBEService>()?.GetChatBubble() ?? 0;
		if (itemData.ActiveMask)
		{
			BubbleContent = "早上好";
			BubbleDesc = dataRow.AppTxt;
			ShowBtn = false;
		}
		else if (itemData.Data.id == num)
		{
			BubbleContent = "使用中";
			BtnText = "已应用";
			BubbleDesc = dataRow.BgsTxt;
			BtnApplyMask = true;
			ShowBtn = true;
		}
		else
		{
			BubbleContent = "早上好";
			BtnText = "应用";
			BubbleDesc = dataRow.BgsTxt;
			BtnApplyMask = false;
			ShowBtn = true;
		}
		ContentColor1 = GetColorByConfig(dataRow.FontColor2, ContentColor2);
		ContentColor2 = GetColorByConfig(dataRow.FontColor1, ContentColor1);
		if (CurSelectBubbleData.isNew)
		{
			Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.SetDecorateItemRead(CurSelectBubbleData.DecorateType, CurSelectBubbleData.id);
		}
		_refreshBubblePrefabRst.Raise();
	}

	private Color GetColorByConfig(string hex, Color defaultColor)
	{
		if (!string.IsNullOrEmpty(hex) && !hex.StartsWith("#"))
		{
			hex = "#" + hex;
		}
		if (!string.IsNullOrEmpty(hex) && ColorUtility.TryParseHtmlString(hex, out var color))
		{
			return color;
		}
		return defaultColor;
	}

	private async void SendApplyRst()
	{
		if (CurSelectBubbleData == null)
		{
			return;
		}
		_applyCmd.Enabled = false;
		int id = CurSelectBubbleData.id;
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IBFBEService>().SetChatBubbleSetting(id);
		loading?.Dispose();
		if (num)
		{
			BubbleContent = "使用中";
			BtnText = "已应用";
			BtnApplyMask = true;
			ShowBtn = true;
			_bubbleItemDataList.ForEach(delegate(ChatBubbleItemData p)
			{
				p.RefreshApplyState();
			});
			RoleService.AddPlayerInfoChangeTDA();
		}
		_applyCmd.Enabled = true;
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is ChatBubbleItemData itemData)
		{
			OnBubbleItemClick(itemData);
		}
		else if (obj is JumpWindowParams jumpWindowParams)
		{
			parent?.ItemOnClick(jumpWindowParams);
		}
	}
}
