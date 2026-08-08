using System.Collections.Generic;
using System.Linq;
using MessagePack;
using UnityEngine;

namespace FlowCanvas.Nodes;

public class MutiGraphCustomFunctionCall : FlowNode
{
	[SerializeField]
	public string sourceFunctionName;

	private ValueInput[] portArgs;

	private object[] objectArgs;

	private FlowOutput fOut;

	private CustomFunctionEvent _sourceFunction;

	public CustomFunctionEvent sourceFunction
	{
		get
		{
			if (_sourceFunction == null)
			{
				_sourceFunction = (NScene.GetCurrentScene() as BattleScene).formula.GetAllNodesOfType<CustomFunctionEvent>().FirstOrDefault((CustomFunctionEvent i) => i.identifier == sourceFunctionName);
				if (_sourceFunction == null)
				{
					_sourceFunction = new object() as CustomFunctionEvent;
				}
			}
			return _sourceFunction;
		}
		set
		{
			_sourceFunction = value;
		}
	}

	public override string name => $"Call {sourceFunctionName} ()";

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		sourceFunctionName = reader.ReadString();
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(sourceFunctionName);
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
		if (_sourceFunction != null)
		{
			if (objectArgs == null)
			{
				objectArgs = new object[portArgs.Length];
			}
			for (int i = 0; i < portArgs.Length; i++)
			{
				objectArgs[i] = portArgs[i].value;
			}
			_sourceFunction.InvokeAsync(f, fOut.Call, objectArgs);
		}
	}
}
