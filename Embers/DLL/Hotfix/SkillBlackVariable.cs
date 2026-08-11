using System;
using System.Collections.Generic;

[Serializable]
public abstract class SkillBlackVariable
{
	public string variableKey;

	private List<BaseClipVariable> _bindSVariableList = new List<BaseClipVariable>();

	public abstract string InitVariableKey { get; }

	public abstract object GetValue { get; }

	public abstract Type VariableType();

	public abstract void SetValue(object obj);

	public void AddBind(BaseClipVariable sBaseClipVariable)
	{
		_bindSVariableList.Add(sBaseClipVariable);
	}

	public void RefreshBind()
	{
		for (int i = 0; i < _bindSVariableList.Count; i++)
		{
			_bindSVariableList[i].SetBindBlackBoardVariable(isBind: false);
		}
		_bindSVariableList.Clear();
		_bindSVariableList = null;
	}
}
