using System;

[Serializable]
public class ClipVariableFloat : BaseClipVariable
{
	public float floatValue;

	public override Type SVariableType()
	{
		return typeof(float);
	}

	public override object GetVariableValue()
	{
		return floatValue;
	}

	public override void SetVariableValue(object obj)
	{
		floatValue = (int)obj;
	}
}
