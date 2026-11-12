using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class GamepadAction : IMessage<GamepadAction>, IMessage, IEquatable<GamepadAction>, IDeepCloneable<GamepadAction>
{
	private static readonly MessageParser<GamepadAction> _parser = new MessageParser<GamepadAction>(() => new GamepadAction());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private string id_ = "";

	public const int XboxIconFieldNumber = 2;

	private string xboxIcon_ = "";

	public const int PlayStationIconFieldNumber = 3;

	private string playStationIcon_ = "";

	public const int KeyboardIconFieldNumber = 4;

	private string keyboardIcon_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<GamepadAction> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(376);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public string Id
	{
		get
		{
			return id_;
		}
		set
		{
			id_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string XboxIcon
	{
		get
		{
			return xboxIcon_;
		}
		set
		{
			xboxIcon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string PlayStationIcon
	{
		get
		{
			return playStationIcon_;
		}
		set
		{
			playStationIcon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string KeyboardIcon
	{
		get
		{
			return keyboardIcon_;
		}
		set
		{
			keyboardIcon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public GamepadAction()
	{
	}

	[DebuggerNonUserCode]
	public GamepadAction(GamepadAction other)
		: this()
	{
		id_ = other.id_;
		xboxIcon_ = other.xboxIcon_;
		playStationIcon_ = other.playStationIcon_;
		keyboardIcon_ = other.keyboardIcon_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public GamepadAction Clone()
	{
		return new GamepadAction(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as GamepadAction);
	}

	[DebuggerNonUserCode]
	public bool Equals(GamepadAction other)
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
		if (XboxIcon != other.XboxIcon)
		{
			return false;
		}
		if (PlayStationIcon != other.PlayStationIcon)
		{
			return false;
		}
		if (KeyboardIcon != other.KeyboardIcon)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Id.Length != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (XboxIcon.Length != 0)
		{
			num ^= XboxIcon.GetHashCode();
		}
		if (PlayStationIcon.Length != 0)
		{
			num ^= PlayStationIcon.GetHashCode();
		}
		if (KeyboardIcon.Length != 0)
		{
			num ^= KeyboardIcon.GetHashCode();
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
		if (Id.Length != 0)
		{
			output.WriteRawTag(10);
			output.WriteString(Id);
		}
		if (XboxIcon.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(XboxIcon);
		}
		if (PlayStationIcon.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(PlayStationIcon);
		}
		if (KeyboardIcon.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(KeyboardIcon);
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
		if (Id.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Id);
		}
		if (XboxIcon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(XboxIcon);
		}
		if (PlayStationIcon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PlayStationIcon);
		}
		if (KeyboardIcon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(KeyboardIcon);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(GamepadAction other)
	{
		if (other != null)
		{
			if (other.Id.Length != 0)
			{
				Id = other.Id;
			}
			if (other.XboxIcon.Length != 0)
			{
				XboxIcon = other.XboxIcon;
			}
			if (other.PlayStationIcon.Length != 0)
			{
				PlayStationIcon = other.PlayStationIcon;
			}
			if (other.KeyboardIcon.Length != 0)
			{
				KeyboardIcon = other.KeyboardIcon;
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
			case 10u:
				Id = input.ReadString();
				break;
			case 18u:
				XboxIcon = input.ReadString();
				break;
			case 26u:
				PlayStationIcon = input.ReadString();
				break;
			case 34u:
				KeyboardIcon = input.ReadString();
				break;
			}
		}
	}
}
