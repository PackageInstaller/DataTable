using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.InputSystem;

namespace Unity.VisualScripting;

public sealed class ValueInput : UnitPort<ValueOutput, IUnitOutputPort, ValueConnection>, IUnitValuePort, IUnitPort, IGraphItem, IUnitInputPort
{
	private static readonly HashSet<Type> typesWithDefaultValues = new HashSet<Type>
	{
		typeof(Vector2),
		typeof(Vector3),
		typeof(Vector4),
		typeof(Color),
		typeof(AnimationCurve),
		typeof(Rect),
		typeof(Ray),
		typeof(Ray2D),
		typeof(Type),
		typeof(InputAction)
	};

	public Type type { get; }

	public bool hasDefaultValue => unit.defaultValues.ContainsKey(key);

	public override IEnumerable<ValueConnection> validConnections => unit?.graph?.valueConnections.WithDestination(this) ?? Enumerable.Empty<ValueConnection>();

	public override IEnumerable<InvalidConnection> invalidConnections => unit?.graph?.invalidConnections.WithDestination(this) ?? Enumerable.Empty<InvalidConnection>();

	public override IEnumerable<ValueOutput> validConnectedPorts => validConnections.Select((ValueConnection c) => c.source);

	public override IEnumerable<IUnitOutputPort> invalidConnectedPorts => invalidConnections.Select((InvalidConnection c) => c.source);

	[DoNotSerialize]
	internal object _defaultValue
	{
		get
		{
			return unit.defaultValues[key];
		}
		set
		{
			unit.defaultValues[key] = value;
		}
	}

	public bool nullMeansSelf { get; private set; }

	public bool allowsNull { get; private set; }

	public ValueConnection connection => unit.graph?.valueConnections.SingleOrDefaultWithDestination(this);

	public override bool hasValidConnection => connection != null;

	public ValueInput(string key, Type type)
		: base(key)
	{
		Ensure.That("type").IsNotNull(type);
		this.type = type;
	}

	public void SetDefaultValue(object value)
	{
		Ensure.That("value").IsOfType(value, type);
		if (SupportsDefaultValue(type))
		{
			if (unit.defaultValues.ContainsKey(key))
			{
				unit.defaultValues[key] = value;
			}
			else
			{
				unit.defaultValues.Add(key, value);
			}
		}
	}

	public override bool CanConnectToValid(ValueOutput port)
	{
		return port.type.IsConvertibleTo(type, guaranteed: false);
	}

	public override void ConnectToValid(ValueOutput port)
	{
		Disconnect();
		unit.graph.valueConnections.Add(new ValueConnection(port, this));
	}

	public override void ConnectToInvalid(IUnitOutputPort port)
	{
		ConnectInvalid(port, this);
	}

	public override void DisconnectFromValid(ValueOutput port)
	{
		ValueConnection valueConnection = validConnections.SingleOrDefault((ValueConnection c) => c.source == port);
		if (valueConnection != null)
		{
			unit.graph.valueConnections.Remove(valueConnection);
		}
	}

	public override void DisconnectFromInvalid(IUnitOutputPort port)
	{
		DisconnectInvalid(port, this);
	}

	public ValueInput NullMeansSelf()
	{
		if (ComponentHolderProtocol.IsComponentHolderType(type))
		{
			nullMeansSelf = true;
		}
		return this;
	}

	public ValueInput AllowsNull()
	{
		if (type.IsNullable())
		{
			allowsNull = true;
		}
		return this;
	}

	public static bool SupportsDefaultValue(Type type)
	{
		if (!typesWithDefaultValues.Contains(type) && !typesWithDefaultValues.Contains(Nullable.GetUnderlyingType(type)) && !type.IsBasic())
		{
			return typeof(UnityEngine.Object).IsAssignableFrom(type);
		}
		return true;
	}

	public override IUnitPort CompatiblePort(IUnit unit)
	{
		if (unit == base.unit)
		{
			return null;
		}
		return unit.CompatibleValueOutput(type);
	}
}
