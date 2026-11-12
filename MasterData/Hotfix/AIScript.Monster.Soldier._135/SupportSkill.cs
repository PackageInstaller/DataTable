using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using Nova.Hotfix;
using TrueSync;

namespace AIScript.Monster.Soldier._135;

public class SupportSkill : SkillAdvancedBase
{
	private const string actionKey = "SupportSkill";

	private const string eventName_Summon = "GhostDoor";

	private const string areaEffectAlias = "Area_GhostDoor_Soldier";

	private static readonly TSVector2 summonOffset = new TSVector2(0, 3);

	private const int summonedChessId = 100008;

	private static readonly FP summonInterval = 1;

	private static readonly FP summonInitialDelay = 0.5;

	private static readonly Dictionary<int, int> partnerAtkBuffId_TODODic = new Dictionary<int, int>
	{
		[1] = 260112711,
		[2] = 260112721,
		[3] = 260112731
	};

	public HotfixEnum.ChessPartnerType partnerTypes = HotfixEnum.ChessPartnerType.QiLiMoFa;

	private LogicEntity _target;

	private int _partnerLv;

	private float _partnerParam1Ratio;

	private bool _isExtraCombo;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_target = null;
		_isExtraCombo = false;
		_partnerLv = 0;
		_partnerParam1Ratio = 0f;
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
		}
		else
		{
			_skill.Clear();
		}
	}

	private void OnInterrupt()
	{
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
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("SupportSkill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void BeginExtraCombo()
	{
		_isExtraCombo = true;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("SupportSkill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (!string.Equals(eventName, "GhostDoor") || !(ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController))
		{
			return;
		}
		TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Left * summonOffset.x + _actor.tsTransform.Forward * summonOffset.y;
		AreaEffectEntity areaEffect = ILRuntimeAPI.GetAreaEffect(ILRuntimeAPI.PlayAreaEffect(_actor, "Area_GhostDoor_Soldier", position, _actor.tsTransform.Rotation));
		if (areaEffect == null)
		{
			return;
		}
		bool isExtraCombo = _isExtraCombo;
		CoroutineNode cor = null;
		areaEffect.OnBeforeEnd = () =>
		{
			if (cor != null)
			{
				StopCoroutine(cor);
			}
		};
		cor = StartCoroutine(IntervalSummon(areaEffect, isExtraCombo));
	}

	private IEnumerator IntervalSummon(AreaEffectEntity area, bool isExtra)
	{
		if (summonInitialDelay > 0)
		{
			yield return _actor.WaitTime(summonInitialDelay);
		}
		while (area != null)
		{
			SpawnAtAreaCenter(area, isExtra);
			yield return _actor.WaitTime(summonInterval);
		}
	}

	private void SpawnAtAreaCenter(AreaEffectEntity area, bool isExtra)
	{
		if (ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController && !(area == null))
		{
			TSVector2 result = area.tsTransform.Position;
			if (!_actor.QueryPositionWalkable(result))
			{
				_actor.QueryClosestPositionWalkable(result, out result);
			}
			TSVector2 normalized = ((_target != null && !_target.IsDead()) ? (_target.tsTransform.Position - result) : _actor.tsTransform.Forward).normalized;
			SoldierActor soldierActor = soldierLevelController.SpawnSoldierSummon(_actor as SoldierActor, 100008, result, normalized.GetAngle());
			if (isExtra && TryGetPartnerAtkBuffId(out var buffId) && soldierActor != null && soldierActor.buffComponent != null)
			{
				soldierActor.buffComponent.AddBuff(buffId, _actor);
			}
		}
	}

	private bool TryGetPartnerAtkBuffId(out int buffId)
	{
		if (partnerAtkBuffId_TODODic.TryGetValue(_partnerLv, out buffId))
		{
			return buffId > 0;
		}
		return false;
	}
}
