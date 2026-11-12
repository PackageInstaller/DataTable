using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._16001;

public class LinkSlotEntity : CustomHotFixEntityBase
{
	private readonly string TargetSlotName = "Slot";

	private readonly PlayFX _playFX = new PlayFX();

	private readonly PlayFX _playLinkFX = new PlayFX();

	private Transform _sourceSlot;

	private Transform _targetSlot;

	private CommomAreaHitConfig _commomAreaHitConfig_Check;

	private List<LogicEntity> _targetList;

	private string _fxKey;

	private string _linkFxKey;

	private CommomAreaHitConfig _commomAreaHitConfig_Hit;

	private FP _hitWidth;

	private int _buffId_Immunity;

	protected override void OnEntityEnable()
	{
		base.OnEntityEnable();
		InitData();
		if (!string.IsNullOrEmpty(_fxKey))
		{
			_playFX.Play(_actor, null, _fxKey, default, _actor.tsTransform.Position, default);
			_playFX.fxInstance.syncSlot = AnimationSlotConfigComponent.SlotType.Base;
			_playFX.fxInstance.Bind(_actor.gameObject, _entity.gameObject);
			_targetSlot = _playFX.fxInstance.transform.FindInChildren(TargetSlotName);
			if (_targetSlot != null && !string.IsNullOrEmpty(_linkFxKey))
			{
				_playLinkFX.PlayLinFx(_actor, _linkFxKey, 1f, useCustSource: true, _actor.gameObject, default, default, _targetSlot.gameObject, default, default);
				if (_playLinkFX.fxInstance is AdventureLinkFXPlayer adventureLinkFXPlayer)
				{
					_sourceSlot = _actor.slotConfig.GetSlotNode(adventureLinkFXPlayer.sourceSlot);
				}
			}
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
	}

	private void InitData()
	{
		_fxKey = null;
		_linkFxKey = null;
		if (_commomAreaHitConfig_Check == null)
		{
			_commomAreaHitConfig_Check = new CommomAreaHitConfig
			{
				hitFlags = HitBox.FeatureFlag.None,
				hitFeatureData = null,
				hurtAnimType = HitBox.HurtAnimType.None
			};
		}
		if (_actor.logicVariable.GetLogicTagToggle("IsLinkSlotEntity_P21"))
		{
			_fxKey = "fx_16001_base_Skill_Sup_Perk21_Slot";
			_linkFxKey = "fx_16001_loop_Skill_Sup_Spout_Perk21";
			_commomAreaHitConfig_Check.hitDamageId = 160521003;
			_commomAreaHitConfig_Hit = Config_Support.commomAreaHitConfig_P21;
			_hitWidth = Config_Support.hitWidth_P21;
			_buffId_Immunity = 16021012;
			_actor.logicVariable.ToggleLogicTag("IsLinkSlotEntity_P21", value: false);
		}
		else if (_actor.logicVariable.GetLogicTagToggle("IsLinkSlotEntity_P22"))
		{
			_fxKey = "fx_16001_base_Skill_Sup_Perk22_Slot";
			_linkFxKey = "fx_16001_loop_Skill_Sup_Spout_Perk22";
			_commomAreaHitConfig_Check.hitDamageId = 160521003;
			_commomAreaHitConfig_Hit = Config_Support.commomAreaHitConfig_P22;
			_hitWidth = Config_Support.hitWidth_P22;
			_buffId_Immunity = 16021012;
			_actor.logicVariable.ToggleLogicTag("IsLinkSlotEntity_P22", value: false);
		}
	}

	public void OnUpdate()
	{
		_entity.tsTransform.Position = _actor.tsTransform.Position;
		_entity.tsTransform.PositionY = _actor.tsTransform.PositionY;
		_entity.tsTransform.Rotation = _actor.tsTransform.Rotation;
		Hit();
	}

	private void Hit()
	{
		if (!(_sourceSlot == null) && !(_targetSlot == null))
		{
			TSVector2 tSVector = new TSVector2(_sourceSlot.position.x, _sourceSlot.position.z);
			TSVector2 tSVector2 = new TSVector2(_targetSlot.position.x, _targetSlot.position.z);
			TSVector2 tSVector3 = tSVector2 - tSVector;
			_commomAreaHitConfig_Check.position = tSVector + tSVector3 * 0.5f;
			_commomAreaHitConfig_Check.direction = tSVector3.normalized;
			ILRuntimeAPI.RectangleAreaHit(_actor, _commomAreaHitConfig_Check, _hitWidth, TSVector2.Distance(tSVector, tSVector2));
			List<LogicEntity> targetList = _targetList;
			if (targetList != null && targetList.Count > 0)
			{
				_commomAreaHitConfig_Hit.position = _commomAreaHitConfig_Check.position;
				_commomAreaHitConfig_Hit.direction = _commomAreaHitConfig_Check.direction;
				ILRuntimeAPI.HitActors(_actor, _targetList, _commomAreaHitConfig_Hit);
				_targetList.Clear();
			}
		}
	}

	private void OnReceiveAttack(IEvent evt)
	{
		if (evt is AdventureActorReceiveAttackEvent { to: MonsterAdventureActor to } adventureActorReceiveAttackEvent && adventureActorReceiveAttackEvent.from == _actor && _commomAreaHitConfig_Check != null && adventureActorReceiveAttackEvent.hitDamageId == _commomAreaHitConfig_Check.hitDamageId && !to.buffComponent.CheckBuffByBuffID(_buffId_Immunity))
		{
			if (_targetList == null)
			{
				_targetList = new List<LogicEntity>();
			}
			_targetList.Add(to);
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		if (evt is AdventureActorReceiveDamageEvent { to: MonsterAdventureActor to } adventureActorReceiveDamageEvent && adventureActorReceiveDamageEvent.from == _actor && _commomAreaHitConfig_Hit != null && adventureActorReceiveDamageEvent.hitDamageId == _commomAreaHitConfig_Hit.hitDamageId)
		{
			to.buffComponent.AddBuff(_buffId_Immunity, _actor);
		}
	}

	protected override void OnEntityDisable()
	{
		base.OnEntityDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		_playLinkFX.Stop();
		_playLinkFX.Clear();
		_playFX.Stop();
		_playFX.Clear();
		_targetList?.Clear();
		_sourceSlot = null;
		_targetSlot = null;
	}
}
