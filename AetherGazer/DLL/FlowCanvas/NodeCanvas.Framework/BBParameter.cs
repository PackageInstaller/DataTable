using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using ParadoxNotion;
using ParadoxNotion.Design;
using ParadoxNotion.Services;
using UnityEngine;

namespace NodeCanvas.Framework;

[Serializable]
[SpoofAOT]
public abstract class BBParameter
{
	[SerializeField]
	private string _name;

	[SerializeField]
	private string _targetVariableID;

	[NonSerialized]
	private IBlackboard _bb;

	[NonSerialized]
	private Variable _varRef;

	public string targetVariableID
	{
		get
		{
			return _targetVariableID;
		}
		set
		{
			_targetVariableID = value;
		}
	}

	public Variable varRef
	{
		get
		{
			return _varRef;
		}
		set
		{
			if (_varRef != value)
			{
				_varRef = value;
				Bind(value);
			}
		}
	}

	public IBlackboard bb
	{
		get
		{
			return _bb;
		}
		set
		{
			if (_bb != value)
			{
				_bb = value;
				varRef = ((value != null) ? ResolveReference(_bb, useID: true) : null);
			}
		}
	}

	public string name
	{
		get
		{
			return _name;
		}
		set
		{
			if (_name != value)
			{
				_name = value;
				varRef = ((value != null) ? ResolveReference(bb, useID: false) : null);
			}
		}
	}

	public bool useBlackboard
	{
		get
		{
			return name != null;
		}
		set
		{
			if (!value)
			{
				name = null;
			}
			if (value && name == null)
			{
				name = string.Empty;
			}
		}
	}

	public bool isNone => name == string.Empty;

	public bool isDefined => !string.IsNullOrEmpty(name);

	public bool isNull => object.Equals(objectValue, null);

	public Type refType
	{
		get
		{
			if (varRef == null)
			{
				return null;
			}
			return varRef.varType;
		}
	}

	public object value
	{
		get
		{
			return objectValue;
		}
		set
		{
			objectValue = value;
		}
	}

	protected abstract object objectValue { get; set; }

	public abstract Type varType { get; }

	public BBParameter()
	{
	}

	public static BBParameter CreateInstance(Type t, IBlackboard bb)
	{
		if (t == null)
		{
			return null;
		}
		BBParameter obj = (BBParameter)Activator.CreateInstance(typeof(BBParameter<>).RTMakeGenericType(t));
		obj.bb = bb;
		return obj;
	}

	public static void SetBBFields(object o, IBlackboard bb)
	{
		List<BBParameter> objectBBParameters = GetObjectBBParameters(o);
		for (int i = 0; i < objectBBParameters.Count; i++)
		{
			if (objectBBParameters[i] != null)
			{
				objectBBParameters[i].bb = bb;
			}
		}
	}

	public static List<BBParameter> GetObjectBBParameters(object o)
	{
		List<BBParameter> list = new List<BBParameter>();
		if (o == null)
		{
			return list;
		}
		if (o is ISubParametersContainer)
		{
			BBParameter[] subParameters = (o as ISubParametersContainer).GetSubParameters();
			if (subParameters != null && subParameters.Length != 0)
			{
				list.AddRange(subParameters);
			}
		}
		FieldInfo[] array = o.GetType().RTGetFields();
		foreach (FieldInfo fieldInfo in array)
		{
			if (typeof(BBParameter).RTIsAssignableFrom(fieldInfo.FieldType))
			{
				object obj = fieldInfo.GetValue(o);
				if (obj == null && !fieldInfo.FieldType.RTIsAbstract())
				{
					obj = Activator.CreateInstance(fieldInfo.FieldType);
					fieldInfo.SetValue(o, obj);
				}
				if (obj != null)
				{
					list.Add((BBParameter)obj);
				}
			}
			else
			{
				if (!typeof(IList).RTIsAssignableFrom(fieldInfo.FieldType) || fieldInfo.FieldType.IsArray)
				{
					continue;
				}
				Type[] array2 = fieldInfo.FieldType.RTGetGenericArguments();
				if (array2.Length == 0)
				{
					continue;
				}
				Type type = array2[0];
				if (type == null || !typeof(BBParameter).RTIsAssignableFrom(type) || !(fieldInfo.GetValue(o) is IList list2))
				{
					continue;
				}
				for (int j = 0; j < list2.Count; j++)
				{
					object obj2 = list2[j];
					if (obj2 == null && !fieldInfo.FieldType.RTIsAbstract())
					{
						obj2 = (list2[j] = Activator.CreateInstance(type));
					}
					if (obj2 != null)
					{
						list.Add((BBParameter)obj2);
					}
				}
			}
		}
		return list;
	}

	public void SetName(string value)
	{
		if (_name != value)
		{
			_name = value;
			varRef = ((value != null) ? ResolveReference(bb, useID: false) : null);
		}
	}

