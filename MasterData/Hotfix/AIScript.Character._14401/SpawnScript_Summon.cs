using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14401;

public class SpawnScript_Summon : AIBase
{
	private PlayFX _playFX;

	private CoroutineNode _spawnLogicCor;

	public void OnStart()
	{
		_actor.Hide();
		_spawnLogicCor = _actor.StartLogicCoroutine(SpawnLogic(), runImmediately: true);
	}

	private IEnumerator SpawnLogic()
	{
		while (!_actor.logicVariable.GetLogicTagToggle("SummonFinish_Summon"))
		{
			yield return null;
		}
		string logicTagStringValue = _actor.logicVariable.GetLogicTagStringValue("SpawnFx_Summon");
		if (!string.IsNullOrEmpty(logicTagStringValue))
		{
			if (_playFX == null)
			{
				_playFX = new PlayFX();
			}
			else
			{
				_playFX.Clear();
			}
			_playFX.Play(_actor, null, logicTagStringValue, default, _actor.tsTransform.Position, default);
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(0.1f));
		}
		_actor.Visible();
		_actor.Action();
	}

	public void OnStop()
	{
		if (_spawnLogicCor != null)
		{
			_actor.StopLogicCoroutine(_spawnLogicCor);
		}
		_spawnLogicCor = null;
	}
}
