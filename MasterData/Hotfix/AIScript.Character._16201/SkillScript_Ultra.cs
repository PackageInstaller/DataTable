#define LOG_ERROR
using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._16201;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private PlayTimeline _playTimeline;

	private bool _isClaymore;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		Init();
		_actor.EnableInvincible();
		_actor.EnableSuperArmor();
		_actor.EnableImmuneControl();
		DefaultLookAt();
	}

	private void Init()
	{
		if (_actor.buffComponent.CheckBuffByBuffID(16290001))
		{
			_actor.buffComponent.AddBuff(16290002, _actor);
			_isClaymore = true;
		}
		else if (_actor.buffComponent.CheckBuffByBuffID(16290002))
		{
			_actor.buffComponent.AddBuff(16290001, _actor);
			_isClaymore = false;
		}
		else
		{
			_actor.buffComponent.AddBuff(16290002, _actor);
			_isClaymore = true;
			NovaLogger.Error("未检测到重剑或轻剑绝招Buff,视为释放重剑绝招并添加添加轻剑绝招Buff");
		}
	}

	public void OnStart()
	{
		if (_playTimeline == null)
		{
			_playTimeline = new PlayTimeline();
		}
		_playTimeline.Play(_actor, OnPlayTimeLineFinish, OnNotPlayTimeLine, _isClaymore ? 1 : 2);
		int buffID = 16290003;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516243, out var _))
		{
			buffID = 16243011;
		}
		_actor.buffComponent.AddBuff(buffID, _actor);
	}

	private void OnPlayTimeLineFinish()
	{
		if (_isClaymore)
		{
			Action<string> onCustomEvent = OnCustomEvent;
			Action onComboFinish = OnFinish;
			Action onInterrupt = OnInterrupt;
			BeginAttack("Ultra_Zhong", flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
		}
		else
		{
			Action<string> onCustomEvent = OnCustomEvent;
			Action onInterrupt = OnFinish;
			Action onComboFinish = OnInterrupt;
			BeginAttack("Ultra_Qing", flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onInterrupt, onComboFinish, onCustomEvent);
		}
	}

	private void OnNotPlayTimeLine()
	{
		if (_isClaymore)
		{
			Action<string> onCustomEvent = OnCustomEvent;
			Action onComboFinish = OnFinish;
			Action onInterrupt = OnInterrupt;
			BeginAttack("Ultra_Zhong", flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
		}
		else
		{
			Action<string> onCustomEvent = OnCustomEvent;
			Action onInterrupt = OnFinish;
			Action onComboFinish = OnInterrupt;
			BeginAttack("Ultra_Qing", flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onInterrupt, onComboFinish, onCustomEvent);
		}
	}

	private void OnCustomEvent(string eventName)
	{
		int perkLevel;
		if (string.Equals(eventName, "162UltraJianQi"))
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 516241, out perkLevel))
			{
				AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
				adventureActorCustomEvent.sender = _actor;
				adventureActorCustomEvent.actor = _actor;
				adventureActorCustomEvent.eventHashCode = Config.eventHashCode_TriggerSowrdAura;
				adventureActorCustomEvent.intParam = 162400006;
				_actor.DispatchEvent(adventureActorCustomEvent);
			}
		}
		else if (string.Equals(eventName, "162P42ZhongJianArea") && CommonUtils.HavePersonalPerk(_actor.dataID, 516242, out perkLevel))
		{
			TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Left * Config.generateOffset_P42.x + _actor.tsTransform.Forward * Config.generateOffset_P42.y;
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_162_LeiDianArea_P42", position);
		}
		if (!((PlayerAdventureActor)_actor).isAssist && Config.fxKeyDic_MainControl_UltraSkill.TryGetValue(eventName, out var value) && !string.IsNullOrEmpty(value))
		{
			CommonUtils.PlayOneOffFx(_actor, value);
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
		_actor.DisableInvincible();
		_actor.DisableSuperArmor();
		_actor.DisableImmuneControl();
		_isClaymore = false;
	}
}
