using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class IceCreamFever : IMessage<IceCreamFever>, IMessage, IEquatable<IceCreamFever>, IDeepCloneable<IceCreamFever>
{
	private static readonly MessageParser<IceCreamFever> _parser = new MessageParser<IceCreamFever>(() => new IceCreamFever());

	private UnknownFieldSet _unknownFields;

	public const int ComboFieldNumber = 1;

	private int combo_;

	public const int MagnificationFieldNumber = 2;

	private float magnification_;

	public const int IconFieldNumber = 3;

	private string icon_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<IceCreamFever> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(442);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int Combo
	{
		get
		{
			return combo_;
		}
		set
		{
			combo_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float Magnification
	{
		get
		{
			return magnification_;
		}
		set
		{
			magnification_ = value;
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
	public IceCreamFever()
	{
	}

	[DebuggerNonUserCode]
	public IceCreamFever(IceCreamFever other)
		: this()
	{
		combo_ = other.combo_;
		magnification_ = other.magnification_;
		icon_ = other.icon_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public IceCreamFever Clone()
	{
		return new IceCreamFever(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as IceCreamFever);
	}

	[DebuggerNonUserCode]
	public bool Equals(IceCreamFever other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Combo != other.Combo)
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(Magnification, other.Magnification))
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Combo != 0)
		{
			num ^= Combo.GetHashCode();
		}
		if (Magnification != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(Magnification);
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
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
		if (Combo != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Combo);
		}
		if (Magnification != 0f)
		{
			output.WriteRawTag(21);
			output.WriteFloat(Magnification);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Icon);
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
		if (Combo != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Combo);
		}
		if (Magnification != 0f)
		{
			num += 5;
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(IceCreamFever other)
	{
		if (other != null)
		{
			if (other.Combo != 0)
			{
				Combo = other.Combo;
			}
			if (other.Magnification != 0f)
			{
				Magnification = other.Magnification;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
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
				Combo = input.ReadInt32();
				break;
			case 21u:
				Magnification = input.ReadFloat();
				break;
			case 26u:
				Icon = input.ReadString();
				break;
			}
		}
	}
}
