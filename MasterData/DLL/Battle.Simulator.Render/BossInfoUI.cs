using System;
using System.Collections.Generic;
using Config;
using UnityEngine;
using UnityEngine.UI;

public class BossInfoUI : MonoBehaviour, IBattleUIElement
{
	public CanvasGroup canvasGroup;

	public Text Name;

	public Text HpCount;

	public Slider HpBar;

	public HPSlowSliderEffect HpSlowBar;

	public Image HpBarBg;

	public Slider PostureBar;

	public Image PostureBarBackground;

	public GameObject AffixTip;

	public Text AffixTipText;

	public GameObject breakDefenseEffect;

	public GameObject shieldCount;

	public GameObject shieldValue;

	public Slider shieldValueSlider;

	public Image shieldTypeImage;

	public Image shieldValueImage;

	public Image shieldValueHandle;

	public Image shieldCountImage;

	public Image shieldCountBgImage;

	public Sprite shieldHandle;

	public Color shielCorlor;

	public Sprite breakHandle;

	public Color breakCorlor;

	public int shieldMaxHpBuffClassID;

	public int shieldBuffClassID;

	public int shieldCountMax = 15;

	public ResistanceUI resistanceUI;

	public UIShake shake;

	public Component[] AllObjects;

	private NAgent _target;

	private BBHumanoid _targetBlackboard;

	private ComponentHealth _componentHealth;

	private List<BuffItemUI> _buffs = new List<BuffItemUI>();

	private List<BuffItemUI> _debuffs = new List<BuffItemUI>();

	private List<AffixItemUI> _affixs = new List<AffixItemUI>();

	private bool _init;

	private long _lastHp;

	private long _lastHpPercent;

	private long _lastStripCount = -1L;

	private List<string> buffIconTempList = new List<string>();

	private const float BASE_TIME = 8000f;

	private float _baseTime = 8000f;

	public List<float> shakeDis = new List<float>();

	public List<int> shieldTypeID = new List<int>();

	public List<string> shieldTypePath = new List<string>();

	private Dictionary<int, string> shieldType;

	private int _lastShieldType = -1;

	public P08UISwitch uiSwitch { get; set; }

	public void SetActive(bool isActive, BattleUIElementActiveChangeReason reason)
	{
		uiSwitch.SetActive(isActive, reason);
	}

	private void SwitchLogicOnAwake()
	{
		if (uiSwitch == null)
		{
			uiSwitch = new P08UISwitch();
			uiSwitch.canvasGroup = canvasGroup;
			uiSwitch.gameObject = base.gameObject;
		}
	}

	public void Awake()
	{
		Transform transform = null;
		for (int i = 0; i < 3; i++)
		{
			transform = base.transform.Find("Buff_Debuff/Buff/Item" + i);
			if (null != transform)
			{
				_buffs.Add(transform.gameObject.AddComponent<BuffItemUI>());
			}
			transform = base.transform.Find("Buff_Debuff/Debuff/Item" + i);
			if (null != transform)
			{
				_debuffs.Add(transform.gameObject.AddComponent<BuffItemUI>());
			}
		}
		for (int j = 0; j < 5; j++)
		{
			transform = base.transform.Find("Affix/Item" + j);
			if (null != transform)
			{
				AffixItemUI item = transform.gameObject.AddComponent<AffixItemUI>();
				int index = j;
				transform.transform.Find("clickArea").GetComponent<Button>().onClick.AddListener(delegate
				{
					OnAffixClick(index);
				});
				_affixs.Add(item);
			}
		}
		SwitchLogicOnAwake();
		InitShieldType();
		AllObjects = GetComponentsInChildren<Component>();
		SetVisible(visible: false);
	}

	private void OnAffixClick(int index)
	{
		if (AffixTip.transform.parent != _affixs[index].transform)
		{
			AffixTip.transform.SetParent(_affixs[index].transform);
			AffixTip.transform.localPosition = new Vector3(80f, -64f, 0f);
			AffixTip.gameObject.SetActive(value: true);
		}
		else
		{
			AffixTip.gameObject.SetActive(!AffixTip.activeSelf);
		}
		if (AffixTip.activeSelf)
		{
			string desc = _affixs[index].GetDesc();
			if (!string.IsNullOrEmpty(desc))
			{
				AffixTipText.text = desc;
				LayoutRebuilder.ForceRebuildLayoutImmediate(AffixTipText.transform as RectTransform);
				LayoutRebuilder.ForceRebuildLayoutImmediate(AffixTip.transform as RectTransform);
			}
		}
	}

