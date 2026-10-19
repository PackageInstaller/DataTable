using System;
using Unity.VisualScripting.Community.Libraries.Humility;

public class ValueCode
{
	private bool convertType;

	private Type castType;

	private string code;

	public bool isCasted => castType != null;

	public ValueCode(string code)
	{
		this.code = code;
	}

	public ValueCode(string code, Type castType)
	{
		this.code = code;
		this.castType = castType;
	}

	public ValueCode(string code, Type castType, bool shouldCast, bool convertType = true)
	{
		this.code = code;
		if (shouldCast)
		{
			this.castType = castType;
		}
		this.convertType = convertType;
	}

	public string GetCode()
	{
		string text;
		if (isCasted)
		{
			text = (convertType ? ("((" + castType.As().CSharpName(hideSystemObject: false, fullName: true) + ")") : ("(" + castType.As().CSharpName(hideSystemObject: false, fullName: true) + ")"));
		}
		else
		{
			text = string.Empty;
		}
		return text + code + ((isCasted && convertType) ? ")" : string.Empty);
	}

	public static implicit operator string(ValueCode valueCode)
	{
		return valueCode.GetCode();
	}

	public static string operator -(ValueCode valueCode, string str)
	{
		return valueCode.GetCode().Replace(str, "");
	}

	public override string ToString()
	{
		return GetCode();
	}
}
