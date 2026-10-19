using System;
using System.Collections;
using System.Collections.Generic;

namespace Unity.VisualScripting;

[SerializationVersion("A", new Type[] { })]
public sealed class VariableDeclarations : IEnumerable<VariableDeclaration>, IEnumerable, ISpecifiesCloner
{
	public VariableKind Kind;

	[InspectorWide(true)]
	[Serialize]
	private VariableDeclarationCollection collection;

	internal Action OnVariableChanged;

	public object this[[InspectorVariableName(ActionDirection.Any)] string variable]
	{
		get
		{
			return Get(variable);
		}
		set
		{
			Set(variable, value);
		}
	}

	ICloner ISpecifiesCloner.cloner => VariableDeclarationsCloner.instance;

	public VariableDeclarations()
	{
		collection = new VariableDeclarationCollection();
	}

	public void Set([InspectorVariableName(ActionDirection.Set)] string variable, object value)
	{
		if (string.IsNullOrEmpty(variable))
		{
			return;
		}
		if (collection.TryGetValue(variable, out var value2))
		{
			if (value2.value != value)
			{
				value2.value = value;
				OnVariableChanged?.Invoke();
			}
		}
		else
		{
			collection.Add(new VariableDeclaration(variable, value));
			OnVariableChanged?.Invoke();
		}
	}

	public object Get([InspectorVariableName(ActionDirection.Get)] string variable)
	{
		if (string.IsNullOrEmpty(variable))
		{
			throw new ArgumentException("No variable name specified.", "variable");
		}
		if (collection.TryGetValue(variable, out var value))
		{
			return value.value;
		}
		throw new InvalidOperationException("Variable not found: '" + variable + "'.");
	}

	public T Get<T>([InspectorVariableName(ActionDirection.Get)] string variable)
	{
		return (T)Get(variable, typeof(T));
	}

	public object Get([InspectorVariableName(ActionDirection.Get)] string variable, Type expectedType)
	{
		return ConversionUtility.Convert(Get(variable), expectedType);
	}

	public void Clear()
	{
		collection.Clear();
	}

	public bool IsDefined([InspectorVariableName(ActionDirection.Any)] string variable)
	{
		if (string.IsNullOrEmpty(variable))
		{
			throw new ArgumentException("No variable name specified.", "variable");
		}
		return collection.Contains(variable);
	}

	public bool Delete([InspectorVariableName(ActionDirection.Any)] string variable)
	{
		if (string.IsNullOrEmpty(variable))
		{
			throw new ArgumentException("No variable name specified.", "variable");
		}
		return collection.Remove(variable);
	}

	public VariableDeclaration GetDeclaration(string variable)
	{
		if (collection.TryGetValue(variable, out var value))
		{
			return value;
		}
		throw new InvalidOperationException("Variable not found: '" + variable + "'.");
	}

	public IEnumerator<VariableDeclaration> GetEnumerator()
	{
		return collection.GetEnumerator();
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return ((IEnumerable)collection).GetEnumerator();
	}
}
