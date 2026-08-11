using GameFramework.Runtime;

namespace Ase;

public class EntryItemData2 : OptionBase
{
	private bool isEmpty;

	private string emptyText;

	private EntryData entryData;

	private string entryName;

	private string entryLevel;

	private string entryIcon;

	private string entryDetail;

	private string actionName;

	private bool isSelected;

	private bool isChoose;

	public bool NeedShowEntryPanel = true;

	public bool NeedShowSelected = true;

	private InteractionRequest openEntryPanelRequest = new InteractionRequest();

	private InteractionRequest playAnimationRequest = new InteractionRequest();

	private InteractionRequest playUIParticleRequest = new InteractionRequest();

	private InteractionRequest hideUIParticleRequest = new InteractionRequest();

	public bool IsChoose => isChoose;

	public bool IsSelected
	{
		get
		{
			return isSelected;
		}
		set
		{
			Set(ref isSelected, value, "IsSelected");
		}
	}

	public bool IsEmpty
	{
		get
		{
			return isEmpty;
		}
		set
		{
			Set(ref isEmpty, value, "IsEmpty");
		}
	}

	public string EmptyText
	{
		get
		{
			return emptyText;
		}
		set
		{
			Set(ref emptyText, value, "EmptyText");
		}
	}

	public EntryData EntryData
	{
		get
		{
			return entryData;
		}
		set
		{
			Set(ref entryData, value, "EntryData");
		}
	}

	public string EntryName
	{
		get
		{
			return entryName;
		}
		set
		{
			Set(ref entryName, value, "EntryName");
		}
	}

	public string EntryLevel
	{
		get
		{
			return entryLevel;
		}
		set
		{
			Set(ref entryLevel, value, "EntryLevel");
		}
	}

	public string EntryIcon
	{
		get
		{
			return entryIcon;
		}
		set
		{
			Set(ref entryIcon, value, "EntryIcon");
		}
	}

	public string EntryDetail
	{
		get
		{
			return entryDetail;
		}
		set
		{
			Set(ref entryDetail, value, "EntryDetail");
		}
	}

	public InteractionRequest OpenEntryPanelRequest => openEntryPanelRequest;

	public InteractionRequest PlayAnimationRequest => playAnimationRequest;

	public InteractionRequest PlayUIParticleRequest => playUIParticleRequest;

	public InteractionRequest HideUIParticleRequest => hideUIParticleRequest;

	public EntryItemData2()
	{
	}

	public EntryItemData2(OptionBase parent, string text)
	{
		base.parent = parent;
		emptyText = text;
		isEmpty = true;
		entryData = null;
		entryName = string.Empty;
		entryLevel = string.Empty;
		EntryIcon = "buff_5";
		entryDetail = string.Empty;
		playAnimationRequest = new InteractionRequest();
		playUIParticleRequest = new InteractionRequest();
	}

	public EntryItemData2(OptionBase parent, EntryData entryData, bool showDetail = true)
	{
		base.parent = parent;
		isEmpty = !entryData.IsRealData;
		this.entryData = entryData;
		entryName = entryData.DrEntry?.Name;
		entryLevel = $"Lv.{entryData.DrEntry?.Level}";
		entryDetail = ((!showDetail) ? entryData.DrEntry?.Desc : entryData.DrEntry?.DetailDesc);
		EntryIcon = entryData.IconPath;
		openEntryPanelRequest = new InteractionRequest();
		playAnimationRequest = new InteractionRequest();
		playUIParticleRequest = new InteractionRequest();
	}

	public void ReSetData(EntryData entryData, bool showDetail = true)
	{
		this.entryData = entryData;
		IsEmpty = !entryData.IsRealData;
		EntryName = entryData.DrEntry?.Name;
		EntryLevel = $"Lv.{entryData.DrEntry?.Level}";
		EntryIcon = entryData.IconPath;
		EntryDetail = ((!showDetail) ? entryData.DrEntry?.Desc : entryData.DrEntry?.DetailDesc);
	}

	public void SetExActionName(string actionName)
	{
		this.actionName = actionName;
	}

	public void PlayAnimation()
	{
		playAnimationRequest.Raise();
	}

	public void PlayUIParticle()
	{
		playUIParticleRequest.Raise();
	}

	public void HideUIParticle()
	{
		hideUIParticleRequest.Raise();
	}

	public void OnShowEntryPanel(EntryItem2 item)
	{
		if (parent != null)
		{
			if (NeedShowEntryPanel)
			{
				parent.ItemOnClick(new OptionArg(item, "OnShowEntryPanel"));
			}
			if (NeedShowSelected)
			{
				parent.ItemOnClick(new OptionArg(this, "Selected"));
			}
		}
	}

	public void OpenPanelRequest()
	{
		openEntryPanelRequest.Raise();
	}

	public void OnClickExBtn()
	{
		parent?.ItemOnClick(new OptionArg(this, actionName));
	}

	public void SetChoose(bool value)
	{
		isChoose = value;
	}
}
