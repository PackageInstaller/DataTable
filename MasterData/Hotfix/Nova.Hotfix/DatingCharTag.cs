using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DatingCharTag : IMessage<DatingCharTag>, IMessage, IEquatable<DatingCharTag>, IDeepCloneable<DatingCharTag>
{
	private static readonly MessageParser<DatingCharTag> _parser = new MessageParser<DatingCharTag>(() => new DatingCharTag());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int KrTagFieldNumber = 2;

	private string krTag_ = "";

	public const int CharSetTagFieldNumber = 3;

	private int charSetTag_;

	[DebuggerNonUserCode]
	public static MessageParser<DatingCharTag> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(248);

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
	public string KrTag
	{
		get
		{
			return krTag_;
		}
		set
		{
			krTag_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int CharSetTag
	{
		get
		{
			return charSetTag_;
		}
		set
		{
			charSetTag_ = value;
		}
	}

	[DebuggerNonUserCode]
	public DatingCharTag()
	{
	}

	[DebuggerNonUserCode]
	public DatingCharTag(DatingCharTag other)
		: this()
	{
		id_ = other.id_;
		krTag_ = other.krTag_;
		charSetTag_ = other.charSetTag_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DatingCharTag Clone()
	{
		return new DatingCharTag(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DatingCharTag);
	}

	[DebuggerNonUserCode]
	public bool Equals(DatingCharTag other)
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
		if (KrTag != other.KrTag)
		{
			return false;
		}
		if (CharSetTag != other.CharSetTag)
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
		if (KrTag.Length != 0)
		{
			num ^= KrTag.GetHashCode();
		}
		if (CharSetTag != 0)
		{
			num ^= CharSetTag.GetHashCode();
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
		if (KrTag.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(KrTag);
		}
		if (CharSetTag != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(CharSetTag);
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
		if (KrTag.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(KrTag);
		}
		if (CharSetTag != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CharSetTag);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(DatingCharTag other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.KrTag.Length != 0)
			{
				KrTag = other.KrTag;
			}
			if (other.CharSetTag != 0)
			{
				CharSetTag = other.CharSetTag;
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
			case 18u:
				KrTag = input.ReadString();
				break;
			case 24u:
				CharSetTag = input.ReadInt32();
				break;
			}
		}
	}
}
