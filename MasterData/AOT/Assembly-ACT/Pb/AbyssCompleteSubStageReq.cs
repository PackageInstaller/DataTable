using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class AbyssCompleteSubStageReq : IMessage<AbyssCompleteSubStageReq>, IMessage, IEquatable<AbyssCompleteSubStageReq>, IDeepCloneable<AbyssCompleteSubStageReq>, IBufferMessage
{
	private static readonly MessageParser<AbyssCompleteSubStageReq> _parser = new MessageParser<AbyssCompleteSubStageReq>(() => new AbyssCompleteSubStageReq());

	private UnknownFieldSet _unknownFields;

	public const int UseSecondsFieldNumber = 1;

	private int useSeconds_;

	public const int SettleInfoFieldNumber = 2;

	private StageSettleInfo settleInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<AbyssCompleteSubStageReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => AbyssReflection.Descriptor.MessageTypes[2];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int UseSeconds
	{
		get
		{
			return useSeconds_;
		}
		set
		{
			useSeconds_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public StageSettleInfo SettleInfo
	{
		get
		{
			return settleInfo_;
		}
		set
		{
			settleInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AbyssCompleteSubStageReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AbyssCompleteSubStageReq(AbyssCompleteSubStageReq other)
		: this()
	{
		useSeconds_ = other.useSeconds_;
		settleInfo_ = ((other.settleInfo_ != null) ? other.settleInfo_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AbyssCompleteSubStageReq Clone()
	{
		return new AbyssCompleteSubStageReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as AbyssCompleteSubStageReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(AbyssCompleteSubStageReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (UseSeconds != other.UseSeconds)
		{
			return false;
		}
		if (!object.Equals(SettleInfo, other.SettleInfo))
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
		if (UseSeconds != 0)
		{
			num ^= UseSeconds.GetHashCode();
		}
		if (settleInfo_ != null)
		{
			num ^= SettleInfo.GetHashCode();
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
		if (UseSeconds != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(UseSeconds);
		}
		if (settleInfo_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(SettleInfo);
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
		if (UseSeconds != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UseSeconds);
		}
		if (settleInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(SettleInfo);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(AbyssCompleteSubStageReq other)
	{
		if (other == null)
		{
			return;
		}
		if (other.UseSeconds != 0)
		{
			UseSeconds = other.UseSeconds;
		}
		if (other.settleInfo_ != null)
		{
			if (settleInfo_ == null)
			{
				SettleInfo = new StageSettleInfo();
			}
			SettleInfo.MergeFrom(other.SettleInfo);
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
				UseSeconds = input.ReadInt32();
				break;
			case 18u:
				if (settleInfo_ == null)
				{
					SettleInfo = new StageSettleInfo();
				}
				input.ReadMessage(SettleInfo);
				break;
			}
		}
	}
}
