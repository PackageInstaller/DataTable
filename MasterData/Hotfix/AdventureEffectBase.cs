using System.Collections.Generic;
using Nova.Hotfix;
using TrueSync;

public abstract class AdventureEffectBase
{
	protected AdventureEffect _effect;

	protected List<AdventureActor> _targets;

	public ExecuteEffectInfo executeEffectInfo;

	protected AdventureActor _owner => _effect._owner;

	protected AdventureActor _fromActor => _effect._fromActor;

	public EffectValue effectValueConfig => _effect.effectValueConfig;

	public FP OrginMaxCd => _effect.OrginMaxCd;

	public long Damage => _effect.Damage;

	public FP CD
	{
		get
		{
			return _effect.CD;
		}
		set
		{
			_effect.CD = value;
		}
	}

	public FP MaxCD
	{
		get
		{
			return _effect.MaxCD;
		}
		set
		{
			_effect.MaxCD = value;
		}
	}

	public bool Removed
	{
		get
		{
			return _effect.Removed;
		}
		set
		{
			_effect.Removed = value;
		}
	}

	public void SetEffectTargets(AdventureEffect effect, List<AdventureActor> targets)
	{
		_effect = effect;
		_targets = targets;
	}

	public virtual void Execute()
	{
	}

	public virtual void AddListenerer()
	{
	}

	public virtual void PostExecute()
	{
	}

	public virtual void RemoveListener()
	{
	}

	public virtual void InitParams()
	{
	}

	public bool TryParseStringParamToInt(string value, out int intValue, bool allowEmpty = false)
	{
		intValue = 0;
		if (_effect != null)
		{
			return _effect.TryParseStringParamToInt(value, out intValue, allowEmpty);
		}
		return false;
	}

	public bool TryParseStringParamToFloat(string value, out float floatValue, bool allowEmpty = false)
	{
		floatValue = 0f;
		if (_effect != null)
		{
			return _effect.TryParseStringParamToFloat(value, out floatValue, allowEmpty);
		}
		return false;
	}

	public bool TryParseStringParamToFDP(string value, out FDP floatValue, bool allowEmpty = false)
	{
		floatValue = FDP.Zero;
		if (_effect != null)
		{
			return _effect.TryParseStringParamToFDP(value, out floatValue, allowEmpty);
		}
		return false;
	}

	public bool TryParseStringParamToFP(string value, out FP fpValue, bool allowEmpty = false)
	{
		fpValue = FP.Zero;
		if (_effect != null)
		{
			return _effect.TryParseStringParamToFP(value, out fpValue, allowEmpty);
		}
		return false;
	}

	public virtual void OnClear()
	{
		_targets = null;
		_effect = null;
		executeEffectInfo = null;
	}
}
