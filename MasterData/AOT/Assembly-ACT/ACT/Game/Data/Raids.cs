using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class Raids : IMessage<Raids>, IMessage, IEquatable<Raids>, IDeepCloneable<Raids>, IBufferMessage
{
	private static readonly MessageParser<Raids> _parser = new MessageParser<Raids>(() => new Raids());

	private UnknownFieldSet _unknownFields;

	public const int ValuesFieldNumber = 1;

	private static readonly MapField<int, Raid>.Codec _map_values_codec = new MapField<int, Raid>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, Raid.Parser), 10u);

	private readonly MapField<int, Raid> values_ = new MapField<int, Raid>();

	public const int UpdateTSFieldNumber = 4;

	private RaidCycleUpdateTime updateTS_;

	public const int CurChallengeRaidIdFieldNumber = 5;

	private int curChallengeRaidId_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Raids> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[211];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, Raid> Values => values_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RaidCycleUpdateTime UpdateTS
	{
		get
		{
			return updateTS_;
		}
		set
		{
			updateTS_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CurChallengeRaidId
	{
		get
		{
			return curChallengeRaidId_;
		}
		set
		{
			curChallengeRaidId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Raids()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Raids(Raids other)
		: this()
	{
		values_ = other.values_.Clone();
		updateTS_ = ((other.updateTS_ != null) ? other.updateTS_.Clone() : null);
		curChallengeRaidId_ = other.curChallengeRaidId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Raids Clone()
	{
		return new Raids(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Raids);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Raids other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!Values.Equals(other.Values))
		{
			return false;
		}
		if (!object.Equals(UpdateTS, other.UpdateTS))
		{
			return false;
		}
		if (CurChallengeRaidId != other.CurChallengeRaidId)
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
		num ^= Values.GetHashCode();
		if (updateTS_ != null)
		{
			num ^= UpdateTS.GetHashCode();
		}
		if (CurChallengeRaidId != 0)
		{
			num ^= CurChallengeRaidId.GetHashCode();
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
		values_.WriteTo(ref output, _map_values_codec);
		if (updateTS_ != null)
		{
			output.WriteRawTag(34);
			output.WriteMessage(UpdateTS);
		}
		if (CurChallengeRaidId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(CurChallengeRaidId);
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
		num += values_.CalculateSize(_map_values_codec);
		if (updateTS_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(UpdateTS);
		}
		if (CurChallengeRaidId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CurChallengeRaidId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Raids other)
	{
		if (other == null)
		{
			return;
		}
		values_.Add(other.values_);
		if (other.updateTS_ != null)
		{
			if (updateTS_ == null)
			{
				UpdateTS = new RaidCycleUpdateTime();
			}
			UpdateTS.MergeFrom(other.UpdateTS);
		}
		if (other.CurChallengeRaidId != 0)
		{
			CurChallengeRaidId = other.CurChallengeRaidId;
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
				values_.AddEntriesFrom(ref input, _map_values_codec);
				break;
			case 34u:
				if (updateTS_ == null)
				{
					UpdateTS = new RaidCycleUpdateTime();
				}
				input.ReadMessage(UpdateTS);
				break;
			case 40u:
				CurChallengeRaidId = input.ReadInt32();
				break;
			}
		}
	}
}
