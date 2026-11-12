using System;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13201;

public class SkillScript_Skill_Support : SkillAdvancedBase
{
	private const string actionTag = "132_Support_Skill";

	private const int perkId_23 = 513223;

	private const string eventName_Shoot_P23 = "132_P23_Shoot";

	private const string bulletPath_P23 = "Bullet_132_Support_P23";

	private readonly TSVector shootOffset_P23 = new TSVector(0, 0, 0);

	private const int perkId_28 = 513228;

	private const string eventName_Shoot_P28 = "132_P28_Shoot";

	private readonly List<string> bulletPathList_P28 = new List<string> { "Bullet_132_Support_P28_1", "Bullet_132_Support_P28_2", "Bullet_132_Support_P28_3", "Bullet_132_Support_P28_4" };

	private readonly FP searchRadius_P28 = 8;

	private readonly TSVector shootOffset_P28 = new TSVector(0, 0, 0);

	private List<LogicEntity> _targets_P28;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		DefaultLookAt();
	}

	public void OnStart()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("132_Support_Skill", flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513223, out var perkLevel) && string.Equals(eventName, "132_P23_Shoot"))
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as PlayerAdventureActor;
			if (playerAdventureActor != null)
			{
				TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Left * shootOffset_P23.x + _actor.tsTransform.Forward * shootOffset_P23.z;
				ILRuntimeAPI.Shoot("Bullet_132_Support_P23", _actor, default, position, shootOffset_P23.y, playerAdventureActor.tsTransform.Position, playerAdventureActor, AimType.Target, BulletDirectionType.BulletToTarget);
			}
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513228, out perkLevel) && string.Equals(eventName, "132_P28_Shoot") && _actor.attackTarget != null)
		{
			ILRuntimeAPI.SearchByRangeAndPosition(_actor, _actor.attackTarget.tsTransform.Position, searchRadius_P28, OnSearchTargetFinish_P28, isConfront: true);
		}
	}

	private void OnFinish()
	{
		_skill?.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	private void OnSearchTargetFinish_P28(List<LogicEntity> targets)
	{
		if (targets == null || targets.Count <= 0 || bulletPathList_P28.Count <= 0)
		{
			return;
		}
		if (_targets_P28 == null)
		{
			_targets_P28 = new List<LogicEntity>(10);
		}
		else
		{
			_targets_P28.Clear();
		}
		bool flag = false;
		if (_actor.attackTarget != null)
		{
			for (int i = 0; i < targets.Count; i++)
			{
				if (targets.get_Item(i).Id == _actor.attackTarget.Id)
				{
					_targets_P28.Add(targets.get_Item(i));
					flag = true;
					break;
				}
			}
			for (int j = 0; j < targets.Count; j++)
			{
				if (targets.get_Item(j).Id != _actor.attackTarget.Id)
				{
					_targets_P28.Add(targets.get_Item(j));
				}
			}
		}
		else
		{
			_targets_P28.AddRange(targets);
		}
		int num = 0;
		int num2 = 0;
		bool flag2 = false;
		while (true)
		{
			LogicEntity logicEntity = _targets_P28.get_Item(num2) ?? _targets_P28.get_Item(0);
			ILRuntimeAPI.Shoot((_targets_P28.Count > 1) ? bulletPathList_P28.get_Item(TSRandom.Range(0, bulletPathList_P28.Count)) : bulletPathList_P28.get_Item(num), position: _actor.tsTransform.Position + _actor.tsTransform.Left * shootOffset_P28.x + _actor.tsTransform.Forward * shootOffset_P28.z, actor: _actor, range: default, positionY: shootOffset_P28.y, targetPosition: logicEntity.tsTransform.Position, target: logicEntity, aimType: AimType.Target, bulletDirectionType: BulletDirectionType.BulletToTarget);
			num++;
			if (num >= bulletPathList_P28.Count)
			{
				break;
			}
			if (flag2)
			{
				if (flag)
				{
					num2 = 0;
					continue;
				}
				num2++;
				num2 = ((num2 < _targets_P28.Count) ? num2 : 0);
				continue;
			}
			num2++;
			if (num2 >= _targets_P28.Count)
			{
				flag2 = true;
				num2 = 0;
			}
		}
	}
}
