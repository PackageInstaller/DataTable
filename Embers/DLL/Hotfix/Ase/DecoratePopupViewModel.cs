namespace Ase;

public class DecoratePopupViewModel : OptionBase
{
	private string _title;

	private string _image = "";

	private string _icon = "";

	private string _name;

	private string _source;

	private PropDataBase _propDataBase;

	private DRHeadDecorate _drHeadDecorate;

	private DRTitle _drTitle;

	private DRHeroCardFrame _drHeroCardFrame;

	private DRChatBox _drChatBox;

	private DREmoticonType _drEmoticonType;

	private DRBattleEmoteGroup _drBattleEmoteGroup;

	public string Title
	{
		get
		{
			return _title;
		}
		set
		{
			Set(ref _title, value, "Title");
		}
	}

	public string Image
	{
		get
		{
			return _image;
		}
		set
		{
			Set(ref _image, value, "Image");
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

	public string Name
	{
		get
		{
			return _name;
		}
		set
		{
			Set(ref _name, value, "Name");
		}
	}

	public string Source
	{
		get
		{
			return _source;
		}
		set
		{
			Set(ref _source, value, "Source");
		}
	}

	public PropDataBase PropDataBase
	{
		get
		{
			return _propDataBase;
		}
		set
		{
			Set(ref _propDataBase, value, "PropDataBase");
		}
	}

	public DecoratePopupViewModel()
	{
	}

	public DecoratePopupViewModel(OptionBase parent, PropDataBase propData)
	{
		base.parent = parent;
		PropDataBase = propData;
		if (propData.PropTypeEnum == PropTypeEnum.HeadDecorate)
		{
			_drHeadDecorate = GameEntry.DataTable.GetDataRow<DRHeadDecorate>(propData.Id);
			if (_drHeadDecorate != null)
			{
				Title = "头像框";
				Image = _drHeadDecorate.Icon;
				Icon = _drHeadDecorate.Icon;
				Name = _drHeadDecorate.Name;
				Source = _drHeadDecorate.Source;
			}
		}
		else if (propData.PropTypeEnum == PropTypeEnum.Title)
		{
			_drTitle = GameEntry.DataTable.GetDataRow<DRTitle>(propData.Id);
			if (_drTitle != null)
			{
				Title = "称号";
				Image = _drTitle.Icon;
				Icon = _drTitle.TitleIcon;
				Name = _drTitle.Name;
				Source = _drTitle.Source;
			}
		}
		else if (propData.PropTypeEnum == PropTypeEnum.CardFrame)
		{
			_drHeroCardFrame = GameEntry.DataTable.GetDataRow((DRHeroCardFrame p) => p.PropId == propData.Id);
			if (_drHeroCardFrame != null)
			{
				Title = "备战边框";
				Image = _drHeroCardFrame.TipsIcon;
				Icon = _drHeroCardFrame.Icon;
				Name = _drHeroCardFrame.Name;
				Source = _drHeroCardFrame.AppTxt;
			}
		}
		else if (propData.PropTypeEnum == PropTypeEnum.ChatBubble)
		{
			_drChatBox = GameEntry.DataTable.GetDataRow((DRChatBox p) => p.PropId == propData.Id);
			if (_drChatBox != null)
			{
				Title = "聊天气泡";
				Image = _drChatBox.Icon;
				Icon = _drChatBox.Icon;
				Name = _drChatBox.Name;
				Source = _drChatBox.AppTxt;
			}
		}
		else if (propData.PropTypeEnum == PropTypeEnum.ChatEmoji)
		{
			_drEmoticonType = GameEntry.DataTable.GetDataRow((DREmoticonType p) => p.UnclockNum == propData.Id);
			if (_drEmoticonType != null)
			{
				Title = "聊天表情";
				Image = _drEmoticonType.Icon;
				Icon = _drEmoticonType.Icon;
				Name = _drEmoticonType.Name;
				Source = "";
			}
		}
		else if (propData.PropTypeEnum == PropTypeEnum.BattleEmoji)
		{
			_drBattleEmoteGroup = GameEntry.DataTable.GetDataRow((DRBattleEmoteGroup p) => p.PropId == propData.Id);
			DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(propData.Id);
			if (_drBattleEmoteGroup != null)
			{
				Title = "战斗表情";
				Image = dataRow.Icon;
				Icon = dataRow.Icon;
				Name = dataRow.Name;
				Source = _drBattleEmoteGroup.AppTxt;
			}
		}
	}
}
