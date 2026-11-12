using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11701;

public class Parallel_B2 : Parallel_old
{
	private static readonly int _skillAttackTag = CommonHelper.StringToHash("117_B2_Hit");

	private static readonly int _targetTag = CommonHelper.StringToHash("LightTag1");

	private const int _extraHitDamageId = 117000001;

	private const string _extraHitFxPath = "fx_13201_light_mark_harm";

	private readonly FP _extraHitDamageInterval = 0.35f;

	private const int _addBuffId_1 = 11732001;

	private const int _addBuffId_2 = 11732002;

	private const int _hitDamageId_normal = 117320201;

	private const string _hitFxPath = "fx_11701_bullet_atk_1";

	private const int _hitDamageId_normal_for_secend = 117320202;

	private const string _hitFxPath_for_secend = "fx_13201_light_mark_harm";

	private readonly FP _doubleHitInterval = 0.5;

	private readonly FP _linkHitInterval = 0.35;

	private readonly FP _linkCheckRange_normal = 4;

	private const int _maxLinkTime = 5;

	private readonly FP _addSkillSectionCooldown_lv1 = 10f;

	private readonly FP _addSkillSectionCooldown_lv2 = 10f;

	private readonly FP _addSkillSectionCooldown_lv3 = 10f;

	private readonly FP _addSkillSectionCooldown_lv4 = 10f;

	private readonly FP _addSkillSectionCooldown_lv5 = 10f;

	private const int _hitDamageId_for_level1 = 117321201;

	private const int _hitDamageId_for_level2 = 117321202;

	private const int _hitDamageId_for_level3 = 117321203;

	private const int _hitDamageId_for_level4 = 117321204;

	private const int _hitDamageId_second_for_level1 = 117321205;

	private const int _hitDamageId_second_for_level2 = 117321206;

	private const int _hitDamageId_second_for_level3 = 117321207;

	private const int _hitDamageId_second_for_level4 = 117321208;

	private const int personalPerkId_4 = 511704;

	private readonly Dictionary<int, int> cooldownDict_perk_4 = new Dictionary<int, int>
	{
		[1] = 5,
		[2] = 4,
		[3] = 3,
		[4] = 2,
		[5] = 1
	};

	private const int additionalAttrId_perk_4 = 11755411;

	private const int personalPerkId_5 = 511705;

	private readonly Dictionary<int, FP> skillCDReduceDict_perk_5 = new Dictionary<int, FP>
	{
		[1] = 1,
		[2] = 1.5,
		[3] = 2,
		[4] = 2.5,
		[5] = 3
	};

	private const int personalPerkId_6 = 511706;

	private readonly Dictionary<int, int> buffIdDict_perk_6 = new Dictionary<int, int>
	{
		[1] = 11755611,
		[2] = 11755621,
		[3] = 11755631,
		[4] = 11755641,
		[5] = 11755651
	};

	private int _hitDamageId;

	private int _hitDamageId_for_secend;

	private FP _linkCheckRange;

	private int _linkTimes;

	private CoroutineNode _waitForDoubleHitCoroutine;

	private CoroutineNode _waitForLinkHitCoroutine;

	private readonly List<LogicEntity> _ridList = new List<LogicEntity>();

	private bool _extraHit;

	private FP _addSkillSectionCooldown;

	private FP _addSkillSectionCooldownTime;

	private FP lastPerk4TakeEffectTime;

