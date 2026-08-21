using System.Collections.Generic;
using System.Linq;
using MessagePack;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using UnityEngine;

namespace FlowCanvas.Nodes;

[DoNotList]
[Name("Function Call", 0)]
[Description("Calls an existing Custom Function")]
[Category("Functions/Custom")]
[DeserializeFrom(new string[] { "FlowCanvas.Nodes.RelayFlowInput" })]
public class CustomFunctionCall : FlowControlNode
{
	[SerializeField]
	private string _sourceOutputUID;

	private ValueInput[] portArgs;

	private object[] objectArgs;

	private FlowOutput fOut;

	private object _sourceFunction;

	private string sourceFunctionUID
	{
		get
		{
			return _sourceOutputUID;
		}
		set
		{
			_sourceOutputUID = value;
		}
	}

	public CustomFunctionEvent sourceFunction
	{
		get
		{
			if (_sourceFunction == null)
			{
				_sourceFunction = base.graph.GetAllNodesOfType<CustomFunctionEvent>().FirstOrDefault((CustomFunctionEvent i) => i.UID == sourceFunctionUID);
				if (_sourceFunction == null)
				{
					_sourceFunction = new object();
				}
			}
			return _sourceFunction as CustomFunctionEvent;
		}
		set
		{
			_sourceFunction = value;
		}
	}

	public override string name => string.Format("Call {0} ()", (sourceFunction != null) ? sourceFunction.identifier : "NONE");

	public override string description => "";

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(_sourceOutputUID);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		_sourceOutputUID = reader.ReadString();
	}

	public void SetFunction(CustomFunctionEvent func)
	{
		sourceFunctionUID = func?.UID;
		sourceFunction = ((func != null) ? func : null);
		GatherPorts();
	}

	protected override void RegisterPorts()
	{
		AddFlowInput(" ", Invoke);
		if (sourceFunction != null)
		{
			List<DynamicPortDefinition> parameters = sourceFunction.parameters;
			portArgs = new ValueInput[parameters.Count];
			for (int i = 0; i < parameters.Count; i++)
			{
				int num = i;
				DynamicPortDefinition dynamicPortDefinition = parameters[num];
				portArgs[num] = AddValueInput(dynamicPortDefinition.name, dynamicPortDefinition.type, dynamicPortDefinition.ID);
			}
			if (sourceFunction.returns.type != null)
			{
				AddValueOutput(sourceFunction.returns.name, sourceFunction.returns.ID, sourceFunction.returns.type, sourceFunction.GetReturnValue);
			}
			fOut = AddFlowOutput(" ");
		}
	}

	private void Invoke(Flow f)
	{
		if (sourceFunction != null)
		{
			if (objectArgs == null)
			{
				objectArgs = new object[portArgs.Length];
			}
			for (int i = 0; i < portArgs.Length; i++)
			{
				objectArgs[i] = portArgs[i].value;
			}
			sourceFunction.InvokeAsync(f, fOut.Call, objectArgs);
		}
	}
}
