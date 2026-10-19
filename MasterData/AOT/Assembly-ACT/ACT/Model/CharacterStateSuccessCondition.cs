using System;
using Fundamental;

namespace ACT.Model;

public class CharacterStateSuccessCondition : IOperateNodeSuccessCondition
{
	private CharacterTutorialTargetMatcher _targetMatcher;

	private string[] _stateNames;

	private string[] _ignoreStateNames;

	public CharacterStateSuccessCondition(CharacterTutorialTargetMatcher targetMatcher, string[] stateNames, string[] ignoreStateNames)
	{
		_targetMatcher = targetMatcher;
		if (stateNames != null)
		{
			_stateNames = new string[stateNames.Length];
			Array.Copy(stateNames, _stateNames, stateNames.Length);
		}
		if (ignoreStateNames != null)
		{
			_ignoreStateNames = new string[ignoreStateNames.Length];
			Array.Copy(ignoreStateNames, _ignoreStateNames, ignoreStateNames.Length);
		}
	}

	public bool CanHandle(CharacterTutorialEventData evt)
	{
		if (evt is CharacterStateEventData characterStateEventData && _targetMatcher.Matches(characterStateEventData.CharacterId))
		{
			if (_ignoreStateNames != null)
			{
				return !_ignoreStateNames.Contains(characterStateEventData.CharacterStateName);
			}
			return true;
		}
		return false;
	}

	public bool IsSuccess(CharacterTutorialEventData evt)
	{
		if (evt is CharacterStateEventData characterStateEventData)
		{
			return _stateNames.Contains(characterStateEventData.CharacterStateName);
		}
		return false;
	}

	public bool IsSuccessOnEnter()
	{
		return false;
	}
}
