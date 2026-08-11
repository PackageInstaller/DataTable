#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Ase.ECS;
using Cysharp.Text;
using DG.Tweening;
using GameFramework;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Ase;

public class UniversalButton : BattleTouchButton
{
	public RectTransform PointValidArea;

	public bool debugLog;

	public float DragSkillJude;

	public bool isAimable;

	[HideInInspector]
	public RectTransform btn;

	public RectTransform aimer;

	public RectTransform pointer;

	public RectTransform skillCanceller;

	public HeroSkillTypeEnum optionType;

	[HideInInspector]
	public bool IsDragOutSkillJudge;

	public DistanceCanelSkill DistanceCanelSkill;

	public bool IsShowAimer;

	protected float canvasScaleFactor;

	public ButtonStateEnum state;

	public bool isActive;

	private bool isDrag;

	private float btnRadius;

	[HideInInspector]
	public float aimerRadius;

	[HideInInspector]
	public bool isFingerDown;

	[HideInInspector]
	public bool isSimulator;

	[HideInInspector]
	public Vector3 initialFingerPosition;

	protected Vector3 fingerPosition;

	protected Vector3 direction;

	[HideInInspector]
	public Vector3 directionXZ;

	protected Vector3 rawDir;

	protected float cancellerRadius;

	private CanvasGroup canvasGroup;

	protected bool canActivateSkill = true;

	public Transform ShowReleaseTipRoot;

	[HideInInspector]
	public Transform ChargeUIFollowTrans;

	[HideInInspector]
	public Vector2 ChargeUIOffset;

	[HideInInspector]
	public Camera BattleCamera;

	[SerializeField]
	protected Image aimerImage;

	[SerializeField]
	protected Image dirAimerImage;

	private Image pointerImage;

	public float ChargeUIMoveSpeed = 5f;

	protected Vector3 refScale;

	protected Vector3 onPressedScale;

	public Color colorActive;

	public Color colorInactive;

	public Color colorPressed;

	private HeroSkill viewModel;

	private Tween ReleaseSkillTipTween;

	public Color CancelRescue;

	private Color aimerCancel = new Color(46f / 51f, 0.24313726f, 10f / 51f);

	private Color aimerNroaml = new Color(0.29411766f, 0.77254903f, 1f);

	[HideInInspector]
	public UnityEventInput onPointerDown;

	[HideInInspector]
	public UnityEventInput onBeginDrag;

	[HideInInspector]
	public UnityEventOnDrag onDrag;

	[HideInInspector]
	public UnityEventInput onPointerUp;

	[HideInInspector]
	public UnityEventInput onEndDrag;

	[HideInInspector]
	public UnityEventDragInput onActivateSkill;

	[HideInInspector]
	public UnityEventInput onCancelSkill;

	[HideInInspector]
	public Action<string, Vector3, HeroSkillTypeEnum, bool> onShowReleaseSkillTip;

	[HideInInspector]
	public Action<HeroSkillTypeEnum> onHideReleaseSkillTip;

	[HideInInspector]
	public UnityEventDescInput onStopPress;

	private float invokeSecond;

	private bool isDragSkill;

	private bool startCounter;

	private bool cancelCounter;

	private AutoDispose pressAutoDispose;

	protected float AnalogStickRadius;

	protected Vector3 validAreaLeftBottom;

	protected Vector3 validAreaRightTop;

	private bool _skipFrame;

	private float _lastCanvasScaleFactor;

	private bool isSetChargeUIPos = true;

	protected ICommandSystemHandle commandSystemHandle;

	[SerializeField]
	private Animation pressAnimation;

	[SerializeField]
	private Transform pressTrans;

	private bool isInit;

	protected Vector3 aimerPos;

	protected Vector3 pointerPos;

	protected bool aimerActive;

	protected int defaultFingerId = -99;

	protected int fingerId = -99;

	public TextMeshProUGUI text;

	public TextMeshProUGUI CDText;

	public Image icon;

	[SerializeField]
	private RectTransform iconRect;

	public bool showProgress;

	public Image progressBar;

	public Image CDBg;

	public Image chargeProgressBar;

	public Image chargeBg;

	public GameObject chargeRoot;

	public GameObject skillLayerBg;

	public TextMeshProUGUI skillLayer;

	public GameObject SkillLayMax;

	public GameObject pressObj;

	public Image anim_2;

	public GameObject AbnormalRedShap;

	public GameObject stateCantRelSkill;

	public GameObject enableEffect;

	public GameObject energyImage;

	public GameObject iconChangeEffect;

	public RectTransform ChargeUI;

	public GameObject ChargeUIBg;

	public TextMeshProUGUI PropNumber;

	public TextMeshProUGUI PropNumber2;

	public GameObject StrengthenStateEffect;

	public GameObject TeachSkillEffect;

	public Image XpFillAmount;

	public Color XpUnEnoughColor;

	public GameObject XpEffect;

	public GameObject XpReleEffect;

	public List<float> ChargeFillList;

	[SerializeField]
	private List<GameObject> ChargeEffect;

	public GameObject HideRoot;

	[SerializeField]
	private EmptyRaycast emptyRaycast;

	[SerializeField]
	private Vector2 iconDefaultSizeData;

	[SerializeField]
	private Vector2 iconSkinSizeData;

	[SerializeField]
	private float iconDefaultAlpha;

