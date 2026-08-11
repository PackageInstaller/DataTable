using System;
using System.Collections.Generic;
using ParadoxNotion;
using UnityEngine;

namespace NodeCanvas.Framework;

[CreateAssetMenu(menuName = "ParadoxNotion/CanvasCore/Signal Definition")]
public class SignalDefinition : ScriptableObject
{
	public delegate void InvokeArguments(Transform sender, Transform receiver, bool isGlobal, params object[] args);

	[SerializeField]
	[HideInInspector]
	private List<DynamicParameterDefinition> _parameters = new List<DynamicParameterDefinition>();

	public List<DynamicParameterDefinition> parameters
	{
		get
		{
			return _parameters;
		}
		private set
		{
			_parameters = value;
		}
	}

	public event InvokeArguments onInvoke;

	public void Invoke(Transform sender, Transform receiver, bool isGlobal, params object[] args)
	{
		if (onInvoke != null)
		{
			onInvoke(sender, receiver, isGlobal, args);
		}
	}

	public void AddParameter(string name, Type type)
	{
		DynamicParameterDefinition item = new DynamicParameterDefinition(name, type);
		_parameters.Add(item);
	}

	public void RemoveParameter(string name)
	{
		DynamicParameterDefinition dynamicParameterDefinition = _parameters.Find((DynamicParameterDefinition p) => p.name == name);
		if (dynamicParameterDefinition != null)
		{
			_parameters.Remove(dynamicParameterDefinition);
		}
	}
}
