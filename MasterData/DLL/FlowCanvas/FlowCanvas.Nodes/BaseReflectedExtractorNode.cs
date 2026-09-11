using System;
using System.Reflection;

namespace FlowCanvas.Nodes;

public abstract class BaseReflectedExtractorNode
{
	protected ParametresDef Params { get; private set; }

	protected Type TargetType { get; private set; }

	protected static event Func<Type, bool, MemberInfo[], BaseReflectedExtractorNode> OnGetAotExtractorNode;

	public static BaseReflectedExtractorNode GetExtractorNode(Type targetType, bool isStatic, MemberInfo[] infos)
	{
		if (!ReflectedNodesHelper.InitParams(targetType, isStatic, infos, out var parametres))
		{
			return null;
		}
		if (OnGetAotExtractorNode != null)
		{
			BaseReflectedExtractorNode baseReflectedExtractorNode = OnGetAotExtractorNode(targetType, isStatic, infos);
			if (baseReflectedExtractorNode != null && baseReflectedExtractorNode.Init(parametres, targetType))
			{
				return baseReflectedExtractorNode;
			}
		}
		PureReflectedExtractorNode pureReflectedExtractorNode = new PureReflectedExtractorNode();
		if (!pureReflectedExtractorNode.Init(parametres, targetType))
		{
			return null;
		}
		return pureReflectedExtractorNode;
	}

	protected bool Init(ParametresDef paramsDef, Type targetType)
	{
		Params = paramsDef;
		TargetType = targetType;
		return InitInternal();
	}

	protected abstract bool InitInternal();

	public abstract void RegisterPorts(FlowNode node);
}
