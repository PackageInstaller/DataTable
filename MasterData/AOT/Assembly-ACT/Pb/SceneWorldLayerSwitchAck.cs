using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class SceneWorldLayerSwitchAck : IMessage<SceneWorldLayerSwitchAck>, IMessage, IEquatable<SceneWorldLayerSwitchAck>, IDeepCloneable<SceneWorldLayerSwitchAck>, IBufferMessage
{
	private static readonly MessageParser<SceneWorldLayerSwitchAck> _parser = new MessageParser<SceneWorldLayerSwitchAck>(() => new SceneWorldLayerSwitchAck());

	private UnknownFieldSet _unknownFields;

	public const int WorldLayerFieldNumber = 1;

	private SceneWorldLayer worldLayer_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<SceneWorldLayerSwitchAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[114];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneWorldLayer WorldLayer
	{
		get
		{
			return worldLayer_;
		}
		set
		{
			worldLayer_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneWorldLayerSwitchAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneWorldLayerSwitchAck(SceneWorldLayerSwitchAck other)
		: this()
	{
		worldLayer_ = other.worldLayer_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneWorldLayerSwitchAck Clone()
	{
		return new SceneWorldLayerSwitchAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as SceneWorldLayerSwitchAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(SceneWorldLayerSwitchAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (WorldLayer != other.WorldLayer)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override int GetHashCode()
	{
		int num = 1;
		if (WorldLayer != SceneWorldLayer.Surface)
		{
			num ^= WorldLayer.GetHashCode();
		}
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void WriteTo(CodedOutputStream output)
	{
		output.WriteRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalWriteTo(ref WriteContext output)
	{
		if (WorldLayer != SceneWorldLayer.Surface)
		{
			output.WriteRawTag(8);
			output.WriteEnum((int)WorldLayer);
		}
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(ref output);
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CalculateSize()
	{
		int num = 0;
		if (WorldLayer != SceneWorldLayer.Surface)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)WorldLayer);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(SceneWorldLayerSwitchAck other)
	{
		if (other != null)
		{
			if (other.WorldLayer != SceneWorldLayer.Surface)
			{
				WorldLayer = other.WorldLayer;
			}
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CodedInputStream input)
	{
		input.ReadRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalMergeFrom(ref ParseContext input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			if (num != 8)
			{
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
			}
			else
			{
				WorldLayer = (SceneWorldLayer)input.ReadEnum();
			}
		}
	}
}
