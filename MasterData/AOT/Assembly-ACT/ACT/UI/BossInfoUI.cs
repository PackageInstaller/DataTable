using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Utility;
using Bamboo.ECS;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;
using UnityEngine.Serialization;

namespace ACT.UI;

public class BossInfoUI : UIBehaviour
{
	[SerializeReference]
	private BossBloodBar bloodBar;

	[FormerlySerializedAs("_bossPostureBarSingle")]
	[FormerlySerializedAs("postureBarSingle")]
	[SerializeField]
	private PostureBarSingle _postureBarSingle;

	[SerializeField]
	private PostureBarMultiGroup postureBarMultiGroup;

	[SerializeField]
	private MonoBossBuffList _bossBuffList;

	[SerializeReference]
	private LocalizeStringEvent bossNameLocalize;

	[SerializeReference]
	private TextMeshProUGUI levelText;

	[SerializeReference]
	private GameObject postureBreak;

	[SerializeReference]
	private BetterAnimation animation;

	private readonly BossInfoRuntimeState _runtimeState = new BossInfoRuntimeState();

	private EntityUIInfo _entityUIInfo;

	private bool _eventListenerAdded;

	private PostureBarBase _curPostureBar;

	private EntityBuffIconData _curBuffIconData;

	private ImageAssetStation _station;

	public bool CanHandle(AddBossHatredEvt evt)
	{
		return _runtimeState.CanHandle(evt);
	}

	public void ApplyBossInfo(AddBossHatredEvt evt, ImageAssetStation station)
	{
		_station = station;
		if (_runtimeState.IsInitialized)
		{
			if (_runtimeState.CanHandle(evt) && _runtimeState.IsSharedGroup)
			{
				ApplySharedGroupRefresh(evt);
			}
			return;
		}
		Entity entity = GameManager.entities.GetEntity(evt.entityId);
		if (entity.IsValid && _runtimeState.Initialize(evt, entity))
		{
			AddEventListener();
			EntityUIInfo entityUIInfo = new EntityUIInfo(evt, entity.GetConfig());
			bloodBar.ApplySnapshot(_runtimeState.CreateBloodBarSnapshot(entityUIInfo.InWeak), animateHpChange: false);
			BindFocusPresentation(entity, entityUIInfo);
			if (evt.inBurst)
			{
				animation.GetSequence("BurstEnter").Play();
			}
			animation.GetSequence("Show").Play();
		}
	}

	protected override void OnDestroy()
	{
		RemoveEventListener();
		base.OnDestroy();
	}

	private void ApplySharedGroupRefresh(AddBossHatredEvt evt)
	{
		bool flag = _runtimeState.TryAddSharedGroupMember(evt.entityId);
		_runtimeState.SetCharacterDamageType(evt.damageType);
		bloodBar.SetCharacterDamageType(evt.damageType);
		if (_entityUIInfo == null || _entityUIInfo.entityId != evt.entityId)
		{
			RefreshFocusFromHatred(evt);
		}
		else
		{
			_entityUIInfo.SetDamageType(evt.damageType);
		}
		if (flag)
		{
			bloodBar.ApplySnapshot(_runtimeState.CreateBloodBarSnapshot(_entityUIInfo != null && _entityUIInfo.InWeak), animateHpChange: false);
		}
	}

	private void OnSharedGroupMemberReady(BaseEventContent eventContent)
	{
		if (eventContent is BossInfoMemberReadyEvt bossInfoMemberReadyEvt && _runtimeState.IsInitialized && _runtimeState.TryAddSharedGroupMember(bossInfoMemberReadyEvt.entityId))
		{
			bloodBar.ApplySnapshot(_runtimeState.CreateBloodBarSnapshot(_entityUIInfo != null && _entityUIInfo.InWeak), animateHpChange: false);
		}
	}

	private void RefreshFocusFromHatred(AddBossHatredEvt evt)
	{
		Entity entity = GameManager.entities.GetEntity(evt.entityId);
		if (entity.IsValid)
		{
			ApplyFocusPresentation(entity, new EntityUIInfo(evt, entity.GetConfig()));
		}
	}

	private void RefreshFocusFromEntity(EntityId entityId)
	{
		Entity entity = GameManager.entities.GetEntity(entityId);
		if (entity.IsValid)
		{
			EntityUIInfo entityUIInfo = new EntityUIInfo(entity);
			if (entity.TryGetCompAbility(out CompAbility component))
			{
				entityUIInfo.SetInBurst(component.IsPostureBurst);
			}
			ApplyFocusPresentation(entity, entityUIInfo);
		}
	}

	private void ApplyFocusPresentation(Entity focusEntity, EntityUIInfo entityUIInfo)
	{
		if (_entityUIInfo == null || !(_entityUIInfo.entityId == focusEntity.Id))
		{
			bool num = _entityUIInfo != null && _entityUIInfo.InBurst;
			BindFocusPresentation(focusEntity, entityUIInfo);
			if (num != _entityUIInfo.InBurst)
			{
				animation.GetSequence(_entityUIInfo.InBurst ? "BurstEnter" : "BurstHide")?.Play();
			}
		}
	}

