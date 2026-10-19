using System;
using System.Collections.Generic;
using System.Linq;

namespace Unity.VisualScripting;

public sealed class UnitPreservation : IPoolable
{
	private struct UnitPortPreservation
	{
		public readonly IUnit unit;

		public readonly string key;

		public UnitPortPreservation(IUnitPort port)
		{
			unit = port.unit;
			key = port.key;
		}

		public UnitPortPreservation(IUnit unit, string key)
		{
			this.unit = unit;
			this.key = key;
		}

		public IUnitPort GetOrCreateInput(out InvalidInput newInvalidInput)
		{
			string key = this.key;
			if (!unit.inputs.Any((IUnitInputPort p) => p.key == key))
			{
				newInvalidInput = new InvalidInput(key);
				unit.invalidInputs.Add(newInvalidInput);
			}
			else
			{
				newInvalidInput = null;
			}
			return unit.inputs.Single((IUnitInputPort p) => p.key == key);
		}

		public IUnitPort GetOrCreateOutput(out InvalidOutput newInvalidOutput)
		{
			string key = this.key;
			if (!unit.outputs.Any((IUnitOutputPort p) => p.key == key))
			{
				newInvalidOutput = new InvalidOutput(key);
				unit.invalidOutputs.Add(newInvalidOutput);
			}
			else
			{
				newInvalidOutput = null;
			}
			return unit.outputs.Single((IUnitOutputPort p) => p.key == key);
		}
	}

	private readonly Dictionary<string, object> defaultValues = new Dictionary<string, object>();

	private readonly Dictionary<string, List<UnitPortPreservation>> inputConnections = new Dictionary<string, List<UnitPortPreservation>>();

	private readonly Dictionary<string, List<UnitPortPreservation>> outputConnections = new Dictionary<string, List<UnitPortPreservation>>();

	private bool disposed;

	void IPoolable.New()
	{
		disposed = false;
	}

	void IPoolable.Free()
	{
		disposed = true;
		foreach (KeyValuePair<string, List<UnitPortPreservation>> inputConnection in inputConnections)
		{
			ListPool<UnitPortPreservation>.Free(inputConnection.Value);
		}
		foreach (KeyValuePair<string, List<UnitPortPreservation>> outputConnection in outputConnections)
		{
			ListPool<UnitPortPreservation>.Free(outputConnection.Value);
		}
		defaultValues.Clear();
		inputConnections.Clear();
		outputConnections.Clear();
	}

	private UnitPreservation()
	{
	}

	public static UnitPreservation Preserve(IUnit unit)
	{
		UnitPreservation unitPreservation = GenericPool<UnitPreservation>.New(() => new UnitPreservation());
		foreach (KeyValuePair<string, object> defaultValue in unit.defaultValues)
		{
			unitPreservation.defaultValues.Add(defaultValue.Key, defaultValue.Value);
		}
		foreach (IUnitInputPort input in unit.inputs)
		{
			if (!input.hasAnyConnection)
			{
				continue;
			}
			unitPreservation.inputConnections.Add(input.key, ListPool<UnitPortPreservation>.New());
			foreach (IUnitPort connectedPort in input.connectedPorts)
			{
				unitPreservation.inputConnections[input.key].Add(new UnitPortPreservation(connectedPort));
			}
		}
		foreach (IUnitOutputPort output in unit.outputs)
		{
			if (!output.hasAnyConnection)
			{
				continue;
			}
			unitPreservation.outputConnections.Add(output.key, ListPool<UnitPortPreservation>.New());
			foreach (IUnitPort connectedPort2 in output.connectedPorts)
			{
				unitPreservation.outputConnections[output.key].Add(new UnitPortPreservation(connectedPort2));
			}
		}
		return unitPreservation;
	}

	public void RestoreTo(IUnit unit)
	{
		if (disposed)
		{
			throw new ObjectDisposedException(ToString());
		}
		foreach (KeyValuePair<string, object> defaultValue in defaultValues)
		{
			if (unit.defaultValues.ContainsKey(defaultValue.Key) && unit.valueInputs.Contains(defaultValue.Key) && unit.valueInputs[defaultValue.Key].type.IsAssignableFrom(defaultValue.Value))
			{
				unit.defaultValues[defaultValue.Key] = defaultValue.Value;
			}
		}
		foreach (KeyValuePair<string, List<UnitPortPreservation>> inputConnection in inputConnections)
		{
			UnitPortPreservation destinationPreservation = new UnitPortPreservation(unit, inputConnection.Key);
			foreach (UnitPortPreservation item in inputConnection.Value)
			{
				RestoreConnection(item, destinationPreservation);
			}
		}
		foreach (KeyValuePair<string, List<UnitPortPreservation>> outputConnection in outputConnections)
		{
			UnitPortPreservation sourcePreservation = new UnitPortPreservation(unit, outputConnection.Key);
			foreach (UnitPortPreservation item2 in outputConnection.Value)
			{
				RestoreConnection(sourcePreservation, item2);
			}
		}
		GenericPool<UnitPreservation>.Free(this);
	}

	private void RestoreConnection(UnitPortPreservation sourcePreservation, UnitPortPreservation destinationPreservation)
	{
		IUnitPort orCreateOutput = sourcePreservation.GetOrCreateOutput(out var newInvalidOutput);
		IUnitPort orCreateInput = destinationPreservation.GetOrCreateInput(out var newInvalidInput);
		if (orCreateOutput.CanValidlyConnectTo(orCreateInput))
		{
			orCreateOutput.ValidlyConnectTo(orCreateInput);
			return;
		}
		if (orCreateOutput.CanInvalidlyConnectTo(orCreateInput))
		{
			orCreateOutput.InvalidlyConnectTo(orCreateInput);
			return;
		}
		if (newInvalidOutput != null)
		{
			sourcePreservation.unit.invalidOutputs.Remove(newInvalidOutput);
		}
		if (newInvalidInput != null)
		{
			destinationPreservation.unit.invalidInputs.Remove(newInvalidInput);
		}
	}
}
