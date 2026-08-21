using System.Collections.Generic;

namespace Ase;

public class HeroVoiceItemData : ItemOptionBase
{
	private DRVoice _drVoice;

	private string textDisplay;

	private bool unlock;

	private bool selected;

	private bool red;

	public DRVoice DrVoice => _drVoice;

	public string TextDisplay
	{
		get
		{
			return textDisplay;
		}
		set
		{
			Set(ref textDisplay, value, "TextDisplay");
		}
	}

	public bool Unlock
	{
		get
		{
			return unlock;
		}
		set
		{
			Set(ref unlock, value, "Unlock");
		}
	}

	public bool Selected
	{
		get
		{
			return selected;
		}
		private set
		{
			Set(ref selected, value, "Selected");
		}
	}

	public bool Red
	{
		get
		{
			return red;
		}
		set
		{
			Set(ref red, value, "Red");
		}
	}

	public HeroVoiceItemData()
	{
	}

	public HeroVoiceItemData(OptionBase parent, DRVoice drVoice, bool unlock)
	{
		base.parent = parent;
		_drVoice = drVoice;
		Unlock = unlock;
		TextDisplay = (unlock ? drVoice.VoiceTitle : GetLockText(drVoice));
		List<RedPointSave> redPoint = Singleton<ServiceSystem>.Instance.GetService<IRedPointService>().GetRedPoint(RedPointLocalSaveKeys.HeroVoiceClick);
		Red = Unlock && !redPoint.Exists((RedPointSave p) => p.keyId.Equals(drVoice.Id) && !p.isNew);
	}

	private string GetLockText(DRVoice drVoice)
	{
		switch (drVoice.LockType)
		{
		case 1:
			return $"好感度达到{drVoice.LockNum}级解锁";
		case 2:
			return $"突破等级达到{drVoice.LockNum}级解锁";
		case 3:
		{
			DRUIHeroSkin dataRow = GameEntry.DataTable.GetDataRow<DRUIHeroSkin>(drVoice.LockNum);
			if (dataRow != null)
			{
				return "拥有幻衣·" + dataRow.SkinName + "解锁";
			}
			return "";
		}
		default:
			return "";
		}
	}

	public void OnVoiceItemClick()
	{
		if (!Unlock)
		{
			Toast.ShowInfo("未解锁");
		}
		else
		{
			parent?.ItemOnClick(this);
		}
	}

	public void SetSelected(bool selected)
	{
		Selected = selected;
	}

	public void SetRed(bool red)
	{
		Red = red;
	}
}
