using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50081DaShiLaiMu;

public class Skill_Burst : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] actionKeys_dodge = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.F };

	private readonly ComboInputBuffer.ActionKey[] actionKeys_around = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.G };

	private readonly ComboInputBuffer.ActionKey[] actionKeys_summon = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.H };

	private readonly ComboInputBuffer.ActionKey[] actionKeys_burst = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.H,
		ComboInputBuffer.ActionKey.A
	};

	private readonly ComboInputBuffer.ActionKey[] actionKeys_weak = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.H,
		ComboInputBuffer.ActionKey.B
	};

	private readonly TSVector2 centerPoint = TSVector2.zero;

	private readonly FP rotateSpeed = 180;

	private readonly FP dodgeDuration = 1;

	private readonly FP aroundDuration = 10;

	private readonly FP summonDuration = 10;

	private readonly int summonMonsterId = 11;

	private readonly string monsterBulletAlias = "";

	private readonly string monsterBulletTag = "monsterBulletTag";

	private readonly List<AreaEffectInfo> burstAreaEffects = new List<AreaEffectInfo>
	{
		new AreaEffectInfo("areaEffect1", 2),
		new AreaEffectInfo("areaEffect2", 2),
		new AreaEffectInfo("areaEffect3", 2)
	};

	private readonly FP weakDuration = 5;

	private bool _gotoCenterFinish;

	private Dodge _dodge;

	private bool _dodgeFinish;

	private int bulletCount;

	protected override void OnSkillEnable()
	{
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
	}

	protected override void OnSkillDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		_gotoCenterFinish = false;
		_dodge?.Interrupte();
		_dodgeFinish = false;
		bulletCount = 0;
	}

	protected override IEnumerator DoMainLogic()
	{
		_actor.EnableImmuneControl();
		Skill_Burst skill_Burst = this;
		TSVector2 targetPos = centerPoint;
		FP fP = rotateSpeed;
		yield return skill_Burst.BeginLookAtByPos(targetPos, default, fP);
		BeginAttack(1, actionKeys_dodge, flushInputedKeys: true);
		if (_dodge == null)
		{
			_dodge = new Dodge();
		}
		TSVector2 normalized = (centerPoint - _actor.tsTransform.Position).normalized;
		FP distance = ILRuntimeAPI.CalcDistanceBetweenActorAndPosition(_actor, centerPoint, calcDistanceWithoutEntityRadius: true);
		_dodge.Begin(_actor, normalized, dodgeDuration, distance, () =>
		{
			_dodgeFinish = true;
		}, comboWithAttack: true);
		yield return _actor.StartLogicCoroutine(waitDodgeFinish());
		CancelAttack();
		_actor.tsTransform.Forward = new TSVector2(0, -1);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginAttack(2, actionKeys_around, flushInputedKeys: true);
		yield return WaitTime(aroundDuration);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginAttack(3, actionKeys_summon, flushInputedKeys: true);
		SetBattleOutEnable();
		yield return WaitTime(summonDuration);
		bool burst = false;
		List<LogicEntity> list = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntitiesByDataID(summonMonsterId);
		if (list != null && list.Count > 0)
		{
			burst = true;
			bulletCount = 0;
			foreach (LogicEntity item in list)
			{
				(item as AdventureActor).DestroySelf();
				Skill_Burst skill_Burst2 = this;
				string bulletAlias = monsterBulletAlias;
				TSVector2 position = item.tsTransform.Position;
				FP positionY = item.tsTransform.PositionY;
				FP range = 0;
				TSVector2 targetPosition = centerPoint;
				if (skill_Burst2.Shoot(bulletAlias, position, positionY, range, default, AimType.Position, BulletDirectionType.BulletToTarget, targetPosition) != 0L)
				{
					bulletCount++;
				}
			}
			yield return _actor.StartLogicCoroutine(waitBulletFinish());
		}
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SetBattleOutDisable();
		if (burst)
		{
			BeginAttack(4, actionKeys_burst, flushInputedKeys: true);
			foreach (AreaEffectInfo burstAreaEffect in burstAreaEffects)
			{
				PlayAreaEffect(burstAreaEffect.areaEffectAlias, _actor.tsTransform.Position, _actor.tsTransform.Rotation);
				yield return WaitTime(burstAreaEffect.interval);
			}
		}
		else
		{
			BeginAttack(4, actionKeys_weak, flushInputedKeys: true);
			yield return WaitTime(weakDuration);
			CancelAttack();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		_actor.DisableImmuneControl();
	}

	private IEnumerator waitDodgeFinish()
	{
		while (!_dodgeFinish)
		{
			yield return null;
		}
	}

	private IEnumerator waitBulletFinish()
	{
		while (bulletCount > 0)
		{
			yield return null;
		}
	}

	private void OnBulletFinish(IEvent iEvent)
	{
		if ((iEvent as AdventureBulletFinishEvent).tag.Equals(monsterBulletTag))
		{
			bulletCount--;
		}
	}
}
