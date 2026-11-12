using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DiscIP : IMessage<DiscIP>, IMessage, IEquatable<DiscIP>, IDeepCloneable<DiscIP>
{
	private static readonly MessageParser<DiscIP> _parser = new MessageParser<DiscIP>(() => new DiscIP());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int VoFileFieldNumber = 2;

	private string voFile_ = "";

	public const int VoBegin1FieldNumber = 3;

	private float voBegin1_;

	public const int VoLoop1FieldNumber = 4;

	private float voLoop1_;

	public const int VoName1FieldNumber = 5;

	private string voName1_ = "";

	public const int VoBegin2FieldNumber = 6;

	private float voBegin2_;

	public const int VoLoop2FieldNumber = 7;

	private float voLoop2_;

	public const int VoName2FieldNumber = 8;

	private string voName2_ = "";

	public const int AvgIdFieldNumber = 9;

	private string avgId_ = "";

	public const int StoryNameFieldNumber = 10;

	private string storyName_ = "";

	public const int StoryDescFieldNumber = 11;

	private string storyDesc_ = "";

	public const int CharIdFieldNumber = 12;

	private static readonly FieldCodec<int> _repeated_charId_codec = FieldCodec.ForInt32(98u);

	private readonly RepeatedField<int> charId_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<DiscIP> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(276);

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
	public string VoFile
	{
		get
		{
			return voFile_;
		}
		set
		{
			voFile_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public float VoBegin1
	{
		get
		{
			return voBegin1_;
		}
		set
		{
			voBegin1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float VoLoop1
	{
		get
		{
			return voLoop1_;
		}
		set
		{
			voLoop1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string VoName1
	{
		get
		{
			return voName1_;
		}
		set
		{
			voName1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public float VoBegin2
	{
		get
		{
			return voBegin2_;
		}
		set
		{
			voBegin2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float VoLoop2
	{
		get
		{
			return voLoop2_;
		}
		set
		{
			voLoop2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string VoName2
	{
		get
		{
			return voName2_;
		}
		set
		{
			voName2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string AvgId
	{
		get
		{
			return avgId_;
		}
		set
		{
			avgId_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string StoryName
	{
		get
		{
			return storyName_;
		}
		set
		{
			storyName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string StoryDesc
	{
		get
		{
			return storyDesc_;
		}
		set
		{
			storyDesc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> CharId => charId_;

	[DebuggerNonUserCode]
	public DiscIP()
	{
	}

	[DebuggerNonUserCode]
	public DiscIP(DiscIP other)
		: this()
	{
		id_ = other.id_;
		voFile_ = other.voFile_;
		voBegin1_ = other.voBegin1_;
		voLoop1_ = other.voLoop1_;
		voName1_ = other.voName1_;
		voBegin2_ = other.voBegin2_;
		voLoop2_ = other.voLoop2_;
		voName2_ = other.voName2_;
		avgId_ = other.avgId_;
		storyName_ = other.storyName_;
		storyDesc_ = other.storyDesc_;
		charId_ = other.charId_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DiscIP Clone()
	{
		return new DiscIP(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DiscIP);
	}

	[DebuggerNonUserCode]
	public bool Equals(DiscIP other)
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
		if (VoFile != other.VoFile)
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(VoBegin1, other.VoBegin1))
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(VoLoop1, other.VoLoop1))
		{
			return false;
		}
		if (VoName1 != other.VoName1)
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(VoBegin2, other.VoBegin2))
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(VoLoop2, other.VoLoop2))
		{
			return false;
		}
		if (VoName2 != other.VoName2)
		{
			return false;
		}
		if (AvgId != other.AvgId)
		{
			return false;
		}
		if (StoryName != other.StoryName)
		{
			return false;
		}
		if (StoryDesc != other.StoryDesc)
		{
			return false;
		}
		if (!charId_.Equals(other.charId_))
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
		if (VoFile.Length != 0)
		{
			num ^= VoFile.GetHashCode();
		}
		if (VoBegin1 != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(VoBegin1);
		}
		if (VoLoop1 != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(VoLoop1);
		}
		if (VoName1.Length != 0)
		{
			num ^= VoName1.GetHashCode();
		}
		if (VoBegin2 != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(VoBegin2);
		}
		if (VoLoop2 != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(VoLoop2);
		}
		if (VoName2.Length != 0)
		{
			num ^= VoName2.GetHashCode();
		}
		if (AvgId.Length != 0)
		{
			num ^= AvgId.GetHashCode();
		}
		if (StoryName.Length != 0)
		{
			num ^= StoryName.GetHashCode();
		}
		if (StoryDesc.Length != 0)
		{
			num ^= StoryDesc.GetHashCode();
		}
		num ^= charId_.GetHashCode();
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
		if (VoFile.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(VoFile);
		}
		if (VoBegin1 != 0f)
		{
			output.WriteRawTag(29);
			output.WriteFloat(VoBegin1);
		}
		if (VoLoop1 != 0f)
		{
			output.WriteRawTag(37);
			output.WriteFloat(VoLoop1);
		}
		if (VoName1.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(VoName1);
		}
		if (VoBegin2 != 0f)
		{
			output.WriteRawTag(53);
			output.WriteFloat(VoBegin2);
		}
		if (VoLoop2 != 0f)
		{
			output.WriteRawTag(61);
			output.WriteFloat(VoLoop2);
		}
		if (VoName2.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(VoName2);
		}
		if (AvgId.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(AvgId);
		}
		if (StoryName.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(StoryName);
		}
		if (StoryDesc.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(StoryDesc);
		}
		charId_.WriteTo(output, _repeated_charId_codec);
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
		if (VoFile.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(VoFile);
		}
		if (VoBegin1 != 0f)
		{
			num += 5;
		}
		if (VoLoop1 != 0f)
		{
			num += 5;
		}
		if (VoName1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(VoName1);
		}
		if (VoBegin2 != 0f)
		{
			num += 5;
		}
		if (VoLoop2 != 0f)
		{
			num += 5;
		}
		if (VoName2.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(VoName2);
		}
		if (AvgId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AvgId);
		}
		if (StoryName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(StoryName);
		}
		if (StoryDesc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(StoryDesc);
		}
		num += charId_.CalculateSize(_repeated_charId_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(DiscIP other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.VoFile.Length != 0)
			{
				VoFile = other.VoFile;
			}
			if (other.VoBegin1 != 0f)
			{
				VoBegin1 = other.VoBegin1;
			}
			if (other.VoLoop1 != 0f)
			{
				VoLoop1 = other.VoLoop1;
			}
			if (other.VoName1.Length != 0)
			{
				VoName1 = other.VoName1;
			}
			if (other.VoBegin2 != 0f)
			{
				VoBegin2 = other.VoBegin2;
			}
			if (other.VoLoop2 != 0f)
			{
				VoLoop2 = other.VoLoop2;
			}
			if (other.VoName2.Length != 0)
			{
				VoName2 = other.VoName2;
			}
			if (other.AvgId.Length != 0)
			{
				AvgId = other.AvgId;
			}
			if (other.StoryName.Length != 0)
			{
				StoryName = other.StoryName;
			}
			if (other.StoryDesc.Length != 0)
			{
				StoryDesc = other.StoryDesc;
			}
			charId_.Add(other.charId_);
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
				VoFile = input.ReadString();
				break;
			case 29u:
				VoBegin1 = input.ReadFloat();
				break;
			case 37u:
				VoLoop1 = input.ReadFloat();
				break;
			case 42u:
				VoName1 = input.ReadString();
				break;
			case 53u:
				VoBegin2 = input.ReadFloat();
				break;
			case 61u:
				VoLoop2 = input.ReadFloat();
				break;
			case 66u:
				VoName2 = input.ReadString();
				break;
			case 74u:
				AvgId = input.ReadString();
				break;
			case 82u:
				StoryName = input.ReadString();
				break;
			case 90u:
				StoryDesc = input.ReadString();
				break;
			case 96u:
			case 98u:
				charId_.AddEntriesFrom(input, _repeated_charId_codec);
				break;
			}
		}
	}
}
