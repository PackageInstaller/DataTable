using System;

[Serializable]
public class ClipVariableBool : BaseClipVariable
{
	public bool boolValue = true;

	public override Type SVariableType()
	{
		return typeof(bool);
	}

	public override object GetVariableValue()
	{
		return boolValue;
	}

	public override void SetVariableValue(object obj)
	{
		boolValue = (bool)obj;
	}
}
