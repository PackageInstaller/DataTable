using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class CharacterSkinOverlap : IMessage<CharacterSkinOverlap>, IMessage, IEquatable<CharacterSkinOverlap>, IDeepCloneable<CharacterSkinOverlap>
{
	private static readonly MessageParser<CharacterSkinOverlap> _parser = new MessageParser<CharacterSkinOverlap>(() => new CharacterSkinOverlap());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int BreakOutModelShowScaleFieldNumber = 2;

	private int breakOutModelShowScale_;

	public const int BreakOutModelShowFieldNumber = 3;

	private string breakOutModelShow_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<CharacterSkinOverlap> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(170);

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
	public int BreakOutModelShowScale
	{
		get
		{
			return breakOutModelShowScale_;
		}
		set
		{
			breakOutModelShowScale_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string BreakOutModelShow
	{
		get
		{
			return breakOutModelShow_;
		}
		set
		{
			breakOutModelShow_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public CharacterSkinOverlap()
	{
	}

	[DebuggerNonUserCode]
	public CharacterSkinOverlap(CharacterSkinOverlap other)
		: this()
	{
		id_ = other.id_;
		breakOutModelShowScale_ = other.breakOutModelShowScale_;
		breakOutModelShow_ = other.breakOutModelShow_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public CharacterSkinOverlap Clone()
	{
		return new CharacterSkinOverlap(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CharacterSkinOverlap);
	}

	[DebuggerNonUserCode]
	public bool Equals(CharacterSkinOverlap other)
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
		if (BreakOutModelShowScale != other.BreakOutModelShowScale)
		{
			return false;
		}
		if (BreakOutModelShow != other.BreakOutModelShow)
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
		if (BreakOutModelShowScale != 0)
		{
			num ^= BreakOutModelShowScale.GetHashCode();
		}
		if (BreakOutModelShow.Length != 0)
		{
			num ^= BreakOutModelShow.GetHashCode();
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
		if (BreakOutModelShowScale != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(BreakOutModelShowScale);
		}
		if (BreakOutModelShow.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(BreakOutModelShow);
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
		if (BreakOutModelShowScale != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BreakOutModelShowScale);
		}
		if (BreakOutModelShow.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BreakOutModelShow);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CharacterSkinOverlap other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.BreakOutModelShowScale != 0)
			{
				BreakOutModelShowScale = other.BreakOutModelShowScale;
			}
			if (other.BreakOutModelShow.Length != 0)
			{
				BreakOutModelShow = other.BreakOutModelShow;
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
				BreakOutModelShowScale = input.ReadInt32();
				break;
			case 26u:
				BreakOutModelShow = input.ReadString();
				break;
			}
		}
	}
}
