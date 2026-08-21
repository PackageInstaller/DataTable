using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class BlackBoardVariable
{
	[SerializeReference]
	private List<SkillBlackVariable> _variables;

	private Dictionary<string, SkillBlackVariable> _variableMapData;

	public List<SkillBlackVariable> Variables => _variables;

	public BlackBoardVariable()
	{
		_variables = new List<SkillBlackVariable>();
	}

	public void AddVariable(SkillBlackVariable blackVariable)
	{
		if (!_variables.Contains(blackVariable))
		{
			_variables.Add(blackVariable);
		}
	}

	public void RemoveVariable(SkillBlackVariable blackVariable)
	{
		if (_variables.Contains(blackVariable))
		{
			_variables.Remove(blackVariable);
		}
	}

	public SkillBlackVariable GetVariable(string key)
	{
		if (_variableMapData == null)
		{
			_variableMapData = new Dictionary<string, SkillBlackVariable>();
			for (int i = 0; i < _variables.Count; i++)
			{
				_variableMapData.TryAdd(_variables[i].variableKey, _variables[i]);
			}
		}
		_variableMapData.TryGetValue(key, out var value);
		return value;
	}
}
