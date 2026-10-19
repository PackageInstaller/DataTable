using System;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Event;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class MonsterCustomUI : MonoBehaviour, IEntityUI
{
	[SerializeField]
	private TextMeshProUGUI level;

	[SerializeField]
	private TargetValueMaskBar bloodBar;

	[SerializeField]
	private PostureBarSingle postureBarSingle;

	[SerializeField]
	private PostureBarMultiGroup postureBarMultiGroup;

	[SerializeField]
	private BetterAnimation _animation;

	[SerializeField]
	private string highHitAnimationName;

	[SerializeField]
	private string lowHitAnimationName;

	public bool enableAttackPercentRefresh = true;

	public float attackPercentRefreshDelay = 0.03f;

	[SerializeField]
	private CanvasGroup _visibleGroup;

	private EntityUIInfo _entityUIInfo;

	private PostureBarBase _curPostureBar;

	private Entity _entity;

	private bool _isDieHiding;

	private bool _isInView;

	private bool _needShowAnim;

	private const float VisibleDistanceSqr = 144f;

	private bool _isVisible;

	[SerializeField]
	private GameObject _monsterDieBarEffectObj;

	private bool _show;

	public EntityUIInfo entityUIInfo => _entityUIInfo;

	public bool Show
	{
		get
		{
			return _show;
		}
		set
		{
			if (_show != value)
			{
				_show = value;
			}
		}
	}

	public bool isDieHiding => _isDieHiding;

	private void SetViewVisible(bool visible)
	{
		_isVisible = visible;
		if (!(_visibleGroup == null))
		{
			_visibleGroup.alpha = (visible ? 1f : 0f);
		}
	}

	private void PlayShowAnim()
	{
		if (!_isDieHiding)
		{
			if (_monsterDieBarEffectObj != null)
			{
				_monsterDieBarEffectObj.SetActive(value: false);
			}
			_animation?.GetSequence("MonsterBloodShow")?.Goto(0f).Play();
		}
	}

	public void PlayDieHide(Action callback)
	{
		if (_isDieHiding)
		{
			return;
		}
		_isDieHiding = true;
		RemoveEventListener();
		if (postureBarMultiGroup != null)
		{
			postureBarMultiGroup.UnInit();
		}
		if (!gameObject.activeInHierarchy)
		{
			HideUI();
			callback?.Invoke();
			return;
		}
		try
		{
			AnimationBuilder animationBuilder = _animation?.GetSequence("MonsterBloodHide");
			if (animationBuilder == null)
			{
				HideUI();
				callback?.Invoke();
				return;
			}
			animationBuilder.OnComplete((AnimationBuilder _) =>
			{
				HideUI();
				callback?.Invoke();
			}).Play();
		}
		catch (Exception arg)
		{
			Debug.LogWarning($"怪物血条hide播放失败: {arg}");
			HideUI();
			callback?.Invoke();
		}
	}

	private void HideUI()
	{
		Show = false;
		_isInView = false;
		_needShowAnim = false;
		SetViewVisible(visible: false);
		if (_monsterDieBarEffectObj != null)
		{
			_monsterDieBarEffectObj.SetActive(value: false);
		}
		gameObject.SetActive(value: false);
	}

	private void RefreshVisibleState()
	{
		if (!_entity.IsValid || !_entity.IsAlive() || _isDieHiding)
		{
			return;
		}
		bool flag = _show && _isInView;
		if (_isVisible != flag)
		{
			SetViewVisible(flag);
			if (flag && _needShowAnim)
			{
				_needShowAnim = false;
				PlayShowAnim();
			}
		}
	}

	public void Init(Entity initEntity, bool show, Vector3 vector3)
	{
		_entityUIInfo = new EntityUIInfo(initEntity);
		_entity = initEntity;
		_isDieHiding = false;
		_isInView = false;
		_needShowAnim = false;
		Show = false;
		if (vector3 != Vector3.zero)
		{
			transform.eulerAngles = vector3;
		}
		postureBarSingle.gameObject.SetActive(value: false);
		postureBarMultiGroup.gameObject.SetActive(value: false);
		_curPostureBar = ((_entityUIInfo.PostureType == PostureType.Multi) ? ((PostureBarBase)postureBarMultiGroup) : ((PostureBarBase)postureBarSingle));
		_curPostureBar.gameObject.SetActive(_entityUIInfo.InPosture);
		_curPostureBar.Init(_entityUIInfo, playInitAnimation: false);
		RefreshHp();
		level.SetText("{0:0}", _entityUIInfo.Level);
		SetViewVisible(visible: false);
		AddEventListener();
	}

	public void OnRelease(Action callback = null)
	{
		Show = false;
		_isDieHiding = false;
		_isInView = false;
		_needShowAnim = false;
		RemoveEventListener();
		if (postureBarMultiGroup != null)
		{
			postureBarMultiGroup.UnInit();
		}
		_animation?.StopAnimation();
		HideUI();
		_entity = default;
		callback?.Invoke();
	}

	public void UpdatePos()
	{
		if (!_entity.IsValid || (!_entity.IsActive() && !_isDieHiding) || (!_entity.IsAlive() && !_isDieHiding) || !transform)
		{
			if (!_isDieHiding)
			{
				HideUI();
			}
			return;
		}
		Transform rootTransform = _entity.GetRootTransform();
		Vector3 monsterUIPosOffset = _entity.GetConfig().MonsterUIPosOffset;
		monsterUIPosOffset.y += _entity.GetCompTransform().size.y;
		monsterUIPosOffset = rootTransform.TransformDirection(monsterUIPosOffset);
		Entity mainEntity = MonoECS.instance.mainEntity;
		Vector3 position = GameUtility.mainCamera.WorldToScreenPoint(rootTransform.position + monsterUIPosOffset);
		if (_isDieHiding)
		{
			position.z = transform.position.z;
			transform.position = GameUtility.uiCamera.ScreenToWorldPoint(position);
			return;
		}
		position.z = transform.position.z;
		transform.position = GameUtility.uiCamera.ScreenToWorldPoint(position);
		bool flag = mainEntity.IsValid && (_entity.GetCompTransform().physicsPosition - mainEntity.GetCompTransform().physicsPosition).sqrMagnitude <= 144f;
		bool flag2 = position.z > 0f && position.x >= 0f && position.x <= (float)Screen.width && position.y >= 0f && position.y <= (float)Screen.height;
		_isInView = flag & flag2;
		RefreshVisibleState();
	}

	public void AddEventListener()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.EntityHpChange, OnHpChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.EntityHitByCharacter, OnHitByCharacter);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.EntityEnterPosture, OnEnterPosture);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.EntityExitPosture, OnExitPosture);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.EntityPostureChange, OnPostureChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.EntityEnterWeak, OnEnterWeak);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.EntityExitWeak, OnExitWeak);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.EntityWeakChange, OnWeakChange);
	}

	public void RemoveEventListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.EntityHpChange, OnHpChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.EntityHitByCharacter, OnHitByCharacter);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.EntityEnterPosture, OnEnterPosture);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.EntityExitPosture, OnExitPosture);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.EntityPostureChange, OnPostureChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.EntityEnterWeak, OnEnterWeak);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.EntityExitWeak, OnExitWeak);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.EntityWeakChange, OnWeakChange);
	}

	private void OnHpChange(BaseEventContent eventContent)
	{
		if (!(eventContent is EntityHpChangeEvt entityHpChangeEvt) || _entityUIInfo == null || _isDieHiding)
		{
			return;
		}
		EntityId entityId = _entityUIInfo.entityId;
		if (entityHpChangeEvt.entityId != entityId || (entityHpChangeEvt.entityType != EntityType.Elite && entityHpChangeEvt.entityType != EntityType.Monster))
		{
			return;
		}
		bool flag = entityHpChangeEvt.oldHp > entityHpChangeEvt.curHp;
		if (_show || flag)
		{
			_entityUIInfo.UpdateHpVal(entityHpChangeEvt);
			if (!_show)
			{
				Show = true;
				_needShowAnim = true;
				RefreshVisibleState();
			}
			else if (gameObject.activeSelf)
			{
				PlayShowAnim();
			}
			RefreshHp();
		}
	}

	private void OnHitByCharacter(BaseEventContent eventContent)
	{
		if (eventContent is EntityHitByCharacterEvt entityHitByCharacterEvt && _entityUIInfo != null && !_isDieHiding && !(entityHitByCharacterEvt.entityId != _entityUIInfo.entityId) && !_show)
		{
			Show = true;
			_needShowAnim = true;
			RefreshVisibleState();
		}
	}

	private void RefreshHp()
	{
		bloodBar.TargetValue = (float)_entityUIInfo.CurHp / (float)_entityUIInfo.CurMaxHp;
		BloodEffect(_entityUIInfo.OldHp - _entityUIInfo.CurHp);
	}

	private void BloodEffect(float damage)
	{
		float num = Mathf.Abs(damage) / (float)_entityUIInfo.CurMaxHp;
		if (damage > 0f)
		{
			if (num < GameLoader.meta.monsterBarShakePercent)
			{
				_animation.GetSequence(lowHitAnimationName).Play();
			}
			else
			{
				_animation.GetSequence(highHitAnimationName).Play();
			}
			if (enableAttackPercentRefresh && num > attackPercentRefreshDelay)
			{
				bloodBar.IgnoreDelayOnce();
			}
		}
	}

	private void OnEnterPosture(BaseEventContent eventContent)
	{
		if (eventContent is EntityEnterPostureEvt entityEnterPostureEvt && !(entityEnterPostureEvt.entityId != _entityUIInfo.entityId))
		{
			_entityUIInfo.SetInPosture(inPosture: true);
			_curPostureBar.OnEnterPosture();
		}
	}

	private void OnExitPosture(BaseEventContent eventContent)
	{
		if (eventContent is EntityExitPostureEvt entityExitPostureEvt && !(entityExitPostureEvt.entityId != _entityUIInfo.entityId))
		{
			_entityUIInfo.SetInPosture(inPosture: false);
			_curPostureBar.OnExitPosture();
		}
	}

	private void OnPostureChange(BaseEventContent eventContent)
	{
		if (eventContent is EntityPostureChangeEvt entityPostureChangeEvt && !(entityPostureChangeEvt.entityId != _entityUIInfo.entityId))
		{
			_entityUIInfo.UpdatePostureVal(entityPostureChangeEvt);
			_curPostureBar.OnPostureValChange();
		}
	}

	private void OnEnterWeak(BaseEventContent eventContent)
	{
		if (eventContent is EntityEnterWeakEvt entityEnterWeakEvt && !(entityEnterWeakEvt.entityId != _entityUIInfo.entityId))
		{
			_entityUIInfo.UpdateWeakVal(entityEnterWeakEvt);
			_curPostureBar.OnEnterWeak();
		}
	}

	private void OnExitWeak(BaseEventContent eventContent)
	{
		if (eventContent is EntityExitWeakEvt entityExitWeakEvt && !(entityExitWeakEvt.entityId != _entityUIInfo.entityId))
		{
			_entityUIInfo.UpdateWeakVal(entityExitWeakEvt);
			_curPostureBar.OnExitWeak();
		}
	}

	private void OnWeakChange(BaseEventContent eventContent)
	{
		if (eventContent is EntityWeakChangeEvt entityWeakChangeEvt && !(entityWeakChangeEvt.entityId != _entityUIInfo.entityId))
		{
			_entityUIInfo.UpdateWeakVal(entityWeakChangeEvt);
			_curPostureBar.OnWeakChange();
		}
	}

	public void SetUIActive(bool active)
	{
		if (!_isDieHiding)
		{
			Show = active;
			if (!active)
			{
				_needShowAnim = false;
			}
			RefreshVisibleState();
		}
	}
}
