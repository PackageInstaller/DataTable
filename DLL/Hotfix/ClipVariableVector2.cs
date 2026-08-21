using System;
using UnityEngine;

[Serializable]
public class ClipVariableVector2 : BaseClipVariable
{
	public Vector2 vector2Value;

	public override Type SVariableType()
	{
		return typeof(Vector2);
	}

	public override object GetVariableValue()
	{
		return vector2Value;
	}

	public override void SetVariableValue(object obj)
	{
		vector2Value = (Vector2)obj;
	}
}
