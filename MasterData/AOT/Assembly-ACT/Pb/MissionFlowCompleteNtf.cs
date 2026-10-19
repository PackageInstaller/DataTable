using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class MissionFlowCompleteNtf : IMessage<MissionFlowCompleteNtf>, IMessage, IEquatable<MissionFlowCompleteNtf>, IDeepCloneable<MissionFlowCompleteNtf>, IBufferMessage
{
	private static readonly MessageParser<MissionFlowCompleteNtf> _parser = new MessageParser<MissionFlowCompleteNtf>(() => new MissionFlowCompleteNtf());

	private UnknownFieldSet _unknownFields;

	public const int MissionIDFieldNumber = 1;

	private long missionID_;

	public const int FlowFieldNumber = 2;

	private MissionFlow flow_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MissionFlowCompleteNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => MissionReflection.Descriptor.MessageTypes[20];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long MissionID
	{
		get
		{
			return missionID_;
		}
		set
		{
			missionID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionFlow Flow
	{
		get
		{
			return flow_;
		}
		set
		{
			flow_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionFlowCompleteNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionFlowCompleteNtf(MissionFlowCompleteNtf other)
		: this()
	{
		missionID_ = other.missionID_;
		flow_ = ((other.flow_ != null) ? other.flow_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MissionFlowCompleteNtf Clone()
	{
		return new MissionFlowCompleteNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MissionFlowCompleteNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MissionFlowCompleteNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (MissionID != other.MissionID)
		{
			return false;
		}
		if (!object.Equals(Flow, other.Flow))
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
		if (MissionID != 0L)
		{
			num ^= MissionID.GetHashCode();
		}
		if (flow_ != null)
		{
			num ^= Flow.GetHashCode();
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
		if (MissionID != 0L)
		{
			output.WriteRawTag(8);
			output.WriteInt64(MissionID);
		}
		if (flow_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(Flow);
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
		if (MissionID != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(MissionID);
		}
		if (flow_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Flow);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MissionFlowCompleteNtf other)
	{
		if (other == null)
		{
			return;
		}
		if (other.MissionID != 0L)
		{
			MissionID = other.MissionID;
		}
		if (other.flow_ != null)
		{
			if (flow_ == null)
			{
				Flow = new MissionFlow();
			}
			Flow.MergeFrom(other.Flow);
		}
		_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
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
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				break;
			case 8u:
				MissionID = input.ReadInt64();
				break;
			case 18u:
				if (flow_ == null)
				{
					Flow = new MissionFlow();
				}
				input.ReadMessage(Flow);
				break;
			}
		}
	}
}
