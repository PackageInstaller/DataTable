using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class BattlePassNtf : IMessage<BattlePassNtf>, IMessage, IEquatable<BattlePassNtf>, IDeepCloneable<BattlePassNtf>, IBufferMessage
{
	private static readonly MessageParser<BattlePassNtf> _parser = new MessageParser<BattlePassNtf>(() => new BattlePassNtf());

	private UnknownFieldSet _unknownFields;

	public const int BattlePassInfoFieldNumber = 1;

	private BattlePassDbModel battlePassInfo_;

	public const int BattlePassBeginTimeFieldNumber = 2;

	private long battlePassBeginTime_;

	public const int BattlePassEndTimeFieldNumber = 3;

	private long battlePassEndTime_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<BattlePassNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => BattlepassReflection.Descriptor.MessageTypes[0];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BattlePassDbModel BattlePassInfo
	{
		get
		{
			return battlePassInfo_;
		}
		set
		{
			battlePassInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long BattlePassBeginTime
	{
		get
		{
			return battlePassBeginTime_;
		}
		set
		{
			battlePassBeginTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long BattlePassEndTime
	{
		get
		{
			return battlePassEndTime_;
		}
		set
		{
			battlePassEndTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BattlePassNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BattlePassNtf(BattlePassNtf other)
		: this()
	{
		battlePassInfo_ = ((other.battlePassInfo_ != null) ? other.battlePassInfo_.Clone() : null);
		battlePassBeginTime_ = other.battlePassBeginTime_;
		battlePassEndTime_ = other.battlePassEndTime_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BattlePassNtf Clone()
	{
		return new BattlePassNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as BattlePassNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(BattlePassNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(BattlePassInfo, other.BattlePassInfo))
		{
			return false;
		}
		if (BattlePassBeginTime != other.BattlePassBeginTime)
		{
			return false;
		}
		if (BattlePassEndTime != other.BattlePassEndTime)
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
		if (battlePassInfo_ != null)
		{
			num ^= BattlePassInfo.GetHashCode();
		}
		if (BattlePassBeginTime != 0L)
		{
			num ^= BattlePassBeginTime.GetHashCode();
		}
		if (BattlePassEndTime != 0L)
		{
			num ^= BattlePassEndTime.GetHashCode();
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
		if (battlePassInfo_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(BattlePassInfo);
		}
		if (BattlePassBeginTime != 0L)
		{
			output.WriteRawTag(16);
			output.WriteInt64(BattlePassBeginTime);
		}
		if (BattlePassEndTime != 0L)
		{
			output.WriteRawTag(24);
			output.WriteInt64(BattlePassEndTime);
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
		if (battlePassInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(BattlePassInfo);
		}
		if (BattlePassBeginTime != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(BattlePassBeginTime);
		}
		if (BattlePassEndTime != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(BattlePassEndTime);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(BattlePassNtf other)
	{
		if (other == null)
		{
			return;
		}
		if (other.battlePassInfo_ != null)
		{
			if (battlePassInfo_ == null)
			{
				BattlePassInfo = new BattlePassDbModel();
			}
			BattlePassInfo.MergeFrom(other.BattlePassInfo);
		}
		if (other.BattlePassBeginTime != 0L)
		{
			BattlePassBeginTime = other.BattlePassBeginTime;
		}
		if (other.BattlePassEndTime != 0L)
		{
			BattlePassEndTime = other.BattlePassEndTime;
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
			case 10u:
				if (battlePassInfo_ == null)
				{
					BattlePassInfo = new BattlePassDbModel();
				}
				input.ReadMessage(BattlePassInfo);
				break;
			case 16u:
				BattlePassBeginTime = input.ReadInt64();
				break;
			case 24u:
				BattlePassEndTime = input.ReadInt64();
				break;
			}
		}
	}
}
