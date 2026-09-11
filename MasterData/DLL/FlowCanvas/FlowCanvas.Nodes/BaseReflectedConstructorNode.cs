using System;
using System.Collections.Generic;
using System.Reflection;

namespace FlowCanvas.Nodes;

public abstract class BaseReflectedConstructorNode
{
	protected ConstructorInfo constructorInfo;

	protected List<ParamDef> paramDefinitions;

	protected ParamDef instanceDef;

	protected ParamDef resultDef;

	protected ReflectedMethodRegistrationOptions options;

	protected static event Func<ConstructorInfo, BaseReflectedConstructorNode> OnGetAotReflectedConstructorNode;

	public static BaseReflectedConstructorNode GetConstructorNode(ConstructorInfo targetConstructor, ReflectedMethodRegistrationOptions options)
	{
		if (!ReflectedNodesHelper.InitParams(targetConstructor, out var parametres))
		{
			return null;
		}
		if (OnGetAotReflectedConstructorNode != null)
		{
			BaseReflectedConstructorNode baseReflectedConstructorNode = OnGetAotReflectedConstructorNode(targetConstructor);
			if (baseReflectedConstructorNode != null)
			{
				baseReflectedConstructorNode.options = options;
				if (baseReflectedConstructorNode.Init(targetConstructor, parametres))
				{
					return baseReflectedConstructorNode;
				}
			}
		}
		PureReflectionConstructorNode pureReflectionConstructorNode = new PureReflectionConstructorNode();
		pureReflectionConstructorNode.options = options;
		if (!pureReflectionConstructorNode.Init(targetConstructor, parametres))
		{
			return null;
		}
		return pureReflectionConstructorNode;
	}

	protected bool Init(ConstructorInfo constructor, ParametresDef parametres)
	{
		if (constructor == null || constructor.ContainsGenericParameters || constructor.IsGenericMethodDefinition)
		{
			return false;
		}
		paramDefinitions = ((parametres.paramDefinitions == null) ? new List<ParamDef>() : parametres.paramDefinitions);
		instanceDef = parametres.instanceDef;
		resultDef = parametres.resultDef;
		constructorInfo = constructor;
		return InitInternal(constructor);
	}

	protected abstract bool InitInternal(ConstructorInfo constructor);

	public abstract void RegisterPorts(FlowNode node, ReflectedMethodRegistrationOptions options);
}
