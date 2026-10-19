using System;
using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting;

public interface IUnit : IGraphElementWithDebugData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	new FlowGraph graph { get; }

	bool canDefine { get; }

	bool isDefined { get; }

	bool failedToDefine { get; }

	Exception definitionException { get; }

	Dictionary<string, object> defaultValues { get; }

	IUnitPortCollection<ControlInput> controlInputs { get; }

	IUnitPortCollection<ControlOutput> controlOutputs { get; }

	IUnitPortCollection<ValueInput> valueInputs { get; }

	IUnitPortCollection<ValueOutput> valueOutputs { get; }

	IUnitPortCollection<InvalidInput> invalidInputs { get; }

	IUnitPortCollection<InvalidOutput> invalidOutputs { get; }

	IEnumerable<IUnitInputPort> inputs { get; }

	IEnumerable<IUnitOutputPort> outputs { get; }

	IEnumerable<IUnitInputPort> validInputs { get; }

	IEnumerable<IUnitOutputPort> validOutputs { get; }

	IEnumerable<IUnitPort> ports { get; }

	IEnumerable<IUnitPort> invalidPorts { get; }

	IEnumerable<IUnitPort> validPorts { get; }

	IConnectionCollection<IUnitRelation, IUnitPort, IUnitPort> relations { get; }

	IEnumerable<IUnitConnection> connections { get; }

	bool isControlRoot { get; }

	Vector2 position { get; set; }

	event Action onPortsChanged;

	void Define();

	void EnsureDefined();

	void RemoveUnconnectedInvalidPorts();

	void PortsChanged();
}