	private float chargeFillAmout;

	private int maxChargeNum;

	private int currentChargeNum;

	private float xpValue;

	private bool resourceAmpleReleaseSkill = true;

	private float _xpReleaseParamVal = -9f;

	private float _xpCurrentParamValue = -9f;

	private bool _existAnim2;

	private bool _existXpFillAmount;

	private bool _existXpEffect;

	private bool _existXpReleEffect;

	private bool _existSkillLayer;

	private bool _existSkillLayMax;

	private bool _existSkillLayerBg;

	private bool _existIcon;

	private bool _existPropNum1;

	private bool _existPropNum2;

	private int _skillCDProp = -99;

	private bool _existChargeProgressInfo;

	private bool _existChargeBg;

	private bool _existCDText1;

	private bool _existCDText2;

	private bool _existChargeRoot;

	private float _skillCDTextVal = -9f;

	private bool _existAmpleCanvasGroup;

	private bool _existEnableEffect;

	private bool _existStateCantRelSkill;

	private bool _existAbnormalRedShap;

	private bool _existStrengthenStateEffect;

	private bool _existChargeUI;

	private Image _imgChargeUI;

	private bool _existChargeUIRoot;

	private bool _existEnergyImage;

	private bool _existTeachSkillEffect;

	private bool _existBtnRoot;

	public float ChargeFillAmount
	{
		get
		{
			return chargeFillAmout;
		}
		set
		{
			chargeFillAmout = value;
			SkillCoolingData coolingData = viewModel.CoolingData;
			if (coolingData.IsChargeSkill)
			{
				if (coolingData.CurrentChargeNumber >= coolingData.MaxChargeNumber)
				{
					chargeProgressBar.fillAmount = ChargeFillList[coolingData.CurrentChargeNumber];
				}
				else
				{
					chargeProgressBar.fillAmount = ChargeFillList[coolingData.CurrentChargeNumber] + (ChargeFillList[coolingData.CurrentChargeNumber + 1] - ChargeFillList[coolingData.CurrentChargeNumber]) * (1f - coolingData.CurrentChargeTime / coolingData.ChargeTime);
				}
			}
		}
	}

	public int MaxChargeNum
	{
		get
		{
			return maxChargeNum;
		}
		set
		{
			maxChargeNum = value;
			chargeBg.fillAmount = ChargeFillList[value];
		}
	}

	public int CurrentChargeNum
	{
		get
		{
			return currentChargeNum;
		}
		set
		{
			currentChargeNum = value;
			for (int i = 0; i < ChargeEffect.Count; i++)
			{
				ChargeEffect[i].SetActive(value - 1 >= i);
			}
		}
	}

	public float XpValue
	{
		get
		{
			return xpValue;
		}
		set
		{
			xpValue = value;
			SkillCoolingData coolingData = viewModel.CoolingData;
			RefreshXpSkillTransparent(coolingData, refreshFillAmount: true);
			if (_existXpReleEffect)
			{
				bool flag = coolingData.CanRelease();
				if (XpReleEffect.activeSelf != flag)
				{
					XpReleEffect.SetActive(flag);
				}
			}
		}
	}

	public bool ResourceAmpleReleaseSkill
	{
		get
		{
			return resourceAmpleReleaseSkill;
		}
		set
		{
			if (resourceAmpleReleaseSkill != value)
			{
				resourceAmpleReleaseSkill = value;
				onHideReleaseSkillTip?.Invoke(optionType);
			}
		}
	}

	protected virtual bool RefreshAboutScaleFactorInfo(float curCanvasScaleFactor)
	{
		if (curCanvasScaleFactor == canvasScaleFactor)
		{
			return false;
		}
		UpdateBound();
		if (PointValidArea != null && aimer != null)
		{
			Vector3 vector = UIUtilly.WrapperGetUIPosition(PointValidArea);
			Vector3 vector2 = new Vector3(PointValidArea.rect.width / 2f * canvasScaleFactor, PointValidArea.rect.height / 2f * canvasScaleFactor);
			validAreaLeftBottom = vector - vector2;
			validAreaRightTop = vector + vector2;
			AnalogStickRadius = aimer.rect.width / 2f * canvasScaleFactor;
		}
		return true;
	}

	private void Start()
	{
		if (PointValidArea != null && aimer != null)
		{
			Vector3 vector = UIUtilly.WrapperGetUIPosition(PointValidArea);
			Vector3 vector2 = new Vector3(PointValidArea.rect.width / 2f * canvasScaleFactor, PointValidArea.rect.height / 2f * canvasScaleFactor);
			validAreaLeftBottom = vector - vector2;
			validAreaRightTop = vector + vector2;
			AnalogStickRadius = aimer.rect.width / 2f * canvasScaleFactor;
		}
	}

	private void SetPressState(int opType)
	{
		if (viewModel != null && viewModel.SkillData != null)
		{
			bool flag = viewModel.SkillData.IndicatorType != 0;
			isAimable = flag;
		}
	}

	private void CheckInvoke()
	{
		if (startCounter && invokeSecond >= 1f)
		{
			onStopPress.Invoke(optionType, arg1: true);
			startCounter = false;
		}
		else if (cancelCounter)
		{
			onStopPress.Invoke(optionType, arg1: false);
			cancelCounter = false;
		}
	}

