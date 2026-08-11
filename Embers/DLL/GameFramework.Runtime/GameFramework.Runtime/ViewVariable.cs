using System;
using UnityEngine;

namespace GameFramework.Runtime;

[Serializable]
public class ViewVariable
{
	[SerializeField]
	protected string name = "";

	[SerializeField]
	protected UnityEngine.Object objectValue;

	[SerializeField]
	protected string dataValue;

	[SerializeField]
	protected ViewVariableType variableType;

	public virtual string Name
	{
		get
		{
			return name;
		}
		set
		{
			name = value;
		}
	}

	public virtual ViewVariableType VariableType => variableType;

	public virtual Type ValueType => variableType switch
	{
		ViewVariableType.Boolean => typeof(bool), 
		ViewVariableType.Float => typeof(float), 
		ViewVariableType.Integer => typeof(int), 
		ViewVariableType.String => typeof(string), 
		ViewVariableType.Color => typeof(Color), 
		ViewVariableType.Vector2 => typeof(Vector2), 
		ViewVariableType.Vector3 => typeof(Vector3), 
		ViewVariableType.Vector4 => typeof(Vector4), 
		ViewVariableType.Object => (objectValue == null) ? typeof(UnityEngine.Object) : objectValue.GetType(), 
		ViewVariableType.GameObject => (objectValue == null) ? typeof(GameObject) : objectValue.GetType(), 
		ViewVariableType.Component => (objectValue == null) ? typeof(Component) : objectValue.GetType(), 
		_ => throw new NotSupportedException(), 
	};

	public virtual void SetValue<T>(T value)
	{
		SetValue(value);
	}

	public virtual T GetValue<T>()
	{
		return (T)GetValue();
	}

	public virtual void SetValue(object value)
	{
		switch (variableType)
		{
		case ViewVariableType.Boolean:
			dataValue = DataConverter.GetString((bool)value);
			break;
		case ViewVariableType.Float:
			dataValue = DataConverter.GetString((float)value);
			break;
		case ViewVariableType.Integer:
			dataValue = DataConverter.GetString((int)value);
			break;
		case ViewVariableType.String:
			dataValue = DataConverter.GetString((string)value);
			break;
		case ViewVariableType.Color:
			dataValue = DataConverter.GetString((Color)value);
			break;
		case ViewVariableType.Vector2:
			dataValue = DataConverter.GetString((Vector2)value);
			break;
		case ViewVariableType.Vector3:
			dataValue = DataConverter.GetString((Vector3)value);
			break;
		case ViewVariableType.Vector4:
			dataValue = DataConverter.GetString((Vector4)value);
			break;
		case ViewVariableType.Object:
			objectValue = (UnityEngine.Object)value;
			break;
		case ViewVariableType.GameObject:
			objectValue = (GameObject)value;
			break;
		case ViewVariableType.Component:
			objectValue = (Component)value;
			break;
		default:
			throw new NotSupportedException();
		}
	}

	public virtual object GetValue()
	{
		return variableType switch
		{
			ViewVariableType.Boolean => DataConverter.ToBoolean(dataValue), 
			ViewVariableType.Float => DataConverter.ToSingle(dataValue), 
			ViewVariableType.Integer => DataConverter.ToInt32(dataValue), 
			ViewVariableType.String => DataConverter.ToString(dataValue), 
			ViewVariableType.Color => DataConverter.ToColor(dataValue), 
			ViewVariableType.Vector2 => DataConverter.ToVector2(dataValue), 
			ViewVariableType.Vector3 => DataConverter.ToVector3(dataValue), 
			ViewVariableType.Vector4 => DataConverter.ToVector4(dataValue), 
			ViewVariableType.Object => objectValue, 
			ViewVariableType.GameObject => objectValue, 
			ViewVariableType.Component => objectValue, 
			_ => throw new NotSupportedException(), 
		};
	}
}
