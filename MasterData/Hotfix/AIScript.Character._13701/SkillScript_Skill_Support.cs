#define LOG_DEBUG
using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13701;

public class SkillScript_Skill_Support : SkillAdvancedBase
{
	public static readonly FP JumpStopDistance = 0.1;

	private int _loopTimes;

	private int _jumpAtkExplodeCount;

	private readonly List<MonsterAdventureActor> _tmpDroneList = new List<MonsterAdventureActor>();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_loopTimes = 0;
		_jumpAtkExplodeCount = 0;
		_actor.logicVariable.SetLogicTagValue("JumpAtkOnceStack_513722", 0);
	}

	public void OnStart()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Skill_Sup", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string evt)
	{
		FP value;
		if (evt == "137SkillSupJumpAtk")
		{
			_actor.logicVariable.SetLogicTagValue("JumpAtkSessionStart", _actor.LogicTime);
			PlayJumpAtkAreaEffect(_actor.tsTransform.Position);
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513721, out var _))
			{
				_actor.logicVariable.SetLogicTagValue("JumpAtkJumpIndex", _loopTimes);
				_actor.logicVariable.SetLogicTagValue("JumpAtkExplodeIndex", _jumpAtkExplodeCount - 1);
				_actor.logicVariable.SetLogicTagTSVector2Value("JumpAtkAnchor", _actor.tsTransform.Position);
				_actor.logicVariable.SetLogicTagTSVector2Value("JumpAtkForward", _actor.tsTransform.Forward);
			}
			_loopTimes++;
			if (_loopTimes % 3 == 0)
			{
				SpawnDrone();
			}
		}
		else if (Config_Support.JumpMoveDurationMap.TryGetValue(evt, out value))
		{
			JumpTowardMainTarget(value);
		}
	}

	private void JumpTowardMainTarget(FP moveTime)
	{
		AdventureActor adventureActor = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true) as AdventureActor;
		TSVector2 tSVector;
		if (adventureActor != null)
		{
			TSVector2 position = adventureActor.tsTransform.Position;
			TSVector2 normalized = (_actor.tsTransform.Position - position).normalized;
			FP fP = adventureActor.GetRadius() + Config_Support.ExtraRadiusForJumpAtk;
			DeterministicShape shape = new DeterministicShape
			{
				shapeType = DeterministicShape.ShapeType.Fan,
				position = position,
				rotation = normalized.GetAngle(),
				innerRadius = fP,
				radius = fP,
				angle = 120
			};
			tSVector = _actor.RandomActorReachablePointInsideShape(shape);
			if (tSVector == position)
			{
				tSVector = position + normalized * fP;
			}
		}
		else
		{
			tSVector = _actor.RandomActorReachablePointInsideRing(_actor.tsTransform.Position, 0, Config_Support.DroneSpawnRadius);
		}
		_actor.LookAt(tSVector, 0);
		FP fP2 = TSVector2.Distance(tSVector, _actor.tsTransform.Position);
		FP fP3 = ((moveTime > FP.Zero) ? moveTime : FP.One);
		if (fP2 > FP.Zero)
		{
			_actor.ToJump(tSVector, fP2 / fP3, fP3, null, comboWithAttack: true, forbiddenHeight: true);
		}
	}

	private int GetTeamSupportCount()
	{
		int num = 0;
		List<AdventureActor> allPlayerActors = ILRuntimeAPI.GetAllPlayerActors(_actor);
		for (int i = 0; i < allPlayerActors.Count; i++)
		{
			if (allPlayerActors.get_Item(i) is PlayerAdventureActor playerAdventureActor && playerAdventureActor.actorInfo.jobClass == HotfixEnum.characterJobClass.Support)
			{
				num++;
			}
		}
		return num;
	}

	private void PlayJumpAtkAreaEffect(TSVector2 position)
	{
		int stackCount = 0;
		int explodeIndex = _jumpAtkExplodeCount;
		_jumpAtkExplodeCount++;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513722, out var perkLevel))
		{
			int num = _actor.logicVariable.GetLogicTagValue("JumpAtkOnceStack_513722").AsInt() + 1;
			_actor.logicVariable.SetLogicTagValue("JumpAtkOnceStack_513722", num);
			stackCount = ((num > 9) ? 9 : num);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513723, out perkLevel))
		{
			_actor.buffComponent.AddBuff(13723011, _actor);
		}
		int supportCount = GetTeamSupportCount();
		ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_137_SkillSup_JumpAtk_Boom", position, default, (AreaEffectEntity entity) =>
		{
			if (stackCount > 0)
			{
				if (supportCount == 1)
				{
					entity.AddAdditionalAttr(13722011, stackCount);
				}
				entity.AddAdditionalAttr(13722021);
			}
		}, null, (AreaEffectEntity entity) =>
		{
			if (explodeIndex > 0 && supportCount == 1 && CommonUtils.HavePersonalPerk(_actor.dataID, 513722, out var _))
			{
				FP scriptValue = CommonUtils.GetScriptValue(_actor, 13721011);
				FP scaleMulti = 1 + scriptValue * explodeIndex / 100;
				entity.ModifyScale(scaleMulti);
			}
		});
	}

	private void SpawnDrone()
	{
		TSVector2 targetPosition = _actor.RandomActorReachablePointInsideRing(_actor.tsTransform.Position, 0, Config_Support.DroneSpawnRadius);
		AdventureBulletBase adventureBulletBase = ILRuntimeAPI.Shoot("Bullet_137_UAV_BirthFly", _actor, default, _actor.tsTransform.Position, _actor.dtCollider.HeightCenter, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget);
		if (adventureBulletBase == null)
		{
			NovaLogger.Debug("13701 Support: UAV birth bullet shoot failed, skip summon.");
		}
		else
		{
			adventureBulletBase.ModifyBulletTag("137_UAVBirthFly");
		}
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
		_loopTimes = 0;
		_jumpAtkExplodeCount = 0;
		_actor.logicVariable.SetLogicTagValue("JumpAtkOnceStack_513722", 0);
	}
}
