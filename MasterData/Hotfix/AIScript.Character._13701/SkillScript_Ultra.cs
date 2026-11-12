using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13701;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private int _bulletIndex;

	private int _areaIndex;

	private PlayTimeline _playTimeline;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.EnableInvincible();
		_actor.EnableSuperArmor();
		_actor.EnableImmuneControl();
		_actor.EnableCloseBlock();
	}

	public void OnStart()
	{
		if (_playTimeline == null)
		{
			_playTimeline = new PlayTimeline();
		}
		_playTimeline.Play(_actor, OnPlayTimeLineFinish, OnNotPlayTimeLine);
	}

	private TSVector2 LookAtTarget()
	{
		TSVector2 tSVector = _actor.tsTransform.Position + _actor.tsTransform.Forward * Config.NoTargetDistance;
		if (_actor is PlayerAdventureActor { isAssist: not false })
		{
			_actor.attackTarget = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true);
		}
		AdventureActor actor = _actor;
		if ((object)actor.attackTarget == null)
		{
			LogicEntity logicEntity = (actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: true));
		}
		if (_actor.attackTarget != null)
		{
			tSVector = _actor.attackTarget.tsTransform.Position;
			_actor.LookAt(tSVector, Config.UltraAtkLookAtDuration);
		}
		return tSVector;
	}

	private void OnCustomEvent(string evt)
	{
		if (evt.Equals("Ultra_Atk_Left"))
		{
			OnShootBullet(isLeft: true);
		}
		else if (evt.Equals("Ultra_Atk_Right"))
		{
			OnShootBullet(isLeft: false);
		}
	}

	private void OnShootBullet(bool isLeft)
	{
		string bulletAlias;
		if (isLeft)
		{
			_bulletIndex = TSRandom.Range(0, Config.LeftUltraAtkBullet.Length);
			bulletAlias = Config.LeftUltraAtkBullet[_bulletIndex];
		}
		else
		{
			_bulletIndex = TSRandom.Range(0, Config.RightUltraAtkBullet.Length);
			bulletAlias = Config.RightUltraAtkBullet[_bulletIndex];
		}
		TSVector2 tSVector = LookAtTarget();
		_ = _actor.dtCollider.HeightCenter;
		FP value = TSRandom.Range(FP.Zero, 360) * TSMath.Deg2Rad;
		FP fP = TSMath.Sqrt(TSRandom.Range(FP.Zero, FP.One)) * Config.UltraAtkRandomRadius;
		TSVector2 targetPosition = tSVector;
		targetPosition += new TSVector2(fP * TSMath.Cos(value), fP * TSMath.Sin(value));
		TSVector2 v = (isLeft ? Config.LeftBulletOffset : Config.RightBulletOffset);
		FP positionY = (isLeft ? Config.LeftBulletHeight : Config.RightBulletHeight);
		v = TSVector2.Rotate(v, _actor.tsTransform.Forward.GetAngle());
		v += _actor.tsTransform.Position;
		ILRuntimeAPI.Shoot(bulletAlias, _actor, default, v, positionY, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget);
	}

	private void OnPlayTimeLineFinish()
	{
		LookAtTarget();
		string actionTag = "Ultra_TL";
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnNotPlayTimeLine()
	{
		LookAtTarget();
		string actionTag = "Ultra_NoTL";
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.DisableInvincible();
		_actor.DisableSuperArmor();
		_actor.DisableImmuneControl();
		_actor.DisableCloseBlock();
		_bulletIndex = 0;
		_areaIndex = 0;
	}
}
