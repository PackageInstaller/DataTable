using System;
using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14501;

public class SkillScript_MainControl : SkillAdvancedBase
{
	private string key_1 = "Skill_Mian_Move";

	private string key_2 = "Skill_Mian_Shot";

	private string bullet_Base = "Bullet_145_SkillMain_Shot";

	private string bullet_P3 = "Bullet_145_SkillMain_Shot_P3";

	private TSVector shootOffset = new TSVector(0, 1.5, 1);

	private FP rotateOffset = 75;

	private string evt_Shoot = "Shot";

	private string evt_P2 = "P2HuDun";

	private string evt_P10 = "P10WuDi";

	private const int perkId_2 = 514502;

	private int shield_2 = 14502001;

	private string areadEffect_2 = "AreaEffect_145_P2_TakeBack";

	private const int perkId_3 = 514503;

	private const int perkId_4 = 514504;

	private const int perkId_10 = 514510;

	private int buff_10_Invincible = 14510011;

	private CoroutineNode corMain;

	private ActorSearchTarget actorSearchInfo;

	private int shootEvent = CommonHelper.StringToHash("shootEvent");

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		actorSearchInfo = _actor.GetLogicComponent<ActorSearchTarget>();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corMain);
		_actor.buffComponent.RemoveBuffByBuffId(buff_10_Invincible);
	}

	public void OnStart()
	{
		StartCoroutine(ref corMain, DoMainLogic());
	}

	private void SkillFinish()
	{
		_skill?.Clear();
	}

	private void SkillInterrupt()
	{
		_skill?.Clear();
	}

	private IEnumerator DoMainLogic()
	{
		TSVector2 tSVector = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
		if (tSVector == TSVector2.zero)
		{
			List<LogicEntity> hearRangeSearch = ILRuntimeAPI.GetHearRangeSearch(_actor);
			if (hearRangeSearch.Count != 0)
			{
				TSVector2 left = _actor.tsTransform.Left;
				if (PartitionPointsByLine(hearRangeSearch, _actor.tsTransform.Position, left, out var leftSide, out var rightSide))
				{
					bool flag = leftSide.Count >= rightSide.Count;
					tSVector = TSVector2.Rotate(_actor.tsTransform.Forward, flag ? (-rotateOffset) : rotateOffset);
				}
			}
		}
		tSVector = ((tSVector == TSVector2.zero) ? _actor.tsTransform.Forward : tSVector);
		_actor.LookAtDir(tSVector, 0f);
		SkillScript_MainControl skillScript_MainControl = this;
		string actionTag = key_1;
		Action<string> action = onCustomEvent;
		RequestComboAttack req = skillScript_MainControl.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, null, action);
		while (!req.isRecoveryBegin)
		{
			yield return null;
		}
		SkillScript_MainControl skillScript_MainControl2 = this;
		string actionTag2 = key_2;
		LogicEntity attackTarget = _actor.attackTarget;
		action = onCustomEvent;
		System.Action onComboFinish = SkillFinish;
		System.Action onInterrupt = SkillInterrupt;
		skillScript_MainControl2.BeginAttack(actionTag2, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: true, attackTarget, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	private void onCustomEvent(string evt)
	{
		if (evt.Equals(evt_P2))
		{
			if (GetPerk(514502))
			{
				_actor.actorShield.AddShield(shield_2, _actor);
				ILRuntimeAPI.PlayAreaEffect(_actor, areadEffect_2, _actor.tsTransform.Position);
			}
		}
		else if (evt.Equals(evt_P10))
		{
			if (GetPerk(514510))
			{
				_actor.buffComponent.AddBuff(buff_10_Invincible, _actor);
			}
		}
		else if (evt.Equals(evt_Shoot))
		{
			TSVector2 tSVector = _actor.tsTransform.TransformLocalPointToWorldSpace(new TSVector2(shootOffset.x, shootOffset.z));
			TSVector2 position = new TSVector2(tSVector.x, tSVector.y);
			FP y = shootOffset.y;
			string bulletAlias = (GetPerk(514503) ? bullet_P3 : bullet_Base);
			if (_actor.attackTarget != null)
			{
				AdventureActor actor = _actor;
				LogicEntity attackTarget = _actor.attackTarget;
				ILRuntimeAPI.Shoot(bulletAlias, actor, default, position, y, default, attackTarget, AimType.Target, BulletDirectionType.BulletToTarget);
			}
			else
			{
				ILRuntimeAPI.Shoot(bulletAlias, _actor, default, position, y, default, null, AimType.Default, BulletDirectionType.ActorToBullet, null);
			}
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.eventHashCode = shootEvent;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
	}

	public bool PartitionPointsByLine(List<LogicEntity> entities, TSVector2 orginPos, TSVector2 normal, out List<TSVector2> leftSide, out List<TSVector2> rightSide)
	{
		leftSide = new List<TSVector2>();
		rightSide = new List<TSVector2>();
		foreach (LogicEntity entity in entities)
		{
			FP fP = TSVector2.Dot(entity.tsTransform.Position - orginPos, normal);
			if (fP > 0)
			{
				leftSide.Add(entity.tsTransform.Position);
			}
			else if (fP < 0)
			{
				rightSide.Add(entity.tsTransform.Position);
			}
		}
		if (leftSide.Count == 0 && rightSide.Count == 0)
		{
			return leftSide.Count == rightSide.Count;
		}
		return true;
	}
}
