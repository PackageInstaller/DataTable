using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class SystemStatus : IMessage<SystemStatus>, IMessage, IEquatable<SystemStatus>, IDeepCloneable<SystemStatus>, IBufferMessage
{
	private static readonly MessageParser<SystemStatus> _parser = new MessageParser<SystemStatus>(() => new SystemStatus());

	private UnknownFieldSet _unknownFields;

	public const int MainIDFieldNumber = 1;

	private int mainID_;

	public const int SubIDFieldNumber = 2;

	private int subID_;

	public const int DisabledFieldNumber = 3;

	private bool disabled_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<SystemStatus> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[290];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int MainID
	{
		get
		{
			return mainID_;
		}
		set
		{
			mainID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int SubID
	{
		get
		{
			return subID_;
		}
		set
		{
			subID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Disabled
	{
		get
		{
			return disabled_;
		}
		set
		{
			disabled_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SystemStatus()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SystemStatus(SystemStatus other)
		: this()
	{
		mainID_ = other.mainID_;
		subID_ = other.subID_;
		disabled_ = other.disabled_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SystemStatus Clone()
	{
		return new SystemStatus(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as SystemStatus);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(SystemStatus other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (MainID != other.MainID)
		{
			return false;
		}
		if (SubID != other.SubID)
		{
			return false;
		}
		if (Disabled != other.Disabled)
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
		if (MainID != 0)
		{
			num ^= MainID.GetHashCode();
		}
		if (SubID != 0)
		{
			num ^= SubID.GetHashCode();
		}
		if (Disabled)
		{
			num ^= Disabled.GetHashCode();
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
		if (MainID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(MainID);
		}
		if (SubID != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(SubID);
		}
		if (Disabled)
		{
			output.WriteRawTag(24);
			output.WriteBool(Disabled);
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
		if (MainID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MainID);
		}
		if (SubID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SubID);
		}
		if (Disabled)
		{
			num += 2;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(SystemStatus other)
	{
		if (other != null)
		{
			if (other.MainID != 0)
			{
				MainID = other.MainID;
			}
			if (other.SubID != 0)
			{
				SubID = other.SubID;
			}
			if (other.Disabled)
			{
				Disabled = other.Disabled;
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
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				break;
			case 8u:
				MainID = input.ReadInt32();
				break;
			case 16u:
				SubID = input.ReadInt32();
				break;
			case 24u:
				Disabled = input.ReadBool();
				break;
			}
		}
	}
}
