using System;
using UnityEngine;

namespace Unity.VisualScripting.Community;

[RenamedFrom("Assets.BAC.Runtime.Fundamentals.Units.Variables.DictionaryVariableItem")]
public abstract class DictionaryVariableItem : UnifiedVariableUnit
{
	[SerializeAs("keyType")]
	private Type _keyType = typeof(string);

	[Inspectable]
	[UnitHeaderInspectable("Key Type")]
	[DoNotSerialize]
	public Type keyType
	{
		get
		{
			return _keyType;
		}
		set
		{
			_keyType = value;
		}
	}

	[DoNotSerialize]
	public ValueInput key { get; private set; }

	protected override void Definition()
	{
		base.Definition();
		key = ValueInput(keyType, "key");
		key.SetDefaultValue(GetDefaultValue(keyType));
	}

	private object GetDefaultValue(Type t)
	{
		if (t.IsValueType)
		{
			return Activator.CreateInstance(t);
		}
		if (t == typeof(string))
		{
			return "";
		}
		return null;
	}

	protected VariableDeclarations GetDeclarations(Flow flow)
	{
		return kind switch
		{
			VariableKind.Flow => flow.variables, 
			VariableKind.Graph => Variables.Graph(flow.stack), 
			VariableKind.Object => Variables.Object(flow.GetValue<GameObject>(@object)), 
			VariableKind.Scene => Variables.Scene(flow.stack.scene), 
			VariableKind.Application => Variables.Application, 
			VariableKind.Saved => Variables.Saved, 
			_ => throw new UnexpectedEnumValueException<VariableKind>(kind), 
		};
	}
}
