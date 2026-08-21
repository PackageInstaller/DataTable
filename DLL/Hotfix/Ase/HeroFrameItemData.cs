using System.Collections.Generic;

namespace Ase;

public class HeroFrameItemData : ItemOptionBase
{
	private DRHeroCardFrame _config;

	private RoleDecorateData _data;

	private bool _selected;

	private bool _activeMask;

	private bool _haveTimeLimit;

	private int _rarity;

	private string _icon = "";

	private bool _applied1;

	private bool _applied2;

	private bool _applied3;

	public DRHeroCardFrame Config
	{
		get
		{
			return _config;
		}
		set
		{
			Set(ref _config, value, "Config");
		}
	}

	public RoleDecorateData Data
	{
		get
		{
			return _data;
		}
		set
		{
			Set(ref _data, value, "Data");
		}
	}

	public bool Selected
	{
		get
		{
			return _selected;
		}
		set
		{
			Set(ref _selected, value, "Selected");
		}
	}

	public bool ActiveMask
	{
		get
		{
			return _activeMask;
		}
		set
		{
			Set(ref _activeMask, value, "ActiveMask");
		}
	}

	public bool HaveTimeLimit
	{
		get
		{
			return _haveTimeLimit;
		}
		set
		{
			Set(ref _haveTimeLimit, value, "HaveTimeLimit");
		}
	}

	public int Rarity
	{
		get
		{
			return _rarity;
		}
		set
		{
			Set(ref _rarity, value, "Rarity");
		}
	}

	public string Icon
	{
		get
		{
			return _icon;
		}
		set
		{
			Set(ref _icon, value, "Icon");
		}
	}

	public bool Applied1
	{
		get
		{
			return _applied1;
		}
		set
		{
			Set(ref _applied1, value, "Applied1");
		}
	}

	public bool Applied2
	{
		get
		{
			return _applied2;
		}
		set
		{
			Set(ref _applied2, value, "Applied2");
		}
	}

	public bool Applied3
	{
		get
		{
			return _applied3;
		}
		set
		{
			Set(ref _applied3, value, "Applied3");
		}
	}

	public HeroFrameItemData()
	{
	}

	public HeroFrameItemData(OptionBase parent)
	{
		base.parent = parent;
	}

	public HeroFrameItemData(OptionBase parent, RoleDecorateData data, bool got)
	{
		base.parent = parent;
		RefreshData(data, got);
	}

	public void RefreshData(RoleDecorateData data, bool got = false)
	{
		Data = data;
		Config = GameEntry.DataTable.GetDataRow<DRHeroCardFrame>(data.id);
		if (Config != null)
		{
			ActiveMask = !got;
			HaveTimeLimit = got && data.expireTime > 0;
			Rarity = Config.Quality;
			Icon = Config.Icon;
			RefreshApplyState();
		}
	}

	public void RefreshApplyState()
	{
		if (ActiveMask)
		{
			Applied1 = false;
			Applied2 = false;
			Applied3 = false;
			return;
		}
		List<int> list = Singleton<ServiceSystem>.Instance.GetService<IBFBEService>()?.GetCardFrameSet() ?? new List<int>();
		int num = ((list.Count > 0) ? list[0] : 0);
		int num2 = ((list.Count > 1) ? list[1] : 0);
		int num3 = ((list.Count > 2) ? list[2] : 0);
		Applied1 = num == Config.Id;
		Applied2 = num2 == Config.Id;
		Applied3 = num3 == Config.Id;
	}

	public void OnItemClick()
	{
		parent?.ItemOnClick(this);
	}
}
