using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class AbyssLeaveReq : IMessage<AbyssLeaveReq>, IMessage, IEquatable<AbyssLeaveReq>, IDeepCloneable<AbyssLeaveReq>, IBufferMessage
{
	private static readonly MessageParser<AbyssLeaveReq> _parser = new MessageParser<AbyssLeaveReq>(() => new AbyssLeaveReq());

	private UnknownFieldSet _unknownFields;

	public const int TmpFieldNumber = 1;

	private bool tmp_;

	public const int SettleInfoFieldNumber = 2;

	private StageSettleInfo settleInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<AbyssLeaveReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => AbyssReflection.Descriptor.MessageTypes[8];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Tmp
	{
		get
		{
			return tmp_;
		}
		set
		{
			tmp_ = value;
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
	public AbyssLeaveReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AbyssLeaveReq(AbyssLeaveReq other)
		: this()
	{
		tmp_ = other.tmp_;
		settleInfo_ = ((other.settleInfo_ != null) ? other.settleInfo_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AbyssLeaveReq Clone()
	{
		return new AbyssLeaveReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as AbyssLeaveReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(AbyssLeaveReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Tmp != other.Tmp)
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
		if (Tmp)
		{
			num ^= Tmp.GetHashCode();
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
		if (Tmp)
		{
			output.WriteRawTag(8);
			output.WriteBool(Tmp);
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
		if (Tmp)
		{
			num += 2;
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
	public void MergeFrom(AbyssLeaveReq other)
	{
		if (other == null)
		{
			return;
		}
		if (other.Tmp)
		{
			Tmp = other.Tmp;
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
				Tmp = input.ReadBool();
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
