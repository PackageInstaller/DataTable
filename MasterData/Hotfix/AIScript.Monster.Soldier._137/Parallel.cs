using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._137;

public class Parallel : AIBase
{
	private CoroutineNode _corAlertAreaEffect;

	private long _areaEffectIdA;

	private long _areaEffectIdB;

	private bool _alertActiveLastFrame;

	public void OnEnable()
	{
		_alertActiveLastFrame = false;
	}

	public void OnDisable()
	{
		StopAlertCoroutine();
		_alertActiveLastFrame = false;
	}

	public void OnUpdate()
	{
		bool flag = _actor.buffComponent.CheckBuffByBuffID(13700011);
		if (flag && !_alertActiveLastFrame)
		{
			StopAlertCoroutine();
			_corAlertAreaEffect = _actor.StartLogicCoroutine(PlayAreaEffectSequence());
		}
		else if (!flag && _alertActiveLastFrame)
		{
			StopAlertCoroutine();
		}
		_alertActiveLastFrame = flag;
	}

	private IEnumerator PlayAreaEffectSequence()
	{
		while (_actor.buffComponent.CheckBuffByBuffID(13700011))
		{
			StopAreaEffectA();
			StopAreaEffectB();
			_areaEffectIdA = ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_137_MainSkill_Ring_OutAtk", _actor.tsTransform.Position);
			yield return _actor.WaitTime(MainSkill.switchTime);
			StopAreaEffectA();
			_areaEffectIdB = ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_137_MainSkill_Ring_In", _actor.tsTransform.Position);
			yield return _actor.WaitTime(MainSkill.switchTime);
			StopAreaEffectB();
		}
		StopAreaEffectA();
		StopAreaEffectB();
		_corAlertAreaEffect = null;
	}

	private void StopAlertCoroutine()
	{
		if (_corAlertAreaEffect != null)
		{
			_actor.StopLogicCoroutine(_corAlertAreaEffect);
			_corAlertAreaEffect = null;
		}
		StopAreaEffectA();
		StopAreaEffectB();
	}

	private void StopAreaEffectA()
	{
		if (_areaEffectIdA > 0)
		{
			ILRuntimeAPI.StopAreaEffect(_areaEffectIdA);
			_areaEffectIdA = 0L;
		}
	}

	private void StopAreaEffectB()
	{
		if (_areaEffectIdB > 0)
		{
			ILRuntimeAPI.StopAreaEffect(_areaEffectIdB);
			_areaEffectIdB = 0L;
		}
	}
}
