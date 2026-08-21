using UnityEngine;

namespace Ase;

public class HeroItemViewModel : OptionBase
{
	private HeroModel _heroModel;

	private int heroTryId;

	private bool showCustomTag;

	private int seatId;

	private Color rarityColor;

	private int levelFix = -1;

	private bool isSelected;

	private bool isChecked;

	private string seatText;

	private bool seatLockTag;

	private bool heroTryTag;

	public int checkVal;

	public float MarkValue;

	private int teamSetId;

	private int tryHeroIndex;

	private int selectHeroIndex;

	public int TeamSetId => teamSetId;

	public int TryHeroIndex => tryHeroIndex;

	public HeroModel HeroModel
	{
		get
		{
			return _heroModel ?? (_heroModel = new HeroModel());
		}
		private set
		{
			value = value ?? new HeroModel();
			Set(ref _heroModel, value, "HeroModel");
			RarityColor = _heroModel.GetColorByRarity(value.Rarity);
		}
	}

	public int SeatId
	{
		get
		{
			return seatId;
		}
		private set
		{
			Set(ref seatId, value, "SeatId");
		}
	}

	public int LevelFix
	{
		get
		{
			return levelFix;
		}
		private set
		{
			Set(ref levelFix, value, "LevelFix");
		}
	}

	public Color RarityColor
	{
		get
		{
			return rarityColor;
		}
		set
		{
			Set(ref rarityColor, value, "RarityColor");
		}
	}

	public bool IsSelected
	{
		get
		{
			return isSelected;
		}
		protected set
		{
			Set(ref isSelected, value, "IsSelected");
		}
	}

	public bool ShowCustomTag
	{
		get
		{
			return showCustomTag;
		}
		set
		{
			Set(ref showCustomTag, value, "ShowCustomTag");
		}
	}

	public bool IsChecked
	{
		get
		{
			return isChecked;
		}
		protected set
		{
			Set(ref isChecked, value, "IsChecked");
		}
	}

	public string SeatText
	{
		get
		{
			return seatText;
		}
		protected set
		{
			Set(ref seatText, value, "SeatText");
		}
	}

	public bool HeroTryTag
	{
		get
		{
			return heroTryTag;
		}
		private set
		{
			Set(ref heroTryTag, value, "HeroTryTag");
		}
	}

	public bool SeatLockTag
	{
		get
		{
			return seatLockTag;
		}
		private set
		{
			Set(ref seatLockTag, value, "SeatLockTag");
		}
	}

	public int SelectHeroIndex
	{
		get
		{
			return selectHeroIndex;
		}
		set
		{
			Set(ref selectHeroIndex, value, "SelectHeroIndex");
		}
	}

	public int HeroTryId => heroTryId;

	public HeroItemViewModel()
	{
		SetData(new HeroModel());
	}

	public HeroItemViewModel(OptionBase parent, HeroModel heroModel = null, int seatId = -1)
	{
		base.parent = parent;
		SetData(heroModel, seatId);
		heroTryId = heroModel?.Id ?? 0;
	}

	public void SetLevelFix(int level)
	{
		LevelFix = level;
	}

	public void SetHeroTryId(int tryId, int teamSetId, int tryHeroIndex)
	{
		heroTryId = tryId;
		this.teamSetId = teamSetId;
		this.tryHeroIndex = tryHeroIndex;
	}

	public void SetHeroTryTag(bool seatLockTag, bool heroTryTag)
	{
		SeatLockTag = seatLockTag;
		HeroTryTag = heroTryTag;
	}

	public void SetSeatId(int seatId)
	{
		SeatId = seatId;
	}

	public void SetIdentity(int index, bool isCap)
	{
		SeatText = (isCap ? "队" : $"{index}P");
	}

	public virtual void OnClick()
	{
		parent?.ItemOnClick(this);
	}

	public void SetSelected(bool value)
	{
		IsSelected = value;
	}

	public void SetChecked(bool value)
	{
		IsChecked = value;
		checkVal = (value ? 1 : 0);
	}

	public void SetData(HeroModel heroModel, int seatId = -1)
	{
		HeroModel = heroModel;
		SeatId = seatId;
	}

	public void SetSelectHeroIndex(int index)
	{
		SelectHeroIndex = index;
	}
}
