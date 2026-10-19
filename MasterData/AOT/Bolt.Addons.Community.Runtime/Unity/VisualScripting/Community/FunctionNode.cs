using System;
using System.Collections.Generic;
using Unity.VisualScripting.Community.Libraries.Humility;
using UnityEngine;

namespace Unity.VisualScripting.Community;

[Serializable]
[RenamedFrom("Bolt.Addons.Community.Code.FunctionUnit")]
[SpecialUnit]
[UnitTitle("Function")]
public sealed class FunctionNode : Unit
{
	public MethodDeclaration methodDeclaration;

	public FieldDeclaration fieldDeclaration;

	public ConstructorDeclaration constructorDeclaration;

	public FunctionType functionType;

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlOutput invoke;

	[DoNotSerialize]
	public List<ValueOutput> parameterPorts = new List<ValueOutput>();

	public FunctionNode()
	{
	}

	public FunctionNode(FunctionType functionType)
	{
		this.functionType = functionType;
	}

	protected override void Definition()
	{
		isControlRoot = true;
		invoke = ControlOutput("invoke");
		switch (functionType)
		{
		case FunctionType.Method:
			MethodDefinition();
			break;
		case FunctionType.Getter:
			GetterDefinition();
			break;
		case FunctionType.Setter:
			SetterDefinition();
			break;
		case FunctionType.Constructor:
			ConstructorDefinition();
			break;
		}
	}

	private void ConstructorDefinition()
	{
		for (int i = 0; i < constructorDeclaration?.parameters.Count; i++)
		{
			if (constructorDeclaration.parameters[i].type != null && !string.IsNullOrEmpty(constructorDeclaration.parameters[i].name))
			{
				parameterPorts.Add(ValueOutput(constructorDeclaration.parameters[i].type, constructorDeclaration.parameters[i].name));
			}
		}
	}

	private void SetterDefinition()
	{
		parameterPorts.Add(ValueOutput(fieldDeclaration.type, "value"));
	}

	private void GetterDefinition()
	{
	}

	private void MethodDefinition()
	{
		for (int i = 0; i < methodDeclaration?.parameters.Count; i++)
		{
			if (methodDeclaration.parameters[i].type != null && !string.IsNullOrEmpty(methodDeclaration.parameters[i].name))
			{
				parameterPorts.Add(ValueOutput(methodDeclaration.parameters[i].type, methodDeclaration.parameters[i].name));
			}
		}
	}

	public object New(Type type, params object[] parameters)
	{
		if (type.Inherits<ScriptableObject>())
		{
			return ScriptableObject.CreateInstance(type);
		}
		return type.New(parameters);
	}

	public object Get()
	{
		return null;
	}

	public void Set(object value)
	{
	}

	public void Invoke(params object[] parameters)
	{
		if (methodDeclaration == null)
		{
			throw new NullReferenceException("methodDeclaration cannot be null.");
		}
		if (parameters.Length != methodDeclaration.parameters.Count)
		{
			throw new ArgumentOutOfRangeException("parameters", "Parameters are not the correct count or types to invoke this method.");
		}
		Flow flow = Flow.New(methodDeclaration.GetReference() as GraphReference);
		for (int i = 0; i < parameterPorts.Count; i++)
		{
			flow.SetValue(parameterPorts[i], parameters[i]);
		}
		flow.Invoke(invoke);
	}
}
