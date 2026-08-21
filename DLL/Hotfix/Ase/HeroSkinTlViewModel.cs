using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public class HeroSkinTlViewModel : OptionBase
{
	private List<HeroSkinTlItemData1> _skinList = new List<HeroSkinTlItemData1>();

	private List<HeroSkinTlItemData2> _tlGroupList = new List<HeroSkinTlItemData2>();

	private List<HeroSkinTlItemData3> _tlItemList = new List<HeroSkinTlItemData3>();

	private List<int> _savedSkinList = new List<int>();

	private HeroSkinTlItemData1 _curSkinItemData;

	private InteractionRequest _refreshTlListRst = new InteractionRequest();

	private SimpleCommand _setSkinSaveCmd;

	private InteractionRequest<(int, string)> _loadTlGroupRst = new InteractionRequest<(int, string)>();

	private SimpleCommand<DRHeroSkinTimeLine> _playTlCmd;

	private bool _showSkinInfo;

	private int _skinId;

	private string _skinName;

	private string _skinDesc;

	private string _skinIcon = "";

	private bool _skinSaved;

	private bool _empty;

	public List<HeroSkinTlItemData1> SkinList => _skinList;

	public List<HeroSkinTlItemData2> TlGroupList => _tlGroupList;

	public List<HeroSkinTlItemData3> TlItemList
	{
		get
		{
			return _tlItemList;
		}
		set
		{
			_tlItemList = value;
		}
	}

	public HeroSkinTlItemData1 CurSkinItemData => _curSkinItemData;

	public InteractionRequest RefreshTlListRst => _refreshTlListRst;

	public SimpleCommand SetSkinSaveCmd => _setSkinSaveCmd;

	public InteractionRequest<(int, string)> LoadTlGroupRst => _loadTlGroupRst;

	public bool ShowSkinInfo
	{
		get
		{
			return _showSkinInfo;
		}
		set
		{
			Set(ref _showSkinInfo, value, "ShowSkinInfo");
		}
	}

	public string SkinName
	{
		get
		{
			return _skinName;
		}
		set
		{
			Set(ref _skinName, value, "SkinName");
		}
	}

	public string SkinDesc
	{
		get
		{
			return _skinDesc;
		}
		set
		{
			Set(ref _skinDesc, value, "SkinDesc");
		}
	}

	public string SkinIcon
	{
		get
		{
			return _skinIcon;
		}
		set
		{
			Set(ref _skinIcon, value, "SkinIcon");
		}
	}

	public bool SkinSaved
	{
		get
		{
			return _skinSaved;
		}
		set
		{
			Set(ref _skinSaved, value, "SkinSaved");
		}
	}

	public bool Empty
	{
		get
		{
			return _empty;
		}
		set
		{
			Set(ref _empty, value, "Empty");
		}
	}

	public HeroSkinTlViewModel()
	{
	}

	public HeroSkinTlViewModel(OptionBase parent)
	{
		base.parent = parent;
		_setSkinSaveCmd = new SimpleCommand(SetSkinSave);
		_playTlCmd = new SimpleCommand<DRHeroSkinTimeLine>(PlayTimeline);
		List<int> list = Singleton<ServiceSystem>.Instance.GetService<IHeroService>()?.GetAllHeroSkins();
		if (list == null || list.Count <= 0)
		{
			Empty = true;
			return;
		}
		foreach (int item in list)
		{
			DRSkinMessage dataRow = GameEntry.DataTable.GetDataRow<DRSkinMessage>(item);
			if (dataRow != null)
			{
				DRUIHeroSkin dataRow2 = GameEntry.DataTable.GetDataRow<DRUIHeroSkin>(dataRow.Id);
				if (dataRow2 != null)
				{
					_skinList.Add(new HeroSkinTlItemData1(this, dataRow, dataRow2));
				}
			}
		}
		Empty = _skinList.Count <= 0;
	}

	public async UniTask RequestSaveData()
	{
		await Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetSkinTimelineReadList();
		_savedSkinList = await Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetSkinTimelineCollect();
		if (_savedSkinList != null)
		{
			IHeroService service = Singleton<ServiceSystem>.Instance.GetService<IHeroService>();
			_skinList.Sort(delegate(HeroSkinTlItemData1 a, HeroSkinTlItemData1 b)
			{
				int num = ((!_savedSkinList.Contains(a.DrSkinMessage.Id)) ? 1 : (-1));
				int value = ((!_savedSkinList.Contains(b.DrSkinMessage.Id)) ? 1 : (-1));
				int num2 = service.GetHeroById(a.DruiHeroSkin.HeroID)?.FeelingLevel ?? 0;
				int value2 = service.GetHeroById(b.DruiHeroSkin.HeroID)?.FeelingLevel ?? 0;
				return num.CompareTo(value) * 100 - num2.CompareTo(value2) * 10 + a.DrSkinMessage.Id.CompareTo(b.DrSkinMessage.Id);
			});
			_skinList.ForEach(delegate(HeroSkinTlItemData1 p)
			{
				p.RefreshSaved(_savedSkinList.Contains(p.DrSkinMessage.Id));
			});
		}
	}

	private void SetSkinItemSelected(HeroSkinTlItemData1 itemData)
	{
		DRSkinMessage drSkinMessage = itemData.DrSkinMessage;
		if (drSkinMessage == null)
		{
			return;
		}
		if (_curSkinItemData != null)
		{
			if (_curSkinItemData.DrSkinMessage.Id == drSkinMessage.Id)
			{
				return;
			}
			_curSkinItemData.Selected = false;
		}
		_curSkinItemData = itemData;
		_curSkinItemData.Selected = true;
		_skinId = drSkinMessage.Id;
		SkinName = itemData.SkinName;
		SkinDesc = itemData.SkinDesc;
		SkinIcon = itemData.SkinIcon;
		SkinSaved = itemData.Saved;
		ShowSkinInfo = true;
		RefreshTlList();
	}

	private void RefreshTlList()
	{
		_tlGroupList.Clear();
		DRSkinMessage dRSkinMessage = _curSkinItemData?.DrSkinMessage;
		if (dRSkinMessage != null)
		{
			for (int i = 0; i < dRSkinMessage.ListID.Count; i++)
			{
				int id = dRSkinMessage.ListID[i];
				string name = ((dRSkinMessage.ListName.Count > i) ? dRSkinMessage.ListName[i] : "");
				string text = ((dRSkinMessage.Prefab.Count > i) ? dRSkinMessage.Prefab[i] : "");
				if (!string.IsNullOrEmpty(text))
				{
					_tlGroupList.Add(new HeroSkinTlItemData2(this, id, name, text));
				}
			}
		}
		_refreshTlListRst.Raise();
	}

	public void RefreshTlItemState()
	{
		TlItemList.ForEach(delegate(HeroSkinTlItemData3 p)
		{
			p.RefreshState();
		});
	}

	private async void SetSkinSave()
	{
		_setSkinSaveCmd.Enabled = false;
		if (_savedSkinList == null)
		{
			_savedSkinList = new List<int>();
		}
		bool saved;
		if (_savedSkinList.Contains(_skinId))
		{
			_savedSkinList.Remove(_skinId);
			saved = false;
		}
		else
		{
			_savedSkinList.Add(_skinId);
			saved = true;
		}
		Loading loading = await Loading.Show();
		await Singleton<ServiceSystem>.Instance.GetService<IHeroService>().SetSkinTimelineCollect(_savedSkinList);
		loading?.Dispose();
		HeroSkinTlItemData1 heroSkinTlItemData = _skinList.Find((HeroSkinTlItemData1 p) => p.DrSkinMessage.Id == _skinId);
		if (heroSkinTlItemData != null)
		{
			heroSkinTlItemData.RefreshSaved(saved);
			SkinSaved = heroSkinTlItemData.Saved;
		}
		_setSkinSaveCmd.Enabled = true;
	}

	private async void PlayTimeline(DRHeroSkinTimeLine config)
	{
		_playTlCmd.Enabled = false;
		await Singleton<Story>.Instance.PlayStory(0u, config.TLID);
		IHeroService service = Singleton<ServiceSystem>.Instance.GetService<IHeroService>();
		List<int> skinTlReadList = service.GetSkinTlReadList();
		if (!skinTlReadList.Contains(config.Id))
		{
			List<int> list = new List<int> { config.Id };
			list.AddRange(skinTlReadList);
			if (await service.SetSkinTimelineRead(list))
			{
				RefreshTlItemState();
			}
		}
		_playTlCmd.Enabled = true;
	}

	private void OnTlGroupItemClick(HeroSkinTlItemData2 heroSkinTlItemData2)
	{
		if (heroSkinTlItemData2.GroupId > 0 && !string.IsNullOrEmpty(heroSkinTlItemData2.Prefab))
		{
			_tlGroupList.ForEach(delegate(HeroSkinTlItemData2 p)
			{
				p.Selected = p.GroupId.Equals(heroSkinTlItemData2.GroupId);
			});
			_loadTlGroupRst.Raise((heroSkinTlItemData2.GroupId, heroSkinTlItemData2.Prefab));
		}
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is HeroSkinTlItemData1 skinItemSelected)
		{
			SetSkinItemSelected(skinItemSelected);
		}
		else if (obj is HeroSkinTlItemData2 heroSkinTlItemData)
		{
			OnTlGroupItemClick(heroSkinTlItemData);
		}
		else if (obj is HeroSkinTlItemData3 heroSkinTlItemData2)
		{
			_playTlCmd.Execute(heroSkinTlItemData2.DrHeroSkinTimeLine);
		}
	}
}
