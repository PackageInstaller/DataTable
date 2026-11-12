using System.Collections;
using System.Collections.Generic;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._72016KuiLeiJuNu;

public class Skill_Lifecycle_BaoZhaXianJing : SkillSimpleBase
{
	private const string combo_Boom = "Boom";

	private const string combo_BigBoom = "BigBoom";

	private FP detectInterval = 0.2f;

	private FP bigBoomRadius = 5;

	private FP detonateTimeout = 3f;

	private const string bigBoomAreaAlias = "Actor/Monster/72016RenOu_JuNu/Weapon/AreaEffect_72016RenOu_JuNu_BoomTrap_B";

	private FP _trapDuration = 8;

	private FP _trapRadius = 2;

	private bool _detonated;

	private bool _destroyed;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		SetInvincibleEnable(autoDisableWhenSkillDisable: false);
		SetSearchedImmunityEnable(autoDisableWhenSkillDisable: false);
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
		FP logicTagFpValue = GetLogicTagFpValue(_actor, "TrapDuration");
		if (logicTagFpValue > 0)
		{
			_trapDuration = logicTagFpValue;
		}
		FP logicTagFpValue2 = GetLogicTagFpValue(_actor, "TrapRadius");
		if (logicTagFpValue2 > 0)
		{
			_trapRadius = logicTagFpValue2;
		}
		_detonated = false;
		Debug.Log($"[陷阱] 生成 actorId={_actor.Id}, duration={_trapDuration}, radius={_trapRadius}");
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TRIGGER_BULLUT_HIT", OnBulletHit);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TRIGGER_BULLUT_HIT", OnBulletHit);
	}

	private void OnBulletHit(IEvent evt)
	{
		if (!_detonated && evt is AdventureBullutHitTrigger adventureBullutHitTrigger && !(adventureBullutHitTrigger.toActor != _actor))
		{
			StartCor(Detonate(isBigBoom: true));
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		for (FP elapsed = FP.Zero; elapsed < _trapDuration; elapsed += detectInterval)
		{
			if (_detonated)
			{
				break;
			}
			if (PlayerInTriggerRange())
			{
				yield return Detonate(isBigBoom: false);
				yield break;
			}
			yield return WaitTime(detectInterval);
		}
		if (!_detonated)
		{
			yield return Detonate(isBigBoom: false);
		}
	}

	private bool PlayerInTriggerRange()
	{
		List<LogicEntity> targetsByFaction = GetTargetsByFaction(isFriend: false);
		if (targetsByFaction == null || targetsByFaction.Count == 0)
		{
			return false;
		}
		TSVector2 position = GetPosition();
		FP trapRadius = _trapRadius;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, trapRadius);
		List<LogicEntity> targetsFromShape = GetTargetsFromShape(shapeData, targetsByFaction);
		if (targetsFromShape != null)
		{
			return targetsFromShape.Count > 0;
		}
		return false;
	}

	private IEnumerator Detonate(bool isBigBoom)
	{
		if (!_detonated)
		{
			_detonated = true;
			if (isBigBoom)
			{
				PlayAreaEffect("Actor/Monster/72016RenOu_JuNu/Weapon/AreaEffect_72016RenOu_JuNu_BoomTrap_B", GetPosition());
			}
			string actionKey = (isBigBoom ? "BigBoom" : "Boom");
			BeginAttack(1, actionKey, flushInputedKeys: true);
			StartCor(DestroyAfterTimeout());
			yield return WaitCombo(ComboAttackType.isComboFinish);
			DestroySelf();
		}
	}

	private IEnumerator DestroyAfterTimeout()
	{
		yield return WaitTime(detonateTimeout);
		if (!_destroyed)
		{
			DestroySelf();
		}
	}

	private void DestroySelf()
	{
		if (!_destroyed)
		{
			_destroyed = true;
			KillActors(new List<LogicEntity> { _actor });
		}
	}
}
