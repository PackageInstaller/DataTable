using System;
using System.Linq;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas;

[SpoofAOT]
public abstract class Port
{
	public FlowNode parent { get; set; }

	public string ID { get; set; }

	public string name { get; set; }

	public int connections { get; set; }

	public bool isConnected => connections > 0;

	public abstract Type type { get; }

	public Port()
	{
	}

	public Port(FlowNode parent, string name, string ID)
	{
		this.parent = parent;
		this.name = name;
		this.ID = ID;
	}

	public bool CanAcceptConnections()
	{
		if (this is ValueOutput || (this is FlowOutput && !isConnected))
		{
			return true;
		}
		if (this is FlowInput || (this is ValueInput && !isConnected))
		{
			return true;
		}
		return false;
	}

	public BinderConnection[] GetPortConnections()
	{
		if (IsInputPort())
		{
			return (from c in parent.inConnections.OfType<BinderConnection>()
				where c.targetPort == this
				select c).ToArray();
		}
		return (from c in parent.outConnections.OfType<BinderConnection>()
			where c.sourcePort == this
			select c).ToArray();
	}

	public BinderConnection GetFirstInputConnection()
	{
		return parent.inConnections.OfType<BinderConnection>().FirstOrDefault((BinderConnection c) => c.targetPort == this);
	}

	public BinderConnection GetFirstOutputConnection()
	{
		return parent.outConnections.OfType<BinderConnection>().FirstOrDefault((BinderConnection c) => c.sourcePort == this);
	}

	public bool IsFlowPort()
	{
		if (!(this is FlowInput))
		{
			return this is FlowOutput;
		}
		return true;
	}

	public bool IsValuePort()
	{
		if (!(this is ValueInput))
		{
			return this is ValueOutput;
		}
		return true;
	}

	public bool IsInputPort()
	{
		if (!(this is FlowInput))
		{
			return this is ValueInput;
		}
		return true;
	}

	public bool IsOutputPort()
	{
		if (!(this is FlowOutput))
		{
			return this is ValueOutput;
		}
		return true;
	}

	public bool IsUnityObject()
	{
		return typeof(UnityEngine.Object).RTIsAssignableFrom(type);
	}

	public bool IsUnitySceneObject()
	{
		if (!typeof(Component).RTIsAssignableFrom(type))
		{
			return type == typeof(GameObject);
		}
		return true;
	}

	public bool IsDelegate()
	{
		return typeof(Delegate).RTIsAssignableFrom(type);
	}

	public bool IsEnumerableCollection()
	{
		return type.IsEnumerableCollection();
	}

	public bool IsWild()
	{
		return type == typeof(Wild);
	}

	public override string ToString()
	{
		return name.SplitCamelCase();
	}
}
