using System.Collections.Generic;

[AdventureEffect(HotfixEnum.effectType.STATE_CAHNGE)]
public class StateChanged : AdventureEffectBase
{
	private HotfixEnum.stateAttributeType _state;

	private HotfixEnum.stateAttributeType _weakenedState;

	private List<bool> _enableStates = new List<bool>();

	private List<bool> _enableWeakenedStates = new List<bool>();

	public override void Execute()
	{
		_enableStates.Clear();
		_enableWeakenedStates.Clear();
		_state = (HotfixEnum.stateAttributeType)effectValueConfig.EffectTypeFirstSubtype;
		_weakenedState = GetWeakenedState(_state);
		HotfixEnum.stateAttributeType state = _state;
		if (state == HotfixEnum.stateAttributeType.NONE || state == HotfixEnum.stateAttributeType.MAX)
		{
			return;
		}
		base.Execute();
		switch (_state)
		{
		case HotfixEnum.stateAttributeType.CHARM:
		{
			AdventureActor fromActor = GetFromActor();
			if (fromActor == null)
			{
				return;
			}
			for (int i = 0; i < _targets.Count; i++)
			{
				if (_targets.get_Item(i).stateAttributeList.Enable(_state))
				{
					_targets.get_Item(i).SetCharmDir(fromActor);
					_enableStates.Add(item: true);
					_enableWeakenedStates.Add(item: false);
				}
				else
				{
					_enableStates.Add(item: false);
					_enableWeakenedStates.Add(_targets.get_Item(i).stateAttributeList.Enable(_weakenedState));
				}
			}
			return;
		}
		case HotfixEnum.stateAttributeType.TERROR:
		{
			AdventureActor fromActor2 = GetFromActor();
			if (fromActor2 == null)
			{
				return;
			}
			for (int k = 0; k < _targets.Count; k++)
			{
				if (_targets.get_Item(k).stateAttributeList.Enable(_state))
				{
					_targets.get_Item(k).SetTerrorDir(fromActor2);
					_enableStates.Add(item: true);
					_enableWeakenedStates.Add(item: false);
				}
				else
				{
					_enableStates.Add(item: false);
					_enableWeakenedStates.Add(_targets.get_Item(k).stateAttributeList.Enable(_weakenedState));
				}
			}
			return;
		}
		case HotfixEnum.stateAttributeType.TAUNT:
		{
			if (_fromActor == null)
			{
				return;
			}
			for (int j = 0; j < _targets.Count; j++)
			{
				if (_targets.get_Item(j).stateAttributeList.CanEnable(_state))
				{
					_targets.get_Item(j).stateAttributeList.Disable(_state);
					_targets.get_Item(j).tauntFromActor = _fromActor;
					_targets.get_Item(j).stateAttributeList.Enable(_state);
					_enableStates.Add(item: true);
					_enableWeakenedStates.Add(item: false);
				}
				else
				{
					_enableStates.Add(item: false);
					_enableWeakenedStates.Add(_targets.get_Item(j).stateAttributeList.Enable(_weakenedState));
				}
			}
			return;
		}
		}
		for (int l = 0; l < _targets.Count; l++)
		{
			if (_targets.get_Item(l).stateAttributeList.Enable(_state))
			{
				_enableStates.Add(item: true);
				_enableWeakenedStates.Add(item: false);
			}
			else
			{
				_enableStates.Add(item: false);
				_enableWeakenedStates.Add(_targets.get_Item(l).stateAttributeList.Enable(_weakenedState));
			}
		}
	}

	private HotfixEnum.stateAttributeType GetWeakenedState(HotfixEnum.stateAttributeType state)
	{
		return state switch
		{
			HotfixEnum.stateAttributeType.STUN => HotfixEnum.stateAttributeType.STUN_WEAKENED, 
			HotfixEnum.stateAttributeType.FROZEN => HotfixEnum.stateAttributeType.FROZEN_WEAKENED, 
			HotfixEnum.stateAttributeType.SLEEP => HotfixEnum.stateAttributeType.SLEEP_WEAKENED, 
			HotfixEnum.stateAttributeType.CHARM => HotfixEnum.stateAttributeType.CHARM_WEAKENED, 
			HotfixEnum.stateAttributeType.TERROR => HotfixEnum.stateAttributeType.TERROR_WEAKENED, 
			HotfixEnum.stateAttributeType.TAUNT => HotfixEnum.stateAttributeType.TAUNT_WEAKENED, 
			HotfixEnum.stateAttributeType.BONDAGE => HotfixEnum.stateAttributeType.BONDAGE_WEAKENED, 
			HotfixEnum.stateAttributeType.SILENCE => HotfixEnum.stateAttributeType.SILENCE_WEAKENED, 
			HotfixEnum.stateAttributeType.CHAOS => HotfixEnum.stateAttributeType.CHAOS_WEAKENED, 
			HotfixEnum.stateAttributeType.BLINDNESS => HotfixEnum.stateAttributeType.BLINDNESS_WEAKENED, 
			_ => HotfixEnum.stateAttributeType.NONE, 
		};
	}

	private AdventureActor GetFromActor()
	{
		AdventureActor result = null;
		if (_fromActor != null)
		{
			result = _fromActor;
		}
		else if (_owner != null)
		{
			result = _owner;
		}
		return result;
	}

	public override void PostExecute()
	{
		HotfixEnum.stateAttributeType state = _state;
		if (state == HotfixEnum.stateAttributeType.NONE || state == HotfixEnum.stateAttributeType.MAX)
		{
			return;
		}
		base.PostExecute();
		for (int i = 0; i < _targets.Count; i++)
		{
			if (_enableStates.get_Item(i))
			{
				_targets.get_Item(i).stateAttributeList.Disable(_state);
			}
			if (_enableWeakenedStates.get_Item(i))
			{
				_targets.get_Item(i).stateAttributeList.Disable(_weakenedState);
			}
		}
	}
}
