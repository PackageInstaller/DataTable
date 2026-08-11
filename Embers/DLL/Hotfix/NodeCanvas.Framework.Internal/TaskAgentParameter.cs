using System;
using ParadoxNotion.Serialization.FullSerializer;
using UnityEngine;

namespace NodeCanvas.Framework.Internal;

[Serializable]
[fsAutoInstance(false)]
public sealed class TaskAgentParameter : BBParameter<UnityEngine.Object>
{
	[SerializeField]
	private Type _type;

	public override Type varType => _type ?? typeof(UnityEngine.Object);

	public new UnityEngine.Object value
	{
		get
		{
			UnityEngine.Object obj = base.value;
			if (obj is GameObject)
			{
				return (obj as GameObject).transform;
			}
			if (obj is Component)
			{
				return (Component)obj;
			}
			return null;
		}
		set
		{
			_value = value;
		}
	}

	public override object GetValueBoxed()
	{
		return value;
	}

	public override void SetValueBoxed(object newValue)
	{
		value = newValue as UnityEngine.Object;
	}

	public void SetType(Type newType)
	{
		if (typeof(UnityEngine.Object).IsAssignableFrom(newType))
		{
			_type = newType;
		}
	}
}
