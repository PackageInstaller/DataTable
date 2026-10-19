using System.Collections.Generic;
using ACT.Battle;
using ACT.Event;
using Bamboo.ECS;
using Bamboo.ImageCenter;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace ACT.UI;

public abstract class OperateBtn : UIBehaviour, IPointerDownHandler, IEventSystemHandler, IPointerUpHandler
{
	[SerializeField]
	private List<GameObject> uiParticles;

	private readonly List<GameObject> _activeUIParticles = new List<GameObject>();

	private bool _uiParticlesHidden;

	[SerializeField]
	private OnScreenControlNodeBool _onScreenControl;

	[SerializeReference]
	protected ActButton btn;

	[FormerlySerializedAs("mainImages")]
	[SerializeField]
	protected BImage mainImage;

	[SerializeField]
	protected Image blackBoard;

	[SerializeField]
	protected GameObject cdRoot;

	[SerializeField]
	protected Image cdMask;

	[SerializeField]
	protected MaskCircleChange useCountCdMask;

	[SerializeField]
	protected TextMeshProUGUI cdText;

	[SerializeField]
	protected BtnDotGroup dotGroup;

	[SerializeField]
	protected GameObject progressRoot;

	[SerializeField]
	protected Image durationImage;

	[SerializeField]
	protected Animator animator;

	[SerializeField]
	protected GameObject guideeff;

	protected ImageAssetStation _imageStation;

	protected bool isInCD;

	protected bool isDisableState;

	private OperateBtnData _operateBtnData;

	private float _originalSize;

	private bool _isPointerAbove;

	private string _currentStateClipName = "Normal";

	private string _playingStateClipName;

	private string _playingInteractionClipName;

	private bool _isPc => MonoECS.instance.ispc;

	protected bool isInProgress => progressRoot.activeInHierarchy;

	public OperateBtnData operateBtnData => _operateBtnData;

	private bool isConfigDisableState
	{
		get
		{
			if (_operateBtnData != null)
			{
				return _operateBtnData.configDisableState;
			}
			return false;
		}
	}

	public virtual int systemId { get; }

	public bool interactable
	{
		get
		{
			return btn.interactable;
		}
		set
		{
			SetInteractable(value);
		}
	}

	protected virtual void SubscribeManagerEvents()
	{
	}

	protected virtual void UnsubscribeManagerEvents()
	{
	}

	public virtual void Init(OperateBtnData operateBtnData, CustomUITransform transform, ImageAssetStation imageStation)
	{
		_imageStation = imageStation;
		_operateBtnData = operateBtnData;
		_originalSize = (base.transform as RectTransform).sizeDelta.x;
		if (animator == null)
		{
			TryGetComponent<Animator>(out animator);
		}
		btn.OnEnter.RemoveListener(OnEnter);
		btn.OnEnter.AddListener(OnEnter);
		btn.OnExit.RemoveListener(OnExit);
		btn.OnExit.AddListener(OnExit);
		SetGuideEffActive(active: false);
		SetTransform(transform);
	}

	protected virtual void OnEnter()
	{
		_isPointerAbove = true;
		if (!isDisableState)
		{
			PlayInteractionState("Above", forceRestart: true);
		}
	}

	protected virtual void OnExit()
	{
		_isPointerAbove = false;
		if (!isDisableState)
		{
			StopInteractionState();
		}
	}

	public virtual void UnInit()
	{
	}

	public void SetGuideEffActive(bool active)
	{
		if (guideeff != null)
		{
			guideeff.SetActive(active);
		}
	}

	public void OnUpdateScheme(CustomUITransform transform)
	{
		SetTransform(transform);
	}

	public void SetTransform(CustomUITransform customUITransform)
	{
		RectTransform obj = transform as RectTransform;
		Vector2 anchorMin = (obj.anchorMax = new Vector2(customUITransform.AnchorX, customUITransform.AnchorY));
		obj.anchorMin = anchorMin;
		obj.anchoredPosition = customUITransform.Pos;
		obj.transform.localScale = customUITransform.Diameter / _originalSize * Vector3.one;
	}

	public void SetActive(bool active)
	{
		gameObject.SetActive(active);
	}

	public void OnPrompt()
	{
		PlayInteractionState("Prompt", forceRestart: true);
	}

