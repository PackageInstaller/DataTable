using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class RaidNtf : IMessage<RaidNtf>, IMessage, IEquatable<RaidNtf>, IDeepCloneable<RaidNtf>, IBufferMessage
{
	private static readonly MessageParser<RaidNtf> _parser = new MessageParser<RaidNtf>(() => new RaidNtf());

	private UnknownFieldSet _unknownFields;

	public const int RaidsFieldNumber = 1;

	private static readonly MapField<int, Raid>.Codec _map_raids_codec = new MapField<int, Raid>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, Raid.Parser), 10u);

	private readonly MapField<int, Raid> raids_ = new MapField<int, Raid>();

	public const int ChallengingRaidIdFieldNumber = 2;

	private int challengingRaidId_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<RaidNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => RaidReflection.Descriptor.MessageTypes[14];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, Raid> Raids => raids_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ChallengingRaidId
	{
		get
		{
			return challengingRaidId_;
		}
		set
		{
			challengingRaidId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RaidNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RaidNtf(RaidNtf other)
		: this()
	{
		raids_ = other.raids_.Clone();
		challengingRaidId_ = other.challengingRaidId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RaidNtf Clone()
	{
		return new RaidNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as RaidNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(RaidNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!Raids.Equals(other.Raids))
		{
			return false;
		}
		if (ChallengingRaidId != other.ChallengingRaidId)
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
		num ^= Raids.GetHashCode();
		if (ChallengingRaidId != 0)
		{
			num ^= ChallengingRaidId.GetHashCode();
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
		raids_.WriteTo(ref output, _map_raids_codec);
		if (ChallengingRaidId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ChallengingRaidId);
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
		num += raids_.CalculateSize(_map_raids_codec);
		if (ChallengingRaidId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ChallengingRaidId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(RaidNtf other)
	{
		if (other != null)
		{
			raids_.Add(other.raids_);
			if (other.ChallengingRaidId != 0)
			{
				ChallengingRaidId = other.ChallengingRaidId;
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
				raids_.AddEntriesFrom(ref input, _map_raids_codec);
				break;
			case 16u:
				ChallengingRaidId = input.ReadInt32();
				break;
			}
		}
	}
}
