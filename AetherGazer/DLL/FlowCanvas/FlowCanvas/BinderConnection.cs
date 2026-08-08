using System;
using MessagePack;
using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Serialization.FullSerializer;
using ParadoxNotion.Services;
using UnityEngine;

namespace FlowCanvas;

public class BinderConnection<T> : BinderConnection
{
	public override void Bind()
	{
		if (base.isActive)
		{
			DoNormalBinding(base.sourcePort, base.targetPort);
		}
	}

	public override void UnBind()
	{
		if (base.targetPort is ValueInput)
		{
			(base.targetPort as ValueInput).UnBind();
		}
	}

	private void DoNormalBinding(Port source, Port target)
	{
		if (source == null)
		{
			Debug.LogError("Source Graph " + base.graph.name);
		}
		if (target == null)
		{
			Debug.LogError("source.name = " + source.name);
			Debug.LogError("source.parent.name = " + source.parent.name);
			Debug.LogError("Target Graph " + base.graph.name);
		}
		else
		{
			(target as ValueInput<T>).BindTo((ValueOutput)source);
		}
	}
}
public class BinderConnection : Connection
{
	[SerializeField]
	[fsProperty("_sourcePortName")]
	private string _sourcePortID;

	[SerializeField]
	[fsProperty("_targetPortName")]
	private string _targetPortID;

	[NonSerialized]
	private Port _sourcePort;

	[NonSerialized]
	private Port _targetPort;

	public string sourcePortID
	{
		get
		{
			if (sourcePort == null)
			{
				return _sourcePortID;
			}
			return sourcePort.ID;
		}
		private set
		{
			_sourcePortID = value;
		}
	}

	public string targetPortID
	{
		get
		{
			if (targetPort == null)
			{
				return _targetPortID;
			}
			return targetPort.ID;
		}
		private set
		{
			_targetPortID = value;
		}
	}

	public Port sourcePort
	{
		get
		{
			if (_sourcePort == null && base.sourceNode is FlowNode)
			{
				_sourcePort = (base.sourceNode as FlowNode).GetOutputPort(_sourcePortID);
			}
			return _sourcePort;
		}
	}

	public Port targetPort
	{
		get
		{
			if (_targetPort == null && base.targetNode is FlowNode)
			{
				_targetPort = (base.targetNode as FlowNode).GetInputPort(_targetPortID);
			}
			return _targetPort;
		}
	}

	public Type bindingType
	{
		get
		{
			if (!GetType().RTIsGenericType())
			{
				return typeof(Flow);
			}
			return GetType().RTGetGenericArguments()[0];
		}
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		base.OnSerializeHandler(ref writer, options);
		writer.Write(_sourcePortID);
		writer.Write(_targetPortID);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		base.OnDeserializeHandler(ref reader, options);
		_sourcePortID = reader.ReadString();
		_targetPortID = reader.ReadString();
	}

	public static BinderConnection Create(Port source, Port target)
	{
		string text = CanBeBoundVerbosed(source, target);
		if (text != null)
		{
			ParadoxNotion.Services.Logger.LogWarning(text, "Editor", source.parent);
			return null;
		}
		source.parent.graph.RecordUndo("Connect Ports");
		BinderConnection binderConnection = null;
		if (source is FlowOutput && target is FlowInput)
		{
			binderConnection = new BinderConnection();
		}
		if (source is ValueOutput && target is ValueInput)
		{
			binderConnection = (BinderConnection)Activator.CreateInstance(typeof(BinderConnection<>).RTMakeGenericType(target.type));
		}
		if (binderConnection != null)
		{
			binderConnection.SetSource(source, isNew: true);
			binderConnection.SetTarget(target, isNew: true);
			binderConnection.sourcePort.connections++;
			binderConnection.targetPort.connections++;
			binderConnection.sourcePort.parent.OnPortConnected(binderConnection.sourcePort, binderConnection.targetPort);
			binderConnection.targetPort.parent.OnPortConnected(binderConnection.targetPort, binderConnection.sourcePort);
			if (Application.isPlaying)
			{
				binderConnection.Bind();
			}
		}
		return binderConnection;
	}

	public void SetSource(Port newSourcePort)
	{
		SetSource(newSourcePort, isNew: false);
	}

	private void SetSource(Port newSourcePort, bool isNew)
	{
		if (newSourcePort != sourcePort && newSourcePort != null && newSourcePort.IsOutputPort())
		{
			if (sourcePort != null)
			{
				sourcePort.parent.OnPortDisconnected(sourcePort, targetPort);
				sourcePort.connections--;
			}
			sourcePortID = newSourcePort.ID;
			SetSource(newSourcePort.parent);
			if (!isNew)
			{
				sourcePort.parent.OnPortConnected(newSourcePort, targetPort);
				GatherAndValidateSourcePort();
			}
		}
	}

	public void SetTarget(Port newTargetPort)
	{
		SetTarget(newTargetPort, isNew: false);
	}

