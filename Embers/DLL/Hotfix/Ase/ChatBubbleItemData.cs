namespace Ase;

public class ChatBubbleItemData : ItemOptionBase
{
	private DRChatBox _config;

	private RoleDecorateData _data;

	private string _bubbleName;

	private bool _selected;

	private bool _activeMask;

	private bool _haveTimeLimit;

	private int _rarity;

	private string _icon = "";

	private bool _applied;

	private string _content;

	public DRChatBox Config
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

	public bool Applied
	{
		get
		{
			return _applied;
		}
		set
		{
			Set(ref _applied, value, "Applied");
		}
	}

	public string Content
	{
		get
		{
			return _content;
		}
		set
		{
			Set(ref _content, value, "Content");
		}
	}

	public ChatBubbleItemData()
	{
	}

	public ChatBubbleItemData(OptionBase parent)
	{
		base.parent = parent;
	}

	public ChatBubbleItemData(OptionBase parent, RoleDecorateData data, bool got)
	{
		base.parent = parent;
		RefreshData(data, got);
	}

	public void RefreshData(RoleDecorateData data, bool got = false)
	{
		Data = data;
		Config = GameEntry.DataTable.GetDataRow<DRChatBox>(data.id);
		if (Config != null)
		{
			BubbleName = Config.Name;
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
			Applied = false;
			Content = "早上好";
		}
		else
		{
			int num = Singleton<ServiceSystem>.Instance.GetService<IBFBEService>()?.GetChatBubble() ?? 0;
			Applied = num == Config.Id;
			Content = (Applied ? "使用中" : "早上好");
		}
	}

	public void OnItemClick()
	{
		parent?.ItemOnClick(this);
	}
}
