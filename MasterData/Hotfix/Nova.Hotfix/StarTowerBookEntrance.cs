using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StarTowerBookEntrance : IMessage<StarTowerBookEntrance>, IMessage, IEquatable<StarTowerBookEntrance>, IDeepCloneable<StarTowerBookEntrance>
{
	private static readonly MessageParser<StarTowerBookEntrance> _parser = new MessageParser<StarTowerBookEntrance>(() => new StarTowerBookEntrance());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int IconFieldNumber = 2;

	private string icon_ = "";

	public const int PositionFieldNumber = 3;

	private string position_ = "";

	public const int DescFieldNumber = 4;

	private string desc_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<StarTowerBookEntrance> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(818);

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
	public string Icon
	{
		get
		{
			return icon_;
		}
		set
		{
			icon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Position
	{
		get
		{
			return position_;
		}
		set
		{
			position_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Desc
	{
		get
		{
			return desc_;
		}
		set
		{
			desc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public StarTowerBookEntrance()
	{
	}

	[DebuggerNonUserCode]
	public StarTowerBookEntrance(StarTowerBookEntrance other)
		: this()
	{
		id_ = other.id_;
		icon_ = other.icon_;
		position_ = other.position_;
		desc_ = other.desc_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StarTowerBookEntrance Clone()
	{
		return new StarTowerBookEntrance(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StarTowerBookEntrance);
	}

	[DebuggerNonUserCode]
	public bool Equals(StarTowerBookEntrance other)
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
		if (Icon != other.Icon)
		{
			return false;
		}
		if (Position != other.Position)
		{
			return false;
		}
		if (Desc != other.Desc)
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
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (Position.Length != 0)
		{
			num ^= Position.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
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
		if (Icon.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Icon);
		}
		if (Position.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Position);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Desc);
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
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (Position.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Position);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StarTowerBookEntrance other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.Position.Length != 0)
			{
				Position = other.Position;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
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
				Icon = input.ReadString();
				break;
			case 26u:
				Position = input.ReadString();
				break;
			case 34u:
				Desc = input.ReadString();
				break;
			}
		}
	}
}
