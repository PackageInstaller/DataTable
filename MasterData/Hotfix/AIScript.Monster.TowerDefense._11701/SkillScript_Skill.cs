using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._11701;

public class SkillScript_Skill : TowerCharacterSkillBase
{
	private const string _customEventName = "117_B1_Shoot";

	public static readonly int hitTag_Thunder = CommonHelper.StringToHash("117_B1_Skill_Hit");

	private readonly FP bulletDistance = 4;

	private readonly FP bulletPositionRamdomRadius = 1;

	private readonly string bulletAlias1 = "Bullet_11701_B1P02_Skill_Thunder_AoE_Lv1_1";

	private readonly string bulletAlias2 = "Bullet_11701_B1P02_Skill_Thunder_AoE_Lv1_2";

	private readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)1768322159,
		(ComboInputBuffer.ActionKey)1918131320,
		(ComboInputBuffer.ActionKey)1701275497
	};

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = false;
	}

	public void OnStart()
	{
		if (_skill != null)
		{
			ComboInputBuffer.ActionKey[] actionKeys = _actionKeys;
			Action<string> onCustomEvent = OnCustomEvent;
			Action onComboFinish = OnFinish;
			Action onInterrupt = OnInterrupt;
			BeginAttack(actionKeys, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
		}
	}

	private void OnCustomEvent(string eventName)
	{
		if (eventName.Equals("117_B1_Shoot"))
		{
			Shoot(GetBulletAlias());
		}
	}

	private string GetBulletAlias()
	{
		if (TSRandom.Range(0, 100) >= 50)
		{
			return bulletAlias2;
		}
		return bulletAlias1;
	}

	private void Shoot(string alias)
	{
		if (!string.IsNullOrEmpty(alias))
		{
			ILRuntimeAPI.Shoot(alias, _actor, default, _actor.tsTransform.Position, 1, GetShootPosition(), null, AimType.Position);
		}
	}

	private TSVector2 GetShootPosition()
	{
		if (_actor.aimLockedTarget == null)
		{
			TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Forward.normalized * bulletDistance;
			return ILRuntimeAPI.GetRandomPointInShape(_actor, CommonUtils.GetDeterministicCircleShape(bulletPositionRamdomRadius, 0, position), isReachable: false);
		}
		return _actor.aimLockedTarget.tsTransform.Position;
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		_skill.Clear();
	}

	public void OnUpdate()
	{
		LockDirection();
	}
}
