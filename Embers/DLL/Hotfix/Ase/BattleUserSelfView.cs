using System.Collections.Generic;
using Ase.ECS;
using DG.Tweening;
using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace Ase;

public class BattleUserSelfView : BattleUserView
{
	public AutoDispose hpEffectGo;

	public Text nameText;

	private float hpCur;

	public RectTransform hpLight;

	public Image rebornBar;

	public GameObject rescueRoot;

	public Image rescueBar;

	private IObjectPool<GameObject> energyEffect2Pool;

	[Header("武器属性")]
	public SwordActiveView swordActiveView;

	public GunActiveView gunActiveView;

	public GlovesActiveView glovesActiveView;

	public BowActiveView bowActiveView;

	public HammerActiveView hammerActiveView;

	[FormerlySerializedAs("spearActiveView")]
	public LanceActiveView lanceActiveView;

	public GameObject HpWarnObj;

	public Animation EnergyAnimation;

	public Image EnergyFillNor;

	public Image EnergyFillSlc;

	public Transform EnergyShow;

	public CanvasGroup EnergyCanvasGroup;

	public GameObject EnergySegment;

	public GameObject EnergyNormalObj;

	public GameObject EnergyOverDraftObj;

	public Transform EnergyAddEffect;

	public float EnergyAddEffectTime = 0.2f;

	public LoopGridView abnormalStateList;

	public SkillChargeBuffLayerView SkillChargeBuffLayerView;

	public HeroIndepentResSkillLayerView HeroIndepentResSkillLayerView;

	public BuffLayerView BuffLayerView;

	public HeroBuffUI2View HeroBuffUI2View;

	public HeroSkillLayerUI2View heroSkillLayerUI2View;

	public BuffLayer2View buffLayer2View;

	public JXKBuffLayerView jxkbufflayerview;

	public LSLBuffLayerView lSLBuffLayerView;

	public YunZhaoBuffLayerView yunZhaoBuffLayerView;

	public SkillQMMBuffLayerView skillQMMBuffLayerView;

	public SkillSFYBuffLayerView skillSFYBuffLayerView;

	public SkillMYBuffLayerView skillMYBuffLayerView;

	public SkillNLLBuffLayerView skillNLLBuffLayerView;

	public float energyUIMoveSpeed = 5f;

	private Camera battleCamera;

	private Transform energyFollow;

	private bool energyValueIsMax = true;

	private float energyFillAmountValue;

	private Vector2 energyUIOffset = Vector2.zero;

	public Color energyNoFillColor;

	private bool teachObserverEnergy = true;

	private bool energyFillMax = true;

	private List<EnergyShowData> energySegmentObj = new List<EnergyShowData>(5);

	private float energyMaxValue;

	private WeaponEnum _weaponEnum;

	private HeroIndepentType _heroIndepentType;

	private bool showEnergyEffect;

	private Tween energyAddTween;

	private bool showEnergyAddEffect;

	private float hpBarWidth;

	public float EnergyFillAmountValue
	{
		get
		{
			return energyFillAmountValue;
		}
		set
		{
			EnergyValueChange(value);
		}
	}

	public float EnergyMaxValue
	{
		get
		{
			return energyMaxValue;
		}
		set
		{
			EnergySegmentShow(value);
		}
	}

	public WeaponEnum WeaponEnum
	{
		get
		{
			return _weaponEnum;
		}
		set
		{
			if (value != WeaponEnum.None)
			{
				RefreshWeaponActiveView(viewModel);
			}
		}
	}

	public HeroIndepentType HeroIndepentType
	{
		get
		{
			return _heroIndepentType;
		}
		set
		{
			if (value != HeroIndepentType.None)
			{
				RefreshIndepentResView(viewModel);
			}
		}
	}

	public bool ShowEnergyEffect
	{
		get
		{
			return showEnergyEffect;
		}
		set
		{
			showEnergyEffect = value;
			EnergyUnenoughEffectRequest();
		}
	}

