using System;
using UnityEngine;

[Serializable]
public class ClipVariableCurve : BaseClipVariable
{
	public AnimationCurve curveValue;

	public override Type SVariableType()
	{
		return typeof(AnimationCurve);
	}

	public override object GetVariableValue()
	{
		return curveValue;
	}

	public override void SetVariableValue(object obj)
	{
		curveValue = (AnimationCurve)obj;
	}
}