	protected abstract void Bind(Variable data);

	private Variable ResolveReference(IBlackboard targetBlackboard, bool useID)
	{
		string text = name;
		if (text != null && text.Contains("/"))
		{
			string[] array = text.Split('/');
			targetBlackboard = GlobalBlackboard.Find(array[0]);
			text = array[1];
		}
		Variable variable = null;
		if (targetBlackboard == null)
		{
			return null;
		}
		if (useID && targetVariableID != null)
		{
			variable = targetBlackboard.GetVariableByID(targetVariableID);
		}
		if (variable == null && !string.IsNullOrEmpty(text))
		{
			variable = targetBlackboard.GetVariable(text, varType);
		}
		return variable;
	}

	public Variable PromoteToVariable(IBlackboard targetBB)
	{
		if (string.IsNullOrEmpty(name))
		{
			varRef = null;
			return null;
		}
		string text = name;
		string text2 = ((targetBB != null) ? targetBB.name : string.Empty);
		if (name.Contains("/"))
		{
			string[] array = name.Split('/');
			text2 = array[0];
			text = array[1];
			targetBB = GlobalBlackboard.Find(text2);
		}
		if (targetBB == null)
		{
			varRef = null;
			ParadoxNotion.Services.Logger.LogError($"Parameter '{text}' failed to promote to a variable, because Blackboard named '{text2}' could not be found.", "Variable", this);
			return null;
		}
		varRef = targetBB.AddVariable(text, varType);
		if (varRef == null)
		{
			ParadoxNotion.Services.Logger.LogError($"Parameter {text} (of type '{varType.FriendlyName()}') failed to promote to a Variable in Blackboard '{text2}'.", "Variable", this);
		}
		return varRef;
	}

	public sealed override string ToString()
	{
		if (isNone)
		{
			return "<b>NONE</b>";
		}
		if (useBlackboard)
		{
			return $"<b>${name}</b>";
		}
		if (isNull)
		{
			return "<b>NULL</b>";
		}
		if (objectValue is IList || objectValue is IDictionary)
		{
			return $"<b>{varType.FriendlyName()}</b>";
		}
		return $"<b>{objectValue.ToStringAdvanced()}</b>";
	}
}
[Serializable]
public class BBParameter<T> : BBParameter
{
	private Func<T> getter;

	private Action<T> setter;

	[SerializeField]
	protected T _value;

	public new T value
	{
		get
		{
			if (getter != null)
			{
				return getter();
			}
			if (Application.isPlaying && base.varRef == null && base.bb != null && !string.IsNullOrEmpty(base.name))
			{
				base.varRef = base.bb.GetVariable(base.name, typeof(T));
				if (getter == null)
				{
					return default(T);
				}
				return getter();
			}
			return _value;
		}
		set
		{
			if (setter != null)
			{
				setter(value);
			}
			else
			{
				if (base.isNone)
				{
					return;
				}
				if (base.varRef == null && base.bb != null && !string.IsNullOrEmpty(base.name))
				{
					base.varRef = PromoteToVariable(base.bb);
					if (setter != null)
					{
						setter(value);
					}
				}
				else
				{
					_value = value;
				}
			}
		}
	}

	protected override object objectValue
	{
		get
		{
			return value;
		}
		set
		{
			this.value = (T)value;
		}
	}

	public override Type varType => typeof(T);

	public BBParameter()
	{
	}

	public BBParameter(T value)
	{
		_value = value;
	}

	protected override void Bind(Variable variable)
	{
		if (variable == null)
		{
			getter = null;
			setter = null;
			_value = default(T);
		}
		else
		{
			BindGetter(variable);
			BindSetter(variable);
		}
	}

	private bool BindGetter(Variable variable)
	{
		if (variable is Variable<T>)
		{
			getter = (variable as Variable<T>).GetValue;
			return true;
		}
		Func<object> convertFunc = variable.GetGetConverter(varType);
		if (convertFunc != null)
		{
			getter = () => (T)convertFunc();
			return true;
		}
		return false;
	}

	private bool BindSetter(Variable variable)
	{
		if (variable is Variable<T>)
		{
			setter = (variable as Variable<T>).SetValue;
			return true;
		}
		Action<object> convertFunc = variable.GetSetConverter(varType);
		if (convertFunc != null)
		{
			setter = delegate(T value)
			{
				convertFunc(value);
			};
			return true;
		}
		setter = delegate
		{
			ParadoxNotion.Services.Logger.LogWarning($"Setting Parameter Type '{typeof(T).FriendlyName()}' back to Variable Type '{variable.varType.FriendlyName()}' is not possible.", "AutoConvert", this);
		};
		return false;
	}

	public static implicit operator BBParameter<T>(T value)
	{
		return new BBParameter<T>
		{
			value = value
		};
	}
}