	private void Update()
	{
		if (startCounter)
		{
			invokeSecond += Time.deltaTime;
			CheckInvoke();
		}
		if (cancelCounter)
		{
			CheckInvoke();
		}
		RefreshChargeUIPos();
	}

	protected void LateUpdate()
	{
		float num = UIUtilly.GetCanvasScaleFactor();
		if (num != _lastCanvasScaleFactor)
		{
			_skipFrame = true;
			_lastCanvasScaleFactor = num;
		}
		if (_skipFrame)
		{
			_skipFrame = false;
			return;
		}
		RefreshAboutScaleFactorInfo(num);
		LateUpdateInUIBind();
	}

	private void RefreshChargeUIPos()
	{
		if (ChargeUIBg != null && viewModel != null && viewModel.SkillData.IsCharging && ChargeUIFollowTrans != null)
		{
			Vector3 vector = BattleCamera.WorldToScreenPoint(ChargeUIFollowTrans.position);
			Vector2 vector2 = default(Vector2);
			RectTransformUtility.ScreenPointToLocalPointInRectangle((RectTransform)ChargeUIBg.transform.parent, (Vector2)vector, UIUtilly.GetUICamera(), ref vector2);
			if (isSetChargeUIPos)
			{
				ChargeUIBg.transform.localPosition = vector2 + ChargeUIOffset;
				isSetChargeUIPos = false;
			}
			else
			{
				ChargeUIBg.transform.localPosition = Vector3.Lerp(ChargeUIBg.transform.localPosition, vector2 + ChargeUIOffset, ChargeUIMoveSpeed * Time.deltaTime);
			}
		}
		else
		{
			isSetChargeUIPos = true;
		}
	}

	public void SetCommandHandle(ICommandSystemHandle commandSystemHandle)
	{
		this.commandSystemHandle = commandSystemHandle;
	}

	public void RefreshData(HeroSkill heroSkill)
	{
		if (!isInit)
		{
			Init(heroSkill);
			isInit = true;
		}
		else
		{
			viewModel = heroSkill;
			this.SetDataContext(heroSkill);
		}
	}

	protected virtual void Awake()
	{
		if (pressObj != null)
		{
			pressAutoDispose = pressObj.GetComponent<AutoDispose>();
			pressAutoDispose.enabled = false;
			pressAutoDispose.AddDisposeAction((Action)delegate
			{
				pressTrans.localPosition = VectorExtensions.ScreenOutPos;
				pressAutoDispose.enabled = false;
			});
		}
		if (aimer != null)
		{
			aimerImage = aimer.GetComponent<Image>();
		}
		if (pointer != null)
		{
			pointerImage = pointer.GetComponent<Image>();
		}
		SetAimerPointer(isActive: false, aimerNroaml);
		btn = GetComponent<RectTransform>();
		UpdateBound();
		refScale = GetComponent<RectTransform>().localScale;
		onPressedScale = refScale * 0.75f;
		UpdateButtonState();
	}

	private bool PointerDownSkillTips()
	{
		if (optionType == HeroSkillTypeEnum.Attack || optionType == HeroSkillTypeEnum.Skill1 || optionType == HeroSkillTypeEnum.Skill2 || optionType == HeroSkillTypeEnum.Skill3 || optionType == HeroSkillTypeEnum.Skill4 || optionType == HeroSkillTypeEnum.Roll || optionType == HeroSkillTypeEnum.PropSkill || optionType == HeroSkillTypeEnum.DeputyPropSkill)
		{
			if (viewModel == null)
			{
				return false;
			}
			if (!viewModel.CoolingData.ResourceAmpleReleaseSkill)
			{
				bool energyUnenough = false;
				string noResourceAmpleText = viewModel.CoolingData.GetNoResourceAmpleText(ref energyUnenough);
				if (ShowReleaseTipRoot != null)
				{
					onShowReleaseSkillTip?.Invoke(noResourceAmpleText, ShowReleaseTipRoot.position, optionType, energyUnenough);
				}
				return false;
			}
		}
		if ((optionType == HeroSkillTypeEnum.PropSkill || optionType == HeroSkillTypeEnum.DeputyPropSkill) && !viewModel.CoolingData.PropNumberAmpleRelSkill)
		{
			return false;
		}
		return true;
	}

	protected void CalculateAimerPos()
	{
		if (AnalogStickRadius == 0f)
		{
			aimerPos = Vector3.zero;
			return;
		}
		Vector3 vector = fingerPosition;
		if (fingerPosition.x - validAreaLeftBottom.x < AnalogStickRadius)
		{
			vector.x = validAreaLeftBottom.x + AnalogStickRadius;
		}
		if (fingerPosition.y - validAreaLeftBottom.y < AnalogStickRadius)
		{
			vector.y = validAreaLeftBottom.y + AnalogStickRadius;
		}
		_ = validAreaRightTop.x - fingerPosition.x;
		_ = AnalogStickRadius;
		_ = validAreaRightTop.y - fingerPosition.y;
		_ = AnalogStickRadius;
		vector.z = UIUtilly.WrapperGetUIPosition(aimer, setZZero: false).z;
		aimerPos = vector;
	}