	private void BindFocusPresentation(Entity focusEntity, EntityUIInfo entityUIInfo)
	{
		_runtimeState.SetFocus(focusEntity.Id);
		_entityUIInfo = entityUIInfo;
		_entityUIInfo.SetDamageType(_runtimeState.CharacterDamageType);
		SetPostureBarInit();
		_curBuffIconData = new EntityBuffIconData(focusEntity);
		_bossBuffList.Init(_station, _curBuffIconData);
		levelText.text = _entityUIInfo.Level.FastToString();
		RefreshBossName(focusEntity.Id);
	}

	private void SetPostureBarInit()
	{
		PostureType postureType = _entityUIInfo.PostureType;
		postureBarMultiGroup.UnInit();
		PostureBarBase curPostureBar = ((postureType != PostureType.Multi) ? ((PostureBarBase)_postureBarSingle) : ((PostureBarBase)postureBarMultiGroup));
		_curPostureBar = curPostureBar;
		_curPostureBar.Init(_entityUIInfo);
		switch (postureType)
		{
		case PostureType.Long:
		case PostureType.Medium:
			_postureBarSingle.gameObject.SetActive(!_entityUIInfo.InWeak);
			postureBarMultiGroup.gameObject.SetActive(value: false);
			break;
		case PostureType.Multi:
			_postureBarSingle.gameObject.SetActive(value: false);
			postureBarMultiGroup.gameObject.SetActive(!_entityUIInfo.InWeak || _entityUIInfo.CurPosture > 0);
			break;
		}
	}

	public void OnBossRemoveHatred()
	{
		RemoveEventListener();
		_entityUIInfo = null;
		_runtimeState.Clear();
		_station = null;
		_bossBuffList.UnInit();
		_curBuffIconData = null;
		bloodBar.OnBossRemoveHatred();
		animation.GetSequence("Hide").OnComplete((AnimationBuilder builder) =>
		{
			Object.Destroy(gameObject);
		}).Play();
	}