	public void OnUpdateLockTarget(int target)
	{
		if (!(null == _target) && _target.AgentID == target)
		{
			return;
		}
		if (AffixTip != null && AffixTip.gameObject != null)
		{
			AffixTip.gameObject.SetActive(value: false);
		}
		_target = ((BattleScene)NScene.GetCurrentScene()).GetAgentManager().GetAgent(target);
		if (null == _target)
		{
			SetVisible(visible: false);
			return;
		}
		bool flag = false;
		_lastHp = 0L;
		_lastStripCount = -1L;
		_targetBlackboard = _target.Blackboard as BBHumanoid;
		_componentHealth = _target.GetComponent<ComponentHealth>();
		if (!(null == _targetBlackboard) && !(null == _componentHealth) && (!(null != _targetBlackboard) || _targetBlackboard.m_NextSimFrameData == null || _targetBlackboard.m_NextSimFrameData.HP > 0))
		{
			flag = UpdateUIName();
			SetVisible(flag);
			OnTargetNotBossOrElitel(_targetBlackboard.m_NextSimFrameData.mEntityType > EnemyType.MonsterNormal);
			UpdateUI();
		}
	}

	public bool UpdateUIName()
	{
		if (_target == null || _targetBlackboard == null)
		{
			return false;
		}
		if (!ConfigHelper.GetInstance().TryGetConfig<charactor_param>(_target.AgentSkinID, out var config))
		{
			config = ConfigHelper.GetInstance().GetConfig<charactor_param>(_target.AgentConfigID);
		}
		if (_target.HasNickName)
		{
			Name.text = _target.NickName;
			return true;
		}
		if (config != null)
		{
			Name.text = WorldStateManager.GetSystemTableI18N(config.Name);
			return true;
		}
		return false;
	}

	private void UpdateUI()
	{
		if (!(null != _componentHealth) || !(null != _targetBlackboard) || _targetBlackboard.m_NextSimFrameData == null)
		{
			return;
		}
		if (_componentHealth.HpStripCount == 0)
		{
			_componentHealth.HpStripCount = 1;
		}
		if (_componentHealth.MaxHealth == 0L)
		{
			_componentHealth.MaxHealth = 1L;
		}
		float num = (float)_componentHealth.MaxHealth / (float)_componentHealth.HpStripCount;
		long num2 = (_componentHealth.HealthChangeSlowly * _componentHealth.HpStripCount - 1) / _componentHealth.MaxHealth;
		long num3 = num2;
		HpBar.value = ((float)_componentHealth.Health - (float)num3 * num) / num;
		if (_lastHp != _componentHealth.Health)
		{
			HpBarBg.enabled = num3 > 0;
			_lastHp = _componentHealth.Health;
		}
		long num4 = _componentHealth.Health * 100 / _componentHealth.MaxHealth;
		if (_lastStripCount != num2 || _lastHpPercent != num4)
		{
			if (num3 <= 0)
			{
				HpCount.text = string.Empty;
			}
			else if (num2 + 1 >= CommonString.Numbers.Length)
			{
				HpCount.text = $"X{num2 + 1} ({num4}%)";
			}
			else
			{
				HpCount.text = $"X{CommonString.Numbers[num2 + 1]} ({num4}%)";
			}
			_lastStripCount = num2;
			_lastHpPercent = num4;
		}
		float num5 = ((num2 <= num3) ? (((float)_componentHealth.HealthChangeSlowly - (float)num2 * num) / num) : 1f);
		if (Mathf.Abs(HpSlowBar.min - HpBar.value) > 0.001f || Mathf.Abs(HpSlowBar.max - num5) > 0.001f)
		{
			HpSlowBar.SetDuration(HpBar.value, num5);
		}
		int sourceSpaceKeepTime = (NScene.GetCurrentScene() as BattleScene).GetWorldSatetManager().m_SourceSpaceKeepTime;
		if (sourceSpaceKeepTime > 0)
		{
			if ((float)sourceSpaceKeepTime > _baseTime)
			{
				_baseTime = sourceSpaceKeepTime;
			}
			PostureBar.value = Mathf.Clamp01((float)sourceSpaceKeepTime / _baseTime);
		}
		else
		{
			if (_baseTime != 8000f)
			{
				_baseTime = 8000f;
			}
			PostureBar.value = ((_targetBlackboard.m_NextSimFrameData.mMaxExposedValue != 0L) ? Mathf.Clamp01((float)_targetBlackboard.m_NextSimFrameData.mExposedValue * 1f / (float)_targetBlackboard.m_NextSimFrameData.mMaxExposedValue) : 0f);
		}
		buffIconTempList.Clear();
		BuffItemUI.UpdateBuffList(_targetBlackboard.m_NextSimFrameData.BuffStateArray, _buffs, "BUFF", buffIconTempList);
		BuffItemUI.UpdateBuffList(_targetBlackboard.m_NextSimFrameData.BuffStateArray, _debuffs, "DEBUFF", buffIconTempList);
		int num6 = 0;
		for (int i = 0; i < _targetBlackboard.m_NextSimFrameData.BuffStateArray.Count; i++)
		{
			BuffState buffState = _targetBlackboard.m_NextSimFrameData.BuffStateArray[i];
			if (num6 < _affixs.Count && ConfigHelper.GetInstance().HasConfig<public_buff>(buffState.mBuffConfigID))
			{
				public_buff config = ConfigHelper.GetInstance().GetConfig<public_buff>(buffState.mBuffConfigID);
				if (config != null && "AFFIX" == config.Type)
				{
					_affixs[num6].SetActive(active: true);
					_affixs[num6].SetIcon(config.Icon);
					int id = buffState.mBuffParams.v3;
					int level = buffState.mBuffParams.v4;
					affix_type config2 = ConfigHelper.GetInstance().GetConfig<affix_type>(id);
					int index = config2.Description.get_Item(0);
					_affixs[num6].SetDesc(index, level);
					_affixs[num6].SetName(WorldStateManager.GetSystemTableI18N(config2.Name));
					_affixs[num6].SetLevel(level);
					num6++;
				}
			}
		}
		for (int j = num6; j < _affixs.Count; j++)
		{
			_affixs[j].SetActive(active: false);
		}
		if (resistanceUI != null)
		{
			bool resistanceState = _componentHealth.ResistanceState;
			int resistanceCurTime = (int)_componentHealth.ResistanceCurTime;
			int resistanceMaxTime = (int)_componentHealth.ResistanceMaxTime;
			int resistanceCurValue = _componentHealth.ResistanceCurValue;
			int resistanceMaxValue = _componentHealth.ResistanceMaxValue;
			resistanceUI.SetResistanceUI(resistanceState, resistanceCurTime, resistanceMaxTime, resistanceCurValue, resistanceMaxValue, _targetBlackboard.m_NextSimFrameData.mResistanceStateEle, _targetBlackboard.m_NextSimFrameData.mResistanceEle);
		}
		if (shake != null && _componentHealth.uishake > 0)
		{
			shake.StartShake();
		}
		if (!UpdateShieldBuff(_targetBlackboard.m_NextSimFrameData.BuffStateArray))
		{
			UpdateBreakValue(_targetBlackboard.m_NextSimFrameData.mBreakState, _targetBlackboard.m_NextSimFrameData.mBreakValue, _targetBlackboard.m_NextSimFrameData.mMaxBreakValue);
		}
	}

