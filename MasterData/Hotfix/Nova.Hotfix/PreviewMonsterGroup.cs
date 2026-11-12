using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class PreviewMonsterGroup : IMessage<PreviewMonsterGroup>, IMessage, IEquatable<PreviewMonsterGroup>, IDeepCloneable<PreviewMonsterGroup>
{
	private static readonly MessageParser<PreviewMonsterGroup> _parser = new MessageParser<PreviewMonsterGroup>(() => new PreviewMonsterGroup());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int MonsterIdsFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_monsterIds_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> monsterIds_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<PreviewMonsterGroup> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(664);

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
	public RepeatedField<int> MonsterIds => monsterIds_;

	[DebuggerNonUserCode]
	public PreviewMonsterGroup()
	{
	}

	[DebuggerNonUserCode]
	public PreviewMonsterGroup(PreviewMonsterGroup other)
		: this()
	{
		id_ = other.id_;
		monsterIds_ = other.monsterIds_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public PreviewMonsterGroup Clone()
	{
		return new PreviewMonsterGroup(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as PreviewMonsterGroup);
	}

	[DebuggerNonUserCode]
	public bool Equals(PreviewMonsterGroup other)
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
		if (!monsterIds_.Equals(other.monsterIds_))
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
		num ^= monsterIds_.GetHashCode();
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
		monsterIds_.WriteTo(output, _repeated_monsterIds_codec);
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
		num += monsterIds_.CalculateSize(_repeated_monsterIds_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(PreviewMonsterGroup other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			monsterIds_.Add(other.monsterIds_);
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
				monsterIds_.AddEntriesFrom(input, _repeated_monsterIds_codec);
				break;
			}
		}
	}
}
