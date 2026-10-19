using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class Abysses : IMessage<Abysses>, IMessage, IEquatable<Abysses>, IDeepCloneable<Abysses>, IBufferMessage
{
	private static readonly MessageParser<Abysses> _parser = new MessageParser<Abysses>(() => new Abysses());

	private UnknownFieldSet _unknownFields;

	public const int ValueFieldNumber = 1;

	private static readonly MapField<int, Abyss>.Codec _map_value_codec = new MapField<int, Abyss>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, Abyss.Parser), 10u);

	private readonly MapField<int, Abyss> value_ = new MapField<int, Abyss>();

	public const int CurAbyssIdFieldNumber = 2;

	private int curAbyssId_;

	public const int CurChallengeAbyssIdFieldNumber = 3;

	private int curChallengeAbyssId_;

	public const int OneTimeAbyssIdFieldNumber = 4;

	private int oneTimeAbyssId_;

	public const int LastChallengeAbyssIDFieldNumber = 5;

	private int lastChallengeAbyssID_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Abysses> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[137];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, Abyss> Value => value_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CurAbyssId
	{
		get
		{
			return curAbyssId_;
		}
		set
		{
			curAbyssId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CurChallengeAbyssId
	{
		get
		{
			return curChallengeAbyssId_;
		}
		set
		{
			curChallengeAbyssId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int OneTimeAbyssId
	{
		get
		{
			return oneTimeAbyssId_;
		}
		set
		{
			oneTimeAbyssId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int LastChallengeAbyssID
	{
		get
		{
			return lastChallengeAbyssID_;
		}
		set
		{
			lastChallengeAbyssID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Abysses()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Abysses(Abysses other)
		: this()
	{
		value_ = other.value_.Clone();
		curAbyssId_ = other.curAbyssId_;
		curChallengeAbyssId_ = other.curChallengeAbyssId_;
		oneTimeAbyssId_ = other.oneTimeAbyssId_;
		lastChallengeAbyssID_ = other.lastChallengeAbyssID_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Abysses Clone()
	{
		return new Abysses(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Abysses);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Abysses other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!Value.Equals(other.Value))
		{
			return false;
		}
		if (CurAbyssId != other.CurAbyssId)
		{
			return false;
		}
		if (CurChallengeAbyssId != other.CurChallengeAbyssId)
		{
			return false;
		}
		if (OneTimeAbyssId != other.OneTimeAbyssId)
		{
			return false;
		}
		if (LastChallengeAbyssID != other.LastChallengeAbyssID)
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
		num ^= Value.GetHashCode();
		if (CurAbyssId != 0)
		{
			num ^= CurAbyssId.GetHashCode();
		}
		if (CurChallengeAbyssId != 0)
		{
			num ^= CurChallengeAbyssId.GetHashCode();
		}
		if (OneTimeAbyssId != 0)
		{
			num ^= OneTimeAbyssId.GetHashCode();
		}
		if (LastChallengeAbyssID != 0)
		{
			num ^= LastChallengeAbyssID.GetHashCode();
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
		value_.WriteTo(ref output, _map_value_codec);
		if (CurAbyssId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(CurAbyssId);
		}
		if (CurChallengeAbyssId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(CurChallengeAbyssId);
		}
		if (OneTimeAbyssId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(OneTimeAbyssId);
		}
		if (LastChallengeAbyssID != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(LastChallengeAbyssID);
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
		num += value_.CalculateSize(_map_value_codec);
		if (CurAbyssId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CurAbyssId);
		}
		if (CurChallengeAbyssId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CurChallengeAbyssId);
		}
		if (OneTimeAbyssId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OneTimeAbyssId);
		}
		if (LastChallengeAbyssID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LastChallengeAbyssID);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Abysses other)
	{
		if (other != null)
		{
			value_.Add(other.value_);
			if (other.CurAbyssId != 0)
			{
				CurAbyssId = other.CurAbyssId;
			}
			if (other.CurChallengeAbyssId != 0)
			{
				CurChallengeAbyssId = other.CurChallengeAbyssId;
			}
			if (other.OneTimeAbyssId != 0)
			{
				OneTimeAbyssId = other.OneTimeAbyssId;
			}
			if (other.LastChallengeAbyssID != 0)
			{
				LastChallengeAbyssID = other.LastChallengeAbyssID;
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
			case 10u:
				value_.AddEntriesFrom(ref input, _map_value_codec);
				break;
			case 16u:
				CurAbyssId = input.ReadInt32();
				break;
			case 24u:
				CurChallengeAbyssId = input.ReadInt32();
				break;
			case 32u:
				OneTimeAbyssId = input.ReadInt32();
				break;
			case 40u:
				LastChallengeAbyssID = input.ReadInt32();
				break;
			}
		}
	}
}
