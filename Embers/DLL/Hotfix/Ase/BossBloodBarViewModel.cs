using System.Collections.Generic;
using System.Collections.Specialized;
using Ase.ECS;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class BossBloodBarViewModel : OptionBase, IPropertyChanged
{
	private readonly InteractionRequest<MonsterPhaseEnum> requestChangeBossStage;

	private readonly InteractionRequest onBuffListChangedRequest;

	private readonly InteractionRequest openDownEffectRequest;

	private readonly InteractionRequest requestShowBossAmend;

	private readonly InteractionRequest<bool> stopDownEffectRequest;

	private readonly InteractionRequest<bool> attackBossHpWeakRequest;

	private readonly InteractionRequest<bool> attackBossTenacityWeakRequest;

	private readonly InteractionRequest<bool> requestBossDownState;

	private readonly InteractionRequest showRoot2Request;

	private readonly InteractionRequest<int> bossDead;

	private BattleMonsterData emptyData;

	private BattleMonsterData monsterData;

	private MonsterPhaseEnum bossStage;

	private float downFill;

	private float downFillMax;

	private float currentBreakPercent;

	private bool isChangeState = true;

	private bool visibility;

	private bool isShowBuffDesc;

	private string buffName = string.Empty;

	private string buffDesc = string.Empty;

	private bool showRoot1;

	private bool showRoot2;

	private string monsterName;

	private string monsterIcon;

	private int tenacityCurZero;

	private Ase.ECS.PropertyData tenacityData;

	private bool downState;

	private string damageRatio;

	private List<string> amendList;

	private HeroAttributeEnum heroAttribute;

	private RectTransform pos;

	private BuffDescViewModel buffDescViewModel;

	public bool DownState => downState;

	public string DamageRatio => damageRatio;

	public List<string> AmendList => amendList;

	public HeroAttributeEnum HeroAttribute => heroAttribute;

	public RectTransform Pos => pos;

	public BattleMonsterData MonsterData
	{
		get
		{
			return monsterData;
		}
		private set
		{
			Set(ref monsterData, value, "MonsterData");
		}
	}

	public MonsterPhaseEnum BossStage
	{
		get
		{
			return bossStage;
		}
		private set
		{
			Set(ref bossStage, value, "BossStage");
		}
	}

	public float DownFill
	{
		get
		{
			return downFill;
		}
		set
		{
			Set(ref downFill, value, "DownFill");
		}
	}

	public float DownFillMax
	{
		get
		{
			return downFillMax;
		}
		set
		{
			Set(ref downFillMax, value, "DownFillMax");
		}
	}

	public float CurrentBreakPercent
	{
		get
		{
			return currentBreakPercent;
		}
		private set
		{
			Set(ref currentBreakPercent, value, "CurrentBreakPercent");
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

	public bool IsChangeState
	{
		get
		{
			return isChangeState;
		}
		set
		{
			Set(ref isChangeState, value, "IsChangeState");
		}
	}

	public bool ShowRoot1
	{
		get
		{
			return showRoot1;
		}
		private set
		{
			Set(ref showRoot1, value, "ShowRoot1");
		}
	}

	public bool ShowRoot2
	{
		get
		{
			return showRoot2;
		}
		private set
		{
			Set(ref showRoot2, value, "ShowRoot2");
		}
	}

	public bool Visibility
	{
		get
		{
			return visibility;
		}
		private set
		{
			Set(ref visibility, value, "Visibility");
		}
	}

	public string MonsterName
	{
		get
		{
			return monsterName;
		}
		private set
		{
			Set(ref monsterName, value, "MonsterName");
		}
	}

	public string MonsterIcon
	{
		get
		{
			return monsterIcon;
		}
		private set
		{
			Set(ref monsterIcon, value, "MonsterIcon");
		}
	}

	public int TenacityCurZero
	{
		get
		{
			return tenacityCurZero;
		}
		private set
		{
			Set(ref tenacityCurZero, value, "TenacityCurZero");
		}
	}

	public IInteractionRequest ShowRoot2Request => showRoot2Request;

	public IInteractionRequest RequestChangeBossStage => requestChangeBossStage;

	public IInteractionRequest OnBuffListChangedRequest => onBuffListChangedRequest;

	public IInteractionRequest OpenDownEffectRequest => openDownEffectRequest;

	public IInteractionRequest StopDownEffectRequest => stopDownEffectRequest;

	public IInteractionRequest AttackBossHpWeakRequest => attackBossHpWeakRequest;

	public IInteractionRequest AttackBossTenacityWeakRequest => attackBossTenacityWeakRequest;

	public IInteractionRequest RequestShowBossAmend => requestShowBossAmend;

	public IInteractionRequest RequestBossDownState => requestBossDownState;

	public IInteractionRequest BossDead => bossDead;

	public override void ItemOnClick(object obj)
	{
		if (obj is OptionArg optionArg && "OnShowDesc".Equals(optionArg.OptionName) && (buffDescViewModel == null || !buffDescViewModel.IsVisible))
		{
			OpenBuffDesc();
		}
	}

	public BossBloodBarViewModel(OptionBase parent)
	{
		base.parent = parent;
		requestChangeBossStage = new InteractionRequest<MonsterPhaseEnum>(this);
		onBuffListChangedRequest = new InteractionRequest(this);
		openDownEffectRequest = new InteractionRequest(this);
		requestShowBossAmend = new InteractionRequest(this);
		stopDownEffectRequest = new InteractionRequest<bool>(this);
		attackBossHpWeakRequest = new InteractionRequest<bool>(this);
		attackBossTenacityWeakRequest = new InteractionRequest<bool>(this);
		requestBossDownState = new InteractionRequest<bool>(this);
		showRoot2Request = new InteractionRequest(this);
		bossDead = new InteractionRequest<int>(this);
		BossStage = MonsterPhaseEnum.None;
		emptyData = BattleMonsterData.Empty();
		MonsterData = emptyData;
	}

	public void UpdateData(BattleMonsterData data, HeroAttributeEnum heroAttributeEnum)
	{
		if (MonsterData != null)
		{
			MonsterData.BuffList.CollectionChanged -= OnBuffListChanged;
			if (tenacityData != null)
			{
				tenacityData.RemoveOnChangedCallback(this);
			}
		}
		if (data == null)
		{
			MonsterData = emptyData;
			amendList = null;
		}
		else
		{
			MonsterData = data;
			MonsterIcon = MonsterData.Icon;
			MonsterData.BuffList.CollectionChanged += OnBuffListChanged;
			DRMonsterInfo dataRow = GameEntry.DataTable.GetDataRow<DRMonsterInfo>(data.GetMonsterType());
			if (dataRow != null)
			{
				MonsterName = MonsterData.LevelShow + dataRow.Name;
			}
			else
			{
				MonsterName = "未知怪物";
			}
			amendList = MonsterData.AmendList();
		}
		tenacityData = MonsterData.Property["Tenacity"];
		if (tenacityData != null)
		{
			tenacityData.SetPropertyName("Tenacity");
			tenacityData.RegisterOnChangedCallback(this);
		}
		heroAttribute = heroAttributeEnum;
		SetBossDown(enterDown: false, string.Empty);
	}

	public void ChangeBossStage(MonsterPhaseEnum stage)
	{
		BossStage = stage;
		requestChangeBossStage.Raise(bossStage);
	}

	private void OnBuffListChanged(object sender, NotifyCollectionChangedEventArgs e)
	{
		for (int i = 0; i < monsterData.BuffList.Count; i++)
		{
			monsterData.BuffList[i].SetParent(this);
		}
		onBuffListChangedRequest.Raise();
	}

	public void AddBuffDescRect(RectTransform descRect)
	{
		pos = descRect;
	}

	private void OpenBuffDesc()
	{
		if (monsterData.BuffList != null && monsterData.BuffList.Count > 0)
		{
			parent.ItemOnClick(new OptionArg(this, "OnShowBuffDesc"));
		}
	}

	public void GetBossBreakPercent(float per)
	{
		CurrentBreakPercent = per;
	}

	public void SetBossDownFillMax(float downFill)
	{
		DownFillMax = downFill;
		DownFill = downFill;
		openDownEffectRequest?.Raise();
	}

	public new void Open()
	{
	}

	public void Show(bool isShow, bool isInLevel)
	{
		Visibility = isShow;
		int num = 0;
		if (!isShow)
		{
			num = TSUtil.SetBitValue(1, 1, num);
		}
		if (isInLevel)
		{
			num = TSUtil.SetBitValue(2, 1, num);
		}
		bossDead.Raise(num);
	}

	public void ShowBar(bool isShow)
	{
		ShowRoot1 = isShow;
		requestShowBossAmend.Raise();
	}

	public void ShowName(bool isShow)
	{
		ShowRoot2 = isShow;
		if (isShow)
		{
			showRoot2Request.Raise();
		}
	}

	public void StopDownEffect(bool isStop)
	{
		stopDownEffectRequest.Raise(isStop);
	}

	public void AttackBoss(bool isWeak, bool reduceHp, bool reduceTenacity)
	{
		if (reduceHp)
		{
			attackBossHpWeakRequest.Raise(isWeak);
		}
		if (reduceTenacity)
		{
			attackBossTenacityWeakRequest.Raise(isWeak);
		}
	}

	public void OnPropertyChanged(string propertyName, PropertyChangedEnum changedEnum, float delta)
	{
		if (propertyName == "Tenacity" && changedEnum == PropertyChangedEnum.CurValue && tenacityData.CurValue == 0f)
		{
			tenacityCurZero = -1;
			TenacityCurZero = 0;
		}
	}

	public void SetBossDown(bool enterDown, string damageRatio)
	{
		this.damageRatio = damageRatio;
		downState = enterDown;
		requestBossDownState.Raise(enterDown);
	}
}
