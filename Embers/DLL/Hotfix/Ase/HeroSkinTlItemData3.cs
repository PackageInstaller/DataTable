using System.Collections.Generic;

namespace Ase;

public class HeroSkinTlItemData3 : OptionBase
{
	private string _tlName;

	private string _tlIcon = "";

	private bool _unlock;

	private bool _read;

	private string _msg = "";

	private DRHeroSkinTimeLine _drHeroSkinTimeLine;

	public string TlName
	{
		get
		{
			return _tlName;
		}
		set
		{
			Set(ref _tlName, value, "TlName");
		}
	}

	public string TlIcon
	{
		get
		{
			return _tlIcon;
		}
		set
		{
			Set(ref _tlIcon, value, "TlIcon");
		}
	}

	public bool Unlock
	{
		get
		{
			return _unlock;
		}
		set
		{
			Set(ref _unlock, value, "Unlock");
		}
	}

	public bool Read
	{
		get
		{
			return _read;
		}
		set
		{
			Set(ref _read, value, "Read");
		}
	}

	public DRHeroSkinTimeLine DrHeroSkinTimeLine => _drHeroSkinTimeLine;

	public HeroSkinTlItemData3()
	{
	}

	public HeroSkinTlItemData3(OptionBase parent, DRHeroSkinTimeLine drHeroSkinTimeLine)
	{
		base.parent = parent;
		if (drHeroSkinTimeLine != null)
		{
			_drHeroSkinTimeLine = drHeroSkinTimeLine;
			TlName = drHeroSkinTimeLine.Title;
			RefreshState();
		}
	}

	public void RefreshState()
	{
		IHeroService service = Singleton<ServiceSystem>.Instance.GetService<IHeroService>();
		if (service != null)
		{
			List<int> skinTlReadList = service.GetSkinTlReadList();
			if (DrHeroSkinTimeLine == null)
			{
				Unlock = false;
				Read = false;
			}
			else
			{
				Unlock = service.GetSkinTlUnlockState(DrHeroSkinTimeLine, out _msg);
				Read = skinTlReadList.Contains(DrHeroSkinTimeLine.Id);
			}
		}
	}

	public void PlayTimeline()
	{
		if (_drHeroSkinTimeLine == null)
		{
			return;
		}
		if (!Unlock)
		{
			if (string.IsNullOrEmpty(_msg))
			{
				Toast.ShowInfo(_msg);
			}
		}
		else
		{
			parent?.ItemOnClick(this);
		}
	}
}
