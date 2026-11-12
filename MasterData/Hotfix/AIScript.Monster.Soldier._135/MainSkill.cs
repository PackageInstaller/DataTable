using System;
using System.Collections.Generic;
using Nova.Hotfix;
using TrueSync;

namespace AIScript.Monster.Soldier._135;

public class MainSkill : SkillAdvancedBase
{
	private const string actionKey = "MainSkill";

	private const string eventName_Summon = "Fire";

	private const int summonedChessId = 100007;

	private const int summonPerCast = 2;

	private const int maxSummonLive = 6;

	private static readonly List<TSVector2> summonOffset = new List<TSVector2>
	{
		new TSVector2(1, 2),
		new TSVector2(-1, 2),
		new TSVector2(2, 1),
		new TSVector2(-2, 1),
		new TSVector2(2.5, 0),
		new TSVector2(-2.5, 0)
	};

	private const int perkLv_BroadcastMin = 2;

	private static readonly int broadcastEvt = CommonHelper.StringToHash("135_MainSkill_CasWhirlwind");

	private const int perkLv_ExpandCap = 3;

	private const int summonPerCast_P3 = 1;

	private const int maxSummonBonus_P3 = 4;

	private static readonly FP extendPerCastSec = 5;

	private static readonly int extendLifeEvt = CommonHelper.StringToHash("135_MainSkill_ExtendLife");

	private static readonly Dictionary<int, int> partnerDamageBuffId_TODODic = new Dictionary<int, int>
	{
		[1] = 260112711,
		[2] = 260112721,
		[3] = 260112731
	};

	public HotfixEnum.ChessPartnerType partnerTypes = HotfixEnum.ChessPartnerType.QiLiMoFa;

	private LogicEntity _target;

	private int _potentialLv;

	private int _partnerLv;

	private float _partnerParam1Ratio;

	private bool _isExtraCombo;

	private int _nextOffsetIdx;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_potentialLv = ((SoldierActor)_actor).GetPotentialLv();
		_target = null;
		_isExtraCombo = false;
		_partnerLv = 0;
		_partnerParam1Ratio = 0f;
		_nextOffsetIdx = 0;
		if (!(ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController))
		{
			return;
		}
		_partnerLv = soldierLevelController.GetPartnerLv(partnerTypes);
		if (_partnerLv > 0)
		{
			SoldierPartner soldierPartner = soldierLevelController.GetSoldierPartner(partnerTypes, _partnerLv);
			if (soldierPartner != null)
			{
				_partnerParam1Ratio = soldierPartner.Parameter1;
			}
		}
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_target = null;
		TryRemovePartnerDamageBuff();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	public void OnUpdate()
	{
	}

	private void OnFinish()
	{
		if (!_isExtraCombo && _partnerLv > 0)
		{
			BeginExtraCombo();
			return;
		}
		TryRemovePartnerDamageBuff();
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		TryRemovePartnerDamageBuff();
		_skill.Clear();
	}

	private void DoMainLogic()
	{
		_target = _actor.attackTarget;
		if (_target != null)
		{
			_actor.soldierAttackTarget = _target;
			_actor.AimAtTarget(_target);
		}
		if (_potentialLv >= 2)
		{
			BroadcastWhirlwindToExistingSummons();
		}
		if (_potentialLv >= 3)
		{
			BroadcastExtendLifeToExistingSummons(extendPerCastSec);
		}
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("MainSkill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (!string.Equals(eventName, "Fire") || !(ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController))
		{
			return;
		}
		int num = 2 + ((_potentialLv >= 3) ? 1 : 0);
		int num2 = 6 + ((_potentialLv >= 3) ? 4 : 0);
		int soldierSummonCount = soldierLevelController.GetSoldierSummonCount(_actor.Id, 100007);
		int val = (_isExtraCombo ? CeilMulRatio(num, _partnerParam1Ratio) : num);
		int val2 = Math.Max(0, num2 - soldierSummonCount);
		int num3 = Math.Min(val, val2);
		for (int i = 0; i < num3; i++)
		{
			TSVector2 tSVector = ((summonOffset.Count > 0) ? summonOffset.get_Item(_nextOffsetIdx % summonOffset.Count) : TSVector2.zero);
			_nextOffsetIdx++;
			TSVector2 result = _actor.tsTransform.Position + _actor.tsTransform.Left * tSVector.x + _actor.tsTransform.Forward * tSVector.y;
			if (!_actor.QueryPositionWalkable(result))
			{
				_actor.QueryClosestPositionWalkable(result, out result);
			}
			TSVector2 normalized = ((_target != null) ? (_target.tsTransform.Position - _actor.tsTransform.Position) : _actor.tsTransform.Forward).normalized;
			soldierLevelController.SpawnSoldierSummon(_actor as SoldierActor, 100007, result, normalized.GetAngle());
		}
	}

	private void BroadcastWhirlwindToExistingSummons()
	{
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.eventHashCode = broadcastEvt;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
	}

	private void BroadcastExtendLifeToExistingSummons(FP addSec)
	{
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.eventHashCode = extendLifeEvt;
		adventureActorCustomEvent.fpParam = addSec;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
	}

	private void BeginExtraCombo()
	{
		_isExtraCombo = true;
		if (TryGetPartnerDamageBuffId(out var buffId) && _actor.buffComponent != null)
		{
			_actor.buffComponent.AddBuff(buffId, _actor);
		}
		if (_potentialLv >= 2)
		{
			BroadcastWhirlwindToExistingSummons();
		}
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("MainSkill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void TryRemovePartnerDamageBuff()
	{
		if (TryGetPartnerDamageBuffId(out var buffId) && _actor != null && _actor.buffComponent != null)
		{
			_actor.buffComponent.RemoveBuffByBuffId(buffId);
		}
	}

	private bool TryGetPartnerDamageBuffId(out int buffId)
	{
		if (partnerDamageBuffId_TODODic.TryGetValue(_partnerLv, out buffId))
		{
			return buffId > 0;
		}
		return false;
	}

	private static int CeilMulRatio(int count, float ratio)
	{
		if (count <= 0 || ratio <= 0f)
		{
			return 0;
		}
		return (int)Math.Round((double)count * (double)ratio);
	}
}
