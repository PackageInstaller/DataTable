using System;
using System.Reflection;

[Serializable]
public class ClipVariableEnum<T> : BaseClipVariable
{
	public int intValue;

	public string enumType;

	private Type _enumType;

	public ClipVariableEnum()
	{
		enumType = typeof(T).FullName;
	}

	public override Type SVariableType()
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

	public override object GetVariableValue()
	{
		if (SVariableType() == null)
		{
			return null;
		}
		return Enum.GetValues(SVariableType()).GetValue(intValue);
	}

	public override void SetVariableValue(object obj)
	{
		if (obj != null)
		{
			intValue = (int)obj;
		}
	}
}
