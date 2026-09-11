using System;
using System.Reflection;

namespace FlowCanvas.Nodes;

public abstract class BaseReflectedFieldNode
{
	protected FieldInfo fieldInfo;

	protected ParamDef instanceDef;

	protected ParamDef resultDef;

	protected static event Func<FieldInfo, BaseReflectedFieldNode> OnGetAotReflectedFieldNode;

	public static BaseReflectedFieldNode GetFieldNode(FieldInfo targetField)
	{
		if (!ReflectedNodesHelper.InitParams(targetField, out var parametres))
		{
			return null;
		}
		if (OnGetAotReflectedFieldNode != null)
		{
			BaseReflectedFieldNode baseReflectedFieldNode = OnGetAotReflectedFieldNode(targetField);
			if (baseReflectedFieldNode != null && baseReflectedFieldNode.Init(targetField, parametres))
			{
				return baseReflectedFieldNode;
			}
		}
		PureReflectedFieldNode pureReflectedFieldNode = new PureReflectedFieldNode();
		if (!pureReflectedFieldNode.Init(targetField, parametres))
		{
			return null;
		}
		return pureReflectedFieldNode;
	}

	protected bool Init(FieldInfo field, ParametresDef parametres)
	{
		if (field == null || field.FieldType.ContainsGenericParameters || field.FieldType.IsGenericTypeDefinition)
		{
			return false;
		}
		instanceDef = parametres.instanceDef;
		resultDef = parametres.resultDef;
		fieldInfo = field;
		return InitInternal(fieldInfo);
	}

	protected abstract bool InitInternal(FieldInfo field);

	public abstract void RegisterPorts(FlowNode node, ReflectedFieldNodeWrapper.AccessMode accessMode);
}
