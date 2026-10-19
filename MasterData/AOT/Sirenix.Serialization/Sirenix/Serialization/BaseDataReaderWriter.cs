using System;
using System.ComponentModel;

namespace Sirenix.Serialization;

public abstract class BaseDataReaderWriter
{
	private NodeInfo[] nodes = new NodeInfo[32];

	private int nodesLength;

	[Obsolete("Use the Binder member on the writer's SerializationContext/DeserializationContext instead.", false)]
	[EditorBrowsable(EditorBrowsableState.Never)]
	public TwoWaySerializationBinder Binder
	{
		get
		{
			if (this is IDataWriter)
			{
				return (this as IDataWriter).Context.Binder;
			}
			if (this is IDataReader)
			{
				return (this as IDataReader).Context.Binder;
			}
			return TwoWaySerializationBinder.Default;
		}
		set
		{
			if (this is IDataWriter)
			{
				(this as IDataWriter).Context.Binder = value;
			}
			else if (this is IDataReader)
			{
				(this as IDataReader).Context.Binder = value;
			}
		}
	}

	public bool IsInArrayNode
	{
		get
		{
			if (nodesLength != 0)
			{
				return nodes[nodesLength - 1].IsArray;
			}
			return false;
		}
	}

	protected int NodeDepth => nodesLength;

	protected NodeInfo[] NodesArray => nodes;

	protected NodeInfo CurrentNode
	{
		get
		{
			if (nodesLength != 0)
			{
				return nodes[nodesLength - 1];
			}
			return NodeInfo.Empty;
		}
	}

	protected void PushNode(NodeInfo node)
	{
		if (nodesLength == nodes.Length)
		{
			ExpandNodes();
		}
		nodes[nodesLength] = node;
		nodesLength++;
	}

	protected void PushNode(string name, int id, Type type)
	{
		if (nodesLength == nodes.Length)
		{
			ExpandNodes();
		}
		nodes[nodesLength] = new NodeInfo(name, id, type, isArray: false);
		nodesLength++;
	}

	protected void PushArray()
	{
		if (nodesLength == nodes.Length)
		{
			ExpandNodes();
		}
		if (nodesLength == 0 || nodes[nodesLength - 1].IsArray)
		{
			nodes[nodesLength] = new NodeInfo(null, -1, null, isArray: true);
		}
		else
		{
			NodeInfo nodeInfo = nodes[nodesLength - 1];
			nodes[nodesLength] = new NodeInfo(nodeInfo.Name, nodeInfo.Id, nodeInfo.Type, isArray: true);
		}
		nodesLength++;
	}

	private void ExpandNodes()
	{
		NodeInfo[] array = new NodeInfo[nodes.Length * 2];
		NodeInfo[] array2 = nodes;
		for (int i = 0; i < array2.Length; i++)
		{
			array[i] = array2[i];
		}
		nodes = array;
	}

	protected void PopNode(string name)
	{
		if (nodesLength == 0)
		{
			throw new InvalidOperationException("There are no nodes to pop.");
		}
		nodesLength--;
	}

	protected void PopArray()
	{
		if (nodesLength == 0)
		{
			throw new InvalidOperationException("There are no nodes to pop.");
		}
		if (!nodes[nodesLength - 1].IsArray)
		{
			throw new InvalidOperationException("Was not in array when exiting array.");
		}
		nodesLength--;
	}

	protected void ClearNodes()
	{
		nodesLength = 0;
	}
}
