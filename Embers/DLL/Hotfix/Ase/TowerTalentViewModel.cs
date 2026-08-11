using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class TowerTalentViewModel : ViewModelBase
{
	private int talntLevel;

	private bool unLock;

	public int MaxLevel;

	private string iconName;

	private string talentTag;

	private InteractionRequest upLevelSuccessRequest = new InteractionRequest();

	private bool canUpLevel;

	public List<int> UnLockTalent;

	public List<int> UnLockOrder;

	public int UnLockNum;

	private int talentType;

	private int _talentId;

	public IInteractionRequest UpLevelSuccessRequest => upLevelSuccessRequest;

	public int TalentType => talentType;

	public int TalentId => _talentId;

	public int TalntLevel
	{
		get
		{
			return talntLevel;
		}
		set
		{
			Set(ref talntLevel, value, "TalntLevel");
		}
	}

	public bool UnLock
	{
		get
		{
			return unLock;
		}
		set
		{
			Set(ref unLock, value, "UnLock");
		}
	}

	public bool CanUpLevel
	{
		get
		{
			return canUpLevel;
		}
		set
		{
			Set(ref canUpLevel, value, "CanUpLevel");
		}
	}

	public string IconName
	{
		get
		{
			return iconName;
		}
		set
		{
			Set(ref iconName, value, "IconName");
		}
	}

	public string TalentTag
	{
		get
		{
			return talentTag;
		}
		set
		{
			Set(ref talentTag, value, "TalentTag");
		}
	}

	public TowerTalentViewModel(int talentType, int talentId, string iconName, string tag)
	{
		_talentId = talentId;
		this.talentType = talentType;
		this.iconName = iconName;
		talentTag = tag;
	}

	public void PlayUpLevelEffect()
	{
		upLevelSuccessRequest.Raise();
	}
}