	void IPointerDownHandler.OnPointerDown(PointerEventData eventData)
	{
		if (interactable && !isDisableState)
		{
			_onScreenControl?.SendValue(value: true, immediate: true);
			PlayInteractionState("Click", forceRestart: true);
		}
	}

	void IPointerUpHandler.OnPointerUp(PointerEventData eventData)
	{
		_onScreenControl?.SendValue(value: false);
	}

	protected virtual void Refresh(OperateBtnDisplayData displayData)
	{
		OperateBtnBindSkillInfo bindSkillInfo = displayData.BindSkillInfo;
		UpdateCd(displayData);
		InitSkillUseCount(displayData.ShowCount, bindSkillInfo);
		if (!displayData.ShowDuration && progressRoot.gameObject.activeSelf)
		{
			progressRoot.gameObject.SetActive(value: false);
		}
		SetInteractive(displayData);
	}

	protected virtual void SetInteractive(OperateBtnDisplayData displayData)
	{
	}

	protected virtual void UpdateCd(OperateBtnDisplayData displayData)
	{
		if (!displayData.ShowCd)
		{
			isInCD = false;
			SetCdActive(active: false);
			SetInteractable(interactableState: true);
			SetDisableState(isDisable: false);
			return;
		}
		if (displayData.BindSkillInfo == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("绑定的Motion名:" + displayData.MotionName + "，在技能配置中找不到，检查一下这个motion对应Skill的配置");
			}
			return;
		}
		float num = Mathf.Max(0f, displayData.BindSkillInfo.CurSkilllCd);
		float num2 = num / displayData.BindSkillInfo.ConfigCd;
		bool flag = displayData.ShowCount && displayData.BindSkillInfo.CurSkillCount != displayData.BindSkillInfo.MaxCount && displayData.BindSkillInfo.CurSkillCount != 0;
		isInCD = num > 0f;
		SetCdActive(isInCD);
		SetInteractable(!isInCD | flag);
		SetDisableState(isInCD && !flag);
		if (useCountCdMask != null && useCountCdMask.gameObject.activeSelf != flag)
		{
			useCountCdMask.gameObject.SetActive(flag);
		}
		bool flag2 = !flag;
		if (cdMask.gameObject.activeSelf != flag2)
		{
			cdMask.gameObject.SetActive(flag2);
		}
		if (cdText.gameObject.activeSelf != flag2)
		{
			cdText.gameObject.SetActive(flag2);
		}
		if (flag)
		{
			float angle = 360f * num2;
			useCountCdMask?.ChangeMaskCircle(angle);
		}
		if (!flag)
		{
			cdMask.fillAmount = num2;
			int num3 = Mathf.RoundToInt(num * 10f);
			int num4 = num3 / 10;
			int num5 = num3 % 10;
			cdText.SetText("{0}.{1}", num4, num5);
		}
	}

	protected void SetCdActive(bool active)
	{
		if (cdRoot.gameObject.activeSelf != active)
		{
			cdRoot.gameObject.SetActive(active);
		}
	}

	protected virtual void InitSkillUseCount(bool showCount, OperateBtnBindSkillInfo bindSkillInfo)
	{
		if (!(dotGroup == null))
		{
			if (showCount && bindSkillInfo != null)
			{
				dotGroup.Init(bindSkillInfo.MaxCount, bindSkillInfo.CurSkillCount);
			}
			else
			{
				dotGroup.UnInit();
			}
		}
	}

	protected void UpdateSkillUseCountDisplay(OperateBtnDisplayData displayData)
	{
		if (!(dotGroup == null))
		{
			OperateBtnBindSkillInfo bindSkillInfo = displayData.BindSkillInfo;
			if (!displayData.ShowCount || bindSkillInfo == null)
			{
				dotGroup.UnInit();
			}
			else
			{
				dotGroup.OnCountChange(bindSkillInfo.MaxCount, bindSkillInfo.CurSkillCount);
			}
		}
	}

	protected virtual void SetDisableState(bool isDisable)
	{
		isDisableState = isDisable || isConfigDisableState;
		RefreshDisableAnim();
	}

	public void SetConfigDisableState(bool enterDisableState)
	{
		_operateBtnData.configDisableState = enterDisableState;
		if (enterDisableState)
		{
			SetInteractable(interactableState: false);
			SetDisableState(isDisable: true);
		}
	}

	protected void SetInteractable(bool interactableState)
	{
		btn.Interactable(interactableState && !isConfigDisableState);
	}

	public virtual void OnAbilityAdd(OperateBtnDisplayData displayData, AbilityAddEvt abilityAddEvt)
	{
	}

	public virtual void OnAbilityRemove(OperateBtnDisplayData displayData, AbilityRemoveEvt abilityRemoveEvt)
	{
	}

	public virtual void OnAbilityStackChange(OperateBtnDisplayData displayData)
	{
	}

	public virtual void OnAbilityDurationChange(OperateBtnDisplayData displayData, AbilityDurationChangeEvt abilityDurationChangeEvt)
	{
	}

	public virtual void OnEnergyValChange(OperateBtnDisplayData displayData)
	{
	}

	public virtual void OnUltraEnergyChange(OperateBtnDisplayData displayData)
	{
	}

	public virtual void OnDynamicValValChange(OperateBtnDisplayData displayData)
	{
	}

	public virtual void OnRebindSkill(OperateBtnDisplayData displayData)
	{
		if (string.IsNullOrEmpty(displayData.MotionName))
		{
			Refresh(displayData);
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"未找到{displayData.BindSkillInfo?.EntityId}在OperateBtnConfig中配置的技能:{displayData.MotionName}，请检查技能的configMotion配置和OperateBtnConfig,确认不需要的话请忽略");
			}
		}
		_currentStateClipName = GetStateClipName(displayData.skillCurType);
		PlayMainState(_currentStateClipName);
		Refresh(displayData);
	}

	protected void RefreshDisableAnim()
	{
		if (isDisableState)
		{
			PlayInteractionState("Disable", forceRestart: true);
		}
		else
		{
			StopInteractionState();
		}
	}

	protected string GetStateClipName(SpskillType skillType)
	{
		return skillType switch
		{
			SpskillType.exchange => "Change", 
			SpskillType.strength => "NormalStrength", 
			SpskillType.ultraStrength => "ChangeStrength", 
			_ => "Normal", 
		};
	}

	protected void PlayMainState(string stateName, bool forceRestart = false)
	{
		PlayAnimatorState(stateName, 0, forceRestart, ref _playingStateClipName);
	}

	private void PlayInteractionState(string stateName, bool forceRestart = false)
	{
		PlayAnimatorState(stateName, 1, forceRestart, ref _playingInteractionClipName);
	}

	private void StopInteractionState()
	{
		PlayInteractionState("Empty");
	}

	private void PlayAnimatorState(string stateName, int layerIndex, bool forceRestart, ref string playingStateName)
	{
		if (animator == null)
		{
			return;
		}
		int stateID = Animator.StringToHash(stateName);
		if (animator.HasState(layerIndex, stateID) && (forceRestart || !(playingStateName == stateName)))
		{
			if (animator.isActiveAndEnabled)
			{
				animator.Play(stateName, layerIndex, 0f);
			}
			playingStateName = stateName;
		}
	}

	public virtual void RefreshDisplay(Entity eb)
	{
	}

	public virtual void ReSetDisPlayData()
	{
	}

	public void SetUIParticleActive(bool active)
	{
		List<GameObject> list = uiParticles;
		if (list == null || list.Count <= 0)
		{
			return;
		}
		if (!active)
		{
			if (_uiParticlesHidden)
			{
				return;
			}
			_activeUIParticles.Clear();
			for (int i = 0; i < uiParticles.Count; i++)
			{
				GameObject gameObject = uiParticles[i];
				if (!(gameObject == null) && gameObject.activeSelf)
				{
					_activeUIParticles.Add(gameObject);
					gameObject.SetActive(value: false);
				}
			}
			_uiParticlesHidden = true;
		}
		else
		{
			if (!_uiParticlesHidden)
			{
				return;
			}
			for (int j = 0; j < _activeUIParticles.Count; j++)
			{
				GameObject gameObject2 = _activeUIParticles[j];
				if (gameObject2 != null)
				{
					gameObject2.SetActive(value: true);
				}
			}
			_activeUIParticles.Clear();
			_uiParticlesHidden = false;
		}
	}
}