	protected virtual void UpdateAiming(PointerEventData eventData, bool updateDirAnimer)
	{
		if (!(aimer == null))
		{
			fingerPosition = UIUtilly.FingerPos2ScenePosCameraUI(eventData.position);
			rawDir = fingerPosition - SetPosZZero(aimerPos);
			rawDir = Vector3.ClampMagnitude(rawDir, aimerRadius);
			pointerPos = aimerPos + rawDir;
			if (aimerActive)
			{
				UIUtilly.WrapperSetUIPosition(pointer, pointerPos);
			}
			else
			{
				UIUtilly.WrapperSetUIPosition(pointer, VectorExtensions.ScreenOutPos);
			}
			UpdateDirection();
			if (updateDirAnimer)
			{
				UpdateDirAnimer();
			}
		}
	}

	private void UpdateDirAnimer()
	{
		if (direction.sqrMagnitude > 0.0001f)
		{
			if (dirAimerImage != null)
			{
				dirAimerImage.transform.up = direction;
				dirAimerImage.enabled = true;
				aimerImage.enabled = false;
			}
		}
		else
		{
			aimerImage.enabled = true;
			dirAimerImage.enabled = false;
		}
	}

	protected void UpdateDirection()
	{
		if (isFingerDown || isSimulator)
		{
			if (!isDrag)
			{
				direction = Vector3.zero;
				directionXZ = Vector3.zero;
				commandSystemHandle?.UpdateInputUv(directionXZ.ToVector2());
			}
			else
			{
				direction = rawDir / aimerRadius;
				directionXZ.x = direction.x;
				directionXZ.y = 0f;
				directionXZ.z = direction.y;
				commandSystemHandle?.UpdateInputUv(directionXZ.ToVector2());
			}
		}
		else
		{
			commandSystemHandle?.UpdateInputUv(Vector2.zero);
		}
	}

	public virtual void SetActiveState(bool active)
	{
		isActive = active;
		UpdateButtonState();
	}

	protected virtual void UpdateButtonState()
	{
		if (isActive)
		{
			state = ButtonStateEnum.Active;
		}
		else
		{
			state = ButtonStateEnum.Inactive;
		}
		UpdateColor();
	}

	protected virtual void UpdateColor()
	{
		switch (state)
		{
		}
	}

	protected bool IsFingerOverSkillCancellerButton()
	{
		return (UIUtilly.WrapperGetUIPosition(skillCanceller) - fingerPosition).sqrMagnitude < cancellerRadius * cancellerRadius;
	}

	public virtual void SetText(string t)
	{
		if ((UnityEngine.Object)(object)text != null)
		{
			((TMP_Text)text).text = t;
		}
	}

	public virtual void UpdateBound()
	{
		canvasScaleFactor = UIUtilly.GetCanvasScaleFactor();
		btnRadius = btn.rect.width / 2f * canvasScaleFactor;
		_ = debugLog;
		if (isAimable)
		{
			aimerRadius = aimer.rect.width / 2f * canvasScaleFactor;
		}
		if (skillCanceller != null)
		{
			cancellerRadius = skillCanceller.rect.width / 2f * canvasScaleFactor;
		}
	}

	protected Vector3 SetPosZZero(Vector3 pos)
	{
		return new Vector3(pos.x, pos.y, 0f);
	}

	public virtual void SetSimulatorMode(bool active)
	{
		isSimulator = !active;
	}

	public virtual void HideAimer()
	{
		SetPressState(2);
		if (state != ButtonStateEnum.Pressed)
		{
			return;
		}
		isFingerDown = false;
		fingerId = defaultFingerId;
		if (isAimable)
		{
			if (aimer == null || pointer == null)
			{
				Log.Error($"{optionType} 技能指示器配置不存在！");
			}
			else
			{
				SetAimerPointer(isActive: false, aimerNroaml);
				DistanceCanelSkill?.PointUpIsCancelSkill(btn.gameObject);
			}
		}
		state = ButtonStateEnum.Active;
		UpdateButtonState();
		if (onPointerUp != null)
		{
			onPointerUp.Invoke(optionType);
		}
		if (onCancelSkill != null)
		{
			onCancelSkill.Invoke(optionType);
		}
		isDrag = false;
		UpdateColor();
		IsDragOutSkillJudge = false;
	}

	private void SetAimerPointer(bool isActive, Color color)
	{
		if (!IsShowAimer)
		{
			return;
		}
		SetAimerPointer(isActive);
		if (optionType != HeroSkillTypeEnum.None)
		{
			if (aimerImage != null)
			{
				aimerImage.color = color;
				dirAimerImage.color = color;
			}
			if (pointerImage != null)
			{
				pointerImage.color = color;
			}
		}
	}

	public void SetAimerPointer(bool isActive)
	{
		if (!IsShowAimer)
		{
			return;
		}
		aimerActive = isActive;
		if (aimer != null)
		{
			if (!isActive)
			{
				aimer.localPosition = VectorExtensions.ScreenOutPos;
			}
			else
			{
				UIUtilly.WrapperSetUIPosition(aimer, aimerPos);
			}
		}
		if (pointer != null)
		{
			if (!isActive)
			{
				pointer.localPosition = VectorExtensions.ScreenOutPos;
			}
			else
			{
				UIUtilly.WrapperSetUIPosition(pointer, pointerPos);
			}
		}
		if (!isActive)
		{
			aimerImage.enabled = true;
			dirAimerImage.enabled = false;
		}
	}

