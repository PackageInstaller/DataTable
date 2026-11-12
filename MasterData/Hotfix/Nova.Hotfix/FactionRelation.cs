using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class FactionRelation : IMessage<FactionRelation>, IMessage, IEquatable<FactionRelation>, IDeepCloneable<FactionRelation>
{
	private static readonly MessageParser<FactionRelation> _parser = new MessageParser<FactionRelation>(() => new FactionRelation());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int FactionRelationShipFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_factionRelationShip_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> factionRelationShip_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<FactionRelation> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(348);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int Id
	{
		get
		{
			return id_;
		}
		set
		{
			id_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> FactionRelationShip => factionRelationShip_;

	[DebuggerNonUserCode]
	public FactionRelation()
	{
	}

	[DebuggerNonUserCode]
	public FactionRelation(FactionRelation other)
		: this()
	{
		id_ = other.id_;
		factionRelationShip_ = other.factionRelationShip_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public FactionRelation Clone()
	{
		return new FactionRelation(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as FactionRelation);
	}

	[DebuggerNonUserCode]
	public bool Equals(FactionRelation other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Id != other.Id)
		{
			return false;
		}
		if (!factionRelationShip_.Equals(other.factionRelationShip_))
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		num ^= factionRelationShip_.GetHashCode();
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	public void WriteTo(CodedOutputStream output)
	{
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		factionRelationShip_.WriteTo(output, _repeated_factionRelationShip_codec);
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(output);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		num += factionRelationShip_.CalculateSize(_repeated_factionRelationShip_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(FactionRelation other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			factionRelationShip_.Add(other.factionRelationShip_);
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CodedInputStream input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, input);
				break;
			case 8u:
				Id = input.ReadInt32();
				break;
			case 16u:
			case 18u:
				factionRelationShip_.AddEntriesFrom(input, _repeated_factionRelationShip_codec);
				break;
			}
		}
	}
}
