using System.Collections.Specialized;
using Ase.ECS;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class BattleUserViewModel : OptionBase
{
	private bool isShowBuffDesc;

	private string buffName = string.Empty;

	private string buffDesc = string.Empty;

	private bool isEmpty;

	private int rebornCountLeft;

	private string iconPath;

	private BattleHeroData emptyData;

	private BattleHeroData heroData;

	private BattleChaosData chaosData;

	private readonly InteractionRequest onBuffListChangedRequest = new InteractionRequest();

	private readonly InteractionRequest onAbnormalStateRequest = new InteractionRequest();

	private readonly InteractionRequest onPlayHpEffectRequest = new InteractionRequest();

	private readonly InteractionRequest refreshDataRequest = new InteractionRequest();

	private HeroSkillData emptyHeroSkillData;

	private HeroSkillData _uitimateSkill;

	private RectTransform pos;

	private BuffDescViewModel buffDescViewModel;

	public bool GamePause;

	public HeroSkillData UItimateSkill
	{
		get
		{
			return _uitimateSkill;
		}
		set
		{
			Set(ref _uitimateSkill, value, "UItimateSkill");
		}
	}

	public bool IsEmpty
	{
		get
		{
			return isEmpty;
		}
		private set
		{
			Set(ref isEmpty, value, "IsEmpty");
		}
	}

	public BattleHeroData HeroData
	{
		get
		{
			return heroData;
		}
		private set
		{
			Set(ref heroData, value, "HeroData");
		}
	}

	public string BuffName
	{
		get
		{
			return buffName;
		}
		set
		{
			Set(ref buffName, value, "BuffName");
		}
	}

	public string BuffDesc
	{
		get
		{
			return buffDesc;
		}
		set
		{
			Set(ref buffDesc, value, "BuffDesc");
		}
	}

	public BattleChaosData ChaosData
	{
		get
		{
			return chaosData;
		}
		set
		{
			Set(ref chaosData, value, "ChaosData");
		}
	}

	public int RebornCountLeft
	{
		get
		{
			return rebornCountLeft;
		}
		private set
		{
			Set(ref rebornCountLeft, value, "RebornCountLeft");
		}
	}

	public string IconPath
	{
		get
		{
			return iconPath;
		}
		private set
		{
			Set(ref iconPath, value, "IconPath");
		}
	}

	public IInteractionRequest OnBuffListChangedRequest => onBuffListChangedRequest;

	public IInteractionRequest OnAbnormalStateRequest => onAbnormalStateRequest;

	public IInteractionRequest OnPlayHpEffectRequest => onPlayHpEffectRequest;

	public IInteractionRequest RefreshDataRequest => refreshDataRequest;

	public override void ItemOnClick(object obj)
	{
		if (obj is OptionArg optionArg && "OnShowDesc".Equals(optionArg.OptionName) && buffDescViewModel != null)
		{
			_ = buffDescViewModel.IsVisible;
		}
	}

	public BattleUserViewModel()
	{
	}

	public static BattleUserViewModel Empty(OptionBase parent)
	{
		return new BattleUserViewModel(parent);
	}

	public BattleUserViewModel(OptionBase parent)
	{
		base.parent = parent;
		emptyData = BattleHeroData.Empty();
		HeroData = emptyData;
		IsEmpty = true;
		emptyHeroSkillData = HeroSkillData.CreateEmpty();
		UItimateSkill = emptyHeroSkillData;
	}

	public void UpdateHero(BattleHeroData battleHeroData)
	{
		if (battleHeroData == null || battleHeroData.HeroModel == null)
		{
			IsEmpty = true;
			if (HeroData != null)
			{
				HeroData.BuffList.CollectionChanged -= OnBuffListChanged;
				HeroData.AbnormalStateList.CollectionChanged -= OnAbnormalStateListChanged;
			}
			HeroData = emptyData;
			UItimateSkill = emptyHeroSkillData;
		}
		else
		{
			IsEmpty = false;
			HeroData = battleHeroData;
			HeroData.BuffList.CollectionChanged += OnBuffListChanged;
			HeroData.AbnormalStateList.CollectionChanged += OnAbnormalStateListChanged;
			UItimateSkill = battleHeroData.CommandType2HeroData[HeroSkillTypeEnum.Skill4];
			IconPath = HeroDefinition.GetHeroIconPath(HeroDefinition.HeroIconType.BattleAvatar, battleHeroData);
		}
	}

	public void SetHeroEmpty()
	{
		IsEmpty = true;
	}

	public void OnUserClick()
	{
		_ = IsEmpty;
	}

	public void OnReleaseSkill4()
	{
		if (!IsEmpty)
		{
			parent?.ItemOnClick(new OptionArg(this, "OnReleaseSkill4"));
		}
	}

	public void RefreshRebornCount(int val)
	{
		RebornCountLeft = val;
	}

	public void OnObserverTeachEnergyGuide()
	{
		if (!IsEmpty)
		{
			parent?.ItemOnClick(new OptionArg(this, "OnObserverTeachEnergyGuide"));
		}
	}

	public void OnObserverTeachAIXpGuide(Transform frame)
	{
		if (!IsEmpty)
		{
			parent?.ItemOnClick(new OptionArg(frame, "OnObserverTeachAIXpGuide"));
		}
	}

	private void OnBuffListChanged(object sender, NotifyCollectionChangedEventArgs e)
	{
		if (HeroData.BuffList != null)
		{
			for (int i = 0; i < heroData.BuffList.Count; i++)
			{
				heroData.BuffList[i].SetParent(this);
			}
			onBuffListChangedRequest.Raise();
		}
	}

	private void OnAbnormalStateListChanged(object sender, NotifyCollectionChangedEventArgs e)
	{
		if (HeroData.AbnormalStateList != null)
		{
			for (int i = 0; i < heroData.AbnormalStateList.Count; i++)
			{
				heroData.AbnormalStateList[i].SetParent(this);
			}
			onAbnormalStateRequest.Raise();
		}
	}

	public void AddBuffDescRect(RectTransform descRect)
	{
		pos = descRect;
	}

	public void PlayHpEffect()
	{
		onPlayHpEffectRequest.Raise();
	}

	protected override void Dispose(bool disposing)
	{
		base.Dispose(disposing);
		buffDescViewModel = null;
		heroData = null;
		chaosData = null;
	}

	public void SetPause(bool isPause)
	{
		GamePause = isPause;
	}
}