	public void HidePressObj()
	{
		pressTrans.localPosition = VectorExtensions.ScreenOutPos;
		pressAutoDispose.ResetTime(0f);
	}

	public bool IsShowDistanceCancel()
	{
		if (optionType != HeroSkillTypeEnum.Attack && optionType != HeroSkillTypeEnum.Skill1 && optionType != HeroSkillTypeEnum.Skill2 && optionType != HeroSkillTypeEnum.Skill3 && optionType != HeroSkillTypeEnum.Roll && optionType != HeroSkillTypeEnum.PropSkill && optionType != HeroSkillTypeEnum.DeputyPropSkill)
		{
			return optionType == HeroSkillTypeEnum.Skill4;
		}
		return true;
	}

	public override void PointerDown(PointerEventData eventData)
	{
		directionXZ = Vector3.zero;
		SetPressState(0);
		if (!PointerDownSkillTips() || !viewModel.CoolingData.StateCanReleaseSkill)
		{
			return;
		}
		if (optionType != HeroSkillTypeEnum.Interaction1 && optionType != HeroSkillTypeEnum.Interaction2 && optionType != HeroSkillTypeEnum.Interaction3 && optionType != HeroSkillTypeEnum.Interaction4)
		{
			SkillCoolingData coolingData = viewModel.CoolingData;
			if (coolingData.IsChargeSkill && coolingData.CurrentChargeNumber == 0 && coolingData.ChargeTime > coolingData.CoolingTime)
			{
				if (coolingData.CurrentChargeTime > 0f)
				{
					return;
				}
			}
			else if (coolingData.CurrentCoolingTime > 0f)
			{
				return;
			}
		}
		if ((optionType == HeroSkillTypeEnum.Interaction1 || optionType == HeroSkillTypeEnum.Interaction2 || optionType == HeroSkillTypeEnum.Interaction3 || optionType == HeroSkillTypeEnum.Interaction4) && progressBar != null && progressBar.fillAmount > 0f)
		{
			return;
		}
		if (pressObj != null)
		{
			pressAnimation.Stop();
			pressAnimation.Play();
			pressAutoDispose.enabled = true;
			pressAutoDispose.ResetTime(0.4f);
			pressTrans.localPosition = VectorExtensions.OriginPos;
		}
		if (state == ButtonStateEnum.Active)
		{
			isFingerDown = true;
			fingerId = eventData.pointerId;
			initialFingerPosition = UIUtilly.FingerPos2ScenePosCameraUI(eventData.position);
			fingerPosition = initialFingerPosition;
			CalculateAimerPos();
			if (isAimable)
			{
				pointerPos = aimerPos;
			}
			if (optionType != HeroSkillTypeEnum.Interaction1 && optionType != HeroSkillTypeEnum.Interaction2 && optionType != HeroSkillTypeEnum.Interaction3 && optionType != HeroSkillTypeEnum.Interaction4)
			{
				state = ButtonStateEnum.Pressed;
			}
			UpdateColor();
			if (onPointerDown != null)
			{
				onPointerDown.Invoke(optionType);
			}
		}
	}

	public override void BeginDrag(PointerEventData eventData)
	{
		SetPressState(1);
		if (isAimable && state == ButtonStateEnum.Pressed)
		{
			UpdateAiming(eventData, updateDirAnimer: false);
			if (onBeginDrag != null)
			{
				onBeginDrag.Invoke(optionType);
			}
			isDrag = true;
		}
	}

	public override void Drag(PointerEventData eventData)
	{
		if (!isAimable || state != ButtonStateEnum.Pressed)
		{
			return;
		}
		if (directionXZ.ToVector2().sqrMagnitude > DragSkillJude * DragSkillJude)
		{
			IsDragOutSkillJudge = true;
		}
		UpdateAiming(eventData, IsDragOutSkillJudge);
		bool flag = false;
		_ = debugLog;
		if (IsDragOutSkillJudge)
		{
			if (IsShowDistanceCancel())
			{
				flag = DistanceCanelSkill.DragShowDistanceCancel(btn.gameObject, fingerPosition - SetPosZZero(aimerPos), aimerPos);
			}
			SetAimerPointer(isActive: true, flag ? aimerCancel : aimerNroaml);
		}
		if (onDrag != null)
		{
			onDrag.Invoke(optionType, directionXZ, flag, IsDragOutSkillJudge);
		}
	}

	public override void EndDrag(PointerEventData eventData)
	{
		if (isAimable)
		{
			if (onEndDrag != null)
			{
				onEndDrag.Invoke(optionType);
			}
			isDrag = false;
		}
	}

	public override void PointerUp(PointerEventData eventData)
	{
		SetPressState(2);
		if (state == ButtonStateEnum.Pressed)
		{
			isFingerDown = false;
			fingerId = defaultFingerId;
			if (isAimable)
			{
				SetAimerPointer(isActive: false, aimerNroaml);
			}
			state = ButtonStateEnum.Active;
			UpdateButtonState();
			if (IsShowDistanceCancel())
			{
				canActivateSkill = !DistanceCanelSkill.PointUpIsCancelSkill(btn.gameObject);
			}
			if (canActivateSkill && onActivateSkill != null)
			{
				UpdateAiming(eventData, updateDirAnimer: false);
				onActivateSkill.Invoke(optionType, directionXZ);
			}
			else if (onCancelSkill != null)
			{
				onCancelSkill.Invoke(optionType);
			}
			if (onPointerUp != null)
			{
				onPointerUp.Invoke(optionType);
			}
			isDrag = false;
			UpdateColor();
			IsDragOutSkillJudge = false;
		}
	}

