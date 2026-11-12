using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class MathParkourItemGroup : IMessage<MathParkourItemGroup>, IMessage, IEquatable<MathParkourItemGroup>, IDeepCloneable<MathParkourItemGroup>
{
	private static readonly MessageParser<MathParkourItemGroup> _parser = new MessageParser<MathParkourItemGroup>(() => new MathParkourItemGroup());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ObjectListFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_objectList_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> objectList_ = new RepeatedField<int>();

	public const int ObjWeightListFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_objWeightList_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> objWeightList_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<MathParkourItemGroup> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(540);

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
	public RepeatedField<int> ObjectList => objectList_;

	[DebuggerNonUserCode]
	public RepeatedField<int> ObjWeightList => objWeightList_;

	[DebuggerNonUserCode]
	public MathParkourItemGroup()
	{
	}

	[DebuggerNonUserCode]
	public MathParkourItemGroup(MathParkourItemGroup other)
		: this()
	{
		id_ = other.id_;
		objectList_ = other.objectList_.Clone();
		objWeightList_ = other.objWeightList_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public MathParkourItemGroup Clone()
	{
		return new MathParkourItemGroup(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MathParkourItemGroup);
	}

	[DebuggerNonUserCode]
	public bool Equals(MathParkourItemGroup other)
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
		if (!objectList_.Equals(other.objectList_))
		{
			return false;
		}
		if (!objWeightList_.Equals(other.objWeightList_))
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
		num ^= objectList_.GetHashCode();
		num ^= objWeightList_.GetHashCode();
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
		objectList_.WriteTo(output, _repeated_objectList_codec);
		objWeightList_.WriteTo(output, _repeated_objWeightList_codec);
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
		num += objectList_.CalculateSize(_repeated_objectList_codec);
		num += objWeightList_.CalculateSize(_repeated_objWeightList_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MathParkourItemGroup other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			objectList_.Add(other.objectList_);
			objWeightList_.Add(other.objWeightList_);
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
				objectList_.AddEntriesFrom(input, _repeated_objectList_codec);
				break;
			case 24u:
			case 26u:
				objWeightList_.AddEntriesFrom(input, _repeated_objWeightList_codec);
				break;
			}
		}
	}
}
