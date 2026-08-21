using System;
using System.Collections.Generic;
using System.Reflection;

namespace FlowCanvas.Nodes;

public abstract class BaseReflectedMethodNode
{
	protected MethodInfo methodInfo;

	protected List<ParamDef> paramDefinitions;

	protected ParamDef instanceDef;

	protected ParamDef resultDef;

	protected ReflectedMethodRegistrationOptions options;

	protected static event Func<MethodInfo, BaseReflectedMethodNode> OnGetAotReflectedMethodNode;

	public static BaseReflectedMethodNode GetMethodNode(MethodInfo targetMethod, ReflectedMethodRegistrationOptions options)
	{
		if (!ReflectedNodesHelper.InitParams(targetMethod, out var parametres))
		{
			return null;
		}
		if (OnGetAotReflectedMethodNode != null)
		{
			BaseReflectedMethodNode baseReflectedMethodNode = OnGetAotReflectedMethodNode(targetMethod);
			if (baseReflectedMethodNode != null)
			{
				baseReflectedMethodNode.options = options;
				if (baseReflectedMethodNode.Init(targetMethod, parametres))
				{
					return baseReflectedMethodNode;
				}
			}
		}
		PureReflectedMethodNode pureReflectedMethodNode = new PureReflectedMethodNode();
		pureReflectedMethodNode.options = options;
		if (!pureReflectedMethodNode.Init(targetMethod, parametres))
		{
			return null;
		}
		return pureReflectedMethodNode;
	}

	protected bool Init(MethodInfo method, ParametresDef parametres)
	{
		if (method == null || method.ContainsGenericParameters || method.IsGenericMethodDefinition)
		{
			return false;
		}
		paramDefinitions = ((parametres.paramDefinitions == null) ? new List<ParamDef>() : parametres.paramDefinitions);
		instanceDef = parametres.instanceDef;
		resultDef = parametres.resultDef;
		methodInfo = method;
		return InitInternal(method);
	}

	protected abstract bool InitInternal(MethodInfo method);

	public abstract void RegisterPorts(FlowNode node, ReflectedMethodRegistrationOptions options);
}
