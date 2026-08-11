#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Reflection;
using GameFramework;

[Serializable]
public class SkillEnumVariable : SkillBlackVariable
{
	public int variableValue;

	private Type _enumType;

	public string enumType;

	public override string InitVariableKey => "EnumVariable";

	public override object GetValue => GetEnumValue();

	public override Type VariableType()
	{
		if (_enumType == null)
		{
			_enumType = Type.GetType(enumType);
			if (_enumType == null)
			{
				Assembly assembly = Assembly.Load("Unity.Model.Codes");
				_enumType = assembly.GetType(enumType);
			}
		}
		return _enumType;
	}

	public void SetEnumType(string type)
	{
		enumType = type;
	}

	public override void SetValue(object obj)
	{
		if (obj != null)
		{
			variableValue = (int)obj;
		}
	}

	public object GetEnumValue()
	{
		if (VariableType() == null)
		{
			Log.Error("技能编辑器找不到对应的类型：" + enumType);
			return null;
		}
		return Enum.GetValues(VariableType()).GetValue(variableValue);
	}
}
