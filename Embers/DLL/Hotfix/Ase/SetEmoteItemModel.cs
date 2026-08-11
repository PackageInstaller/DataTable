using GameFramework.Runtime;

namespace Ase;

public class SetEmoteItemModel : OptionBase
{
	private int id;

	private int emoteIndex;

	private string emoteIcon;

	private ToHaveEmoteItemModel initialEmote;

	private string sendEmoteTimeTxt;

	private bool isSelected;

	private bool isHaveEmote;

	private int timeLimitGroupId;

	private bool showRemoveBtn;

	private bool showReplaceBtn;

	private bool showAddBtn;

	private SimpleCommand<string> optCommand;

	private BattleEmoteSetViewModel parentVM;

	public int Id => id;

	public ICommand OptCommand => optCommand;

	public int TimeLimitGroupId => timeLimitGroupId;

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

	public bool ShowRemoveBtn
	{
		get
		{
			return showRemoveBtn;
		}
		set
		{
			Set(ref showRemoveBtn, value, "ShowRemoveBtn");
		}
	}

	public bool ShowReplaceBtn
	{
		get
		{
			return showReplaceBtn;
		}
		set
		{
			Set(ref showReplaceBtn, value, "ShowReplaceBtn");
		}
	}

	public bool ShowAddBtn
	{
		get
		{
			return showAddBtn;
		}
		set
		{
			Set(ref showAddBtn, value, "ShowAddBtn");
		}
	}

	public bool IsHaveEmote
	{
		get
		{
			return isHaveEmote;
		}
		set
		{
			Set(ref isHaveEmote, value, "IsHaveEmote");
		}
	}

	public string EmoteIcon
	{
		get
		{
			return emoteIcon;
		}
		set
		{
			Set(ref emoteIcon, value, "EmoteIcon");
		}
	}

	public string SendEmoteTimeTxt
	{
		get
		{
			return sendEmoteTimeTxt;
		}
		set
		{
			Set(ref sendEmoteTimeTxt, value, "SendEmoteTimeTxt");
		}
	}

	public ToHaveEmoteItemModel InitialEmote
	{
		get
		{
			return initialEmote;
		}
		set
		{
			Set(ref initialEmote, value, "InitialEmote");
		}
	}

	public SetEmoteItemModel()
	{
	}

	public SetEmoteItemModel(OptionBase parent, int index)
	{
		base.parent = parent;
		emoteIndex = index;
		optCommand = new SimpleCommand<string>(OnOpt);
	}

	public SetEmoteItemModel(OptionBase parent, int index, string txt)
	{
		base.parent = parent;
		emoteIndex = index;
		sendEmoteTimeTxt = txt;
		optCommand = new SimpleCommand<string>(OnOpt);
	}

	public void SetEmote(ToHaveEmoteItemModel emote)
	{
		if (emote == null)
		{
			if (InitialEmote != null)
			{
				id = InitialEmote.Id;
				EmoteIcon = InitialEmote.EmoteIconPath;
				timeLimitGroupId = InitialEmote.TimeLimitGroupId;
			}
			else
			{
				id = 0;
				EmoteIcon = null;
				timeLimitGroupId = 0;
			}
		}
		else
		{
			id = emote.Id;
			EmoteIcon = emote.EmoteIconPath;
			timeLimitGroupId = emote.TimeLimitGroupId;
		}
		if (EmoteIcon != null)
		{
			IsHaveEmote = true;
		}
	}

	public void InitValue(ToHaveEmoteItemModel emoteData)
	{
		id = emoteData.Id;
		IsHaveEmote = true;
		EmoteIcon = emoteData.EmoteIconPath;
		InitialEmote = emoteData;
		timeLimitGroupId = emoteData.TimeLimitGroupId;
	}

	public void ReplaceOrAddEmoteValue(ToHaveEmoteItemModel emoteData)
	{
		IsHaveEmote = true;
		id = emoteData.Id;
		EmoteIcon = emoteData.EmoteIconPath;
		InitialEmote = emoteData;
		timeLimitGroupId = emoteData.TimeLimitGroupId;
	}

	public void RemoveEmoteValue()
	{
		IsHaveEmote = false;
		id = 0;
		EmoteIcon = null;
		InitialEmote = null;
		timeLimitGroupId = 0;
	}

	private void OnOpt(string obj)
	{
		if ("OnClick".Equals(obj))
		{
			OnClick();
		}
		else if ("Remove".Equals(obj))
		{
			RemoveEmote();
		}
		else if ("Replace".Equals(obj))
		{
			ReplaceEmote();
		}
		else if ("Add".Equals(obj))
		{
			AddEmote();
		}
	}

	private void AddEmote()
	{
		parent?.ItemOnClick(new OptionArg(this, "AddEmote"));
	}

	private void ReplaceEmote()
	{
		parent?.ItemOnClick(new OptionArg(this, "ReplaceEmote"));
	}

	private void RemoveEmote()
	{
		IsSelected = !IsSelected;
		ShowRemoveBtn = false;
		RemoveEmoteValue();
		(parent as BattleEmoteSetViewModel).SendSaveBattleEmote();
	}

	public void ShowEmoteState()
	{
		if (!isSelected && isHaveEmote)
		{
			ShowReplaceBtn = true;
		}
		else if (!isSelected && !isHaveEmote)
		{
			ShowAddBtn = true;
		}
		else if (isSelected && isHaveEmote)
		{
			IsSelected = false;
			ShowRemoveBtn = false;
			ShowReplaceBtn = true;
		}
	}

	public void HideEmoteState()
	{
		ShowReplaceBtn = false;
		ShowAddBtn = false;
	}

	public void HideRemoveBtn()
	{
		ShowRemoveBtn = false;
		if (isHaveEmote)
		{
			IsSelected = false;
		}
		if (isHaveEmote && ShowRemoveBtn)
		{
			ShowRemoveBtn = false;
		}
	}

	private void OnClick()
	{
		if (isHaveEmote && !ShowReplaceBtn && !ShowRemoveBtn)
		{
			parent?.ItemOnClick(new OptionArg(this, "BattleEmoteItemOnClick"));
			IsSelected = !IsSelected;
			ShowRemoveBtn = true;
		}
	}

	public void SetHaveEmote(bool isHaveEmote)
	{
		IsHaveEmote = isHaveEmote;
	}

	public void SetTimeLimit(int timeLimitGroupId)
	{
		this.timeLimitGroupId = timeLimitGroupId;
	}
}
