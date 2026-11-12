using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._16201;

public class SkillScript_Skill_Support : SkillAdvancedBase
{
	private int _totalLoopTims;

	private int _loopTimes;

	private int _generateIndex_P22;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_totalLoopTims = 4;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516224, out var _))
		{
			_totalLoopTims += CommonUtils.GetScriptValue(_actor, 16224011).AsInt();
		}
		_loopTimes = 0;
		_generateIndex_P22 = 0;
		_actor.attackTarget = CommonUtils.GetAssistantAttackTarget(_actor);
		DefaultLookAt();
	}

	public void OnStart()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboLoop = OnComboLoop;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Skill_Sup", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent, null, fadeOutAnim: false, onComboLoop);
	}

	private void OnComboLoop()
	{
		_loopTimes++;
		if (_loopTimes >= _totalLoopTims)
		{
			comboAttack?.CancelAttack();
		}
	}

	private void OnCustomEvent(string eventName)
	{
		int perkLevel;
		if (string.Equals(eventName, "162SuoDi"))
		{
			_actor.attackTarget = CommonUtils.GetAssistantAttackTarget(_actor);
			DefaultLookAt();
		}
		else if (string.Equals(eventName, "P21"))
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 516221, out perkLevel))
			{
				TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Left * Config_Support.generateOffset_P21.x + _actor.tsTransform.Forward * Config_Support.generateOffset_P21.y;
				ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_162_LeiDianArea_P21", position);
			}
		}
		else if (string.Equals(eventName, "162P22ZhongJianFall"))
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 516222, out perkLevel))
			{
				TSVector2 tSVector = Config_Support.generateOffsetList_P22.get_Item(TSMath.Clamp(_generateIndex_P22, 0, Config_Support.generateOffsetList_P22.Count - 1).AsInt());
				TSVector2 position2 = _actor.tsTransform.Position + _actor.tsTransform.Left * tSVector.x + _actor.tsTransform.Forward * tSVector.y;
				string fxAlias = "AreaEffect_162_LeiDianZhongJian_Fall_P22";
				if (CommonUtils.HavePersonalPerk(_actor.dataID, 516225, out perkLevel))
				{
					fxAlias = "AreaEffect_162_LeiDianZhongJian_Fall_P22P25";
					_actor.buffComponent.AddBuff(16225011, _actor);
				}
				ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, position2);
				_generateIndex_P22++;
				_generateIndex_P22 = ((_generateIndex_P22 < Config_Support.generateOffsetList_P22.Count) ? _generateIndex_P22 : 0);
			}
		}
		else if (string.Equals(eventName, "162P23JianQi"))
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 516223, out perkLevel))
			{
				AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
				adventureActorCustomEvent.sender = _actor;
				adventureActorCustomEvent.actor = _actor;
				adventureActorCustomEvent.eventHashCode = Config.eventHashCode_TriggerSowrdAura;
				adventureActorCustomEvent.intParam = 162320005;
				_actor.DispatchEvent(adventureActorCustomEvent);
			}
		}
		else if (string.Equals(eventName, "162P26UltraZhong"))
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 516226, out perkLevel))
			{
				_actor.buffComponent.AddBuff(16290001, _actor);
			}
		}
		else if (string.Equals(eventName, "162P29UltraQing") && CommonUtils.HavePersonalPerk(_actor.dataID, 516229, out perkLevel))
		{
			_actor.buffComponent.AddBuff(16290002, _actor);
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
		_generateIndex_P22 = 0;
	}
}
