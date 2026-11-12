using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class InteractiveAction : IMessage<InteractiveAction>, IMessage, IEquatable<InteractiveAction>, IDeepCloneable<InteractiveAction>
{
	private static readonly MessageParser<InteractiveAction> _parser = new MessageParser<InteractiveAction>(() => new InteractiveAction());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int PlayerAniFieldNumber = 2;

	private bool playerAni_;

	public const int Icon0FieldNumber = 3;

	private string icon0_ = "";

	public const int Title0FieldNumber = 4;

	private string title0_ = "";

	public const int Icon1FieldNumber = 5;

	private string icon1_ = "";

	public const int Title1FieldNumber = 6;

	private string title1_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<InteractiveAction> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(464);

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
	public bool PlayerAni
	{
		get
		{
			return playerAni_;
		}
		set
		{
			playerAni_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Icon0
	{
		get
		{
			return icon0_;
		}
		set
		{
			icon0_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Title0
	{
		get
		{
			return title0_;
		}
		set
		{
			title0_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Icon1
	{
		get
		{
			return icon1_;
		}
		set
		{
			icon1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Title1
	{
		get
		{
			return title1_;
		}
		set
		{
			title1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public InteractiveAction()
	{
	}

	[DebuggerNonUserCode]
	public InteractiveAction(InteractiveAction other)
		: this()
	{
		id_ = other.id_;
		playerAni_ = other.playerAni_;
		icon0_ = other.icon0_;
		title0_ = other.title0_;
		icon1_ = other.icon1_;
		title1_ = other.title1_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public InteractiveAction Clone()
	{
		return new InteractiveAction(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as InteractiveAction);
	}

	[DebuggerNonUserCode]
	public bool Equals(InteractiveAction other)
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
		if (PlayerAni != other.PlayerAni)
		{
			return false;
		}
		if (Icon0 != other.Icon0)
		{
			return false;
		}
		if (Title0 != other.Title0)
		{
			return false;
		}
		if (Icon1 != other.Icon1)
		{
			return false;
		}
		if (Title1 != other.Title1)
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
		if (PlayerAni)
		{
			num ^= PlayerAni.GetHashCode();
		}
		if (Icon0.Length != 0)
		{
			num ^= Icon0.GetHashCode();
		}
		if (Title0.Length != 0)
		{
			num ^= Title0.GetHashCode();
		}
		if (Icon1.Length != 0)
		{
			num ^= Icon1.GetHashCode();
		}
		if (Title1.Length != 0)
		{
			num ^= Title1.GetHashCode();
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
		if (PlayerAni)
		{
			output.WriteRawTag(16);
			output.WriteBool(PlayerAni);
		}
		if (Icon0.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Icon0);
		}
		if (Title0.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Title0);
		}
		if (Icon1.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Icon1);
		}
		if (Title1.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Title1);
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
		if (PlayerAni)
		{
			num += 2;
		}
		if (Icon0.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon0);
		}
		if (Title0.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title0);
		}
		if (Icon1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon1);
		}
		if (Title1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title1);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(InteractiveAction other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.PlayerAni)
			{
				PlayerAni = other.PlayerAni;
			}
			if (other.Icon0.Length != 0)
			{
				Icon0 = other.Icon0;
			}
			if (other.Title0.Length != 0)
			{
				Title0 = other.Title0;
			}
			if (other.Icon1.Length != 0)
			{
				Icon1 = other.Icon1;
			}
			if (other.Title1.Length != 0)
			{
				Title1 = other.Title1;
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
				PlayerAni = input.ReadBool();
				break;
			case 26u:
				Icon0 = input.ReadString();
				break;
			case 34u:
				Title0 = input.ReadString();
				break;
			case 42u:
				Icon1 = input.ReadString();
				break;
			case 50u:
				Title1 = input.ReadString();
				break;
			}
		}
	}
}
