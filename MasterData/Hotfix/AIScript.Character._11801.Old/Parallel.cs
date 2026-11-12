#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11801.Old;

public class Parallel : AIBase
{
	protected readonly int _certainBuffId = 11801;

	protected CoroutineNode _waitForPullEndCoroutine;

	protected readonly List<LogicEntity> targets = new List<LogicEntity>();

	protected readonly List<PlayFX> _fxs = new List<PlayFX>();

	public virtual void OnDisable()
	{
		NovaLogger.Debug("11801 Parallel OnDisable");
		if (_waitForPullEndCoroutine != null)
		{
			_actor.StopLogicCoroutine(_waitForPullEndCoroutine);
			_waitForPullEndCoroutine = null;
		}
		targets.Clear();
		ClearBuffAndEffect();
	}

	public void OnUpdate()
	{
		if (_actor.logicVariable.GetLogicTagToggle("playEffect"))
		{
			_actor.logicVariable.ToggleLogicTag("playEffect", value: false);
			AddEffect();
		}
		if (_actor.logicVariable.GetLogicTagToggle("removeBuffAndEffect"))
		{
			_actor.logicVariable.ToggleLogicTag("removeBuffAndEffect", value: false);
			ClearBuffAndEffect();
		}
		if (_actor.logicVariable.GetLogicTagToggle("WaitForPullEnd"))
		{
			_actor.logicVariable.ToggleLogicTag("WaitForPullEnd", value: false);
			FP logicTagValue = _actor.logicVariable.GetLogicTagValue("PullDuration");
			if (_waitForPullEndCoroutine != null)
			{
				_actor.StopLogicCoroutine(_waitForPullEndCoroutine);
				_waitForPullEndCoroutine = null;
			}
			_waitForPullEndCoroutine = _actor.StartLogicCoroutine(WaitForPullEnd(logicTagValue));
		}
	}

	protected virtual IEnumerator WaitForPullEnd(FP duration)
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(duration));
		ClearBuffAndEffect();
	}

	protected void ClearBuffAndEffect()
	{
		targets.Clear();
		for (int i = 0; i < ModuleController<AdventureModuleController>.Instance.monsterActors.Count; i++)
		{
			MonsterAdventureActor monsterAdventureActor = ModuleController<AdventureModuleController>.Instance.monsterActors.get_Item(i) as MonsterAdventureActor;
			if (monsterAdventureActor.buffComponent.CheckBuffByBuffID(_certainBuffId))
			{
				monsterAdventureActor.GetComponent<AdventureActor>()?.buffComponent.RemoveBuffByBuffId(_certainBuffId);
				targets.Add(monsterAdventureActor);
			}
		}
		for (int j = 0; j < _fxs.Count; j++)
		{
			_fxs.get_Item(j).Stop();
			_fxs.get_Item(j).Clear();
		}
		_fxs.Clear();
	}

	protected void AddEffect()
	{
		for (int i = 0; i < ModuleController<AdventureModuleController>.Instance.monsterActors.Count; i++)
		{
			MonsterAdventureActor monsterAdventureActor = ModuleController<AdventureModuleController>.Instance.monsterActors.get_Item(i) as MonsterAdventureActor;
			if (monsterAdventureActor.buffComponent.CheckBuffByBuffID(_certainBuffId))
			{
				PlayFX playFX = new PlayFX();
				playFX.Play(_actor, null, "fx_11801_loop_line_skill1_01", FP.Zero, TSVector2.zero, TSVector2.zero, null, 1f, 1f, actorScale: false, null, monsterAdventureActor.gameObject.transform);
				_fxs.Add(playFX);
			}
		}
	}
}
