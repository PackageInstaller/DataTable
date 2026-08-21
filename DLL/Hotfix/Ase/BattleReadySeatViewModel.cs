using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class BattleReadySeatViewModel : HeroViewModel
{
	private int _seatId;

	private bool _isCaptain;

	private bool _practiceTag;

	private bool _seatLockTag;

	private bool _heroTryTag;

	private int heroTryId;

	private string attribute = "";

	private string _cardFrame = "";

	private int destinyLevel;

	private bool configDisable;

	private InteractionRequest<HeroModel> _onHeroModelChangedRequest;

	public string Attribute
	{
		get
		{
			return attribute;
		}
		set
		{
			Set(ref attribute, value, "Attribute");
		}
	}

	public string CardFrame
	{
		get
		{
			return _cardFrame;
		}
		set
		{
			Set(ref _cardFrame, value, "CardFrame");
		}
	}

	public new HeroModel Data
	{
		get
		{
			return base.Data;
		}
		set
		{
			base.Data = value;
			Attribute = (value.IsNullOrEmpty() ? Attribute : $"hero_attr_{(int)value.Attribute}");
		}
	}

	public bool PracticeTag
	{
		get
		{
			return _practiceTag;
		}
		private set
		{
			Set(ref _practiceTag, value, "PracticeTag");
		}
	}

	public bool HeroTryTag
	{
		get
		{
			return _heroTryTag;
		}
		private set
		{
			Set(ref _heroTryTag, value, "HeroTryTag");
		}
	}

	public bool SeatLockTag
	{
		get
		{
			return _seatLockTag;
		}
		private set
		{
			Set(ref _seatLockTag, value, "SeatLockTag");
		}
	}

	public bool ConfigDisable
	{
		get
		{
			return configDisable;
		}
		set
		{
			Set(ref configDisable, value, "ConfigDisable");
		}
	}

	public int SeatId => _seatId;

	public int HeroTryId => heroTryId;

	public InteractionRequest<HeroModel> OnHeroModelChangedRequest => _onHeroModelChangedRequest;

	public BattleReadySeatViewModel(OptionBase parent)
		: base(parent)
	{
		_onHeroModelChangedRequest = new InteractionRequest<HeroModel>();
	}

	public void SetSeatData(int seatId, bool isCaptain)
	{
		_seatId = seatId;
		_isCaptain = isCaptain;
		List<int> list = Singleton<ServiceSystem>.Instance.GetService<IBFBEService>()?.GetCardFrameSet() ?? new List<int>();
		int id = ((list.Count > seatId - 1) ? list[seatId - 1] : 0);
		CardFrame = GameEntry.DataTable.GetDataRow<DRHeroCardFrame>(id)?.EdgePath ?? "";
	}

	public void RefreshHero(HeroModel heroModel)
	{
		if ((!Data.IsNullOrEmpty() || !heroModel.IsNullOrEmpty()) && (Data.IsNullOrEmpty() || heroModel.IsNullOrEmpty() || !Data.Id.Equals(heroModel.Id)))
		{
			HeroModel context = Data;
			Data = heroModel;
			_onHeroModelChangedRequest.Raise(context);
		}
	}

	public void SetPracticeTag(bool visible)
	{
	}

	public void SetHeroTry(bool isLock, bool isTry, int heroTryId)
	{
		if (!data.Empty)
		{
			SeatLockTag = isLock;
			HeroTryTag = isTry;
			this.heroTryId = heroTryId;
		}
		else
		{
			SeatLockTag = false;
			HeroTryTag = false;
			this.heroTryId = 0;
		}
	}

	public void OnPointerEnter()
	{
		if (parent != null && parent is BattleReadyViewModel battleReadyViewModel)
		{
			battleReadyViewModel.OnPointerEnterSeat(this);
		}
	}

	public void OnPointerExit()
	{
		if (parent != null && parent is BattleReadyViewModel battleReadyViewModel)
		{
			battleReadyViewModel.OnPointerExitSeat(this);
		}
	}

	public void OnSeatBtnClick()
	{
		if (_seatLockTag)
		{
			ShowHeroTryLockToast();
		}
		else
		{
			parent.ItemOnClick(this);
		}
	}

	public void ShowHeroTryLockToast()
	{
		Toast.ShowInfo("无法调整锁定位置烬天使");
	}
}
