#define LOG_WARNING
using System;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster.Soldier._119;

public class SupportSkill : SkillAdvancedBase
{
	private const string comboTag = "Support";

	private const string eventName_Place = "119_Soldier_Support_Shoot";

	private const string dartsLauncherKey = "Bullet_Soldier_119_Support";

	private const string areaEffectKey = "AreaEffect_Soldier_119_Support_Flower";

	private static readonly FP ringInnerRadius = 1;

	private static readonly FP ringOuterRadius = 3;

	private static readonly FP forwardDistance = 4;

	private bool _partnerRolled;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_partnerRolled = false;
	}

	public void OnStart()
	{
		if (_actor.attackTarget == null)
		{
			LogicEntity logicEntity = ((SoldierActor)_actor).soldierAI?.FindNearestConfrontTarget();
			if (logicEntity != null)
			{
				_actor.attackTarget = logicEntity;
				_actor.soldierAttackTarget = logicEntity;
			}
		}
		Action onAnticipationEnd = OnAnticipationEnd;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Support", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnAnticipationEnd()
	{
		if (!_partnerRolled)
		{
			_partnerRolled = true;
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
		if (string.Equals(eventName, "119_Soldier_Support_Shoot") && TryPickPlacePosition(out var position))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_Soldier_119_Support_Flower", position);
			PlaceDartsLauncher(position);
		}
	}

	private bool TryPickPlacePosition(out TSVector2 position)
	{
		LogicEntity attackTarget = _actor.attackTarget;
		if (attackTarget != null && !attackTarget.IsDead())
		{
			position = TrueSyncExtensions.RandomPointInsideRing(attackTarget.tsTransform.Position, ringInnerRadius, ringOuterRadius);
			return true;
		}
		SoldierActor soldierActor = (SoldierActor)_actor;
		SoldierActor soldierActor2 = soldierActor;
		if (soldierActor.isSupport && soldierActor.onStageType == HotfixEnum.ChessAssistOnStageType.NotAppearing)
		{
			SoldierActor soldierActor3 = (ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController)?.GetMainControlActor(soldierActor.isEnemyCamp);
			if (soldierActor3 == null)
			{
				position = default;
				return false;
			}
			soldierActor2 = soldierActor3;
		}
		position = soldierActor2.tsTransform.Position + soldierActor2.tsTransform.Forward.normalized * forwardDistance;
		return true;
	}

	private void PlaceDartsLauncher(TSVector2 position)
	{
		GameObject gameObject = _actor.comboGroup?.relatedResourceConfig?.GetFXByAlias("Bullet_Soldier_119_Support");
		if (gameObject == null)
		{
			NovaLogger.Warning("[119] 飞镖发射器别名 Bullet_Soldier_119_Support 不在 RelateResource 的 FX 组里，本次未放置");
			return;
		}
		FP terrainHeight = CommonHelper.GetTerrainHeight(position, _actor.tsTransform.PositionY);
		Vector3 spawnPosition = new Vector3((float)position.x, (float)terrainHeight, (float)position.y);
		if (SceneSingleton<SpecialEntityManager>.Instance.PlaySpecialProcess(_actor, gameObject, spawnPosition, Quaternion.identity) == null)
		{
			NovaLogger.Warning("[119] 预制体 Bullet_Soldier_119_Support 上没有 ScatteringDartsEntity 组件，飞镖未发射且已泄漏一个池对象");
		}
	}
}
