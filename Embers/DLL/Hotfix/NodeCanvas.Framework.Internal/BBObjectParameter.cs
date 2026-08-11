using System;
using ParadoxNotion;
using UnityEngine;

namespace NodeCanvas.Framework.Internal;

[Serializable]
public class BBObjectParameter : BBParameter<object>, ISerializationCallbackReceiver
{
	[SerializeField]
	private string _type;

	private Type type { get; set; }

	public override Type varType
	{
		get
		{
			if (!(type != null))
			{
				return typeof(object);
			}
			return type;
		}
	}

	void ISerializationCallbackReceiver.OnBeforeSerialize()
	{
		if (type != null)
		{
			_type = type.FullName;
		}
	}

	void ISerializationCallbackReceiver.OnAfterDeserialize()
	{
		type = ReflectionTools.GetType(_type, fallbackNoNamespace: true);
	}

	public BBObjectParameter()
	{
		SetType(typeof(object));
	}

	public BBObjectParameter(Type t)
	{
		SetType(t);
	}

	public BBObjectParameter(BBParameter source)
	{
		if (source != null)
		{
			type = source.varType;
			_value = source.value;
			base.name = source.name;
			base.targetVariableID = source.targetVariableID;
		}
	}

	public void SetType(Type t)
	{
		if (t == null)
		{
			t = typeof(object);
		}
		if (t != type || (t.RTIsValueType() && _value == null))
		{
			_value = (t.RTIsValueType() ? Activator.CreateInstance(t) : null);
		}
		type = t;
	}
}
