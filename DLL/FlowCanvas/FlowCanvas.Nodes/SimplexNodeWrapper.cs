using System;
using MessagePack;
using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[DoNotList]
[Icon("", false, "GetRuntimeIconType")]
public class SimplexNodeWrapper<T> : FlowNode where T : SimplexNode
{
	[SerializeField]
	private T _simplexNode;

	private T simplexNode
	{
		get
		{
			if (_simplexNode == null)
			{
				_simplexNode = (T)Activator.CreateInstance(typeof(T));
				if (_simplexNode != null)
				{
					GatherPorts();
				}
			}
			return _simplexNode;
		}
	}

	public override string name
	{
		get
		{
			if (simplexNode == null)
			{
				return "NULL";
			}
			return simplexNode.name;
		}
	}

	public override string description
	{
		get
		{
			if (simplexNode == null)
			{
				return "NULL";
			}
			return simplexNode.description;
		}
	}

	private Type GetRuntimeIconType()
	{
		return typeof(T);
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		base.OnSerializeHandler(ref writer, options);
		_simplexNode.OnSerializeHandler(ref writer, options);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		base.OnDeserializeHandler(ref reader, options);
		simplexNode.OnDeserializeHandler(ref reader, options);
	}

	public override Type GetNodeWildDefinitionType()
	{
		return typeof(T).GetFirstGenericParameterConstraintType();
	}

	public override void OnCreate(Graph assignedGraph)
	{
		if (simplexNode != null)
		{
			simplexNode.SetDefaultParameters(this);
		}
	}

	public override void OnGraphStarted()
	{
		if (simplexNode != null)
		{
			simplexNode.OnGraphStarted();
		}
	}

	public override void OnGraphPaused()
	{
		if (simplexNode != null)
		{
			simplexNode.OnGraphPaused();
		}
	}

	public override void OnGraphUnpaused()
	{
		if (simplexNode != null)
		{
			simplexNode.OnGraphUnpaused();
		}
	}

	public override void OnGraphStoped()
	{
		if (simplexNode != null)
		{
			simplexNode.OnGraphStoped();
		}
	}

	protected override void RegisterPorts()
	{
		if (simplexNode != null)
		{
			simplexNode.RegisterPorts(this);
		}
	}
}
