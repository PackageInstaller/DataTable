using System;

[Serializable]
public class ClipVariableInt : BaseClipVariable
{
	public int intValue;

	public override Type SVariableType()
	{
		return typeof(int);
	}

	public override object GetVariableValue()
	{
		return intValue;
	}

	public override void SetVariableValue(object obj)
	{
		intValue = (int)obj;
	}
}
