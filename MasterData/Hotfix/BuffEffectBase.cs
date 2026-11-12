#define LOG_ERROR
using System.Collections;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;

public class BuffEffectBase
{
	public BuffEntity buffEntity;

	protected BuffEffect buffEffectConfig;

	protected AdventureActor fromActor;

	protected AdventureActor owner;

	protected CoroutineNode _coroutine;

	protected int processCount;

	private int _buffuid;

	protected FP period;

	private bool _ended;

	public int BuffUid => _buffuid;

	public void OnInit(AdventureActor _owner, AdventureActor _fromActor, BuffEntity _buffEntity, BuffEffect _buffEffectConfig, int buffUid)
	{
		_buffuid = buffUid;
		fromActor = _fromActor;
		owner = _owner;
		buffEntity = _buffEntity;
		buffEffectConfig = _buffEffectConfig;
		CalculateProcess();
		OnStart();
	}

	private void CalculateProcess()
	{
		if (!TryParseStringParamToFP(buffEffectConfig.Param2, out period, allowEmpty: true) || period <= 0)
		{
			period = 1;
		}
		processCount = Mathf.Max(1, TSMath.CeilToInt(buffEntity.LeftTime / period));
	}

	protected virtual void Enter()
	{
	}

	protected virtual void Execute()
	{
	}

	protected virtual void Exit()
	{
	}

	public void Restart()
	{
		CalculateProcess();
		OnStart();
	}

	private void OnStart()
	{
		if (_coroutine != null)
		{
			owner.StopLogicCoroutine(_coroutine);
			_coroutine = null;
		}
		_ended = false;
		_coroutine = owner.StartLogicCoroutine(Process());
	}

	private IEnumerator Process()
	{
		AdventureActor self = owner;
		FP nextTick = FP.Zero;
		yield return null;
		if (_ended)
		{
			yield break;
		}
		Enter();
		if (_ended)
		{
			yield break;
		}
		while (true)
		{
			Execute();
			if (_ended)
			{
				break;
			}
			nextTick = TSMath.Max(nextTick, -period) + period;
			do
			{
				nextTick -= self.LogicDeltaTime;
				yield return null;
				if (_ended)
				{
					yield break;
				}
			}
			while (nextTick > 0);
		}
	}

	protected void EndProcess()
	{
		_ended = true;
		if (_coroutine != null)
		{
			if (owner != null)
			{
				owner.StopLogicCoroutine(_coroutine);
			}
			_coroutine = null;
		}
	}

	public void OnEnd()
	{
		Exit();
		EndProcess();
		buffEntity = null;
		buffEffectConfig = null;
		fromActor = null;
		owner = null;
		processCount = 0;
	}

	public bool TryParseStringParamToInt(string value, out int intValue, bool allowEmpty = false)
	{
		intValue = 0;
		if (allowEmpty && string.IsNullOrEmpty(value))
		{
			return true;
		}
		if (!allowEmpty && string.IsNullOrEmpty(value))
		{
			NovaLogger.Error($"buffEffectConfig param convert error，buffEffectConfig id:{buffEffectConfig.Id}, param is empty");
			return false;
		}
		if (!CommonHelper.TryParseStringParamToInt(value, out intValue))
		{
			NovaLogger.Error($"buffEffectConfig param convert error，buffEffectConfig id:{buffEffectConfig.Id}, param:{value}");
			return false;
		}
		return true;
	}

	public bool TryParseStringParamToFloat(string value, out float floatValue, bool allowEmpty = false)
	{
		floatValue = 0f;
		if (allowEmpty && string.IsNullOrEmpty(value))
		{
			return true;
		}
		if (!allowEmpty && string.IsNullOrEmpty(value))
		{
			Debug.LogError($"buffEffectConfig param convert error，buffEffectConfig id:{buffEffectConfig.Id}, param is empty");
			return false;
		}
		if (!CommonHelper.TryParseStringParamToFloat(value, out floatValue))
		{
			Debug.LogError($"buffEffectConfig param convert error，buffEffectConfig id:{buffEffectConfig.Id}, param:{value}");
			return false;
		}
		return true;
	}

	public bool TryParseStringParamToFP(string value, out FP fpValue, bool allowEmpty = false)
	{
		fpValue = FP.Zero;
		if (allowEmpty && string.IsNullOrEmpty(value))
		{
			return true;
		}
		if (!allowEmpty && string.IsNullOrEmpty(value))
		{
			Debug.LogError($"buffEffectConfig param convert error，buffEffectConfig id:{buffEffectConfig.Id}, param is empty");
			return false;
		}
		if (!CommonHelper.TryParseStringParamToFP(value, out fpValue))
		{
			Debug.LogError($"buffEffectConfig param convert error，buffEffectConfig id:{buffEffectConfig.Id}, param:{value}");
			return false;
		}
		return true;
	}
}
