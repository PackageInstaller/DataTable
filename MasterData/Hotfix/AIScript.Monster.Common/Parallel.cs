#define LOG_DEBUG
using System.Collections;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.Common;

public class Parallel : AIBase
{
	protected CoroutineNode _searchCoroutine;

	protected LogicVariable _logicVariable;

	public void OnStart()
	{
		NovaLogger.Debug("Common Parallel OnStart");
		_logicVariable = ActorHelper.GetFlowLogicVariable(_actor.gameObject);
		_searchCoroutine = _actor.StartLogicCoroutine(Search());
	}

	private IEnumerator Search()
	{
		while (true)
		{
			if (_logicVariable != null)
			{
				_actor.monsterTarget = _actor.actorSearchTargetInfo?.GetMonsterAttackTarget();
				if (_actor.monsterTarget != null)
				{
					_logicVariable.SetLogicTagStringValue("Target", _actor.monsterTarget.Id.ToString());
				}
			}
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(0.1f));
		}
	}

	public void OnDisable()
	{
		NovaLogger.Debug("Common Parallel OnDisable");
		if (_searchCoroutine != null)
		{
			_actor.StopLogicCoroutine(_searchCoroutine);
			_searchCoroutine = null;
		}
	}

	public void OnEnable()
	{
		NovaLogger.Debug("Common Parallel OnEnable");
	}
}
