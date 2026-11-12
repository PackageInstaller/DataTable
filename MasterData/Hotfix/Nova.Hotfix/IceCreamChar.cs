using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class IceCreamChar : IMessage<IceCreamChar>, IMessage, IEquatable<IceCreamChar>, IDeepCloneable<IceCreamChar>
{
	private static readonly MessageParser<IceCreamChar> _parser = new MessageParser<IceCreamChar>(() => new IceCreamChar());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int VoiceHappyFieldNumber = 3;

	private string voiceHappy_ = "";

	public const int VoiceSadFieldNumber = 4;

	private string voiceSad_ = "";

	public const int VoiceAngryFieldNumber = 5;

	private string voiceAngry_ = "";

	public const int CharTypeFieldNumber = 6;

	private int charType_;

	[DebuggerNonUserCode]
	public static MessageParser<IceCreamChar> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(436);

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
	public string VoiceHappy
	{
		get
		{
			return voiceHappy_;
		}
		set
		{
			voiceHappy_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string VoiceSad
	{
		get
		{
			return voiceSad_;
		}
		set
		{
			voiceSad_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string VoiceAngry
	{
		get
		{
			return voiceAngry_;
		}
		set
		{
			voiceAngry_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int CharType
	{
		get
		{
			return charType_;
		}
		set
		{
			charType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public IceCreamChar()
	{
	}

	[DebuggerNonUserCode]
	public IceCreamChar(IceCreamChar other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		voiceHappy_ = other.voiceHappy_;
		voiceSad_ = other.voiceSad_;
		voiceAngry_ = other.voiceAngry_;
		charType_ = other.charType_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public IceCreamChar Clone()
	{
		return new IceCreamChar(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as IceCreamChar);
	}

	[DebuggerNonUserCode]
	public bool Equals(IceCreamChar other)
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
		if (VoiceHappy != other.VoiceHappy)
		{
			return false;
		}
		if (VoiceSad != other.VoiceSad)
		{
			return false;
		}
		if (VoiceAngry != other.VoiceAngry)
		{
			return false;
		}
		if (CharType != other.CharType)
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
		if (VoiceHappy.Length != 0)
		{
			num ^= VoiceHappy.GetHashCode();
		}
		if (VoiceSad.Length != 0)
		{
			num ^= VoiceSad.GetHashCode();
		}
		if (VoiceAngry.Length != 0)
		{
			num ^= VoiceAngry.GetHashCode();
		}
		if (CharType != 0)
		{
			num ^= CharType.GetHashCode();
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
		if (VoiceHappy.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(VoiceHappy);
		}
		if (VoiceSad.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(VoiceSad);
		}
		if (VoiceAngry.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(VoiceAngry);
		}
		if (CharType != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(CharType);
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
		if (VoiceHappy.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(VoiceHappy);
		}
		if (VoiceSad.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(VoiceSad);
		}
		if (VoiceAngry.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(VoiceAngry);
		}
		if (CharType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CharType);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(IceCreamChar other)
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
			if (other.VoiceHappy.Length != 0)
			{
				VoiceHappy = other.VoiceHappy;
			}
			if (other.VoiceSad.Length != 0)
			{
				VoiceSad = other.VoiceSad;
			}
			if (other.VoiceAngry.Length != 0)
			{
				VoiceAngry = other.VoiceAngry;
			}
			if (other.CharType != 0)
			{
				CharType = other.CharType;
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
				VoiceHappy = input.ReadString();
				break;
			case 34u:
				VoiceSad = input.ReadString();
				break;
			case 42u:
				VoiceAngry = input.ReadString();
				break;
			case 48u:
				CharType = input.ReadInt32();
				break;
			}
		}
	}
}
