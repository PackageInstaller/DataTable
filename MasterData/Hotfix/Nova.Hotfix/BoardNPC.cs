using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class BoardNPC : IMessage<BoardNPC>, IMessage, IEquatable<BoardNPC>, IDeepCloneable<BoardNPC>
{
	private static readonly MessageParser<BoardNPC> _parser = new MessageParser<BoardNPC>(() => new BoardNPC());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int AliasFieldNumber = 3;

	private string alias_ = "";

	public const int DefaultSkinIdFieldNumber = 4;

	private int defaultSkinId_;

	[DebuggerNonUserCode]
	public static MessageParser<BoardNPC> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(130);

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
	public string Name
	{
		get
		{
			return name_;
		}
		set
		{
			name_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Alias
	{
		get
		{
			return alias_;
		}
		set
		{
			alias_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int DefaultSkinId
	{
		get
		{
			return defaultSkinId_;
		}
		set
		{
			defaultSkinId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public BoardNPC()
	{
	}

	[DebuggerNonUserCode]
	public BoardNPC(BoardNPC other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		alias_ = other.alias_;
		defaultSkinId_ = other.defaultSkinId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public BoardNPC Clone()
	{
		return new BoardNPC(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as BoardNPC);
	}

	[DebuggerNonUserCode]
	public bool Equals(BoardNPC other)
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
		if (Name != other.Name)
		{
			return false;
		}
		if (Alias != other.Alias)
		{
			return false;
		}
		if (DefaultSkinId != other.DefaultSkinId)
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
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Alias.Length != 0)
		{
			num ^= Alias.GetHashCode();
		}
		if (DefaultSkinId != 0)
		{
			num ^= DefaultSkinId.GetHashCode();
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
		if (Name.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Name);
		}
		if (Alias.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Alias);
		}
		if (DefaultSkinId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(DefaultSkinId);
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
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Alias.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Alias);
		}
		if (DefaultSkinId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DefaultSkinId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(BoardNPC other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Alias.Length != 0)
			{
				Alias = other.Alias;
			}
			if (other.DefaultSkinId != 0)
			{
				DefaultSkinId = other.DefaultSkinId;
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
				Name = input.ReadString();
				break;
			case 26u:
				Alias = input.ReadString();
				break;
			case 32u:
				DefaultSkinId = input.ReadInt32();
				break;
			}
		}
	}
}