	public void Update()
	{
		if (!_init)
		{
			CameraParamComponent virtualCameraParam = ((BattleScene)NScene.GetCurrentScene()).virtualCameraParam;
			if (null == virtualCameraParam)
			{
				return;
			}
			virtualCameraParam.gameObject.GetComponent<LockTargetCinemachine>();
			_init = true;
		}
		if (null != _targetBlackboard && _targetBlackboard.m_NextSimFrameData != null && _targetBlackboard.m_NextSimFrameData.HP <= 0)
		{
			_target = null;
			_targetBlackboard = null;
			_componentHealth = null;
			SetVisible(visible: false);
		}
		WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
		if (worldStateManager == null)
		{
			SetVisible(visible: false);
			return;
		}
		int lockedAgentID = worldStateManager.lockedAgentID;
		if (_target == null || lockedAgentID != _target.AgentID)
		{
			OnUpdateLockTarget(lockedAgentID);
		}
		if (_target != null)
		{
			UpdateUI();
		}
	}

	private void OnTargetNotBossOrElitel(bool isBossorElitel)
	{
		PostureBar.gameObject.SetActive(isBossorElitel);
	}

	private void SetVisible(bool visible)
	{
		SetActive(visible, BattleUIElementActiveChangeReason.DefaultState);
	}

	private void OnDestroy()
	{
		for (int i = 0; i < _affixs.Count; i++)
		{
			_affixs[i].transform.Find("clickArea").GetComponent<Button>().onClick.RemoveAllListeners();
		}
		BattleScene battleScene = (BattleScene)NScene.GetCurrentScene();
		if (!(battleScene == null))
		{
			CameraParamComponent virtualCameraParam = battleScene.virtualCameraParam;
			if (!(null == virtualCameraParam))
			{
				_ = virtualCameraParam.gameObject.GetComponent<LockTargetCinemachine>() == null;
			}
		}
	}

