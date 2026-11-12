#define LOG_DEBUG
using System;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._12301;

public class SkillScript_Zhiyuan_Skill : SkillAdvancedBase
{
	private readonly string SkillTag = "B2_Skill";

	private string evt_Fenq = "123WindWallShoot";

	private const string areaEffect_Default = "AreaEffect_123_B2_WindWall";

	private const string areaEffect_Wave_Default = "AreaEffect_123_B2_WindWall_Wave_Buff";

	private readonly FP searchRange = 15;

	private int buff_default = 12393015;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("_12301 SkillScript_Zhiyuan_Skill OnDisable");
		base.OnSkillDisable();
		_actor.CancelAiming();
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("_12301 SkillScript_Zhiyuan_Skill OnEnable");
		base.OnSkillEnable();
	}

	public void aimDirec()
	{
		PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance?.ActivedPlayerActor;
		if (playerAdventureActor != null && playerAdventureActor.attackTarget != null)
		{
			_actor.AimAtTarget(playerAdventureActor.attackTarget);
			return;
		}
		LogicEntity targetNearByRange = ILRuntimeAPI.GetTargetNearByRange(_actor, searchRange);
		if (targetNearByRange != null)
		{
			_actor.AimAtTarget(targetNearByRange);
		}
	}

	public void OnStart()
	{
		NovaLogger.Debug("===================_12301 SkillScript_Zhiyuan_Skill OnStart");
		aimDirec();
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i).buffComponent.AddBuff(buff_default, _actor);
		}
		string skillTag = SkillTag;
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onInterrupt = OnInterrupt;
		System.Action onComboFinish = OnFinish;
		BeginAttack(skillTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private string GetWindEffectName()
	{
		return "AreaEffect_123_B2_WindWall_Wave_Buff";
	}

	protected void OnCustomEvent(string evt)
	{
		NovaLogger.Debug("_12301 SkillScript_Zhiyuan_Skill OnCustomEvent: " + evt);
		if (!string.Equals(evt, evt_Fenq))
		{
			return;
		}
		FP angle = TSVector2.Rotate(_actor.tsTransform.Forward, 45).GetAngle();
		long num;
		long num2;
		if (GetPerk(Parallel.personalPerkId_21))
		{
			num = ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_123_B2_WindWall", _actor.tsTransform.Position, angle, ParseAreaEffect);
			num2 = ILRuntimeAPI.PlayAreaEffect(_actor, GetWindEffectName(), _actor.tsTransform.Position, angle);
			if (num != 0L && num2 != 0L)
			{
				Parallel.dicAreaBind_1.Add(num, num2);
			}
			if (GetPerk(Parallel.personalPerkId_23))
			{
				long num3 = ILRuntimeAPI.PlayAreaEffect(_actor, Parallel.areaEffect_p23, _actor.tsTransform.Position, angle);
				if (num != 0L && num3 != 0L)
				{
					Parallel.dicAreaBind_2.Add(num, num3);
				}
			}
			angle = TSVector2.Rotate(_actor.tsTransform.Forward, -45).GetAngle();
			num = ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_123_B2_WindWall", _actor.tsTransform.Position, angle, ParseAreaEffect);
			num2 = ILRuntimeAPI.PlayAreaEffect(_actor, GetWindEffectName(), _actor.tsTransform.Position, angle);
			if (num != 0L && num2 != 0L)
			{
				Parallel.dicAreaBind_1.Add(num, num2);
			}
			if (GetPerk(Parallel.personalPerkId_23))
			{
				long num3 = ILRuntimeAPI.PlayAreaEffect(_actor, Parallel.areaEffect_p23, _actor.tsTransform.Position, angle);
				if (num != 0L && num3 != 0L)
				{
					Parallel.dicAreaBind_2.Add(num, num3);
				}
			}
		}
		num = ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_123_B2_WindWall", _actor.tsTransform.Position, _actor.tsTransform.Rotation, ParseAreaEffect);
		num2 = ILRuntimeAPI.PlayAreaEffect(_actor, GetWindEffectName(), _actor.tsTransform.Position, _actor.tsTransform.Rotation);
		if (num != 0L && num2 != 0L)
		{
			Parallel.dicAreaBind_1.Add(num, num2);
		}
		if (GetPerk(Parallel.personalPerkId_23))
		{
			long num3 = ILRuntimeAPI.PlayAreaEffect(_actor, Parallel.areaEffect_p23, _actor.tsTransform.Position, _actor.tsTransform.Rotation);
			if (num != 0L && num3 != 0L)
			{
				Parallel.dicAreaBind_2.Add(num, num3);
			}
		}
		if (GetPerk(Parallel.personalPerkId_26))
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance?.ActivedPlayerActor;
			if (playerAdventureActor != null)
			{
				playerAdventureActor.buffComponent.AddBuff(12352611, _actor);
			}
		}
	}

	private void ParseAreaEffect(AreaEffectEntity areaEffect)
	{
		if (!(areaEffect == null) && GetPerk(Parallel.personalPerkId_24))
		{
			AreaEffect_ModifyBulletSpeedComponent areaEffectComponent = areaEffect.GetAreaEffectComponent<AreaEffect_ModifyBulletSpeedComponent>();
			if (areaEffectComponent != null)
			{
				areaEffectComponent.criteriaInfo = new TargetFilterCriteriaInfo
				{
					filterCriteriaList = new List<TargetFilterCriteriaInfo.TargetFilterCriteria>
					{
						new TargetFilterCriteriaInfo.TargetFilterCriteria
						{
							targetType = TargetFilterCriteriaInfo.TargetTypeMapping.MainPlayerActor
						}
					}
				};
				areaEffectComponent.additionalAttrId = Parallel.attri_p24;
			}
		}
	}

	protected virtual void OnFinish()
	{
		NovaLogger.Debug("===================SkillScript_Zhiyuan_Skill _12301 onFinish");
		_skill.Clear();
	}

	protected virtual void OnInterrupt()
	{
		NovaLogger.Debug("===================_12301 SkillScript_Zhiyuan_Skill onInterrupt");
		_skill.Clear();
	}
}
