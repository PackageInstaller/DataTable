using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class OperationalActivityInfo : IMessage<OperationalActivityInfo>, IMessage, IEquatable<OperationalActivityInfo>, IDeepCloneable<OperationalActivityInfo>, IBufferMessage
{
	private static readonly MessageParser<OperationalActivityInfo> _parser = new MessageParser<OperationalActivityInfo>(() => new OperationalActivityInfo());

	private UnknownFieldSet _unknownFields;

	public const int TimeTpyeFieldNumber = 1;

	private int timeTpye_;

	public const int BeginTimeFieldNumber = 2;

	private int beginTime_;

	public const int TimeLongFieldNumber = 3;

	private int timeLong_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<OperationalActivityInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[240];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int TimeTpye
	{
		get
		{
			return timeTpye_;
		}
		set
		{
			timeTpye_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int BeginTime
	{
		get
		{
			return beginTime_;
		}
		set
		{
			beginTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int TimeLong
	{
		get
		{
			return timeLong_;
		}
		set
		{
			timeLong_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public OperationalActivityInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public OperationalActivityInfo(OperationalActivityInfo other)
		: this()
	{
		timeTpye_ = other.timeTpye_;
		beginTime_ = other.beginTime_;
		timeLong_ = other.timeLong_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public OperationalActivityInfo Clone()
	{
		return new OperationalActivityInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as OperationalActivityInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(OperationalActivityInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (TimeTpye != other.TimeTpye)
		{
			return false;
		}
		if (BeginTime != other.BeginTime)
		{
			return false;
		}
		if (TimeLong != other.TimeLong)
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
		if (TimeTpye != 0)
		{
			num ^= TimeTpye.GetHashCode();
		}
		if (BeginTime != 0)
		{
			num ^= BeginTime.GetHashCode();
		}
		if (TimeLong != 0)
		{
			num ^= TimeLong.GetHashCode();
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
		if (TimeTpye != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(TimeTpye);
		}
		if (BeginTime != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(BeginTime);
		}
		if (TimeLong != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(TimeLong);
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
		if (TimeTpye != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TimeTpye);
		}
		if (BeginTime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BeginTime);
		}
		if (TimeLong != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TimeLong);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(OperationalActivityInfo other)
	{
		if (other != null)
		{
			if (other.TimeTpye != 0)
			{
				TimeTpye = other.TimeTpye;
			}
			if (other.BeginTime != 0)
			{
				BeginTime = other.BeginTime;
			}
			if (other.TimeLong != 0)
			{
				TimeLong = other.TimeLong;
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
				TimeTpye = input.ReadInt32();
				break;
			case 16u:
				BeginTime = input.ReadInt32();
				break;
			case 24u:
				TimeLong = input.ReadInt32();
				break;
			}
		}
	}
}
