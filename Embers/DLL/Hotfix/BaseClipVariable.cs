using System;

[Serializable]
public abstract class BaseClipVariable
{
	public bool isBindBlackBoardVariable;

	public string blackBoardVariableKey;

	private BlackBoardVariable _blackBoardVariable;

	public object GetRunTimeValue()
	{
		if (isBindBlackBoardVariable)
		{
			return _blackBoardVariable.GetVariable(blackBoardVariableKey).GetValue;
		}
		return GetVariableValue();
	}

	public abstract Type SVariableType();

	public abstract object GetVariableValue();

	public abstract void SetVariableValue(object obj);

	public void SetBindBlackBoardVariable(bool isBind)
	{
		isBindBlackBoardVariable = isBind;
		if (!isBindBlackBoardVariable)
		{
			blackBoardVariableKey = string.Empty;
		}
	}

	public void SetBindBlackBoardVariableKey(SkillBlackVariable blackVariable)
	{
		blackBoardVariableKey = blackVariable.variableKey;
		blackVariable.AddBind(this);
	}

	public void SetBlackBoard(BlackBoardVariable blackBoardVariable)
	{
		_blackBoardVariable = blackBoardVariable;
	}
}