	private void SetTarget(Port newTargetPort, bool isNew)
	{
		if (newTargetPort != targetPort && newTargetPort != null && newTargetPort.IsInputPort())
		{
			if (targetPort != null)
			{
				targetPort.parent.OnPortDisconnected(targetPort, sourcePort);
				targetPort.connections--;
			}
			targetPortID = newTargetPort.ID;
			SetTarget(newTargetPort.parent);
			if (!isNew)
			{
				targetPort.parent.OnPortConnected(newTargetPort, sourcePort);
				GatherAndValidateTargetPort();
			}
		}
	}

	public void GatherAndValidateSourcePort()
	{
		_sourcePort = null;
		if (targetPort != null && targetPort.type != bindingType && TypeConverter.HasConvertion(sourcePort.type, targetPort.type))
		{
			base.graph.RemoveConnection(this);
			Create(sourcePort, targetPort);
			targetPortID = targetPort.ID;
			targetPort.connections++;
		}
		if (sourcePort != null && TypeConverter.HasConvertion(sourcePort.type, bindingType))
		{
			sourcePortID = sourcePort.ID;
			sourcePort.connections++;
		}
		else if (!(base.sourceNode is IReflectedWrapper reflectedWrapper) || reflectedWrapper.GetMemberInfo() != null)
		{
			base.graph.RemoveConnection(this, recordUndo: false);
			Debug.LogError(base.graph.name + " " + base.targetNode.name + " " + base.sourceNode.name);
		}
	}

	public void GatherAndValidateTargetPort()
	{
		_targetPort = null;
		if (targetPort != null)
		{
			if (targetPort.type == bindingType)
			{
				targetPortID = targetPort.ID;
				targetPort.connections++;
				return;
			}
			if (targetPort is ValueInput && sourcePort is ValueOutput && TypeConverter.HasConvertion(sourcePort.type, targetPort.type))
			{
				base.graph.RemoveConnection(this);
				Create(sourcePort, targetPort);
				targetPortID = targetPort.ID;
				targetPort.connections++;
				return;
			}
			if (targetPort is ValueInput && TypeConverter.HasConvertion(bindingType, targetPort.type))
			{
				return;
			}
		}
		if (!(base.targetNode is IReflectedWrapper reflectedWrapper) || reflectedWrapper.GetMemberInfo() != null)
		{
			base.graph.RemoveConnection(this, recordUndo: false);
		}
	}

	public static bool CanBeBound(Port source, Port target, BinderConnection refConnection = null)
	{
		return CanBeBoundVerbosed(source, target, refConnection) == null;
	}

	public static string CanBeBoundVerbosed(Port source, Port target, BinderConnection refConnection = null)
	{
		if (source == null || target == null)
		{
			return "A port is null.";
		}
		if (source == target)
		{
			return string.Empty;
		}
		if (source.parent == target.parent)
		{
			return "Can't connect ports on the same node.";
		}
		if (source.parent == target.parent)
		{
			return "Can't connect ports on the same parent node.";
		}
		if (source.IsInputPort() && target.IsInputPort())
		{
			return "Can't connect input to input.";
		}
		if (source.IsOutputPort() && target.IsOutputPort())
		{
			return "Can't connect output to output.";
		}
		if (source.IsFlowPort() != target.IsFlowPort())
		{
			return "Flow ports can only be connected to other Flow ports.";
		}
		if ((refConnection == null || refConnection.sourcePort != source) && !source.CanAcceptConnections())
		{
			return "Source port can accept no more out connections.";
		}
		if ((refConnection == null || refConnection.targetPort != target) && !target.CanAcceptConnections())
		{
			return "Target port can accept no more in connections.";
		}
		if (!TypeConverter.HasConvertion(source.type, target.type))
		{
			return $"Can't connect ports. Type '{target.type.FriendlyName()}' is not assignable from Type '{source.type.FriendlyName()}' and there exists no automatic conversion for those types.";
		}
		return null;
	}

	public sealed override void OnDestroy()
	{
		if (sourcePort != null)
		{
			sourcePort.parent.OnPortDisconnected(sourcePort, targetPort);
			sourcePort.connections--;
		}
		if (targetPort != null)
		{
			targetPort.parent.OnPortDisconnected(targetPort, sourcePort);
			targetPort.connections--;
		}
		if (Application.isPlaying)
		{
			UnBind();
		}
	}

	public virtual void Bind()
	{
		if (base.isActive && sourcePort is FlowOutput && targetPort is FlowInput)
		{
			(sourcePort as FlowOutput).BindTo((FlowInput)targetPort);
		}
	}

	public virtual void UnBind()
	{
		if (sourcePort is FlowOutput)
		{
			(sourcePort as FlowOutput).UnBind();
		}
	}

	public virtual void Serialize(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		options.Resolver.GetFormatterWithVerify<BinderConnection>().Serialize(ref writer, this, options);
	}
}
