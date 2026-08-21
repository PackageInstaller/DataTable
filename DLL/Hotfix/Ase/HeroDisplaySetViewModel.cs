using System;
using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class HeroDisplaySetViewModel : OptionBase
{
	public enum SubTabEnum
	{
		Frame = 1
	}

	private SubTabEnum _curSubTabEnum;

	private List<TabItemData> _subTabItemDataList = new List<TabItemData>();

	private InteractionRequest _subTabChangedRst = new InteractionRequest();

	private InteractionRequest<SubTabEnum> _dataListChangeRst = new InteractionRequest<SubTabEnum>();

	private List<HeroFrameItemData> _frameItemDataList = new List<HeroFrameItemData>();

	private RoleDecorateData _curSelectFrameData;

	private InteractionRequest _curSelectChangedRst = new InteractionRequest();

	private List<HeroFrameSetItemData> _frameSetItemDataList = new List<HeroFrameSetItemData>();

	private bool _sendRstEnabled = true;

	public SubTabEnum CurSubTabEnum
	{
		get
		{
			return _curSubTabEnum;
		}
		set
		{
			Set(ref _curSubTabEnum, value, "CurSubTabEnum");
		}
	}

	public List<TabItemData> SubTabItemDataList => _subTabItemDataList;

	public InteractionRequest SubTabChangedRst => _subTabChangedRst;

	public InteractionRequest<SubTabEnum> DataListChangeRst => _dataListChangeRst;

	public List<HeroFrameItemData> FrameItemDataList => _frameItemDataList;

	public RoleDecorateData CurSelectFrameData
	{
		get
		{
			return _curSelectFrameData;
		}
		set
		{
			Set(ref _curSelectFrameData, value, "CurSelectFrameData");
		}
	}

	public InteractionRequest CurSelectChangedRst => _curSelectChangedRst;

	public List<HeroFrameSetItemData> FrameSetItemDataList => _frameSetItemDataList;

	public HeroDisplaySetViewModel()
	{
	}

	public HeroDisplaySetViewModel(OptionBase parent, SubTabEnum defaultTabEnum = SubTabEnum.Frame)
	{
		base.parent = parent;
		foreach (SubTabEnum value in Enum.GetValues(typeof(SubTabEnum)))
		{
			string subTabName = GetSubTabName(value);
			_subTabItemDataList.Add(new TabItemData(this, (int)value)
			{
				TextNormal = subTabName,
				TextSelected = subTabName
			});
		}
		OnInit();
		SetSubTabSelected(defaultTabEnum);
	}

	private void OnInit()
	{
		List<int> list = Singleton<ServiceSystem>.Instance.GetService<IBFBEService>()?.GetCardFrameSet() ?? new List<int>();
		for (int i = 0; i < 3; i++)
		{
			int curFrameId = ((list.Count > i) ? list[i] : 0);
			_frameSetItemDataList.Add(new HeroFrameSetItemData(this, i + 1, curFrameId));
		}
		RefreshHeroFrameDatas();
	}

	public void SetSubTabSelected(SubTabEnum subTabEnum)
	{
		TabItemData tabItemData = _subTabItemDataList.Find((TabItemData p) => p.TabIndex == (int)subTabEnum);
		if (tabItemData != null)
		{
			SetSubTabSelected(tabItemData);
		}
	}

	private void SetSubTabSelected(TabItemData tabItemData)
	{
		CurSubTabEnum = (SubTabEnum)tabItemData.TabIndex;
		_subTabItemDataList.ForEach(delegate(TabItemData p)
		{
			p.IsSelected = p.TabIndex == tabItemData.TabIndex;
		});
		_subTabChangedRst.Raise();
	}

	public int GetDisplayDataCount()
	{
		if (CurSubTabEnum == SubTabEnum.Frame)
		{
			return _frameItemDataList.Count;
		}
		return 0;
	}

	private void RefreshHeroFrameDatas()
	{
		_frameItemDataList.Clear();
		List<RoleDecorateData> list = Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.GetItemList(RoleDecorateEnum.CardFrame) ?? new List<RoleDecorateData>();
		foreach (DRHeroCardFrame config in GameEntry.DataTable.GetAllDataRow<DRHeroCardFrame>().ToList())
		{
			bool got = true;
			RoleDecorateData roleDecorateData = list.Find((RoleDecorateData p) => p.id == config.Id);
			if (roleDecorateData == null)
			{
				roleDecorateData = new RoleDecorateData
				{
					id = config.Id,
					expireTime = -1L,
					DecorateType = RoleDecorateEnum.CardFrame
				};
				got = false;
			}
			_frameItemDataList.Add(new HeroFrameItemData(this, roleDecorateData, got));
		}
		_frameItemDataList.Sort(delegate(HeroFrameItemData a, HeroFrameItemData b)
		{
			int num = GetAppliedValue(a.Applied1, a.Applied2, a.Applied3);
			int value = GetAppliedValue(b.Applied1, b.Applied2, b.Applied3);
			int num2 = ((!a.ActiveMask) ? 1 : (-1));
			int value2 = ((!b.ActiveMask) ? 1 : (-1));
			return -num.CompareTo(value) * 10000 - num2.CompareTo(value2) * 1000 - a.Rarity.CompareTo(b.Rarity) * 100 + a.Config.Sort.CompareTo(b.Config.Sort) * 10 - a.Config.Id.CompareTo(b.Config.Id);
		});
		_dataListChangeRst.Raise(SubTabEnum.Frame);
		static int GetAppliedValue(bool applied1, bool applied2, bool applied3)
		{
			int num = -1;
			if (applied1)
			{
				num += 6;
			}
			if (applied2)
			{
				num += 4;
			}
			if (applied3)
			{
				num += 2;
			}
			return num;
		}
	}

	private void OnFrameItemClick(HeroFrameItemData itemData)
	{
		if (CurSelectFrameData != null && CurSelectFrameData.id == itemData.Data.id)
		{
			return;
		}
		_frameItemDataList.ForEach(delegate(HeroFrameItemData p)
		{
			p.Selected = p.Data.id == itemData.Data.id;
		});
		CurSelectFrameData = itemData.Data;
		_curSelectChangedRst.Raise();
		foreach (HeroFrameSetItemData frameSetItemData in _frameSetItemDataList)
		{
			if (itemData.ActiveMask)
			{
				frameSetItemData.ShowBtnPart = false;
			}
			else if (itemData.Data.id == frameSetItemData.CurFrameId)
			{
				frameSetItemData.BtnText = "已应用";
				frameSetItemData.ShowBtnMask = true;
				frameSetItemData.ShowBtnPart = true;
			}
			else
			{
				frameSetItemData.BtnText = "应用";
				frameSetItemData.ShowBtnMask = false;
				frameSetItemData.ShowBtnPart = true;
			}
		}
		if (CurSelectFrameData.isNew)
		{
			Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.SetDecorateItemRead(CurSelectFrameData.DecorateType, CurSelectFrameData.id);
		}
	}

	private void OnFrameSetItemClick(HeroFrameSetItemData itemData)
	{
		if (!_sendRstEnabled)
		{
			return;
		}
		IBFBEService service = Singleton<ServiceSystem>.Instance.GetService<IBFBEService>();
		if (service == null)
		{
			return;
		}
		List<int> cardFrameSet = service.GetCardFrameSet();
		List<int> list = new List<int>();
		for (int i = 0; i < 3; i++)
		{
			int item = ((cardFrameSet.Count > i) ? cardFrameSet[i] : 0);
			if (i == itemData.SeatIndex - 1)
			{
				item = _curSelectFrameData?.id ?? 0;
			}
			list.Add(item);
		}
		SendSetFrameRst(list, itemData, _curSelectFrameData?.id ?? 0);
	}

	private async void SendSetFrameRst(List<int> frameSet, HeroFrameSetItemData itemData, int frameId)
	{
		_sendRstEnabled = false;
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IBFBEService>().SetCardFrameSetting(frameSet);
		loading?.Dispose();
		if (num)
		{
			if (itemData != null)
			{
				itemData.SetFrame(frameId);
				itemData.BtnText = "已应用";
				itemData.ShowBtnMask = true;
				itemData.ShowBtnPart = true;
			}
			_frameItemDataList.ForEach(delegate(HeroFrameItemData p)
			{
				p.RefreshApplyState();
			});
			RoleService.AddPlayerInfoChangeTDA();
		}
		_sendRstEnabled = true;
	}

	public string GetSubTabName(SubTabEnum subTabEnum)
	{
		if (subTabEnum == SubTabEnum.Frame)
		{
			return "备战边框";
		}
		return "";
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is HeroFrameItemData itemData)
		{
			OnFrameItemClick(itemData);
		}
		else if (obj is HeroFrameSetItemData itemData2)
		{
			OnFrameSetItemClick(itemData2);
		}
		else if (obj is JumpWindowParams jumpWindowParams)
		{
			parent?.ItemOnClick(jumpWindowParams);
		}
		base.ItemOnClick(obj);
	}
}
