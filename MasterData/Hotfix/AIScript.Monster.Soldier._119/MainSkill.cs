#define LOG_WARNING
using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._119;

public class MainSkill : SkillAdvancedBase
{
	private const string comboTag = "MainSkill";

	private const string eventName_Shoot = "119_Soldier_MainSkill_Shoot";

	public const string boomerangKey = "Bullet_Soldier_119_MainSkill";

	public const string boomerangTagPrefix = "119_MainBoomerang_";

	private static readonly TSVector2 shootOffset = new TSVector2(0, 0);

	private static readonly FP fallbackRange = 10;

	public static readonly int buffId_Trigger = 250105201;

	private int _potentialLv;

	private bool _castLatched;

	private static readonly FP shootDirEpsilonSqr = (FP)1 / (FP)100;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_potentialLv = ((SoldierActor)_actor).GetPotentialLv();
		_castLatched = false;
	}

	public void OnStart()
	{
		TryAcquireTarget();
		Action onAnticipationEnd = OnAnticipationEnd;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("MainSkill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnAnticipationEnd()
	{
		if (!_castLatched)
		{
			_castLatched = true;
			TryAddTriggerBuff();
		}
	}

	private void TryAddTriggerBuff()
	{
		if (_potentialLv >= 3 && buffId_Trigger > 0 && !_actor.IsDead())
		{
			_actor.buffComponent?.AddBuff(buffId_Trigger, _actor);
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "119_Soldier_MainSkill_Shoot"))
		{
			ShootBoomerang();
		}
	}

	private void ShootBoomerang()
	{
		TryAcquireTarget();
		LockDirection();
		TSVector2 tSVector = _actor.tsTransform.Position + _actor.tsTransform.Left * shootOffset.x + _actor.tsTransform.Forward * shootOffset.y;
		LogicEntity attackTarget = _actor.attackTarget;
		TSVector2 tSVector2 = ((attackTarget != null && !attackTarget.IsDead()) ? attackTarget.tsTransform.Position : (tSVector + _actor.tsTransform.Forward.normalized * fallbackRange)) - tSVector;
		TSVector2 dirction = ((tSVector2.LengthSquared() > shootDirEpsilonSqr) ? tSVector2.normalized : _actor.tsTransform.Forward.normalized);
		AdventureBoomerang adventureBoomerang = ILRuntimeAPI.Shoot("Bullet_Soldier_119_MainSkill", _actor, tSVector, dirction) as AdventureBoomerang;
		if (adventureBoomerang == null)
		{
			NovaLogger.Warning("[119] 回旋镖发射失败，检查别名 Bullet_Soldier_119_MainSkill 是否配在 RelateResource 里、且预制体上挂了 AdventureBoomerang 组件");
		}
		else
		{
			adventureBoomerang.customTag = "119_MainBoomerang_1";
		}
	}

	private void TryAcquireTarget()
	{
		if (!(_actor.attackTarget != null))
		{
			LogicEntity logicEntity = ((SoldierActor)_actor).FindNearestConfrontTarget();
			if (logicEntity != null)
			{
				_actor.attackTarget = logicEntity;
			}
		}
	}
}