	protected override bool OnlySameFinger(PointerEventData eventData)
	{
		if (fingerId == defaultFingerId)
		{
			return true;
		}
		if (fingerId != eventData.pointerId)
		{
			return false;
		}
		return true;
	}

	private void RefreshXpSkillTransparent(SkillCoolingData cdData, bool refreshFillAmount)
	{
		if (optionType == HeroSkillTypeEnum.Skill4 && viewModel.SkillData.IsXpSkill)
		{
			CoolingBase coolingBase = cdData?.UItimateSkillXp;
			bool flag = coolingBase != null;
			if (_existIcon)
			{
				icon.color = ((!flag) ? Color.white : ((coolingBase.CurrentParamValue >= coolingBase.ReleaseParamValue) ? Color.white : XpUnEnoughColor));
			}
			if (((_existXpFillAmount & refreshFillAmount) && XpFillAmount.gameObject.activeSelf) & flag)
			{
				XpFillAmount.fillAmount = ((coolingBase.ReleaseParamValue == 0f) ? 1f : (coolingBase.CurrentParamValue / coolingBase.ReleaseParamValue));
			}
		}
	}

	public virtual void Init(HeroSkill heroSkill)
	{
		canvasGroup = GetComponent<CanvasGroup>();
		viewModel = heroSkill;
		BindingSet<UniversalButton, HeroSkill> bindingSet = this.CreateBindingSet(heroSkill);
		bindingSet.Bind(base.gameObject).For((GameObject v) => v.activeSelf).To((HeroSkill vm) => vm.IsShow);
		_existIcon = icon != null;
		if (_existIcon)
		{
			bindingSet.Bind(icon).For((Image v) => v.sprite).To((HeroSkill vm) => vm.IconBattle)
				.WithConversion("ItemIcon");
		}
		if (iconChangeEffect != null)
		{
			bindingSet.Bind(iconChangeEffect).For((GameObject v) => v.activeSelf).To((HeroSkill vm) => vm.IconChangeEffect);
		}
		_existEnableEffect = enableEffect != null;
		_existStateCantRelSkill = stateCantRelSkill != null;
		_existAbnormalRedShap = AbnormalRedShap != null;
		_existAmpleCanvasGroup = (UnityEngine.Object)(object)canvasGroup != null;
		_existCDText1 = (UnityEngine.Object)(object)text != null;
		_existCDText2 = (UnityEngine.Object)(object)CDText != null;
		_existChargeRoot = chargeRoot != null;
		_existChargeProgressInfo = chargeProgressBar != null && ChargeFillList != null && ChargeFillList.Count > 0;
		_existChargeBg = chargeBg != null;
		_existPropNum1 = (UnityEngine.Object)(object)PropNumber != null;
		_existPropNum2 = (UnityEngine.Object)(object)PropNumber2 != null;
		_existAnim2 = anim_2 != null;
		_existXpFillAmount = XpFillAmount != null;
		_existXpEffect = XpEffect != null;
		_existXpReleEffect = XpReleEffect != null;
		_existSkillLayer = (UnityEngine.Object)(object)skillLayer != null;
		_existSkillLayMax = SkillLayMax != null;
		_existSkillLayerBg = skillLayerBg != null;
		_existEnergyImage = energyImage != null;
		_imgChargeUI = (_existChargeUI ? ChargeUI.GetComponent<Image>() : null);
		_existChargeUI = _imgChargeUI != null;
		_existChargeUIRoot = ChargeUIBg != null;
		_existStrengthenStateEffect = StrengthenStateEffect != null;
		_existTeachSkillEffect = TeachSkillEffect != null;
		_existBtnRoot = HideRoot != null;
		bindingSet.Bind().For((UniversalButton v) => v.OnSkillDataUpdate).To((HeroSkill vm) => vm.SkillDataUpdateRequest);
		bindingSet.Build();
	}

	private void OnSkillDataUpdate(object sender, InteractionEventArgs e)
	{
		if (optionType == HeroSkillTypeEnum.Skill4)
		{
			RefreshXpSkillTransparent(viewModel.CoolingData, refreshFillAmount: false);
		}
		RefreshSkillDeriveData();
	}

	private void RefreshSkillXpVal(SkillCoolingData cdData)
	{
		CoolingBase coolingBase = cdData?.UItimateSkillXp;
		if (coolingBase != null)
		{
			if (_xpCurrentParamValue != coolingBase.CurrentParamValue)
			{
				_xpCurrentParamValue = coolingBase.CurrentParamValue;
				XpValue = _xpCurrentParamValue;
			}
			else if (_xpReleaseParamVal != coolingBase.ReleaseParamValue)
			{
				_xpReleaseParamVal = coolingBase.ReleaseParamValue;
				XpValue = _xpReleaseParamVal;
			}
		}
	}

	private void UpdateSkill4Alpha()
	{
		if (optionType == HeroSkillTypeEnum.Skill4 && !viewModel.SkillData.IsXpSkill)
		{
			Color color = ((viewModel.CoolingData.AbnormalRedShapPos.x == 0f) ? XpUnEnoughColor : Color.white);
			if (icon.color.a != color.a)
			{
				icon.color = color;
			}
		}
	}