	private bool UpdateShieldBuff(List<BuffState> buffStates)
	{
		bool flag = false;
		int num = 0;
		for (int i = 0; i < buffStates.Count; i++)
		{
			if (buffStates[i].mBuffClassID == 4503)
			{
				if (!shieldValue.activeSelf)
				{
					shieldValue.SetActive(value: true);
				}
				if (shieldCount.activeSelf)
				{
					shieldCount.SetActive(value: false);
				}
				shieldValueSlider.value = Mathf.Clamp01(1f - (float)(long)buffStates[i].mBuffParams.v1 / (float)(long)buffStates[i].mBuffParams.v3);
				flag = true;
				break;
			}
			if (buffStates[i].mBuffClassID != shieldBuffClassID && buffStates[i].mBuffClassID != shieldMaxHpBuffClassID)
			{
				continue;
			}
			num = 0;
			int num2 = 0;
			int num3 = 1;
			if (!buffStates[i].mBuffParams.v3.boolVar)
			{
				if (ConfigHelper.GetInstance().TryGetConfig<public_buff>(buffStates[i].mBuffConfigID, out var config))
				{
					num = config.BuffparamBase.get_Item(0);
					num2 = config.BuffparamBase.get_Item(1) + config.BuffparamFactor.get_Item(1) * buffStates[i].mFloor;
					num2 = ((num2 < 1) ? 1 : num2);
					num3 = num2;
				}
				else
				{
					num = buffStates[i].mBuffParams.v1;
					num2 = buffStates[i].mBuffParams.v2;
					num2 = ((num2 < 1) ? 1 : num2);
					num3 = num2;
				}
			}
			else
			{
				num = buffStates[i].mBuffParams.v1;
				num2 = buffStates[i].mBuffParams.v2;
				num3 = buffStates[i].mBuffParams.v4;
			}
			ShieldPatternType shieldPatternType = (ShieldPatternType)(num & 0xF);
			num3 = ((num3 == 0) ? int.MaxValue : num3);
			switch (shieldPatternType)
			{
			case ShieldPatternType.ByTime:
				if (shieldValue.activeSelf)
				{
					shieldValue.SetActive(value: false);
				}
				if (!shieldCount.activeSelf)
				{
					shieldCount.SetActive(value: true);
				}
				flag = true;
				shieldCountBgImage.fillAmount = Mathf.Clamp01((float)num3 / (float)shieldCountMax);
				shieldCountImage.fillAmount = Mathf.Clamp01((float)num2 / (float)shieldCountMax);
				break;
			case ShieldPatternType.ByValue:
				if (!shieldValue.activeSelf)
				{
					shieldValue.SetActive(value: true);
				}
				if (shieldCount.activeSelf)
				{
					shieldCount.SetActive(value: false);
				}
				flag = true;
				shieldValueSlider.value = Mathf.Clamp01((float)num2 / (float)num3);
				break;
			default:
				continue;
			}
			break;
		}
		if (_lastShieldType != num)
		{
			_lastShieldType = num;
			if (shieldType.ContainsKey(num))
			{
				if (!shieldTypeImage.gameObject.activeSelf)
				{
					shieldTypeImage.gameObject.SetActive(value: true);
				}
				shieldTypeImage.sprite = AtlasManager.GetSpriteWithoutAtlas(shieldType[num]);
			}
			else if (shieldTypeImage.gameObject.activeSelf)
			{
				shieldTypeImage.gameObject.SetActive(value: false);
			}
		}
		if (!flag && shieldCount.activeSelf)
		{
			shieldCount.SetActive(value: false);
		}
		if (flag)
		{
			shieldValueImage.color = shielCorlor;
			shieldValueHandle.sprite = shieldHandle;
		}
		else
		{
			shieldValueImage.color = breakCorlor;
			shieldValueHandle.sprite = breakHandle;
		}
		return flag;
	}

	private void UpdateBreakValue(BreakState breakState, int breakValue, int maxBreakValue)
	{
		if (maxBreakValue <= 0)
		{
			if (shieldValue.activeSelf)
			{
				shieldValue.SetActive(value: false);
			}
			if (breakDefenseEffect.activeSelf)
			{
				breakDefenseEffect.SetActive(value: false);
			}
			return;
		}
		if (!shieldValue.activeSelf)
		{
			shieldValue.SetActive(value: true);
		}
		shieldValueSlider.value = Mathf.Clamp01((float)breakValue / (float)maxBreakValue);
		if (breakState == BreakState.breakCDState)
		{
			if (!breakDefenseEffect.activeSelf)
			{
				breakDefenseEffect.SetActive(value: true);
			}
		}
		else if (breakDefenseEffect.activeSelf)
		{
			breakDefenseEffect.SetActive(value: false);
		}
	}

	private void InitShieldType()
	{
		shieldType = new Dictionary<int, string>();
		for (int i = 0; i < shieldTypeID.Count; i++)
		{
			shieldType[shieldTypeID[i]] = shieldTypePath[i];
		}
	}

	public void SetHpShakeLevel(int index)
	{
		index = Math.Clamp(index, 0, shakeDis.Count - 1);
		shake.distance = shakeDis[index];
	}
}
