using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class CharGetLines : IMessage<CharGetLines>, IMessage, IEquatable<CharGetLines>, IDeepCloneable<CharGetLines>
{
	private static readonly MessageParser<CharGetLines> _parser = new MessageParser<CharGetLines>(() => new CharGetLines());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int CharacterFieldNumber = 2;

	private int character_;

	public const int TypeFieldNumber = 3;

	private int type_;

	public const int SkinIdFieldNumber = 4;

	private int skinId_;

	public const int VoResourceFieldNumber = 5;

	private string voResource_ = "";

	public const int LinesFieldNumber = 6;

	private string lines_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<CharGetLines> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(200);

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
	public int Character
	{
		get
		{
			return character_;
		}
		set
		{
			character_ = value;
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
	public string VoResource
	{
		get
		{
			return voResource_;
		}
		set
		{
			voResource_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Lines
	{
		get
		{
			return lines_;
		}
		set
		{
			lines_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public CharGetLines()
	{
	}

	[DebuggerNonUserCode]
	public CharGetLines(CharGetLines other)
		: this()
	{
		id_ = other.id_;
		character_ = other.character_;
		type_ = other.type_;
		skinId_ = other.skinId_;
		voResource_ = other.voResource_;
		lines_ = other.lines_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public CharGetLines Clone()
	{
		return new CharGetLines(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CharGetLines);
	}

	[DebuggerNonUserCode]
	public bool Equals(CharGetLines other)
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
		if (Character != other.Character)
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (SkinId != other.SkinId)
		{
			return false;
		}
		if (VoResource != other.VoResource)
		{
			return false;
		}
		if (Lines != other.Lines)
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
		if (Character != 0)
		{
			num ^= Character.GetHashCode();
		}
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (SkinId != 0)
		{
			num ^= SkinId.GetHashCode();
		}
		if (VoResource.Length != 0)
		{
			num ^= VoResource.GetHashCode();
		}
		if (Lines.Length != 0)
		{
			num ^= Lines.GetHashCode();
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
		if (Character != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Character);
		}
		if (Type != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Type);
		}
		if (SkinId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(SkinId);
		}
		if (VoResource.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(VoResource);
		}
		if (Lines.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Lines);
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
		if (Character != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Character);
		}
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (SkinId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SkinId);
		}
		if (VoResource.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(VoResource);
		}
		if (Lines.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Lines);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CharGetLines other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Character != 0)
			{
				Character = other.Character;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.SkinId != 0)
			{
				SkinId = other.SkinId;
			}
			if (other.VoResource.Length != 0)
			{
				VoResource = other.VoResource;
			}
			if (other.Lines.Length != 0)
			{
				Lines = other.Lines;
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
				Character = input.ReadInt32();
				break;
			case 24u:
				Type = input.ReadInt32();
				break;
			case 32u:
				SkinId = input.ReadInt32();
				break;
			case 42u:
				VoResource = input.ReadString();
				break;
			case 50u:
				Lines = input.ReadString();
				break;
			}
		}
	}
}
