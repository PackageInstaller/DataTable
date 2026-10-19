using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class DivinePupil : IMessage<DivinePupil>, IMessage, IEquatable<DivinePupil>, IDeepCloneable<DivinePupil>, IBufferMessage
{
	private static readonly MessageParser<DivinePupil> _parser = new MessageParser<DivinePupil>(() => new DivinePupil());

	private UnknownFieldSet _unknownFields;

	public const int CurLvFieldNumber = 1;

	private int curLv_;

	public const int CurExpFieldNumber = 2;

	private int curExp_;

	public const int ClaimedRewardFieldNumber = 3;

	private bool claimedReward_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<DivinePupil> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[85];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CurLv
	{
		get
		{
			return curLv_;
		}
		set
		{
			curLv_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CurExp
	{
		get
		{
			return curExp_;
		}
		set
		{
			curExp_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool ClaimedReward
	{
		get
		{
			return claimedReward_;
		}
		set
		{
			claimedReward_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DivinePupil()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DivinePupil(DivinePupil other)
		: this()
	{
		curLv_ = other.curLv_;
		curExp_ = other.curExp_;
		claimedReward_ = other.claimedReward_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DivinePupil Clone()
	{
		return new DivinePupil(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as DivinePupil);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(DivinePupil other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (CurLv != other.CurLv)
		{
			return false;
		}
		if (CurExp != other.CurExp)
		{
			return false;
		}
		if (ClaimedReward != other.ClaimedReward)
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
		if (CurLv != 0)
		{
			num ^= CurLv.GetHashCode();
		}
		if (CurExp != 0)
		{
			num ^= CurExp.GetHashCode();
		}
		if (ClaimedReward)
		{
			num ^= ClaimedReward.GetHashCode();
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
		if (CurLv != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(CurLv);
		}
		if (CurExp != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(CurExp);
		}
		if (ClaimedReward)
		{
			output.WriteRawTag(24);
			output.WriteBool(ClaimedReward);
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
		if (CurLv != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CurLv);
		}
		if (CurExp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CurExp);
		}
		if (ClaimedReward)
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
	public void MergeFrom(DivinePupil other)
	{
		if (other != null)
		{
			if (other.CurLv != 0)
			{
				CurLv = other.CurLv;
			}
			if (other.CurExp != 0)
			{
				CurExp = other.CurExp;
			}
			if (other.ClaimedReward)
			{
				ClaimedReward = other.ClaimedReward;
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
				CurLv = input.ReadInt32();
				break;
			case 16u:
				CurExp = input.ReadInt32();
				break;
			case 24u:
				ClaimedReward = input.ReadBool();
				break;
			}
		}
	}
}
