using Config;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class AbilityButton : MonoBehaviour, IPointerDownHandler, IEventSystemHandler, IPointerUpHandler
{
	private const float HIDE_SUB_BUTTON_CD_TIME = 0.3f;

	public EOperatorType OperatorType;

	public SubStickController JoyStick;

	[Tooltip("如果不赋值,则不会触发按钮(AttackButton)按下+弹起的事件,只会处理摇杆")]
	public AttackButton mAttackButton;

	public Text ConsumeText;

	public Image ConsumeLine;

	private Text _cdText;

	private Image _cdImage;

	private Image _endurance;

	private Image _abilityIcon;

	private Image _disableImage;

	private AttackButton[] _extendAbility;

	private bool _isShowSubButton;

	private float _showSubButtonTime;

	public float ShowSubButtonTime = 3f;

	public string SubJoystickPrefabPath = "UI/BattlePanelEffect/AbilityButtonSubJoystick";

	public SubStickEffectController JoyStickEffectController;

	public EffectLevel ChargingController;

	private int _curChargeCount;

	private float m_lastCd;

	public GameObject effect;

	private bool useEffect;

	private bool useableCD = true;

	private bool useableOther = true;

	public bool Enable { get; set; }

	public void Awake()
	{
		Transform transform = base.transform.Find("CDMask");
		if (null != transform)
		{
			_cdImage = transform.GetComponent<Image>();
		}
		Transform transform2 = base.transform.Find("Endurance");
		if (null != transform2)
		{
			_endurance = transform2.GetComponent<Image>();
		}
		Transform transform3 = base.transform.Find("SkillIcon");
		if (transform3 != null)
		{
			_abilityIcon = transform3.GetComponent<Image>();
		}
		Transform transform4 = base.transform.Find("Disable");
		if (null != transform4)
		{
			_disableImage = transform4.GetComponent<Image>();
		}
		Transform transform5 = base.transform.Find("text");
		if (null != transform5)
		{
			_cdText = transform5.GetComponent<Text>();
		}
		switch (OperatorType)
		{
		case EOperatorType.Sub:
		{
			GetComponent<AttackButton>().enabled = false;
			_extendAbility = new AttackButton[3];
			for (int i = 0; i < _extendAbility.Length; i++)
			{
				Transform transform6 = base.transform.Find("Subs/SubAbilityButton" + i);
				if (null != transform6)
				{
					_extendAbility[i] = transform6.GetComponent<AttackButton>();
					transform6.GetComponent<Button>().onClick.AddListener(OnClickSubButton);
				}
			}
			break;
		}
		case EOperatorType.JoyStic:
			GetComponent<AttackButton>().enabled = false;
			break;
		case EOperatorType.SendMessage:
			break;
		}
	}

	public void UpdateConsume(string info)
	{
		ConsumeText.text = info;
	}

	public void ShowConsume(bool visible)
	{
		ConsumeText.enabled = visible;
		ConsumeLine.enabled = visible;
	}

	public void SetCD(float current, float max)
	{
		if (current < 0f)
		{
			Debug.LogError("CD 负数了！！！");
			current = 0f;
		}
		if (null != ChargingController)
		{
			ChargingController.UpdateChargingCD(_curChargeCount, current, max);
		}
		if (_curChargeCount > 0)
		{
			current = 0f;
			max = 1f;
		}
		if (null != _cdText)
		{
			if (0f == current)
			{
				_cdText.text = string.Empty;
			}
			else
			{
				int num = Mathf.CeilToInt(current / 1000f);
				if (num < CommonString.Numbers.Length)
				{
					_cdText.text = CommonString.Numbers[num];
				}
				else
				{
					_cdText.text = num.ToString();
				}
			}
		}
		if (null != _cdImage)
		{
			if (null != _cdImage && max != 0f)
			{
				_cdImage.fillAmount = current / max;
			}
			else
			{
				_cdImage.fillAmount = 0f;
			}
		}
		if (m_lastCd != current && null != _abilityIcon)
		{
			if (0f != m_lastCd && 0f == current)
			{
				useableCD = true;
			}
			else if (0f == m_lastCd && 0f != current)
			{
				useableCD = false;
			}
			if (useableCD && (_disableImage == null || !_disableImage.gameObject.activeSelf))
			{
				_abilityIcon.color = new Color(_abilityIcon.color.r, _abilityIcon.color.g, _abilityIcon.color.b, 1f);
			}
			else if (!useableCD)
			{
				_abilityIcon.color = new Color(_abilityIcon.color.r, _abilityIcon.color.g, _abilityIcon.color.b, 8f / 85f);
			}
			UpdateEffect();
		}
		m_lastCd = current;
	}

	private void UpdateEffect()
	{
		if (!(effect == null))
		{
			bool flag = useEffect && useableCD && useableOther;
			if (flag && !effect.activeSelf)
			{
				effect.SetActive(value: true);
			}
			else if (!flag && effect.activeSelf)
			{
				effect.SetActive(value: false);
			}
		}
	}

	public void SetIcon(Sprite icon)
	{
		if (null != _abilityIcon)
		{
			_abilityIcon.sprite = icon;
		}
		if (int.TryParse(icon.name.Replace("(Clone)", ""), out var result) && ConfigHelper.GetInstance().TryGetConfig<AbilityConfig>(result, out var config) && config.IsExtensionalSkill)
		{
			useEffect = true;
		}
		else
		{
			useEffect = false;
		}
		UpdateEffect();
	}

	public void SetCharge(int count)
	{
		_curChargeCount = count;
		if (null != ChargingController)
		{
			ChargingController.PlayLevel(count);
		}
	}

	public void ShowDisable(bool show)
	{
		if (_endurance != null && _endurance.enabled == show)
		{
			_endurance.enabled = !show;
		}
		if (!_disableImage || _disableImage.gameObject.activeSelf == show)
		{
			return;
		}
		_disableImage.gameObject.SetActive(show);
		useableOther = !show;
		UpdateEffect();
		if (_abilityIcon != null && m_lastCd == 0f)
		{
			if (show)
			{
				_abilityIcon.color = new Color(_abilityIcon.color.r, _abilityIcon.color.g, _abilityIcon.color.b, 8f / 85f);
			}
			else
			{
				_abilityIcon.color = new Color(_abilityIcon.color.r, _abilityIcon.color.g, _abilityIcon.color.b, 1f);
			}
		}
	}

	public void Update()
	{
		if (EOperatorType.Sub == OperatorType && _isShowSubButton)
		{
			if (_showSubButtonTime >= ShowSubButtonTime)
			{
				OnClickSubButton();
			}
			if (_showSubButtonTime > 0.3f && Input.GetMouseButtonDown(0))
			{
				OnClickSubButton();
			}
			_showSubButtonTime += Time.deltaTime;
		}
	}

	private void OnClickSubButton()
	{
		ShowExternAbility(isShow: false);
		_isShowSubButton = false;
		_showSubButtonTime = 0f;
	}

	public void Setendurance(float current, float max)
	{
		if (null != _endurance)
		{
			_endurance.fillAmount = current / max;
		}
	}

	public void ShowExternAbility(bool isShow)
	{
		int num = 0;
		while (_extendAbility != null && num < _extendAbility.Length)
		{
			if (null != _extendAbility[num])
			{
				_extendAbility[num].gameObject.SetActive(isShow);
			}
			num++;
		}
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		switch (OperatorType)
		{
		case EOperatorType.JoyStic:
			if (null != JoyStick && m_lastCd <= 0f && Enable)
			{
				JoyStick.gameObject.SetActive(value: true);
				JoyStick.Enable = true;
				JoyStick.transform.position = base.transform.position;
				JoyStickEffectController.Enter();
			}
			if (mAttackButton != null)
			{
				mAttackButton.OnClick();
			}
			JoyStick.InitAimPosition();
			break;
		case EOperatorType.Sub:
			if (!_isShowSubButton)
			{
				ShowExternAbility(isShow: true);
				_isShowSubButton = true;
				_showSubButtonTime = 0f;
			}
			else
			{
				ShowExternAbility(isShow: false);
				_isShowSubButton = false;
			}
			break;
		}
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		switch (OperatorType)
		{
		case EOperatorType.JoyStic:
			if (null != JoyStick)
			{
				Interrupt();
			}
			if (mAttackButton != null)
			{
				mAttackButton.OnRelease();
			}
			break;
		case EOperatorType.Sub:
		{
			RaycastResult pointerCurrentRaycast = eventData.pointerCurrentRaycast;
			if (!(null != pointerCurrentRaycast.gameObject))
			{
				break;
			}
			for (int i = 0; i < _extendAbility.Length; i++)
			{
				if (null != _extendAbility[i] && pointerCurrentRaycast.gameObject == _extendAbility[i].gameObject)
				{
					_extendAbility[i].OnClick();
					OnClickSubButton();
					break;
				}
			}
			break;
		}
		}
	}

	public void Interrupt()
	{
		if (OperatorType == EOperatorType.JoyStic && null != JoyStick)
		{
			JoyStick.Enable = false;
			JoyStick.SendLocalCommandend();
			JoyStickEffectController.Exit();
		}
	}

	public SubStickController ChangeType2SubJoystick()
	{
		GameObject gameObject = CommonEffectClipPlayer.InstantiateEffect(base.transform, SubJoystickPrefabPath, string.Empty, Vector3.zero, Vector3.one, Vector3.zero, Vector3.forward, isAttach: true);
		if (gameObject != null)
		{
			OperatorType = EOperatorType.JoyStic;
			JoyStick = gameObject.GetComponent<SubStickController>();
			JoyStickEffectController = gameObject.GetComponent<SubStickEffectController>();
			JoyStickEffectController.InitEvent(delegate
			{
				JoyStick.gameObject.SetActive(value: false);
			});
			mAttackButton = GetComponent<AttackButton>();
			if (mAttackButton != null)
			{
				mAttackButton.enabled = false;
			}
			gameObject.SetActive(value: false);
		}
		return JoyStick;
	}

	private void OnDisable()
	{
		if (JoyStick != null)
		{
			JoyStick.gameObject.SetActive(value: false);
		}
	}
}
