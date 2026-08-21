using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Threading.Tasks;
using Ase.ECS;
using Coffee.UIExtensions;
using DG.Tweening;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BossBloodBarView : UGuiView
{
	public GameObject root1;

	public GameObject root2;

	public TextMeshProUGUI BossName1;

	public TextMeshProUGUI BossName2;

	public TextMeshProUGUI BossName3;

	public TweenBossHP hpBar;

	public TextMeshProUGUI hpText;

	[Space(10f)]
	[SerializeField]
	private GameObject angerRoot;

	[Space(10f)]
	[SerializeField]
	private GameObject angerStateRoot;

	[SerializeField]
	private Image angerBar;

	[SerializeField]
	private Animation angerStateAnimation;

	[Space(10f)]
	[SerializeField]
	private GameObject overdriveStageRoot;

	[SerializeField]
	private Image overdriveImg;

	[SerializeField]
	private GameObject overdriveBlackImage;

	[SerializeField]
	private Animation overdriveAnimation;

	[Space(10f)]
	[SerializeField]
	private GameObject breakStageRoot;

	[SerializeField]
	private Image breakBar;

	[SerializeField]
	private CanvasGroup breakStageCanvesGroup;

	[Space(10f)]
	[SerializeField]
	private GameObject overdriveState;

	[SerializeField]
	private GameObject breakState;

	[SerializeField]
	private Image bossIcon1;

	[SerializeField]
	private Image bossIcon2;

	public TweenBossTenacity tenacityBar;

	public GameObject tenacityRoot;

	public LoopGridView buffList;

	public RectTransform descRect;

	public GameObject DownEffect;

	private float hpModify;

	private bool showRoot2;

	[SerializeField]
	private GameObject downOverEffect;

	[SerializeField]
	private UIParticle downOverUIParticle;

	[SerializeField]
	private GameObject weakHpEffect;

	[SerializeField]
	private UIParticle weakHpUIParticle;

	[SerializeField]
	private GameObject weakTenacityEffect;

	[SerializeField]
	private UIParticle weakTenacityUIParticle;

	[SerializeField]
	private GameObject normalHpEffect;

	[SerializeField]
	private UIParticle normalHpUIParticle;

	[SerializeField]
	private GameObject normalTenacityEffect;

	[SerializeField]
	private UIParticle normalTenacityUIParticle;

	[SerializeField]
	private List<MonsterAmendUI> _amendGameObjects;

	[SerializeField]
	private Animator tenacityLock;

	[SerializeField]
	private Animation damageRatioAni;

	[SerializeField]
	private TextMeshProUGUI damageRatioText1;

	[SerializeField]
	private TextMeshProUGUI damageRatioText2;

	[SerializeField]
	private GameObject enterDownShow;

	[SerializeField]
	private GameObject killBossShow;

	private BossBloodBarViewModel viewModel;

	private bool lockTenacity;

	private int _lastCurHp;

	private int _lastMaxHp;

	private Animator aniRoot1;

	private string bossIcon;

	private float downFillMax;

	private MonsterPhaseEnum lastMonsterPhaseEnum;

	private string bossTypeNormal = "BossType0";

	private string bossType1Enter = "BossType1Enter";

	private string bossType1Out = "BossType1Out";

	private Tweener breakStageTween;

	public string BossIcon
	{
		get
		{
			return bossIcon;
		}
		set
		{
			bossIcon = value;
			SetBossIcon(value);
		}
	}

	public bool ShowRoot
	{
		get
		{
			return showRoot2;
		}
		set
		{
			showRoot2 = value;
			root2.SetActive(value);
		}
	}

	protected void LateUpdate()
	{
		ObservableDictionary<string, Ase.ECS.PropertyData> property = viewModel.MonsterData.Property;
		if (property.ContainsKey("Hp"))
		{
			Ase.ECS.PropertyData propertyData = property["Hp"];
			if (hpBar.HpCurValue != propertyData.CurValue)
			{
				hpBar.HpCurValue = propertyData.CurValue;
			}
			if (hpBar.HpMaxValue != propertyData.MaxValue)
			{
				hpBar.HpMaxValue = propertyData.MaxValue;
			}
			int num = Mathf.FloorToInt(propertyData.CurValue);
			int num2 = Mathf.FloorToInt(propertyData.MaxValue);
			if (_lastCurHp != num || _lastMaxHp != num2)
			{
				_lastCurHp = num;
				_lastMaxHp = num2;
				if (((Component)(object)hpText).gameObject.activeInHierarchy)
				{
					((TMP_Text)hpText).SetText("{0}/{1}", (float)num, (float)num2);
				}
			}
		}
		if (property.ContainsKey("MonsterAnger"))
		{
			Ase.ECS.PropertyData propertyData2 = property["MonsterAnger"];
			Image image = angerBar;
			float fillAmount = (overdriveImg.fillAmount = ((propertyData2.MaxValue == 0f) ? 0f : Mathf.Clamp01(propertyData2.CurValue / propertyData2.MaxValue)));
			image.fillAmount = fillAmount;
		}
		if (property.ContainsKey("Tenacity"))
		{
			int num4 = (int)property["Tenacity"].CurValue;
			int num5 = (int)property["Tenacity"].MaxValue;
			if (tenacityBar.DestValue != num4)
			{
				tenacityBar.DestValue = num4;
			}
			tenacityBar.PerMaxValue = num5;
			tenacityBar.MaxValue = num5;
		}
		if (viewModel.ShowRoot1 && property.ContainsKey("TenacityMitigate"))
		{
			if (property["TenacityMitigate"].CurValue == 1f && !lockTenacity)
			{
				tenacityLock.Play("Lock");
				tenacityLock.SetBool("Lock", true);
				lockTenacity = true;
			}
			else if (property["TenacityMitigate"].CurValue == 0f && lockTenacity)
			{
				tenacityLock.Play("UnLock");
				tenacityLock.SetBool("Lock", false);
				lockTenacity = false;
			}
		}
	}

	protected override void OnInit(object userData)
	{
		viewModel = (BossBloodBarViewModel)userData;
		BindingSet<BossBloodBarView, BossBloodBarViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(root1).For((GameObject v) => v.activeSelf).To((BossBloodBarViewModel vm) => vm.ShowRoot1);
		bindingSet.Bind(this).For((BossBloodBarView v) => v.ShowRoot).To((BossBloodBarViewModel vm) => vm.ShowRoot2);
		bindingSet.Bind().For((BossBloodBarView v) => v.ShowRoot2).To((BossBloodBarViewModel vm) => vm.ShowRoot2Request);
		bindingSet.Bind<TextMeshProUGUI>(BossName1).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BossBloodBarViewModel vm) => vm.MonsterName);
		bindingSet.Bind<TextMeshProUGUI>(BossName2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BossBloodBarViewModel vm) => vm.MonsterName);
		bindingSet.Bind<TextMeshProUGUI>(BossName3).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BossBloodBarViewModel vm) => vm.MonsterName);
		bindingSet.Bind().For((BossBloodBarView v) => OnRequestChangeBossStage).To((BossBloodBarViewModel vm) => vm.RequestChangeBossStage);
		bindingSet.Bind().For((BossBloodBarView v) => OnRequestAttackBossHp).To((BossBloodBarViewModel vm) => vm.AttackBossHpWeakRequest);
		bindingSet.Bind().For((BossBloodBarView v) => OnRequestAttackBossTenacity).To((BossBloodBarViewModel vm) => vm.AttackBossTenacityWeakRequest);
		bindingSet.Bind().For((BossBloodBarView v) => OnShowAmend).To((BossBloodBarViewModel vm) => vm.RequestShowBossAmend);
		bindingSet.Bind().For((BossBloodBarView v) => OnRequestBossDownState).To((BossBloodBarViewModel vm) => vm.RequestBossDownState);
		bindingSet.Bind(this).For((BossBloodBarView v) => v.OnDismissRequest).To((BossBloodBarViewModel vm) => vm.DismissRequest);
		bindingSet.Bind().For((BossBloodBarView v) => OnBossDead).To((BossBloodBarViewModel vm) => vm.BossDead);
		bindingSet.Bind(this).For((BossBloodBarView v) => v.BossIcon).To((BossBloodBarViewModel vm) => vm.MonsterIcon);
		bindingSet.Bind(angerRoot).For((GameObject v) => v.activeSelf).ToExpression((BossBloodBarViewModel vm) => vm.IsChangeState);
		bindingSet.Bind(overdriveStageRoot).For((GameObject v) => v.activeSelf).ToExpression((BossBloodBarViewModel vm) => (int)vm.BossStage == 2);
		bindingSet.Bind(breakStageRoot).For((GameObject v) => v.activeSelf).ToExpression((BossBloodBarViewModel vm) => (int)vm.BossStage == 3);
		bindingSet.Bind(angerStateRoot).For((GameObject v) => v.activeSelf).ToExpression((BossBloodBarViewModel vm) => (int)vm.BossStage == 1 || (int)vm.BossStage == 0);
		bindingSet.Bind(breakBar).For((Image v) => v.fillAmount).ToExpression((BossBloodBarViewModel vm) => (vm.CurrentBreakPercent <= 1f) ? (1f - vm.CurrentBreakPercent) : 0f);
		bindingSet.Bind().For((BossBloodBarView v) => OnBuffListChanged).To((BossBloodBarViewModel vm) => vm.OnBuffListChangedRequest);
		bindingSet.Bind(tenacityBar).For((TweenBossTenacity v) => v.DestValue).To((BossBloodBarViewModel vm) => vm.TenacityCurZero);
		bindingSet.Build();
		hpBar.InitBar();
		tenacityBar.InitBar();
		viewModel.AddBuffDescRect(descRect);
		aniRoot1 = root1.GetComponent<Animator>();
	}

	private void OnDismissRequest(object sender, InteractionEventArgs e)
	{
		this.ClearAllBindings();
	}

	private void OnRequestBossDownState(object sender, InteractionEventArgs e)
	{
		bool flag = (bool)e.Context;
		tenacityBar.SetDownState(flag);
		if (flag)
		{
			((Component)(object)damageRatioAni).gameObject.SetActive(flag);
			damageRatioAni.Play("dmg_enter");
			((TMP_Text)damageRatioText1).text = viewModel.DamageRatio;
			((TMP_Text)damageRatioText2).text = viewModel.DamageRatio;
		}
		else
		{
			damageRatioAni.Play("dmg_out");
		}
		enterDownShow.SetActive(flag);
		if (!flag)
		{
			SetEffectAutoDis(downOverEffect, downOverUIParticle);
		}
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		OnBuffListChanged(null, null);
	}

	private async void ShowRoot2(object sender, InteractionEventArgs e)
	{
		await Task.Delay(2500);
		root2.gameObject.SetActive(value: false);
	}

	private void RefreshData(object sender, InteractionEventArgs e)
	{
		this.ClearAllBindings();
		Init(viewModel);
	}

	protected void OnBuffListChanged(object sender, InteractionEventArgs e)
	{
		if (viewModel != null && viewModel.MonsterData != null && viewModel.MonsterData.BuffList != null)
		{
			int num = ((viewModel.MonsterData.BuffList.Count > 6) ? 6 : viewModel.MonsterData.BuffList.Count);
			if (!buffList.MListViewInited)
			{
				buffList.InitGridView(num, OnGetBuffItemByIndex);
				return;
			}
			buffList.SetListItemCount(num);
			buffList.RefreshAllShownItem();
		}
	}

	protected LoopGridViewItem OnGetBuffItemByIndex(LoopGridView gridView, int index, int row, int column)
	{
		if (index < 0 || index >= viewModel.MonsterData.BuffList.Count)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = gridView.NewListViewItem("BuffItemView");
		if (loopGridViewItem != null)
		{
			BuffItemView component = loopGridViewItem.GetComponent<BuffItemView>();
			if (!loopGridViewItem.IsInitHandlerCalled)
			{
				loopGridViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.MonsterData.BuffList[index]);
			}
			else
			{
				component.RefreshData(viewModel.MonsterData.BuffList[index]);
			}
		}
		return loopGridViewItem;
	}

	private void OnRequestChangeBossStage(object sender, InteractionEventArgs e)
	{
		if (viewModel == null || viewModel.MonsterData == null)
		{
			return;
		}
		MonsterPhaseEnum monsterPhaseEnum = (MonsterPhaseEnum)e.Context;
		bool isOutBreak = lastMonsterPhaseEnum == MonsterPhaseEnum.Break;
		if (viewModel.MonsterData.StateType == 0)
		{
			ShowStageFill(monsterPhaseEnum == MonsterPhaseEnum.OverDrive, monsterPhaseEnum == MonsterPhaseEnum.Normal || monsterPhaseEnum == MonsterPhaseEnum.None);
		}
		else if (viewModel.MonsterData.StateType == 1)
		{
			if (monsterPhaseEnum != MonsterPhaseEnum.Break)
			{
				ShowStageFill(monsterPhaseEnum == MonsterPhaseEnum.OverDrive, monsterPhaseEnum == MonsterPhaseEnum.Normal || monsterPhaseEnum == MonsterPhaseEnum.None);
			}
			else
			{
				ShowStageFill(lastMonsterPhaseEnum == MonsterPhaseEnum.OverDrive, lastMonsterPhaseEnum == MonsterPhaseEnum.Normal || lastMonsterPhaseEnum == MonsterPhaseEnum.None);
			}
		}
		switch (monsterPhaseEnum)
		{
		case MonsterPhaseEnum.OverDrive:
		{
			Sequence sequence2 = DOTween.Sequence();
			sequence2.AppendCallback(delegate
			{
				overdriveState.SetActive(value: true);
			});
			sequence2.AppendInterval(5f);
			sequence2.Play();
			sequence2.AppendCallback(delegate
			{
				overdriveState.SetActive(value: false);
			});
			overdriveBlackImage.SetActive(viewModel.MonsterData.StateType == 0);
			StagePlayAnimation(overdriveAnimation, isOutBreak);
			break;
		}
		case MonsterPhaseEnum.Break:
		{
			Sequence sequence = DOTween.Sequence();
			sequence.AppendCallback(delegate
			{
				breakState.SetActive(value: true);
			});
			sequence.AppendInterval(1.5f);
			sequence.Play();
			sequence.AppendCallback(delegate
			{
				breakState.SetActive(value: false);
			});
			if (viewModel.MonsterData.StateType == 1)
			{
				if (lastMonsterPhaseEnum == MonsterPhaseEnum.OverDrive)
				{
					overdriveAnimation.Play(bossType1Enter);
				}
				else if (lastMonsterPhaseEnum == MonsterPhaseEnum.Normal || lastMonsterPhaseEnum == MonsterPhaseEnum.None)
				{
					angerStateAnimation.Play(bossType1Enter);
				}
				breakStageCanvesGroup.alpha = 0f;
				breakStageTween = DOTweenModuleUI.DOFade(breakStageCanvesGroup, 1f, 0.2f).OnComplete(delegate
				{
					breakStageTween = null;
				});
			}
			else
			{
				if (breakStageTween != null)
				{
					DOTween.Kill(breakStageTween);
					breakStageTween = null;
				}
				breakStageCanvesGroup.alpha = 1f;
			}
			break;
		}
		case MonsterPhaseEnum.Normal:
			StagePlayAnimation(angerStateAnimation, isOutBreak);
			break;
		}
		lastMonsterPhaseEnum = monsterPhaseEnum;
	}

	private void StagePlayAnimation(Animation stageAnimation, bool isOutBreak)
	{
		if (viewModel.MonsterData.StateType == 0)
		{
			stageAnimation.Play(bossTypeNormal);
		}
		else if (viewModel.MonsterData.StateType == 1 && isOutBreak)
		{
			stageAnimation.Play(bossType1Out);
		}
	}

	private void ShowStageFill(bool showODFill, bool showAngerFill)
	{
		((Component)(object)overdriveAnimation).gameObject.SetActive(showODFill);
		((Component)(object)angerStateAnimation).gameObject.SetActive(showAngerFill);
	}

	protected override void OnVisibleChanged(object sender, InteractionEventArgs e)
	{
		bool flag = (bool)e.Context;
		CanvasGroup.alpha = (flag ? 1 : 0);
	}

	protected override void OnDestroy()
	{
		hpBar.StopCoroutinesAhead();
		base.OnDestroy();
	}

	private void OnRequestAttackBossHp(object sender, InteractionEventArgs e)
	{
		bool flag = (bool)e.Context;
		if (!flag)
		{
			flag = viewModel.BossStage == MonsterPhaseEnum.Break || viewModel.DownState;
		}
		if (flag)
		{
			SetEffectAutoDis(weakHpEffect, weakHpUIParticle);
		}
		else
		{
			SetEffectAutoDis(normalHpEffect, normalHpUIParticle);
		}
	}

	private void OnBossDead(object sender, InteractionEventArgs e)
	{
		int value = (int)e.Context;
		bool flag = TSUtil.GetBitValue(1, value) == 1;
		bool num = TSUtil.GetBitValue(2, value) == 1;
		CanvasGroup.alpha = 1f;
		if ((bool)(UnityEngine.Object)(object)aniRoot1)
		{
			if (flag)
			{
				aniRoot1.Play("BossDead");
				lastMonsterPhaseEnum = MonsterPhaseEnum.None;
			}
			else
			{
				aniRoot1.Play("BossShow");
			}
		}
		else
		{
			CanvasGroup.alpha = ((!flag) ? 1 : 0);
		}
		if (flag)
		{
			lockTenacity = false;
			tenacityLock.Play("Normal");
			tenacityLock.SetBool("Lock", false);
		}
		if (!num)
		{
			killBossShow.SetActive(flag);
		}
	}

	private async void SetBossIcon(string iconName)
	{
		if (!string.IsNullOrEmpty(iconName))
		{
			Sprite sprite = await LoadSpriteAsync(SkinAssetUtility.GetBossIcon(iconName));
			if (!(sprite == null))
			{
				bossIcon1.sprite = sprite;
				bossIcon2.sprite = sprite;
			}
		}
	}

	private void OnRequestAttackBossTenacity(object sender, InteractionEventArgs e)
	{
		bool flag = (bool)e.Context;
		if (!flag)
		{
			flag = viewModel.BossStage == MonsterPhaseEnum.Break || viewModel.DownState;
		}
		if (flag)
		{
			SetEffectAutoDis(weakTenacityEffect, weakTenacityUIParticle);
		}
		else
		{
			SetEffectAutoDis(normalTenacityEffect, normalTenacityUIParticle);
		}
	}

	private void SetEffectAutoDis(GameObject autoDispose, UIParticle particle)
	{
		if (autoDispose.activeSelf)
		{
			particle.Play();
		}
		else
		{
			autoDispose.SetActive(value: true);
		}
	}

	private void OnShowAmend(object sender, InteractionEventArgs e)
	{
		if (viewModel == null || viewModel.AmendList == null)
		{
			return;
		}
		List<string> amendList = viewModel.AmendList;
		string text = HeroAttributeEnumToProperty(viewModel.HeroAttribute);
		foreach (MonsterAmendUI amendGameObject in _amendGameObjects)
		{
			bool flag = amendList.Contains(amendGameObject.AmendName);
			bool active = flag && amendGameObject.AmendName == text;
			bool active2 = flag && amendGameObject.AmendName != text;
			if (flag)
			{
				amendGameObject.On.SetActive(active);
				amendGameObject.Off.SetActive(active2);
			}
			amendGameObject.gameObject.SetActive(flag);
		}
	}

	private string HeroAttributeEnumToProperty(HeroAttributeEnum heroAttributeEnum)
	{
		return heroAttributeEnum switch
		{
			HeroAttributeEnum.Dark => "AmendByDark", 
			HeroAttributeEnum.Wind => "AmendByWind", 
			HeroAttributeEnum.Fire => "AmendByFire", 
			HeroAttributeEnum.Water => "AmendByWater", 
			HeroAttributeEnum.Light => "AmendByLight", 
			HeroAttributeEnum.Thunder => "AmendByThunder", 
			HeroAttributeEnum.Ice => "AmendByIce", 
			_ => string.Empty, 
		};
	}
}
