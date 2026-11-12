using System.Collections;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._11901111Hanahara;

public class SkillScript_Spawn : SkillSimpleBase
{
	private int keyIndex = 1;

	private string key = "Birth";

	protected const string fxKey_NoTimeline = "fx_11901_base_Ultra_Summon_In";

	protected const string fxKey_NoTimeline_3 = "fx_11903_base_Ultra_Summon_In";

	protected readonly FP duration_Fx = 1;

	protected PlayerAdventureActor _summoner;

	protected PlayFX _playFx;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		if (logicComponent != null)
		{
			_summoner = logicComponent.SummonActor as PlayerAdventureActor;
		}
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(keyIndex, key, flushInputedKeys: true);
		if ((!(_summoner != null) || !_summoner.logicVariable.GetLogicTagToggle("PlayUltraTimeline")) && duration_Fx > 0)
		{
			_actor.Hide();
			TSVector2 position = _summoner.tsTransform.Position;
			TSVector2 position2 = _actor.tsTransform.Position;
			TSVector2 dir = (position2 - position).normalized;
			FP speed = TSVector2.Distance(position, position2) / 1;
			if (_playFx == null)
			{
				_playFx = new PlayFX();
			}
			string fxAlias = ((_summoner.skinID == 11903) ? "fx_11903_base_Ultra_Summon_In" : "fx_11901_base_Ultra_Summon_In");
			_playFx.Play(_actor, null, fxAlias, 0, position, TSVector2.zero, null, 1f, 1.2f);
			FP time = 0;
			TSVector2 fxPos = position;
			while (time < duration_Fx)
			{
				time += _actor.LogicDeltaTime;
				fxPos += dir * speed * _actor.LogicDeltaTime;
				if (_playFx.fxInstance != null)
				{
					_playFx.fxInstance.transform.position = new Vector3((float)fxPos.x, (float)_actor.tsTransform.PositionY, (float)fxPos.y);
					_playFx.fxInstance.transform.rotation = _actor.transform.rotation;
				}
				yield return null;
			}
			_playFx.Stop();
			_playFx.Clear();
			_actor.Visible();
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
