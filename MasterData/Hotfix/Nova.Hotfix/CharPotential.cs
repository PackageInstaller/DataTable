using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class CharPotential : IMessage<CharPotential>, IMessage, IEquatable<CharPotential>, IDeepCloneable<CharPotential>
{
	private static readonly MessageParser<CharPotential> _parser = new MessageParser<CharPotential>(() => new CharPotential());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int MasterSpecificPotentialIdsFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_masterSpecificPotentialIds_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> masterSpecificPotentialIds_ = new RepeatedField<int>();

	public const int AssistSpecificPotentialIdsFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_assistSpecificPotentialIds_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> assistSpecificPotentialIds_ = new RepeatedField<int>();

	public const int CommonPotentialIdsFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_commonPotentialIds_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> commonPotentialIds_ = new RepeatedField<int>();

	public const int MasterNormalPotentialIdsFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_masterNormalPotentialIds_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> masterNormalPotentialIds_ = new RepeatedField<int>();

	public const int AssistNormalPotentialIdsFieldNumber = 6;

	private static readonly FieldCodec<int> _repeated_assistNormalPotentialIds_codec = FieldCodec.ForInt32(50u);

	private readonly RepeatedField<int> assistNormalPotentialIds_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<CharPotential> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(206);

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
	public RepeatedField<int> MasterSpecificPotentialIds => masterSpecificPotentialIds_;

	[DebuggerNonUserCode]
	public RepeatedField<int> AssistSpecificPotentialIds => assistSpecificPotentialIds_;

	[DebuggerNonUserCode]
	public RepeatedField<int> CommonPotentialIds => commonPotentialIds_;

	[DebuggerNonUserCode]
	public RepeatedField<int> MasterNormalPotentialIds => masterNormalPotentialIds_;

	[DebuggerNonUserCode]
	public RepeatedField<int> AssistNormalPotentialIds => assistNormalPotentialIds_;

	[DebuggerNonUserCode]
	public CharPotential()
	{
	}

	[DebuggerNonUserCode]
	public CharPotential(CharPotential other)
		: this()
	{
		id_ = other.id_;
		masterSpecificPotentialIds_ = other.masterSpecificPotentialIds_.Clone();
		assistSpecificPotentialIds_ = other.assistSpecificPotentialIds_.Clone();
		commonPotentialIds_ = other.commonPotentialIds_.Clone();
		masterNormalPotentialIds_ = other.masterNormalPotentialIds_.Clone();
		assistNormalPotentialIds_ = other.assistNormalPotentialIds_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public CharPotential Clone()
	{
		return new CharPotential(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CharPotential);
	}

	[DebuggerNonUserCode]
	public bool Equals(CharPotential other)
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
		if (!masterSpecificPotentialIds_.Equals(other.masterSpecificPotentialIds_))
		{
			return false;
		}
		if (!assistSpecificPotentialIds_.Equals(other.assistSpecificPotentialIds_))
		{
			return false;
		}
		if (!commonPotentialIds_.Equals(other.commonPotentialIds_))
		{
			return false;
		}
		if (!masterNormalPotentialIds_.Equals(other.masterNormalPotentialIds_))
		{
			return false;
		}
		if (!assistNormalPotentialIds_.Equals(other.assistNormalPotentialIds_))
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
		num ^= masterSpecificPotentialIds_.GetHashCode();
		num ^= assistSpecificPotentialIds_.GetHashCode();
		num ^= commonPotentialIds_.GetHashCode();
		num ^= masterNormalPotentialIds_.GetHashCode();
		num ^= assistNormalPotentialIds_.GetHashCode();
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
		masterSpecificPotentialIds_.WriteTo(output, _repeated_masterSpecificPotentialIds_codec);
		assistSpecificPotentialIds_.WriteTo(output, _repeated_assistSpecificPotentialIds_codec);
		commonPotentialIds_.WriteTo(output, _repeated_commonPotentialIds_codec);
		masterNormalPotentialIds_.WriteTo(output, _repeated_masterNormalPotentialIds_codec);
		assistNormalPotentialIds_.WriteTo(output, _repeated_assistNormalPotentialIds_codec);
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
		num += masterSpecificPotentialIds_.CalculateSize(_repeated_masterSpecificPotentialIds_codec);
		num += assistSpecificPotentialIds_.CalculateSize(_repeated_assistSpecificPotentialIds_codec);
		num += commonPotentialIds_.CalculateSize(_repeated_commonPotentialIds_codec);
		num += masterNormalPotentialIds_.CalculateSize(_repeated_masterNormalPotentialIds_codec);
		num += assistNormalPotentialIds_.CalculateSize(_repeated_assistNormalPotentialIds_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CharPotential other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			masterSpecificPotentialIds_.Add(other.masterSpecificPotentialIds_);
			assistSpecificPotentialIds_.Add(other.assistSpecificPotentialIds_);
			commonPotentialIds_.Add(other.commonPotentialIds_);
			masterNormalPotentialIds_.Add(other.masterNormalPotentialIds_);
			assistNormalPotentialIds_.Add(other.assistNormalPotentialIds_);
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
				masterSpecificPotentialIds_.AddEntriesFrom(input, _repeated_masterSpecificPotentialIds_codec);
				break;
			case 24u:
			case 26u:
				assistSpecificPotentialIds_.AddEntriesFrom(input, _repeated_assistSpecificPotentialIds_codec);
				break;
			case 32u:
			case 34u:
				commonPotentialIds_.AddEntriesFrom(input, _repeated_commonPotentialIds_codec);
				break;
			case 40u:
			case 42u:
				masterNormalPotentialIds_.AddEntriesFrom(input, _repeated_masterNormalPotentialIds_codec);
				break;
			case 48u:
			case 50u:
				assistNormalPotentialIds_.AddEntriesFrom(input, _repeated_assistNormalPotentialIds_codec);
				break;
			}
		}
	}
}
