using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace FlowCanvas.Macros;

[CreateAssetMenu(menuName = "ParadoxNotion/FlowCanvas/Macro Asset")]
public class Macro : FlowScriptBase
{
	[Serializable]
	private struct DerivedSerializationData
	{
		public List<DynamicPortDefinition> inputDefinitions;

		public List<DynamicPortDefinition> outputDefinitions;
	}

	[SerializeField]
	public List<DynamicPortDefinition> inputDefinitions = new List<DynamicPortDefinition>();

	[SerializeField]
	public List<DynamicPortDefinition> outputDefinitions = new List<DynamicPortDefinition>();

	[NonSerialized]
	public Dictionary<string, FlowHandler> entryActionMap = new Dictionary<string, FlowHandler>(StringComparer.Ordinal);

	[NonSerialized]
	public Dictionary<string, FlowHandler> exitActionMap = new Dictionary<string, FlowHandler>(StringComparer.Ordinal);

	[NonSerialized]
	public Dictionary<string, ValueHandlerObject> entryFunctionMap = new Dictionary<string, ValueHandlerObject>(StringComparer.Ordinal);

	[NonSerialized]
	public Dictionary<string, ValueHandlerObject> exitFunctionMap = new Dictionary<string, ValueHandlerObject>(StringComparer.Ordinal);

	private MacroInputNode _entry;

	private MacroOutputNode _exit;

	public override bool useLocalBlackboard => true;

	public MacroInputNode entry
	{
		get
		{
			if (_entry == null)
			{
				_entry = base.allNodes.OfType<MacroInputNode>().FirstOrDefault();
				if (_entry == null)
				{
					_entry = AddNode<MacroInputNode>(new Vector2(0f - base.translation.x + 200f, 0f - base.translation.y + 200f));
				}
			}
			return _entry;
		}
	}

	public MacroOutputNode exit
	{
		get
		{
			if (_exit == null)
			{
				_exit = base.allNodes.OfType<MacroOutputNode>().FirstOrDefault();
				if (_exit == null)
				{
					_exit = AddNode<MacroOutputNode>(new Vector2(0f - base.translation.x + 600f, 0f - base.translation.y + 200f));
				}
			}
			return _exit;
		}
	}

	public override object OnDerivedDataSerialization()
	{
		return new DerivedSerializationData
		{
			inputDefinitions = inputDefinitions,
			outputDefinitions = outputDefinitions
		};
	}

	public override void OnDerivedDataDeserialization(object data)
	{
		if (data is DerivedSerializationData)
		{
			inputDefinitions = ((DerivedSerializationData)data).inputDefinitions;
			outputDefinitions = ((DerivedSerializationData)data).outputDefinitions;
		}
	}

	protected override void OnGraphValidate()
	{
		base.OnGraphValidate();
		_entry = null;
		_exit = null;
		_entry = entry;
		_exit = exit;
		if (inputDefinitions.Count == 0 && outputDefinitions.Count == 0)
		{
			DynamicPortDefinition def = new DynamicPortDefinition("In", typeof(Flow));
			DynamicPortDefinition def2 = new DynamicPortDefinition("Out", typeof(Flow));
			Port source = AddInputDefinition(def);
			Port target = AddOutputDefinition(def2);
			BinderConnection.Create(source, target);
		}
	}

	public Port AddInputDefinition(DynamicPortDefinition def)
	{
		if (inputDefinitions.Find((DynamicPortDefinition d) => d.ID == def.ID) == null)
		{
			inputDefinitions.Add(def);
			entry.GatherPorts();
			return entry.GetOutputPort(def.ID);
		}
		return null;
	}

	public Port AddOutputDefinition(DynamicPortDefinition def)
	{
		if (outputDefinitions.Find((DynamicPortDefinition d) => d.ID == def.ID) == null)
		{
			outputDefinitions.Add(def);
			exit.GatherPorts();
			return exit.GetInputPort(def.ID);
		}
		return null;
	}
}