	public void AddEventListener()
	{
		if (!_eventListenerAdded)
		{
			_eventListenerAdded = true;
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.BossInfo_MemberReady, OnSharedGroupMemberReady);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.EntityHpChange, OnBossHpChange);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.EntityEnterPosture, OnEnterPosture);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.EntityExitPosture, OnExitPosture);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.EntityPostureChange, OnPostureChange);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.EntityEnterWeak, OnEnterWeak);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.EntityExitWeak, OnExitWeak);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.EntityWeakChange, OnWeakChange);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.EntityEnterBurst, OnEnterBurst);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.EntityExitBurst, OnExitBurst);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.EntityBurstChange, OnBurstChange);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.BattleCharacterChange, OnCharacterChange);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.EntityHitByCharacter, OnHitByCharacter);
		}
	}

	public void RemoveEventListener()
	{
		if (_eventListenerAdded)
		{
			_eventListenerAdded = false;
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BossInfo_MemberReady, OnSharedGroupMemberReady);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.EntityHpChange, OnBossHpChange);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.EntityEnterPosture, OnEnterPosture);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.EntityExitPosture, OnExitPosture);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.EntityPostureChange, OnPostureChange);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.EntityEnterWeak, OnEnterWeak);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.EntityExitWeak, OnExitWeak);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.EntityWeakChange, OnWeakChange);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.EntityEnterBurst, OnEnterBurst);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.EntityExitBurst, OnExitBurst);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.EntityBurstChange, OnBurstChange);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BattleCharacterChange, OnCharacterChange);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.EntityHitByCharacter, OnHitByCharacter);
		}
	}

	private void OnBossHpChange(BaseEventContent eventContent)
	{
		if (!(eventContent is EntityHpChangeEvt entityHpChangeEvt) || !_runtimeState.TryApplyHpChange(entityHpChangeEvt))
		{
			return;
		}
		if (!_runtimeState.IsSharedGroup)
		{
			if (_entityUIInfo == null || entityHpChangeEvt.entityId != _entityUIInfo.entityId)
			{
				return;
			}
			_entityUIInfo.UpdateHpVal(entityHpChangeEvt);
		}
		bloodBar.ApplySnapshot(_runtimeState.CreateBloodBarSnapshot(_entityUIInfo != null && _entityUIInfo.InWeak), animateHpChange: true);
	}

	private void OnEnterPosture(BaseEventContent eventContent)
	{
		if (eventContent is EntityEnterPostureEvt entityEnterPostureEvt && _entityUIInfo != null && !(_curPostureBar == null) && !(entityEnterPostureEvt.entityId != _entityUIInfo.entityId))
		{
			_entityUIInfo.SetInPosture(inPosture: true);
			_curPostureBar.OnEnterPosture();
		}
	}

	private void OnExitPosture(BaseEventContent eventContent)
	{
		if (eventContent is EntityExitPostureEvt entityExitPostureEvt && _entityUIInfo != null && !(_curPostureBar == null) && !(entityExitPostureEvt.entityId != _entityUIInfo.entityId))
		{
			_entityUIInfo.SetInPosture(inPosture: false);
			_curPostureBar.OnExitPosture();
		}
	}

	private void OnPostureChange(BaseEventContent eventContent)
	{
		if (eventContent is EntityPostureChangeEvt entityPostureChangeEvt && _entityUIInfo != null && !(_curPostureBar == null) && !(entityPostureChangeEvt.entityId != _entityUIInfo.entityId))
		{
			_entityUIInfo.UpdatePostureVal(entityPostureChangeEvt);
			_curPostureBar.OnPostureValChange();
		}
	}

	private void OnEnterWeak(BaseEventContent eventContent)
	{
		if (eventContent is EntityEnterWeakEvt entityEnterWeakEvt && _entityUIInfo != null && !(_curPostureBar == null) && !(entityEnterWeakEvt.entityId != _entityUIInfo.entityId))
		{
			_entityUIInfo.UpdateWeakVal(entityEnterWeakEvt);
			_curPostureBar.OnEnterWeak();
		}
	}

	private void OnExitWeak(BaseEventContent eventContent)
	{
		if (eventContent is EntityExitWeakEvt entityExitWeakEvt && _entityUIInfo != null && !(_curPostureBar == null) && !(entityExitWeakEvt.entityId != _entityUIInfo.entityId))
		{
			_entityUIInfo.UpdateWeakVal(entityExitWeakEvt);
			_curPostureBar.OnExitWeak();
		}
	}

	private void OnWeakChange(BaseEventContent eventContent)
	{
		if (eventContent is EntityWeakChangeEvt entityWeakChangeEvt && _entityUIInfo != null && !(_curPostureBar == null) && !(entityWeakChangeEvt.entityId != _entityUIInfo.entityId))
		{
			_entityUIInfo.UpdateWeakVal(entityWeakChangeEvt);
			_curPostureBar.OnWeakChange();
		}
	}

	private void OnEnterBurst(BaseEventContent eventContent)
	{
		if (eventContent is EntityEnterBurstEvt entityEnterBurstEvt && _entityUIInfo != null && !(entityEnterBurstEvt.entityId != _entityUIInfo.entityId))
		{
			_entityUIInfo.SetInBurst(inBurst: true);
			animation.GetSequence("BurstEnter").Play();
		}
	}

	private void OnExitBurst(BaseEventContent eventContent)
	{
		if (eventContent is EntityExitBurstEvt entityExitBurstEvt && _entityUIInfo != null && !(entityExitBurstEvt.entityId != _entityUIInfo.entityId))
		{
			_entityUIInfo.SetInBurst(inBurst: false);
			animation.GetSequence("BurstHide").Play();
		}
	}

	private void OnBurstChange(BaseEventContent eventContent)
	{
		if (eventContent is EntityBurstChangeEvt entityBurstChangeEvt && _entityUIInfo != null && !(entityBurstChangeEvt.entityId != _entityUIInfo.entityId))
		{
			_entityUIInfo.UpdateBurstVal(entityBurstChangeEvt);
		}
	}

	private void OnCharacterChange(BaseEventContent eventContent)
	{
		if (eventContent is BattleCharacterChangeEvt)
		{
			bloodBar.IgnoreDelayOnce();
		}
	}

	private void OnHitByCharacter(BaseEventContent eventContent)
	{
		if (!(eventContent is EntityHitByCharacterEvt entityHitByCharacterEvt) || !_runtimeState.ContainsMember(entityHitByCharacterEvt.entityId))
		{
			return;
		}
		_runtimeState.SetCharacterDamageType(entityHitByCharacterEvt.characterDamageType);
		if (_runtimeState.IsSharedGroup)
		{
			if (_entityUIInfo == null || _entityUIInfo.entityId != entityHitByCharacterEvt.entityId)
			{
				RefreshFocusFromEntity(entityHitByCharacterEvt.entityId);
			}
		}
		else if (_entityUIInfo == null || entityHitByCharacterEvt.entityId != _entityUIInfo.entityId)
		{
			return;
		}
		if (_entityUIInfo != null && _entityUIInfo.entityId == entityHitByCharacterEvt.entityId)
		{
			_entityUIInfo.SetDamageType(entityHitByCharacterEvt.characterDamageType);
		}
		bloodBar.SetCharacterDamageType(entityHitByCharacterEvt.characterDamageType);
	}

	private void RefreshBossName(EntityId entityId)
	{
		Entity entity = GameManager.entities.GetEntity(entityId);
		int num = ((entity.IsValid && entity.TryGetCompMonster(out CompMonster component)) ? component.id : (_runtimeState.TryGetMonsterId(entityId, out var monsterId) ? monsterId : 0));
		if (num > 0)
		{
			EntityData data = CoreUtils.GetData(num, RuntimeConfigs.data.entityDatas);
			bossNameLocalize.SetReference(LocalizeTable.ShortCommon, data.nameLocal);
		}
	}
}
