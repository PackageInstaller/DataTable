using System;
using System.Reflection;

namespace FlowCanvas.Nodes;

public class PureReflectedMethodNode : BaseReflectedMethodNode
{
	private ValueInput instanceInput;

	private object instanceObject;

	private object resultObject;

	private object[] callParams;

	private ValueInput[] inputs;

	private ValueInput[] arrayInputs;

	private int arrayParamsInput = -1;

	private Type arrayParamsType;

	protected override bool InitInternal(MethodInfo method)
	{
		callParams = new object[paramDefinitions.Count];
		if (options.exposeParams)
		{
			for (int i = 0; i <= paramDefinitions.Count - 1; i++)
			{
				ParamDef paramDef = paramDefinitions[i];
				if (paramDef.isParamsArray)
				{
					arrayParamsInput = i;
					arrayParamsType = paramDef.arrayType;
					break;
				}
			}
			if (arrayParamsInput >= 0 && options.exposedParamsCount >= 0)
			{
				arrayInputs = new ValueInput[options.exposedParamsCount];
			}
		}
		inputs = new ValueInput[paramDefinitions.Count];
		instanceInput = null;
		resultObject = null;
		return true;
	}

	private void Call()
	{
		for (int i = 0; i <= callParams.Length - 1; i++)
		{
			if (options.exposeParams && arrayParamsInput == i && arrayInputs != null)
			{
				Array array = Array.CreateInstance(arrayParamsType, arrayInputs.Length);
				for (int j = 0; j <= arrayInputs.Length - 1; j++)
				{
					array.SetValue(arrayInputs[j].value, j);
				}
				callParams[i] = array;
			}
			else if (inputs[i] != null)
			{
				callParams[i] = inputs[i].value;
			}
		}
		instanceObject = ((instanceInput != null) ? instanceInput.value : null);
		resultObject = methodInfo.Invoke(instanceObject, callParams);
	}

	private void RegisterOutput(FlowNode node, bool callable, ParamDef def, int idx)
	{
		node.AddValueOutput(def.portName, def.portId, def.paramType, delegate
		{
			if (!callable)
			{
				Call();
			}
			return callParams[idx];
		});
	}

	private void RegisterInput(FlowNode node, ParamDef def, int idx)
	{
		if (options.exposeParams && arrayParamsInput == idx && def.isParamsArray)
		{
			for (int i = 0; i <= options.exposedParamsCount - 1; i++)
			{
				arrayInputs[i] = node.AddValueInput(def.portName + " #" + i, def.arrayType, def.portId + i);
			}
		}
		else
		{
			inputs[idx] = node.AddValueInput(def.portName, def.paramType, def.portId);
		}
	}

	public override void RegisterPorts(FlowNode node, ReflectedMethodRegistrationOptions options)
	{
		if (options.callable)
		{
			FlowOutput output = node.AddFlowOutput(" ");
			node.AddFlowInput(" ", delegate(Flow flow)
			{
				Call();
				output.Call(flow);
			});
		}
		if (instanceDef.paramMode != ParamMode.Undefined)
		{
			instanceInput = node.AddValueInput(instanceDef.portName, instanceDef.paramType, instanceDef.portId);
			if (options.callable)
			{
				node.AddValueOutput(instanceDef.portName, instanceDef.paramType, () => instanceObject, instanceDef.portId);
			}
		}
		if (resultDef.paramMode != ParamMode.Undefined)
		{
			node.AddValueOutput(resultDef.portName, resultDef.portId, resultDef.paramType, delegate
			{
				if (!options.callable)
				{
					Call();
				}
				return resultObject;
			});
		}
		for (int num = 0; num <= paramDefinitions.Count - 1; num++)
		{
			ParamDef def = paramDefinitions[num];
			if (def.paramMode == ParamMode.Ref)
			{
				RegisterInput(node, def, num);
				RegisterOutput(node, options.callable, def, num);
			}
			else if (def.paramMode == ParamMode.In)
			{
				RegisterInput(node, def, num);
			}
			else if (def.paramMode == ParamMode.Out)
			{
				RegisterOutput(node, options.callable, def, num);
			}
		}
	}
}
