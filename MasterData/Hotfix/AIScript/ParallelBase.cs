using System.Collections.Generic;
using TrueSync;

namespace AIScript;

public class ParallelBase : AIBase
{
	private Dictionary<long, FP> _perkTimeDic;

	public virtual void OnEnable()
	{
	}

	public virtual void OnDisable()
	{
		_perkTimeDic?.Clear();
	}

	protected override bool CheckPerkCd(long perkId, FP Cd)
	{
		if (Cd <= 0 || Cd == default(FP))
		{
			return true;
		}
		if (_perkTimeDic == null)
		{
			_perkTimeDic = new Dictionary<long, FP>(10);
		}
		if (_perkTimeDic.TryGetValue(perkId, out var value))
		{
			if (_actor.LogicTime - value > Cd)
			{
				_perkTimeDic.set_Item(perkId, _actor.LogicTime);
				return true;
			}
			return false;
		}
		_perkTimeDic.Add(perkId, _actor.LogicTime);
		return true;
	}

	protected void SetPerkCd(long perkId)
	{
		if (_perkTimeDic == null)
		{
			_perkTimeDic = new Dictionary<long, FP>(10);
		}
		if (_perkTimeDic.TryGetValue(perkId, out var _))
		{
			_perkTimeDic.set_Item(perkId, _actor.LogicTime);
		}
		else
		{
			_perkTimeDic.Add(perkId, _actor.LogicTime);
		}
	}

	protected bool IsTeamMember(AdventureActor advAc)
	{
		if (advAc == null)
		{
			return false;
		}
		if (advAc is PlayerAdventureActor)
		{
			return true;
		}
		return false;
	}
}
