using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._5050100ShaSha;

public class SkillScript_ShadowGathering_1 : SkillScript_SkillBase
{
	protected readonly ComboInputBuffer.ActionKey[] _actionKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.H };

	protected readonly string eventBoom = "boom";

	protected readonly List<string> strAreaEffectByTag = new List<string> { "shuiyu", "duyu" };

	protected FP endWaitTime = 0.1;

	protected readonly string addBuffEvent = "AddBuff";

	protected readonly List<PlayFX> fxList_1 = new List<PlayFX>();

	protected readonly List<PlayFX> fxList_2 = new List<PlayFX>();

	protected readonly List<CoroutineNode> buttleCor = new List<CoroutineNode>();

	protected CoroutineNode _createButtle;

	protected CoroutineNode _waitEnd;

	public override void OnStart()
	{
		_actor.logicVariable.ToggleLogicTag("CheckSkill_ShaSha", value: false);
		BeginSkill();
	}

	protected override void BeginSkill()
	{
		base.BeginSkill();
		_comboAttack.BeginAttack(_actor, _skill, _actionKey, flushInputedKeys: true, (_skill != null) ? _skill.skillId : 0, forceInterruptAttack: false, autoLookAtTarget: false, null, null, onCustomEvent: OnCustomEvent, onInterrupt: OnInterrupt, aimTargetPosition: default, onAnticipationEnd: null, onRecoveryBegin: null, onComboLoop: null, onComboFinish: () =>
		{
			StopCoroutine(ref _waitEnd);
			StartCoroutine(ref _waitEnd, WaitEnd());
		});
	}

	protected void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventBoom, eventName))
		{
			for (int i = 0; i < strAreaEffectByTag.Count; i++)
			{
				ILRuntimeAPI.StopAreaEffectByTag(strAreaEffectByTag.get_Item(i));
			}
		}
		else if (string.Equals(addBuffEvent, eventName))
		{
			_actor.buffComponent.AddBuff(505010110, _actor);
		}
	}

	protected void OnFinish()
	{
		_actor.logicVariable.ToggleLogicTag("CheckSkill_ShaSha", value: true);
		_skill?.Clear();
	}

	protected void OnInterrupt()
	{
		OnFinish();
	}

	protected IEnumerator WaitEnd()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(endWaitTime));
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.logicVariable.ToggleLogicTag("5050100ShaShaSpecial", value: false);
		_actor.logicVariable.ToggleLogicTag("5050100ShaShaViolent", value: true);
		_actor.logicVariable.ToggleLogicTag("5050100ShaShaViolent_Start", value: true);
		StopCoroutine(ref _createButtle);
		StopCoroutine(ref _waitEnd);
	}
}
