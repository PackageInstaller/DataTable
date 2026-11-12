using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ThrowGiftSpecialObstacle : IMessage<ThrowGiftSpecialObstacle>, IMessage, IEquatable<ThrowGiftSpecialObstacle>, IDeepCloneable<ThrowGiftSpecialObstacle>
{
	private static readonly MessageParser<ThrowGiftSpecialObstacle> _parser = new MessageParser<ThrowGiftSpecialObstacle>(() => new ThrowGiftSpecialObstacle());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TypeFieldNumber = 2;

	private int type_;

	public const int ParamFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_param_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> param_ = new RepeatedField<int>();

	public const int ResetFieldNumber = 4;

	private bool reset_;

	[DebuggerNonUserCode]
	public static MessageParser<ThrowGiftSpecialObstacle> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(938);

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
	public int Type
	{
		get
		{
			return type_;
		}
		set
		{
			type_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Param => param_;

	[DebuggerNonUserCode]
	public bool Reset
	{
		get
		{
			return reset_;
		}
		set
		{
			reset_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ThrowGiftSpecialObstacle()
	{
	}

	[DebuggerNonUserCode]
	public ThrowGiftSpecialObstacle(ThrowGiftSpecialObstacle other)
		: this()
	{
		id_ = other.id_;
		type_ = other.type_;
		param_ = other.param_.Clone();
		reset_ = other.reset_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ThrowGiftSpecialObstacle Clone()
	{
		return new ThrowGiftSpecialObstacle(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ThrowGiftSpecialObstacle);
	}

	[DebuggerNonUserCode]
	public bool Equals(ThrowGiftSpecialObstacle other)
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
		if (Type != other.Type)
		{
			return false;
		}
		if (!param_.Equals(other.param_))
		{
			return false;
		}
		if (Reset != other.Reset)
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
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		num ^= param_.GetHashCode();
		if (Reset)
		{
			num ^= Reset.GetHashCode();
		}
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
		if (Type != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Type);
		}
		param_.WriteTo(output, _repeated_param_codec);
		if (Reset)
		{
			output.WriteRawTag(32);
			output.WriteBool(Reset);
		}
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
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		num += param_.CalculateSize(_repeated_param_codec);
		if (Reset)
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
	public void MergeFrom(ThrowGiftSpecialObstacle other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			param_.Add(other.param_);
			if (other.Reset)
			{
				Reset = other.Reset;
			}
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
				Type = input.ReadInt32();
				break;
			case 24u:
			case 26u:
				param_.AddEntriesFrom(input, _repeated_param_codec);
				break;
			case 32u:
				Reset = input.ReadBool();
				break;
			}
		}
	}
}