	public bool ShowEnergyAddEffect
	{
		get
		{
			return showEnergyAddEffect;
		}
		set
		{
			float num = 0f;
			ObservableDictionary<string, Ase.ECS.PropertyData> property = viewModel.HeroData.Property;
			if (property.ContainsKey("Energy"))
			{
				Ase.ECS.PropertyData propertyData = property["Energy"];
				num = ((propertyData.MaxValue == 0f) ? 1f : (propertyData.CurValue * 1f / propertyData.MaxValue));
			}
			if (!energyFillMax && !(num <= 0f))
			{
				showEnergyAddEffect = value;
				if (energyAddTween != null)
				{
					EnergyAddEffect.localEulerAngles = Vector3.zero;
					energyAddTween.Kill();
					energyAddTween = null;
					EnergyAddEffect.gameObject.SetActive(value: false);
				}
				EnergyAddEffect.localEulerAngles = Vector3.zero;
				EnergyAddEffect.gameObject.SetActive(value: true);
				energyAddTween = EnergyAddEffect.DOLocalRotate(Vector3.back * num * 360f, EnergyAddEffectTime, RotateMode.LocalAxisAdd).OnComplete(delegate
				{
					energyAddTween = null;
					EnergyAddEffect.gameObject.SetActive(value: false);
				});
			}
		}
	}

	public float HpCur
	{
		get
		{
			return hpCur;
		}
		set
		{
			AddLight(hpBar.GetFillVal(), hpBarWidth, hpLight, changeSize: false);
			hpCur = hpBar.DestValue;
		}
	}

	private void EnergySegmentShow(float energyMaxValue)
	{
		if (energyMaxValue < 300f)
		{
			for (int i = 0; i < energySegmentObj.Count; i++)
			{
				energySegmentObj[i].EnergySegGobj.SetActive(value: false);
			}
		}
		int num = 0;
		num = ((energyMaxValue % 300f != 0f) ? ((int)energyMaxValue / 300) : ((int)energyMaxValue / 300 - 1));
		if (energySegmentObj.Count < num)
		{
			for (int j = energySegmentObj.Count + 1; j <= num; j++)
			{
				GameObject gameObject = Object.Instantiate(EnergySegment, EnergyShow);
				energySegmentObj.Add(new EnergyShowData
				{
					EnergySegGobj = gameObject,
					EnergySegImage = gameObject.transform.Find("Image").GetComponent<Image>(),
					EnergySegAnimation = gameObject.GetComponent<Animation>()
				});
			}
		}
		float num2 = 108000f / energyMaxValue;
		for (int k = 0; k < energySegmentObj.Count; k++)
		{
			if (num - 1 >= k)
			{
				energySegmentObj[k].EnergySegGobj.SetActive(value: true);
				energySegmentObj[k].EnergySegGobj.transform.localEulerAngles = num2 * (float)(k + 1) * Vector3.back;
				energySegmentObj[k].EnergySegValue = num2 * (float)(k + 1) / 360f;
			}
			else
			{
				energySegmentObj[k].EnergySegGobj.SetActive(value: false);
				energySegmentObj[k].EnergySegValue = 0f;
			}
		}
	}