	private void RefreshSkillCDPropNumPerLateUpdate(SkillCoolingData cdData)
	{
		int propNumber = cdData.PropNumber;
		if (_existPropNum1 && _skillCDProp != propNumber)
		{
			GameObject gameObject = ((Component)(object)PropNumber).gameObject;
			if (propNumber == 0)
			{
				gameObject.SetActive(value: false);
			}
			else
			{
				gameObject.SetActive(value: true);
				((TMP_Text)PropNumber).SetText(ZString.Format("{0}", propNumber), true);
			}
		}
		if (_existPropNum2 && _skillCDProp != propNumber)
		{
			GameObject gameObject2 = ((Component)(object)PropNumber2).gameObject;
			if (propNumber == 0)
			{
				gameObject2.SetActive(value: false);
			}
			else
			{
				gameObject2.SetActive(value: true);
				((TMP_Text)PropNumber2).SetText(ZString.Format("{0}", propNumber), true);
			}
		}
		_skillCDProp = propNumber;
	}

	private void RefreshSkillCDTextPerLateUpdate(SkillCoolingData cdData)
	{
		float cDTextValue = cdData.CDTextValue;
		if (_skillCDTextVal != cDTextValue)
		{
			bool flag = cDTextValue > 0f;
			if (flag && (_existCDText1 || _existCDText2))
			{
				string text = ZString.Format("{0:F1}", cDTextValue);
				if (_existCDText1)
				{
					((TMP_Text)this.text).SetText(text, true);
				}
				if (_existCDText2)
				{
					((TMP_Text)CDText).SetText(text, true);
				}
			}
			if (_existCDText1 && ((Behaviour)(object)this.text).enabled != flag)
			{
				((Behaviour)(object)this.text).enabled = flag;
			}
			if (_existCDText2 && ((Behaviour)(object)CDText).enabled != flag)
			{
				((Behaviour)(object)CDText).enabled = flag;
			}
		}
		_skillCDTextVal = cDTextValue;
	}

	private void RefreshSkillCompPosPerLateUpdate(SkillCoolingData cdData)
	{
		if (showProgress)
		{
			if (progressBar.fillAmount != cdData.CDFillAmount)
			{
				progressBar.fillAmount = cdData.CDFillAmount;
			}
			if (CDBg.transform.localPosition.x != cdData.CDBGPos.x)
			{
				CDBg.transform.localPosition = cdData.CDBGPos;
			}
		}
		if (_existEnableEffect && enableEffect.transform.localPosition.x != cdData.CanReleEffect.x)
		{
			enableEffect.transform.localPosition = cdData.CanReleEffect;
			if (enableEffect.transform.localPosition.x == VectorExtensions.OriginPos.x)
			{
				enableEffect.SetActive(value: false);
				enableEffect.SetActive(value: true);
			}
		}
		if (_existStateCantRelSkill && stateCantRelSkill.transform.localPosition.x != cdData.AbnormalCanReleEffectPos.x)
		{
			stateCantRelSkill.transform.localPosition = cdData.AbnormalCanReleEffectPos;
		}
		if (_existAbnormalRedShap && AbnormalRedShap.transform.localPosition.x != cdData.AbnormalRedShapPos.x)
		{
			AbnormalRedShap.transform.localPosition = cdData.AbnormalRedShapPos;
		}
	}

	private void RefreshSkillChargeInfoPerLateUpdate(SkillCoolingData cdData)
	{
		if (_existChargeRoot)
		{
			bool isChargeVisible = cdData.IsChargeVisible;
			if (chargeRoot.activeSelf != isChargeVisible)
			{
				chargeRoot.SetActive(isChargeVisible);
			}
			if ((_existChargeBg & isChargeVisible) && MaxChargeNum != cdData.MaxChargeNumber)
			{
				MaxChargeNum = cdData.MaxChargeNumber;
			}
			if ((_existChargeProgressInfo & isChargeVisible) && ChargeFillAmount != cdData.CurrentChargeTime)
			{
				ChargeFillAmount = cdData.CurrentChargeTime;
			}
			if (isChargeVisible && CurrentChargeNum != cdData.CurrentChargeNumber)
			{
				CurrentChargeNum = cdData.CurrentChargeNumber;
			}
		}
	}

	private void RefreshSkillDeriveData()
	{
		SkillDeriveData skillDeriveData = viewModel?.SkillDeriveData;
		if (skillDeriveData == null)
		{
			return;
		}
		bool flag = skillDeriveData.IsDeriving && skillDeriveData.IsStateDerive;
		if (_existAnim2)
		{
			GameObject gameObject = anim_2.gameObject;
			if (gameObject.activeSelf != flag)
			{
				gameObject.SetActive(flag);
			}
		}
	}

	private void RefreshSkillDerivePrgPLU()
	{
		if (viewModel.SkillDeriveData != null && _existAnim2)
		{
			float progress = viewModel.SkillDeriveData.Progress;
			GameObject gameObject = anim_2.gameObject;
			if (gameObject.activeSelf && progress <= 0f)
			{
				gameObject.SetActive(value: false);
			}
			else if (gameObject.activeSelf && anim_2.fillAmount != progress)
			{
				anim_2.fillAmount = progress;
			}
		}
	}

