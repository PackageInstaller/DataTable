using System;
using System.Collections;
using System.Diagnostics;
using ParadoxNotion;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using ParadoxNotion.Serialization.FullSerializer;
using ParadoxNotion.Services;
using UnityEngine;
using UnityEngine.Scripting;

namespace NodeCanvas.Framework;

[Serializable]
[SpoofAOT]
[fsAutoInstance(true)]
[fsUninitialized]
[Preserve]
public abstract class BBParameter : ISerializationCollectable, ISerializationCallbackReceiver
{
	[SerializeField]
	private string _name;

	[SerializeField]
	private string _targetVariableID;

	private IBlackboard _bb;

	private Variable _varRef;

	public string targetVariableID
	{
		get
		{
			return _targetVariableID;
		}
		protected set
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
		protected set
		{
			if (_varRef != value)
			{
				_varRef = value;
				Bind(value);
				if (onVariableReferenceChanged != null)
				{
					onVariableReferenceChanged(value);
				}
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
				if (string.IsNullOrEmpty(value))
				{
					varRef = null;
					targetVariableID = null;
				}
				else
				{
					varRef = ((value != null) ? ResolveReference(bb, useID: false) : null);
				}
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
			}
			varRef = ((value != null) ? ResolveReference(_bb, useID: true) : null);
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
				targetVariableID = null;
				varRef = null;
			}
			if (value && name == null)
			{
				name = string.Empty;
			}
		}
	}

	public bool isPresumedDynamic
	{
		get
		{
			if (name != null)
			{
				return name.StartsWith("_");
			}
			return false;
		}
	}

	public bool isNone => name == string.Empty;

	public bool isNull => ObjectUtils.AnyEquals(value, null);

	public bool isNoneOrNull
	{
		get
		{
			if (!isNone)
			{
				return isNull;
			}
			return true;
		}
	}

	public bool isDefined => !string.IsNullOrEmpty(name);

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
			return GetValueBoxed();
		}
		set
		{
			SetValueBoxed(value);
		}
	}

	public abstract Type varType { get; }

	public event Action<Variable> onVariableReferenceChanged;

	void ISerializationCallbackReceiver.OnBeforeSerialize()
	{
		if (useBlackboard)
		{
			SetDefaultValue();
		}
	}

	void ISerializationCallbackReceiver.OnAfterDeserialize()
	{
	}

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

	public static void SetBBFields(object target, IBlackboard bb)
	{
		if (target == null)
		{
			return;
		}
		JSONSerializer.SerializeAndExecuteNoCycles(target.GetType(), target, delegate(object o, fsData d)
		{
			if (o is BBParameter)
			{
				(o as BBParameter).bb = bb;
			}
		});
	}

	protected abstract void SetDefaultValue();

	protected abstract void Bind(Variable data);

	public abstract object GetValueBoxed();

	public abstract void SetValueBoxed(object value);

	public void SetTargetVariable(IBlackboard targetBB, Variable targetVariable)
	{
		if (targetVariable != null)
		{
			_targetVariableID = targetVariable.ID;
			_name = ((targetBB is GlobalBlackboard) ? $"{targetBB.identifier}/{targetVariable.name}" : targetVariable.name);
			varRef = ResolveReference(bb, useID: true);
		}
		else
		{
			targetVariableID = null;
		}
	}

	private Variable ResolveReference(IBlackboard targetBlackboard, bool useID)
	{
		if (string.IsNullOrEmpty(name) && string.IsNullOrEmpty(targetVariableID))
		{
			return null;
		}
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
		string varName = name;
		string empty = string.Empty;
		if (name.Contains("/"))
		{
			string[] array = name.Split('/');
			empty = array[0];
			varName = array[1];
			targetBB = GlobalBlackboard.Find(empty);
		}
		if (targetBB == null)
		{
			varRef = null;
			return null;
		}
		varRef = targetBB.AddVariable(varName, varType);
		_ = varRef;
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
		if (value is IList || value is IDictionary)
		{
			return $"<b>{varType.FriendlyName()}</b>";
		}
		return $"<b>{value.ToStringAdvanced()}</b>";
	}
}
[Serializable]
[Preserve]
public class BBParameter<T> : BBParameter
{
	[SerializeField]
	protected T _value;

	private string _blackVariableKey;

	private Type _variableType;

	public new T value
	{
		get
		{
			if (getter != null)
			{
				return getter();
			}
			if (Threader.applicationIsPlaying && base.varRef == null && base.bb != null && !string.IsNullOrEmpty(base.name))
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
					if (base.isPresumedDynamic)
					{
						base.varRef = PromoteToVariable(base.bb);
						if (setter != null)
						{
							setter(value);
						}
					}
				}
				else
				{
					_value = value;
				}
			}
		}
	}

	public override Type varType => typeof(T);

	private event Func<T> getter;

	private event Action<T> setter;

	public BBParameter()
	{
	}

	public BBParameter(T value)
	{
		_value = value;
	}

	public override object GetValueBoxed()
	{
		return value;
	}

	public override void SetValueBoxed(object newValue)
	{
		value = (T)newValue;
	}

	public T GetValue()
	{
		return value;
	}

	public void SetValue(T value)
	{
		this.value = value;
	}

	protected override void SetDefaultValue()
	{
		_value = default(T);
	}

	protected override void Bind(Variable variable)
	{
		_value = default(T);
		if (variable == null)
		{
			getter = null;
			setter = null;
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
		_blackVariableKey = variable.name;
		_variableType = variable.varType;
		if (varType.RTIsAssignableFrom(variable.varType))
		{
			getter = GetBlackVariableValue;
		}
		return false;
	}

	[Conditional("ENABLE_LOG")]
	[Conditional("ENABLE_WARNING_LOG")]
	[Conditional("ENABLE_DEBUG_AND_ABOVE_LOG")]
	[Conditional("ENABLE_INFO_AND_ABOVE_LOG")]
	[Conditional("ENABLE_WARNING_AND_ABOVE_LOG")]
	private void LogError()
	{
		if (varType.RTIsAssignableFrom(_variableType))
		{
			_ = Threader.isMainThread;
		}
		if (varType == typeof(int) && _variableType == typeof(float))
		{
			_ = Threader.isMainThread;
		}
		if (varType == typeof(float) && _variableType == typeof(int))
		{
			_ = Threader.isMainThread;
		}
	}

	private bool BindSetter(Variable variable)
	{
		if (variable is Variable<T> variable2)
		{
			setter = variable2.SetValue;
			return true;
		}
		_blackVariableKey = variable.name;
		_variableType = variable.varType;
		if (varType.RTIsAssignableFrom(variable.varType))
		{
			setter = SetBlackVariableValue;
		}
		return false;
	}

	private T GetBlackVariableValue()
	{
		if (string.IsNullOrEmpty(_blackVariableKey))
		{
			return default(T);
		}
		if (base.bb.GetVariable<T>(_blackVariableKey) == null)
		{
			return default(T);
		}
		return base.bb.GetVariable<T>(_blackVariableKey).value;
	}

	private void SetBlackVariableValue(T va)
	{
		base.bb.SetVariableValue(_blackVariableKey, va);
	}

	public static implicit operator BBParameter<T>(T value)
	{
		return new BBParameter<T>
		{
			value = value
		};
	}
}