	private void EnergyValueChange(float value)
	{
		if (energyFillAmountValue == value)
		{
			return;
		}
		bool flag = value < 0f;
		EnergyNormalObj.SetActive(!flag);
		EnergyOverDraftObj.SetActive(flag);
		EnergyFillNor.fillAmount = value;
		EnergyFillSlc.fillAmount = Mathf.Abs(value);
		if (value == 1f && !energyValueIsMax)
		{
			energyValueIsMax = true;
			EnergyAnimation.Play("EnergyFillMax");
			energyFillMax = true;
		}
		else if (value < 1f && value >= 0f)
		{
			EnergyAnimation.Play("EnergyConsume");
			energyFillMax = false;
			EnergyCanvasGroup.alpha = 1f;
			if (energyValueIsMax)
			{
				RefreshEnergyUIPos(isSetPos: true);
			}
			energyValueIsMax = false;
			if (teachObserverEnergy)
			{
				teachObserverEnergy = false;
				viewModel.OnObserverTeachEnergyGuide();
			}
		}
		for (int i = 0; i < energySegmentObj.Count; i++)
		{
			if (energySegmentObj[i].EnergySegValue == 0f)
			{
				continue;
			}
			if (flag)
			{
				if (energySegmentObj[i].SegImageState != SegImageState.Clear)
				{
					energySegmentObj[i].EnergySegImage.color = Color.clear;
					energySegmentObj[i].SegImageState = SegImageState.Clear;
				}
				continue;
			}
			Animation energySegAnimation = energySegmentObj[i].EnergySegAnimation;
			if (energySegmentObj[i].EnergySegValue <= value)
			{
				if (energySegmentObj[i].SegImageState != SegImageState.Light)
				{
					energySegAnimation.Play("EnergySegLight");
					energySegmentObj[i].SegImageState = SegImageState.Light;
				}
			}
			else if (energySegmentObj[i].SegImageState != SegImageState.Drak)
			{
				energySegAnimation.Play("EnergySegDrak");
				energySegmentObj[i].SegImageState = SegImageState.Drak;
			}
		}
		energyFillAmountValue = value;
	}