	public override void OnEnable()
	{
		base.OnEnable();
		lastPerk4TakeEffectTime = -_actor.LogicTime;
		_hitDamageId = 117320201;
		_hitDamageId_for_secend = 117320202;
		_linkCheckRange = _linkCheckRange_normal;
		_addSkillSectionCooldown = _addSkillSectionCooldown_lv1;
		if (((PlayerAdventureActor)_actor).GetTalentGroupType() == PlayerTalentGroupType.Group34 || ((PlayerAdventureActor)_actor).GetTalentGroupType() == PlayerTalentGroupType.Group13)
		{
			switch (((PlayerAdventureActor)_actor).GetTalentGroupLevel())
			{
			case 1:
				_addSkillSectionCooldown = _addSkillSectionCooldown_lv1;
				break;
			case 2:
				_addSkillSectionCooldown = _addSkillSectionCooldown_lv2;
				break;
			case 3:
				_addSkillSectionCooldown = _addSkillSectionCooldown_lv3;
				break;
			case 4:
				_addSkillSectionCooldown = _addSkillSectionCooldown_lv4;
				break;
			case 5:
				_addSkillSectionCooldown = _addSkillSectionCooldown_lv5;
				break;
			}
		}
		_addSkillSectionCooldownTime = _actor.LogicTime - _addSkillSectionCooldown;
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 511705, out var perkLevel))
		{
			(_actor as PlayerAdventureActor).playerSkillCd.ModifyResumeTimeAbs(-skillCDReduceDict_perk_5.get_Item(perkLevel), ActionKey.B);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
	}

	protected override void OnBeforeHit(IEvent evt)
	{
		base.OnBeforeHit(evt);
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (!(adventureActorReceiveDamageBeforeHitEvent.from != _actor) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, _skillAttackTag) && (adventureActorReceiveDamageBeforeHitEvent.to as AdventureActor).CheckTag(_targetTag) && ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 511704, out var perkLevel) && _actor.LogicTime - lastPerk4TakeEffectTime >= cooldownDict_perk_4.get_Item(perkLevel))
		{
			lastPerk4TakeEffectTime = _actor.LogicTime;
			AdventureActor.AddFromAttr(11755411, _actor);
		}
	}

	protected override void OnDamage(IEvent evt)
	{
		base.OnDamage(evt);
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (adventureActorReceiveDamageEvent.from != _actor || !CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, _skillAttackTag))
		{
			return;
		}
		AdventureActor adventureActor = adventureActorReceiveDamageEvent.to as AdventureActor;
		if (adventureActor.CheckTag(_targetTag))
		{
			_actor.StartLogicCoroutine(ExtraHit(adventureActor));
			if ((((PlayerAdventureActor)_actor).GetTalentGroupType() == PlayerTalentGroupType.Group3 || ((PlayerAdventureActor)_actor).GetTalentGroupType() == PlayerTalentGroupType.Group34 || ((PlayerAdventureActor)_actor).GetTalentGroupType() == PlayerTalentGroupType.Group13 || ((PlayerAdventureActor)_actor).GetTalentGroupType() == PlayerTalentGroupType.Group23) && _actor.LogicTime > _addSkillSectionCooldownTime + _addSkillSectionCooldown)
			{
				if (!_actor.logicVariable.GetLogicTagToggle("beginLightning"))
				{
					_addSkillSectionCooldownTime = _actor.LogicTime;
				}
				(_actor as PlayerAdventureActor).playerSkillCd.AddSkillSection(ActionKey.B);
			}
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 511706, out var perkLevel))
			{
				_actor.buffComponent?.AddBuff(buffIdDict_perk_6.get_Item(perkLevel), _actor);
			}
		}
		_actor.buffComponent?.AddBuff(11732001, _actor);
		_actor.buffComponent?.AddBuff(11732002, _actor);
	}

	private IEnumerator ExtraHit(AdventureActor target)
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_extraHitDamageInterval));
		if (target != null && target.actorHealthInfo.isAlive)
		{
			ILRuntimeAPI.HitActor(_actor, target, 117000001, null, "fx_13201_light_mark_harm", attackFxPlayOnTarget: true);
		}
	}

	public void OnUpdate()
	{
		if (!_actor.logicVariable.GetLogicTagToggle("beginLightning") || _actor.aimLockedTarget == null)
		{
			return;
		}
		if (!CommonUtils.CheckElementMark(CommonDefine.Light, _actor.aimLockedTarget as AdventureActor))
		{
			_actor.logicVariable.ToggleLogicTag("beginLightning", value: false);
			_addSkillSectionCooldownTime = _actor.LogicTime;
		}
		else
		{
			if (_extraHit)
			{
				return;
			}
			_actor.logicVariable.ToggleLogicTag("beginLightning", value: false);
			_extraHit = true;
			if (((PlayerAdventureActor)_actor).GetTalentGroupType() == PlayerTalentGroupType.Group12)
			{
				switch ((int)(long)_actor.logicVariable.GetLogicTagValue("skillUseCount"))
				{
				case 0:
					_hitDamageId = 117321201;
					_hitDamageId_for_secend = 117321205;
					break;
				case 1:
					_hitDamageId = 117321202;
					_hitDamageId_for_secend = 117321206;
					break;
				case 2:
					_hitDamageId = 117321203;
					_hitDamageId_for_secend = 117321207;
					break;
				case 3:
					_hitDamageId = 117321204;
					_hitDamageId_for_secend = 117321208;
					break;
				}
			}
			ExtraHit(_actor.aimLockedTarget, firstCheck: true);
		}
	}

	private void ExtraHit(LogicEntity target, bool firstCheck = false)
	{
		if (_linkTimes >= 5)
		{
			ClearExtraHit();
			return;
		}
		if (firstCheck)
		{
			_ridList.Add(_actor);
		}
		_ridList.Add(target);
		ILRuntimeAPI.SearchByRange(target as AdventureActor, _linkCheckRange, (List<LogicEntity> result) =>
		{
			if (result.Count > 0)
			{
				for (int i = 0; i < _ridList.Count; i++)
				{
					if (result.Contains(_ridList.get_Item(i)))
					{
						result.Remove(_ridList.get_Item(i));
					}
				}
			}
			if (result.Count == 0)
			{
				if (firstCheck)
				{
					_waitForDoubleHitCoroutine = _actor.StartLogicCoroutine(WaitForDoubleHit());
				}
				else
				{
					ClearExtraHit();
				}
			}
			else
			{
				LogicEntity logicEntity = result.get_Item(0);
				_actor.hitBox.hurtEffectSource = target.gameObject;
				ILRuntimeAPI.HitActor(_actor, logicEntity as AdventureActor, _hitDamageId, null, "fx_11701_bullet_atk_1", attackFxPlayOnTarget: true);
				_actor.hitBox.hurtEffectSource = null;
				_linkTimes++;
				_waitForLinkHitCoroutine = _actor.StartLogicCoroutine(WaitForLinkHit(logicEntity));
			}
		});
	}

	private IEnumerator WaitForDoubleHit()
	{
		AdventureActor target = _actor.aimLockedTarget as AdventureActor;
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_doubleHitInterval));
		if (target != null && target.actorHealthInfo.isAlive)
		{
			ILRuntimeAPI.HitActor(_actor, target, _hitDamageId_for_secend, null, "fx_13201_light_mark_harm", attackFxPlayOnTarget: true);
		}
		ClearExtraHit();
	}

	private IEnumerator WaitForLinkHit(LogicEntity target)
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_linkHitInterval));
		ExtraHit(target);
	}

	private void ClearExtraHit()
	{
		if (_waitForDoubleHitCoroutine != null)
		{
			_actor.StopLogicCoroutine(_waitForDoubleHitCoroutine);
			_waitForDoubleHitCoroutine = null;
		}
		if (_waitForLinkHitCoroutine != null)
		{
			_actor.StopLogicCoroutine(_waitForLinkHitCoroutine);
			_waitForLinkHitCoroutine = null;
		}
		_ridList.Clear();
		_linkTimes = 0;
		_extraHit = false;
		_addSkillSectionCooldownTime = _actor.LogicTime;
	}
}
