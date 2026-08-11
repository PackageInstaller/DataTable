using System;
using UnityEngine;

[Serializable]
public class ClipVariableVector3 : BaseClipVariable
{
	public Vector3 vector3Value;

	public override Type SVariableType()
	{
		return typeof(Vector3);
	}

	public override object GetVariableValue()
	{
		return vector3Value;
	}

	public override void SetVariableValue(object obj)
	{
		vector3Value = (Vector3)obj;
	}
}
