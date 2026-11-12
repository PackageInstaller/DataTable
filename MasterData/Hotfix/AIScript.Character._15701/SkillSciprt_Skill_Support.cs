using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15701;

public class SkillSciprt_Skill_Support : SkillAdvancedBase
{
	private int _triggerTimes_P24;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_triggerTimes_P24 = 0;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515732, out var _))
		{
			_actor.buffComponent.AddBuff(15732011, _actor);
		}
		AdventureActor actor = _actor;
		LogicEntity attackTarget = (_actor.attackTarget = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true));
		actor.attackTarget = attackTarget;
		DefaultLookAt();
	}

	public void OnStart()
	{
		string text = "Skill_Sup";
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515723, out var _))
		{
			text = "Skill_Sup_P23";
		}
		string actionTag = text;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		int perkLevel;
		string value2;
		if (Config_Support.shootInfoDic_Skill.TryGetValue(eventName, out (TSVector2, FP) value))
		{
			TSVector2 item = value.Item1;
			FP item2 = value.Item2;
			TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Left * item.x + _actor.tsTransform.Forward * item.y;
			TSVector2 shootDir = TSVector2.Rotate(_actor.tsTransform.Forward, item2);
			string bulletAlias = "Bullet_157_Skill_Sup_Fish1";
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 515721, out perkLevel))
			{
				bulletAlias = ((!CommonUtils.HavePersonalPerk(_actor.dataID, 515725, out perkLevel)) ? "Bullet_157_Skill_Sup_P21_Fish1" : "Bullet_157_Skill_Sup_P21_Fish1_P25");
			}
			else if (CommonUtils.HavePersonalPerk(_actor.dataID, 515725, out perkLevel))
			{
				bulletAlias = "Bullet_157_Skill_Sup_Fish1_P25";
			}
			ILRuntimeAPI.ShootByDirection(bulletAlias, _actor, default, shootDir, position, Config_Support.shootPositionY_Skill);
		}
		else if (Config_Support.playFxInfoDic_Skill.TryGetValue(eventName, out value2))
		{
			new PlayFX().PlayLinFx(_actor, value2, 1f, useCustSource: true, _actor.gameObject, default, default, _actor.gameObject, default, default);
		}
		else if (string.Equals(eventName, "157SkillSupReSuoDi"))
		{
			AdventureActor actor = _actor;
			LogicEntity attackTarget = (_actor.attackTarget = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true));
			actor.attackTarget = attackTarget;
			DefaultLookAt();
		}
		else if (string.Equals(eventName, "157RestartP24") && CommonUtils.HavePersonalPerk(_actor.dataID, 515724, out perkLevel))
		{
			_triggerTimes_P24 = 0;
		}
	}

	protected override void OnReceiveDamage(IEvent evt)
	{
		base.OnReceiveDamage(evt);
		if (evt is AdventureActorReceiveDamageEvent { to: MonsterAdventureActor to, from: PlayerAdventureActor playerAdventureActor } adventureActorReceiveDamageEvent && playerAdventureActor == _actor && CommonUtils.HavePersonalPerk(_actor.dataID, 515724, out var _) && _triggerTimes_P24 < 4 && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P24))
		{
			_triggerTimes_P24++;
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_157_P24_Boom", to.tsTransform.Position);
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

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_triggerTimes_P24 = 0;
	}
}
