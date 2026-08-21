using System;

namespace Ase;

public class ObserverConditionParams
{
	private string originString;

	private string paramStr;

	private bool compare;

	private bool isParse;

	private int paramInt;

	private float paramFloat;

	private bool paramBool;

	protected const string ANY = "Any";

	public string OriginString => originString;

	public string ParamString => paramStr;

	public int ParamInt
	{
		get
		{
			if (!isParse)
			{
				OnParseInt();
			}
			return paramInt;
		}
	}

	public float ParamFloat
	{
		get
		{
			if (!isParse)
			{
				OnParseFloat();
			}
			return paramFloat;
		}
	}

	public bool ParamBool
	{
		get
		{
			if (!isParse)
			{
				OnParseBool();
			}
			return paramBool;
		}
	}

	public bool Compare => compare;

	public bool IsAny
	{
		get
		{
			if (paramStr != null && !string.Equals(paramStr, "Any", StringComparison.OrdinalIgnoreCase))
			{
				return string.IsNullOrEmpty(paramStr);
			}
			return true;
		}
	}

	public T ParamEnum<T>() where T : struct
	{
		Enum.TryParse<T>(paramStr, out var result);
		return result;
	}

	public ObserverConditionParams(string param)
	{
		CheckParams(param);
		originString = param;
		if (param.StartsWith("!"))
		{
			int length = param.Length;
			int num = 1;
			int length2 = length - num;
			paramStr = param.Substring(num, length2);
			compare = false;
		}
		else
		{
			paramStr = param;
			compare = true;
		}
		isParse = false;
	}

	private void CheckParams(string param)
	{
		string.IsNullOrWhiteSpace(param);
	}

	public void OnParseInt()
	{
		if (!int.TryParse(paramStr, out paramInt))
		{
			_ = IsAny;
		}
		isParse = true;
	}

	public void OnParseFloat()
	{
		if (!float.TryParse(paramStr, out paramFloat))
		{
			_ = IsAny;
		}
		isParse = true;
	}

	public void OnParseBool()
	{
		if (!bool.TryParse(paramStr, out paramBool))
		{
			_ = IsAny;
		}
		isParse = true;
	}
}
