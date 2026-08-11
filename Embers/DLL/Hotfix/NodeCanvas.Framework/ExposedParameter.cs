using System;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.Scripting;

namespace NodeCanvas.Framework;

[SpoofAOT]
[Preserve]
public abstract class ExposedParameter
{
	public abstract string targetVariableID { get; }

	public abstract Type type { get; }

	public abstract object valueBoxed { get; set; }

	public abstract Variable varRefBoxed { get; }

	public abstract void Bind(IBlackboard blackboard);

	public abstract void UnBind();

	public static ExposedParameter CreateInstance(Variable target)
	{
		return (ExposedParameter)Activator.CreateInstance(typeof(ExposedParameter<>).MakeGenericType(target.varType), ReflectionTools.SingleTempArgsArray(target));
	}
}
[Preserve]
public sealed class ExposedParameter<T> : ExposedParameter
{
	[SerializeField]
	private string _targetVariableID;

	[SerializeField]
	private T _value;

	public Variable<T> varRef { get; private set; }

	public override string targetVariableID => _targetVariableID;

	public override Type type => typeof(T);

	public override object valueBoxed
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

	public override Variable varRefBoxed => varRef;

	public T value
	{
		get
		{
			if (varRef == null || !Application.isPlaying)
			{
				return _value;
			}
			return varRef.value;
		}
		set
		{
			if (varRef != null && Application.isPlaying)
			{
				varRef.value = value;
			}
			_value = value;
		}
	}

	public ExposedParameter()
	{
	}

	public ExposedParameter(Variable target)
	{
		_targetVariableID = target.ID;
		_value = (T)target.value;
	}

	public override void Bind(IBlackboard blackboard)
	{
		if (varRef != null)
		{
			varRef.UnBind();
		}
		varRef = (Variable<T>)blackboard.GetVariableByID(targetVariableID);
		if (varRef != null)
		{
			varRef.BindGetSet(GetRawValue, SetRawValue);
		}
	}

	public override void UnBind()
	{
		if (varRef != null)
		{
			varRef.UnBind();
		}
	}

	private T GetRawValue()
	{
		return _value;
	}

	private void SetRawValue(T value)
	{
		_value = value;
	}
}
