using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._10001;

public class MainSkill : SkillAdvancedBase
{
	private const string actionKey = "Skill";

	private const string fireEvent = "Fire";

	private const string bulletPath = "Bullet_Skill_1";

	private const string bulletPath_big = "Bullet_Skill_2";

	private static readonly FP bulletHeight = 0.8;

	private static readonly FP bulletRange = 10;

	private static readonly TSVector2 bulletFireOffset = new TSVector2(0, 2);

	private int PotentialLv = 1;

	private readonly List<LogicEntity> _searchBuffer = new List<LogicEntity>();

	private readonly List<AdventureActor> _candidates = new List<AdventureActor>();

	private readonly List<int> _tierIndices = new List<int>();

	private readonly List<AdventureActor> _skillTargets = new List<AdventureActor>();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		PotentialLv = (_actor as SoldierActor).GetPotentialLv();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.CancelAiming();
		_skillTargets.Clear();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		_skill.Clear();
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
	}

	private void DoMainLogic()
	{
		int count = ((PotentialLv < 3) ? 1 : 2);
		FindHighestHpTargets(count, _skillTargets);
		if (_skillTargets.Count > 0)
		{
			AdventureActor adventureActor = _skillTargets.get_Item(0);
			_actor.attackTarget = adventureActor;
			_actor.soldierAttackTarget = adventureActor;
			_actor.AimAtTarget(adventureActor);
		}
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Skill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string evt)
	{
		if (!evt.Equals("Fire"))
		{
			return;
		}
		string bullet = ((PotentialLv >= 2) ? "Bullet_Skill_2" : "Bullet_Skill_1");
		if (_skillTargets.Count > 0)
		{
			for (int i = 0; i < _skillTargets.Count; i++)
			{
				ShootBullet(bullet, _skillTargets.get_Item(i));
			}
		}
		else
		{
			ShootBullet(bullet, null);
		}
	}

	private void FindHighestHpTargets(int count, List<AdventureActor> result)
	{
		result.Clear();
		if (count <= 0 || !(_actor is SoldierActor))
		{
			return;
		}
		CommonUtils.SearchNearTargetsByCircle(_actor, _actor.actorSearchTargetInfo.monsterSearchRange, isConfront: true, includeSelf: false, _searchBuffer);
		_candidates.Clear();
		for (int i = 0; i < _searchBuffer.Count; i++)
		{
			if (_searchBuffer.get_Item(i) is AdventureActor { actorHealthInfo: { isAlive: not false } } adventureActor && !adventureActor.IsSearchedImmunity() && !(adventureActor is SoldierActor { isSupport: not false }))
			{
				_candidates.Add(adventureActor);
			}
		}
		while (result.Count < count && _candidates.Count > 0)
		{
			int num = -1;
			for (int j = 0; j < _candidates.Count; j++)
			{
				int num2 = (int)(long)(_candidates.get_Item(j).actorHealthInfo.hpPercentage * 100);
				if (num2 > num)
				{
					num = num2;
				}
			}
			_tierIndices.Clear();
			for (int k = 0; k < _candidates.Count; k++)
			{
				if ((int)(long)(_candidates.get_Item(k).actorHealthInfo.hpPercentage * 100) == num)
				{
					_tierIndices.Add(k);
				}
			}
			int num3 = count - result.Count;
			if (_tierIndices.Count <= num3)
			{
				for (int l = 0; l < _tierIndices.Count; l++)
				{
					result.Add(_candidates.get_Item(_tierIndices.get_Item(l)));
				}
			}
			else
			{
				for (int m = 0; m < num3; m++)
				{
					int index = TSRandom.Range(0, _tierIndices.Count);
					result.Add(_candidates.get_Item(_tierIndices.get_Item(index)));
					_tierIndices.RemoveAt(index);
				}
			}
			for (int num4 = _candidates.Count - 1; num4 >= 0; num4--)
			{
				if ((int)(long)(_candidates.get_Item(num4).actorHealthInfo.hpPercentage * 100) == num)
				{
					_candidates.RemoveAt(num4);
				}
			}
		}
	}

	private void ShootBullet(string bullet, LogicEntity target)
	{
		TSVector2 position = _actor.tsTransform.TransformLocalPointToWorldSpace(bulletFireOffset);
		if (target != null && !target.IsDead())
		{
			ILRuntimeAPI.Shoot(bullet, _actor, 0, position, bulletHeight, default, target, AimType.Target, BulletDirectionType.BulletToTarget);
		}
		else
		{
			ILRuntimeAPI.ShootByDirection(bullet, _actor, bulletRange, _actor.tsTransform.Forward, position, bulletHeight);
		}
	}
}
