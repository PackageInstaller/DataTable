using System.Reflection;
using ParadoxNotion.Serialization;
using UnityEngine;

namespace NodeCanvas.Framework.Internal;

public abstract class ReflectedWrapper : IReflectedWrapper
{
	[SerializeField]
	protected SerializedMethodInfo _targetMethod;

	public ReflectedWrapper()
	{
	}

	public static ReflectedWrapper Create(MethodInfo method, IBlackboard bb)
	{
		if (method == null)
		{
			return null;
		}
		if (method.ReturnType == typeof(void))
		{
			return ReflectedActionWrapper.Create(method, bb);
		}
		return ReflectedFunctionWrapper.Create(method, bb);
	}

	ISerializedReflectedInfo IReflectedWrapper.GetSerializedInfo()
	{
		return _targetMethod;
	}

	public void SetVariablesBB(IBlackboard bb)
	{
		BBParameter[] variables = GetVariables();
		for (int i = 0; i < variables.Length; i++)
		{
			variables[i].bb = bb;
		}
	}

	public SerializedMethodInfo GetSerializedMethod()
	{
		return _targetMethod;
	}

	public MethodInfo GetMethod()
	{
		return _targetMethod;
	}

	public bool HasChanged()
	{
		if (_targetMethod == null)
		{
			return false;
		}
		return _targetMethod.HasChanged();
	}

	public string AsString()
	{
		if (_targetMethod == null)
		{
			return null;
		}
		return _targetMethod.AsString();
	}

	public override string ToString()
	{
		return AsString();
	}

	public abstract BBParameter[] GetVariables();

	public abstract void Init(object instance);
}
