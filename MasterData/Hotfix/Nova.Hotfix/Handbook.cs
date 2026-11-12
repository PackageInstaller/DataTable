using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class Handbook : IMessage<Handbook>, IMessage, IEquatable<Handbook>, IDeepCloneable<Handbook>
{
	private static readonly MessageParser<Handbook> _parser = new MessageParser<Handbook>(() => new Handbook());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int IndexFieldNumber = 2;

	private int index_;

	public const int TypeFieldNumber = 3;

	private int type_;

	public const int CharIdFieldNumber = 4;

	private int charId_;

	public const int SkinIdFieldNumber = 5;

	private int skinId_;

	public const int CondFieldNumber = 6;

	private int cond_;

	[DebuggerNonUserCode]
	public static MessageParser<Handbook> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(420);

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
	public int Index
	{
		get
		{
			return index_;
		}
		set
		{
			index_ = value;
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
	public int CharId
	{
		get
		{
			return charId_;
		}
		set
		{
			charId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SkinId
	{
		get
		{
			return skinId_;
		}
		set
		{
			skinId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Cond
	{
		get
		{
			return cond_;
		}
		set
		{
			cond_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Handbook()
	{
	}

	[DebuggerNonUserCode]
	public Handbook(Handbook other)
		: this()
	{
		id_ = other.id_;
		index_ = other.index_;
		type_ = other.type_;
		charId_ = other.charId_;
		skinId_ = other.skinId_;
		cond_ = other.cond_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public Handbook Clone()
	{
		return new Handbook(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Handbook);
	}

	[DebuggerNonUserCode]
	public bool Equals(Handbook other)
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
		if (Index != other.Index)
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (CharId != other.CharId)
		{
			return false;
		}
		if (SkinId != other.SkinId)
		{
			return false;
		}
		if (Cond != other.Cond)
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
		if (Index != 0)
		{
			num ^= Index.GetHashCode();
		}
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (CharId != 0)
		{
			num ^= CharId.GetHashCode();
		}
		if (SkinId != 0)
		{
			num ^= SkinId.GetHashCode();
		}
		if (Cond != 0)
		{
			num ^= Cond.GetHashCode();
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
		if (Index != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Index);
		}
		if (Type != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Type);
		}
		if (CharId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(CharId);
		}
		if (SkinId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(SkinId);
		}
		if (Cond != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Cond);
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
		if (Index != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Index);
		}
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (CharId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CharId);
		}
		if (SkinId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SkinId);
		}
		if (Cond != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Cond);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Handbook other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Index != 0)
			{
				Index = other.Index;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.CharId != 0)
			{
				CharId = other.CharId;
			}
			if (other.SkinId != 0)
			{
				SkinId = other.SkinId;
			}
			if (other.Cond != 0)
			{
				Cond = other.Cond;
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
				Index = input.ReadInt32();
				break;
			case 24u:
				Type = input.ReadInt32();
				break;
			case 32u:
				CharId = input.ReadInt32();
				break;
			case 40u:
				SkinId = input.ReadInt32();
				break;
			case 48u:
				Cond = input.ReadInt32();
				break;
			}
		}
	}
}
