using System.Collections.Generic;
using System.Reflection;

namespace FlowCanvas.Nodes;

public class PureReflectedExtractorNode : BaseReflectedExtractorNode
{
	private static readonly object[] EmptyParams = new object[0];

	private ValueInput instanceInput;

	protected override bool InitInternal()
	{
		instanceInput = null;
		return true;
	}

	private ValueHandler<object> GetPortHandler(FieldInfo info)
	{
		if (info != null)
		{
			return delegate
			{
				object obj = ((instanceInput != null) ? instanceInput.value : null);
				return info.GetValue(obj);
			};
		}
		return null;
	}

	private ValueHandler<object> GetPortHandler(MethodInfo info)
	{
		if (info != null)
		{
			return delegate
			{
				object obj = ((instanceInput != null) ? instanceInput.value : null);
				return info.Invoke(obj, EmptyParams);
			};
		}
		return null;
	}

	public override void RegisterPorts(FlowNode node)
	{
		instanceInput = null;
		ParamDef instanceDef = base.Params.instanceDef;
		if (instanceDef.paramMode != ParamMode.Undefined)
		{
			instanceInput = node.AddValueInput(instanceDef.portName, instanceDef.paramType, instanceDef.portId);
		}
		List<ParamDef> paramDefinitions = base.Params.paramDefinitions;
		if (paramDefinitions == null)
		{
			return;
		}
		for (int i = 0; i <= paramDefinitions.Count - 1; i++)
		{
			ParamDef paramDef = paramDefinitions[i];
			if (paramDef.paramMode == ParamMode.Out)
			{
				ValueHandler<object> valueHandler = null;
				FieldInfo fieldInfo = paramDef.presentedInfo as FieldInfo;
				if (fieldInfo != null)
				{
					valueHandler = GetPortHandler(fieldInfo);
				}
				MethodInfo methodInfo = paramDef.presentedInfo as MethodInfo;
				if (methodInfo != null)
				{
					valueHandler = GetPortHandler(methodInfo);
				}
				if (valueHandler != null)
				{
					node.AddValueOutput(paramDef.portName, valueHandler, paramDef.portId);
				}
			}
		}
	}
}