	private void RefreshXpSkillInfoPLU(HeroSkillData skillData)
	{
		if (_existXpFillAmount && XpFillAmount.gameObject.activeSelf != skillData.IsXpSkill)
		{
			XpFillAmount.gameObject.SetActive(skillData.IsXpSkill);
		}
		if (_existXpEffect && XpEffect.activeSelf != skillData.IsXpSkill)
		{
			XpEffect.SetActive(skillData.IsXpSkill);
		}
	}

	private void RefreshChargeSkillInfoPLU(HeroSkillData skillData)
	{
		if (_existChargeUIRoot)
		{
			bool isCharging = skillData.IsCharging;
			if (ChargeUIBg.activeSelf != isCharging)
			{
				ChargeUIBg.SetActive(isCharging);
			}
			if ((_existChargeUI & isCharging) && _imgChargeUI.fillAmount != skillData.ChargeUIFill)
			{
				_imgChargeUI.fillAmount = skillData.ChargeUIFill;
			}
		}
	}

	private void RefreshSkillLayerInfoPLU(HeroSkillData skillData)
	{
		bool flag = skillData.SkillCoolingData?.IsCacheLayerVisible ?? false;
		if (_existSkillLayerBg && skillLayerBg.activeSelf != flag)
		{
			skillLayerBg.SetActive(flag);
		}
		if (flag)
		{
			if (_existSkillLayer)
			{
				((TMP_Text)skillLayer).SetText(ZString.Format("{0}", skillData.CacheLayer), true);
			}
			bool flag2 = skillData.CacheLayer == skillData.MaxCacheLayer && skillData.MaxCacheLayer != 0;
			if (_existSkillLayMax && flag2 != SkillLayMax.activeSelf)
			{
				SkillLayMax.SetActive(flag2);
			}
		}
	}

	private void LateUpdateInUIBind()
	{
		if (viewModel == null)
		{
			return;
		}
		bool flag = !viewModel.HideSkillBtn;
		bool flag2 = viewModel.ShowTeachClickEffect;
		HeroSkillData skillData = viewModel.SkillData;
		if (skillData != null)
		{
			RefreshXpSkillInfoPLU(skillData);
			UpdateSkill4Alpha();
			RefreshChargeSkillInfoPLU(skillData);
			RefreshSkillLayerInfoPLU(skillData);
			if (_existEnergyImage && energyImage.activeSelf != skillData.IsAccumulatSkill)
			{
				energyImage.SetActive(skillData.IsAccumulatSkill);
			}
			if (_existStrengthenStateEffect && StrengthenStateEffect.activeSelf != skillData.IsStrengthen)
			{
				StrengthenStateEffect.SetActive(skillData.IsStrengthen);
			}
			flag = skillData.SkillNormalShow && !viewModel.HideSkillBtn;
			flag2 = skillData.IsTeachClick || viewModel.ShowTeachClickEffect;
		}
		if (_existBtnRoot && HideRoot.activeSelf != flag)
		{
			HideRoot.SetActive(flag);
			emptyRaycast.enabled = flag;
		}
		if (_existTeachSkillEffect && TeachSkillEffect.activeSelf != flag2)
		{
			TeachSkillEffect.SetActive(flag2);
		}
		SkillCoolingData coolingData = viewModel.CoolingData;
		if (coolingData != null)
		{
			if (ResourceAmpleReleaseSkill != coolingData.ResourceAmpleReleaseSkill)
			{
				ResourceAmpleReleaseSkill = coolingData.ResourceAmpleReleaseSkill;
			}
			bool flag3 = !coolingData.ResourceAmpleReleaseSkill || !coolingData.PropNumberAmpleRelSkill;
			if (_existAmpleCanvasGroup && canvasGroup.interactable != flag3)
			{
				canvasGroup.interactable = flag3;
			}
			RefreshSkillXpVal(coolingData);
			RefreshSkillCDPropNumPerLateUpdate(coolingData);
			RefreshSkillCDTextPerLateUpdate(coolingData);
			RefreshSkillChargeInfoPerLateUpdate(coolingData);
			RefreshSkillCompPosPerLateUpdate(coolingData);
		}
		RefreshSkillDerivePrgPLU();
	}

	private void ChangeSkinChargeReset(bool useSkin, Color normal)
	{
		aimerNroaml = normal;
		if (chargeRoot == null)
		{
			return;
		}
		if (ChargeEffect == null)
		{
			ChargeEffect = new List<GameObject>(4);
		}
		else
		{
			ChargeEffect.Clear();
		}
		Transform transform = chargeRoot.transform.Find("Effects_Battle_Charge");
		if (transform == null)
		{
			return;
		}
		for (int i = 1; i <= 4; i++)
		{
			Transform transform2 = transform.Find(i.ToString());
			if (transform2 != null)
			{
				ChargeEffect.Add(transform2.gameObject);
			}
		}
	}

	public void ChangeSkinReset(bool useSkin, Color normal)
	{
		iconRect.sizeDelta = (useSkin ? iconSkinSizeData : iconDefaultSizeData);
		icon.color = (useSkin ? Color.white : new Color(1f, 1f, 1f, iconDefaultAlpha));
		ChangeSkinChargeReset(useSkin, normal);
	}
}
