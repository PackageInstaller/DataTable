using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class TempleArea : IMessage<TempleArea>, IMessage, IEquatable<TempleArea>, IDeepCloneable<TempleArea>, IBufferMessage
{
	private static readonly MessageParser<TempleArea> _parser = new MessageParser<TempleArea>(() => new TempleArea());

	private UnknownFieldSet _unknownFields;

	public const int AreaIdFieldNumber = 1;

	private int areaId_;

	public const int TemplesFieldNumber = 2;

	private static readonly MapField<int, Temple>.Codec _map_temples_codec = new MapField<int, Temple>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, Temple.Parser), 18u);

	private readonly MapField<int, Temple> temples_ = new MapField<int, Temple>();

	public const int TakenStarRewardsFieldNumber = 3;

	private static readonly MapField<int, bool>.Codec _map_takenStarRewards_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 26u);

	private readonly MapField<int, bool> takenStarRewards_ = new MapField<int, bool>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<TempleArea> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[140];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int AreaId
	{
		get
		{
			return areaId_;
		}
		set
		{
			areaId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, Temple> Temples => temples_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> TakenStarRewards => takenStarRewards_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempleArea()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempleArea(TempleArea other)
		: this()
	{
		areaId_ = other.areaId_;
		temples_ = other.temples_.Clone();
		takenStarRewards_ = other.takenStarRewards_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TempleArea Clone()
	{
		return new TempleArea(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as TempleArea);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(TempleArea other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (AreaId != other.AreaId)
		{
			return false;
		}
		if (!Temples.Equals(other.Temples))
		{
			return false;
		}
		if (!TakenStarRewards.Equals(other.TakenStarRewards))
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
		if (AreaId != 0)
		{
			num ^= AreaId.GetHashCode();
		}
		num ^= Temples.GetHashCode();
		num ^= TakenStarRewards.GetHashCode();
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
		if (AreaId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(AreaId);
		}
		temples_.WriteTo(ref output, _map_temples_codec);
		takenStarRewards_.WriteTo(ref output, _map_takenStarRewards_codec);
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
		if (AreaId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AreaId);
		}
		num += temples_.CalculateSize(_map_temples_codec);
		num += takenStarRewards_.CalculateSize(_map_takenStarRewards_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(TempleArea other)
	{
		if (other != null)
		{
			if (other.AreaId != 0)
			{
				AreaId = other.AreaId;
			}
			temples_.Add(other.temples_);
			takenStarRewards_.Add(other.takenStarRewards_);
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
				AreaId = input.ReadInt32();
				break;
			case 18u:
				temples_.AddEntriesFrom(ref input, _map_temples_codec);
				break;
			case 26u:
				takenStarRewards_.AddEntriesFrom(ref input, _map_takenStarRewards_codec);
				break;
			}
		}
	}
}