	private void LateUpdateBindUIView()
	{
		ObservableDictionary<string, Ase.ECS.PropertyData> property = viewModel.HeroData.Property;
		if (property.ContainsKey("RescueTime"))
		{
			Ase.ECS.PropertyData propertyData = property["RescueTime"];
			rescueBar.fillAmount = ((propertyData.MaxValue == 0f) ? 1f : Mathf.Clamp01(1f - propertyData.CurValue * 1f / propertyData.MaxValue));
			if (propertyData.CurValue != propertyData.MaxValue && !rescueRoot.gameObject.activeSelf)
			{
				rescueRoot.gameObject.SetActive(value: true);
			}
		}
		if (property.ContainsKey("Energy"))
		{
			Ase.ECS.PropertyData propertyData2 = property["Energy"];
			if (viewModel.HeroData.IsDead)
			{
				if (EnergyCanvasGroup.alpha != 0f)
				{
					EnergyAnimation.Stop();
					EnergyCanvasGroup.alpha = 0f;
				}
			}
			else
			{
				EnergyFillAmountValue = ((propertyData2.MaxValue == 0f) ? 1f : (propertyData2.CurValue * 1f / propertyData2.MaxValue));
			}
		}
		if (property.ContainsKey("Hp") && property.ContainsKey("Shield"))
		{
			HpCur = property["Hp"].CurValue * 1f + property["Shield"].CurValue * 1f;
		}
	}

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<BattleUserViewModel>(userData);
		InitWeaponActiveView(viewModel);
		BindingSet<BattleUserSelfView, BattleUserViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((BattleUserSelfView v) => ((BattleUserView)v).OnBuffListChanged).To((BattleUserViewModel vm) => vm.OnBuffListChangedRequest);
		bindingSet.Bind(this).For((BattleUserSelfView v) => v.PlayHpEffect).To((BattleUserViewModel vm) => vm.OnPlayHpEffectRequest);
		bindingSet.Bind(this).For((BattleUserSelfView v) => v.OnRefreshDataRequest).To((BattleUserViewModel vm) => vm.RefreshDataRequest);
		bindingSet.Bind(nameText).For((Text v) => v.text).ToExpression((BattleUserViewModel vm) => vm.HeroData.Name);
		bindingSet.Bind(rebornBar).For((Image v) => v.fillAmount).ToExpression((BattleUserViewModel vm) => vm.HeroData.RevivedTime * 1f / vm.HeroData.RebornTime);
		bindingSet.Bind(base.gameObject).For((GameObject v) => v.activeSelf).ToExpression((BattleUserViewModel vm) => vm.HeroData.SkillCount > 0);
		bindingSet.Bind(this).For((BattleUserSelfView v) => v.OnAbnormalStateListChanged).To((BattleUserViewModel vm) => vm.OnAbnormalStateRequest);
		bindingSet.Bind().For((BattleUserSelfView v) => v.WeaponEnum).ToExpression((BattleUserViewModel vm) => vm.HeroData.WeaponEnum);
		bindingSet.Bind().For((BattleUserSelfView v) => v.HeroIndepentType).ToExpression((BattleUserViewModel vm) => vm.HeroData.HeroIndepentType);
		bindingSet.Bind().For((BattleUserSelfView v) => v.ShowEnergyEffect).To((BattleUserViewModel vm) => vm.HeroData.ShowEnergyEffect);
		bindingSet.Bind().For((BattleUserSelfView v) => v.ShowEnergyAddEffect).To((BattleUserViewModel vm) => vm.HeroData.ShowEnergyAddEffect);
		bindingSet.Build();
		hpBar.InitBar();
		SetInitPropertyValue();
		InitHeroIndepentRes(viewModel);
		hpBarWidth = hpBar.GetHpBarWidth();
		hpEffectGo.AddDisposeAction(delegate(GameObject hpEffectGo)
		{
			hpEffectGo.SetActive(value: false);
		});
	}

	private void InitWeaponActiveView(BattleUserViewModel battleUserViewModel)
	{
		swordActiveView.Init(battleUserViewModel);
		gunActiveView.Init(battleUserViewModel);
		glovesActiveView.Init(battleUserViewModel);
		bowActiveView.Init(battleUserViewModel);
		hammerActiveView.Init(battleUserViewModel);
		lanceActiveView.Init(battleUserViewModel);
	}

	private void InitHeroIndepentRes(BattleUserViewModel battleUserViewModel)
	{
		SkillChargeBuffLayerView.OnInitIndepentView(battleUserViewModel);
		HeroIndepentResSkillLayerView.OnInitIndepentView(battleUserViewModel);
		BuffLayerView.OnInitIndepentView(battleUserViewModel);
		HeroBuffUI2View.OnInitIndepentView(battleUserViewModel);
		heroSkillLayerUI2View.OnInitIndepentView(battleUserViewModel);
		buffLayer2View.OnInitIndepentView(battleUserViewModel);
		jxkbufflayerview.OnInitIndepentView(battleUserViewModel);
		lSLBuffLayerView.OnInitIndepentView(battleUserViewModel);
		yunZhaoBuffLayerView.OnInitIndepentView(battleUserViewModel);
		skillQMMBuffLayerView.OnInitIndepentView(battleUserViewModel);
		skillSFYBuffLayerView.OnInitIndepentView(battleUserViewModel);
		skillMYBuffLayerView.OnInitIndepentView(battleUserViewModel);
		skillNLLBuffLayerView.OnInitIndepentView(battleUserViewModel);
	}

	private void PlayHpEffect(object sender, InteractionEventArgs e)
	{
		hpEffectGo.gameObject.SetActive(value: true);
	}

	private void OnRefreshDataRequest(object sender, InteractionEventArgs e)
	{
	}

	private void EnergyUnenoughEffectRequest()
	{
		EnergyAnimation.Stop();
		EnergyAnimation.Play("EnergyUnEnough");
	}

	public override void RefreshData(object userData)
	{
		enableModifyEffect = false;
		viewModel = GetUserData<BattleUserViewModel>(userData);
		SetInitPropertyValue();
		base.UpdateHpSlider(viewModel);
		this.SetDataContext(viewModel);
		RefreshWeaponActiveView(viewModel);
		RefreshIndepentResView(viewModel);
		OnBuffListChanged(null, null);
		enableModifyEffect = true;
	}

	private void SetInitPropertyValue()
	{
		if (viewModel.HeroData != null)
		{
			if (viewModel.HeroData.Property.TryGetValue("Hp", out var value))
			{
				HpCur = value.MaxValue;
			}
			if (viewModel.HeroData.Property.TryGetValue("Energy", out var value2))
			{
				EnergyMaxValue = value2.MaxValue;
			}
		}
	}

	private void RefreshWeaponActiveView(BattleUserViewModel battleUserViewModel)
	{
		swordActiveView.WeaponRefresh(battleUserViewModel);
		gunActiveView.WeaponRefresh(battleUserViewModel);
		glovesActiveView.WeaponRefresh(battleUserViewModel);
		bowActiveView.WeaponRefresh(battleUserViewModel);
		hammerActiveView.WeaponRefresh(battleUserViewModel);
		lanceActiveView.WeaponRefresh(battleUserViewModel);
	}

	private void RefreshIndepentResView(BattleUserViewModel battleUserViewModel)
	{
		SkillChargeBuffLayerView.RefreshData(battleUserViewModel);
		HeroIndepentResSkillLayerView.RefreshData(battleUserViewModel);
		BuffLayerView.RefreshData(battleUserViewModel);
		HeroBuffUI2View.RefreshData(battleUserViewModel);
		heroSkillLayerUI2View.RefreshData(battleUserViewModel);
		buffLayer2View.RefreshData(battleUserViewModel);
		jxkbufflayerview.RefreshData(battleUserViewModel);
		yunZhaoBuffLayerView.RefreshData(battleUserViewModel);
		skillQMMBuffLayerView.RefreshData(battleUserViewModel);
		skillSFYBuffLayerView.RefreshData(battleUserViewModel);
		skillMYBuffLayerView.RefreshData(battleUserViewModel);
		skillNLLBuffLayerView.RefreshData(battleUserViewModel);
	}

	protected override void OnBuffListChanged(object sender, InteractionEventArgs e)
	{
		if (viewModel != null && viewModel.HeroData != null && viewModel.HeroData.BuffList != null)
		{
			int count = viewModel.HeroData.BuffList.Count;
			count = ((count > 6) ? 6 : count);
			if (!buffList.MListViewInited)
			{
				buffList.InitGridView(count, OnGetBuffItemByIndex);
			}
			else
			{
				buffList.SetListItemCount(count);
				buffList.RefreshAllShownItem();
			}
			buffList.SetGridFixedGroupCount(GridFixedType.ColumnCountFixed, 3);
			buffList.SetItemPadding(new Vector2(0f, 0f));
		}
	}

	private void OnAbnormalStateListChanged(object sender, InteractionEventArgs e)
	{
		if (viewModel != null && viewModel.HeroData != null && viewModel.HeroData.AbnormalStateList != null)
		{
			int count = viewModel.HeroData.AbnormalStateList.Count;
			count = ((count > 3) ? 3 : count);
			if (!abnormalStateList.MListViewInited)
			{
				abnormalStateList.InitGridView(count, OnGetAbnormalStateItemByIndex);
			}
			else
			{
				abnormalStateList.SetListItemCount(count);
				abnormalStateList.RefreshAllShownItem();
			}
			abnormalStateList.SetGridFixedGroupCount(GridFixedType.ColumnCountFixed, 3);
			abnormalStateList.SetItemPadding(new Vector2(0f, 0f));
		}
	}

	private LoopGridViewItem OnGetAbnormalStateItemByIndex(LoopGridView gridView, int index, int row, int column)
	{
		if (index < 0 || index >= viewModel.HeroData.AbnormalStateList.Count)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = null;
		loopGridViewItem = gridView.NewListViewItem("AbnormalStateItemView");
		if (loopGridViewItem != null)
		{
			AbnormalStateItemView component = loopGridViewItem.GetComponent<AbnormalStateItemView>();
			if (!loopGridViewItem.IsInitHandlerCalled)
			{
				loopGridViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.HeroData.AbnormalStateList[index]);
			}
			else
			{
				component.ResetViewModel(viewModel.HeroData.AbnormalStateList[index]);
			}
		}
		return loopGridViewItem;
	}

	protected override LoopGridViewItem OnGetBuffItemByIndex(LoopGridView gridView, int index, int row, int column)
	{
		if (index < 0 || index >= viewModel.HeroData.BuffList.Count)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = null;
		loopGridViewItem = gridView.NewListViewItem("BuffItemView");
		if (loopGridViewItem != null)
		{
			BuffItemView component = loopGridViewItem.GetComponent<BuffItemView>();
			if (!loopGridViewItem.IsInitHandlerCalled)
			{
				loopGridViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.HeroData.BuffList[index]);
			}
			else
			{
				component.RefreshData(viewModel.HeroData.BuffList[index]);
			}
		}
		return loopGridViewItem;
	}

	private void Update()
	{
		if (deadFillRoot.gameObject.activeSelf)
		{
			Vector3 heroPos = viewModel.HeroData.GetHeroPos();
			Vector2 vector = default(Vector2);
			if (RectTransformUtility.ScreenPointToLocalPointInRectangle((RectTransform)base.transform, (Vector2)heroPos, UIUtilly.GetUICamera(), ref vector))
			{
				deadFillRoot.GetComponent<RectTransform>().localPosition = vector;
			}
		}
	}

	protected override void LateUpdate()
	{
		base.LateUpdate();
		if (viewModel != null)
		{
			LateUpdateBindUIView();
		}
		if (viewModel != null && !viewModel.GamePause)
		{
			RefreshEnergyUIPos(isSetPos: false);
		}
	}

	private void RefreshEnergyUIPos(bool isSetPos)
	{
		if (battleCamera != null && energyFollow != null && EnergyCanvasGroup.alpha > 0f)
		{
			Vector3 vector = battleCamera.WorldToScreenPoint(energyFollow.position);
			Vector2 vector2 = default(Vector2);
			RectTransformUtility.ScreenPointToLocalPointInRectangle((RectTransform)EnergyShow.parent, (Vector2)vector, UIUtilly.GetUICamera(), ref vector2);
			if (isSetPos)
			{
				EnergyShow.localPosition = vector2 + energyUIOffset;
			}
			else
			{
				EnergyShow.localPosition = Vector3.Lerp(EnergyShow.localPosition, vector2 + energyUIOffset, energyUIMoveSpeed * Time.deltaTime);
			}
		}
	}

	private void AddLight(float curVal, float width, RectTransform light, bool changeSize)
	{
		float x = curVal * width;
		light.anchoredPosition = new Vector2(x, 0f);
		if (HpWarnObj.activeSelf != curVal < 0.15f)
		{
			HpWarnObj.SetActive(!HpWarnObj.activeSelf);
		}
	}

	private void AddEnergyEffect2(float w, float x)
	{
		GameObject gameObject = energyEffect2Pool.Allocate();
		RectTransform component = gameObject.GetComponent<RectTransform>();
		AutoDispose component2 = gameObject.GetComponent<AutoDispose>();
		if (component != null && component2 != null)
		{
			component.sizeDelta = new Vector2(w, component.sizeDelta.y);
			component.anchoredPosition3D = new Vector3(x, 0f, 0f);
			component.gameObject.SetActive(value: true);
			component2.AddDisposeAction(RemoveEnergyEffect2);
		}
		else
		{
			energyEffect2Pool.Free(gameObject);
		}
	}

	public void RemoveEnergyEffect2(GameObject go)
	{
		energyEffect2Pool.Free(go);
	}

	private void RemoveEnergySegment()
	{
		if (energySegmentObj != null)
		{
			for (int i = 0; i < energySegmentObj.Count; i++)
			{
				Object.Destroy(energySegmentObj[i].EnergySegGobj);
			}
		}
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		energyEffect2Pool?.Dispose();
		energyEffect2Pool = null;
		energySegmentObj.Clear();
		energySegmentObj = null;
	}

	public void SetBattleCameraEnergyFollowRoot(Camera battleCamera, Transform energyFollow, Vector2 offset)
	{
		this.battleCamera = battleCamera;
		this.energyFollow = energyFollow;
		energyUIOffset = offset;
	}
}
