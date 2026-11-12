using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15601;

public class SkillScript_Skill_MainControl : SkillAdvancedBase
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515613, out var _))
		{
			foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
			{
				actorL.buffComponent.AddBuff(15613011, _actor);
			}
		}
		DefaultLookAt();
	}

	public void OnStart()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Skill_Mian_CallPenguinDoll", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "CallPenguinDoll"))
		{
			TSVector2 result = _actor.tsTransform.Position + _actor.tsTransform.Forward * Config_MainControl.summonOffset_Skill;
			if (!_actor.QueryPositionWalkable(result))
			{
				_actor.QueryClosestPositionWalkable(result, out result);
			}
			ILRuntimeAPI.SummonMonster(_actor, 0, 15600011, result, _actor.tsTransform.Forward, Config_MainControl.summonCfg_Summon, null, (MonsterAdventureActor monster) =>
			{
				if (CommonUtils.HavePersonalPerk(_actor.dataID, 515601, out var _))
				{
					monster.actorScaleInfo.modelScale = Config_MainControl.modelScale_Summoned_P1;
					monster.buffComponent.AddBuff(15601021, _actor);
				}
				else
				{
					monster.actorScaleInfo.modelScale = monster.actorScaleInfo.originModelScale;
				}
			});
		}
		else if (string.Equals(eventName, "156SlowMoveStart"))
		{
			_actor.buffComponent.AddBuff(15690002, _actor);
		}
		else if (string.Equals(eventName, "156SlowMoveEnd"))
		{
			_actor.buffComponent.RemoveBuffByBuffId(15690002);
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
		_actor.buffComponent.RemoveBuffByBuffId(15690002);
	}
}
