using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SubNoteSkill : IMessage<SubNoteSkill>, IMessage, IEquatable<SubNoteSkill>, IDeepCloneable<SubNoteSkill>
{
	private static readonly MessageParser<SubNoteSkill> _parser = new MessageParser<SubNoteSkill>(() => new SubNoteSkill());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ScoresFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_scores_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> scores_ = new RepeatedField<int>();

	public const int EffectIdFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_effectId_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> effectId_ = new RepeatedField<int>();

	public const int NameFieldNumber = 4;

	private string name_ = "";

	public const int IconFieldNumber = 5;

	private string icon_ = "";

	public const int BriefDescFieldNumber = 6;

	private string briefDesc_ = "";

	public const int DescFieldNumber = 7;

	private string desc_ = "";

	public const int Param1FieldNumber = 8;

	private string param1_ = "";

	public const int Param2FieldNumber = 9;

	private string param2_ = "";

	public const int Param3FieldNumber = 10;

	private string param3_ = "";

	public const int Param4FieldNumber = 11;

	private string param4_ = "";

	public const int Param5FieldNumber = 12;

	private string param5_ = "";

	public const int Param6FieldNumber = 13;

	private string param6_ = "";

	public const int Param7FieldNumber = 14;

	private string param7_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<SubNoteSkill> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(910);

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
	public RepeatedField<int> Scores => scores_;

	[DebuggerNonUserCode]
	public RepeatedField<int> EffectId => effectId_;

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
	public string BriefDesc
	{
		get
		{
			return briefDesc_;
		}
		set
		{
			briefDesc_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public string Param1
	{
		get
		{
			return param1_;
		}
		set
		{
			param1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param2
	{
		get
		{
			return param2_;
		}
		set
		{
			param2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param3
	{
		get
		{
			return param3_;
		}
		set
		{
			param3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param4
	{
		get
		{
			return param4_;
		}
		set
		{
			param4_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param5
	{
		get
		{
			return param5_;
		}
		set
		{
			param5_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param6
	{
		get
		{
			return param6_;
		}
		set
		{
			param6_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param7
	{
		get
		{
			return param7_;
		}
		set
		{
			param7_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public SubNoteSkill()
	{
	}

	[DebuggerNonUserCode]
	public SubNoteSkill(SubNoteSkill other)
		: this()
	{
		id_ = other.id_;
		scores_ = other.scores_.Clone();
		effectId_ = other.effectId_.Clone();
		name_ = other.name_;
		icon_ = other.icon_;
		briefDesc_ = other.briefDesc_;
		desc_ = other.desc_;
		param1_ = other.param1_;
		param2_ = other.param2_;
		param3_ = other.param3_;
		param4_ = other.param4_;
		param5_ = other.param5_;
		param6_ = other.param6_;
		param7_ = other.param7_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SubNoteSkill Clone()
	{
		return new SubNoteSkill(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SubNoteSkill);
	}

	[DebuggerNonUserCode]
	public bool Equals(SubNoteSkill other)
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
		if (!scores_.Equals(other.scores_))
		{
			return false;
		}
		if (!effectId_.Equals(other.effectId_))
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (BriefDesc != other.BriefDesc)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (Param1 != other.Param1)
		{
			return false;
		}
		if (Param2 != other.Param2)
		{
			return false;
		}
		if (Param3 != other.Param3)
		{
			return false;
		}
		if (Param4 != other.Param4)
		{
			return false;
		}
		if (Param5 != other.Param5)
		{
			return false;
		}
		if (Param6 != other.Param6)
		{
			return false;
		}
		if (Param7 != other.Param7)
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
		num ^= scores_.GetHashCode();
		num ^= effectId_.GetHashCode();
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (BriefDesc.Length != 0)
		{
			num ^= BriefDesc.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Param1.Length != 0)
		{
			num ^= Param1.GetHashCode();
		}
		if (Param2.Length != 0)
		{
			num ^= Param2.GetHashCode();
		}
		if (Param3.Length != 0)
		{
			num ^= Param3.GetHashCode();
		}
		if (Param4.Length != 0)
		{
			num ^= Param4.GetHashCode();
		}
		if (Param5.Length != 0)
		{
			num ^= Param5.GetHashCode();
		}
		if (Param6.Length != 0)
		{
			num ^= Param6.GetHashCode();
		}
		if (Param7.Length != 0)
		{
			num ^= Param7.GetHashCode();
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
		scores_.WriteTo(output, _repeated_scores_codec);
		effectId_.WriteTo(output, _repeated_effectId_codec);
		if (Name.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Name);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Icon);
		}
		if (BriefDesc.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(BriefDesc);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Desc);
		}
		if (Param1.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(Param1);
		}
		if (Param2.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(Param2);
		}
		if (Param3.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(Param3);
		}
		if (Param4.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(Param4);
		}
		if (Param5.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(Param5);
		}
		if (Param6.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(Param6);
		}
		if (Param7.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(Param7);
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
		num += scores_.CalculateSize(_repeated_scores_codec);
		num += effectId_.CalculateSize(_repeated_effectId_codec);
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (BriefDesc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BriefDesc);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Param1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Param1);
		}
		if (Param2.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Param2);
		}
		if (Param3.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Param3);
		}
		if (Param4.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Param4);
		}
		if (Param5.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Param5);
		}
		if (Param6.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Param6);
		}
		if (Param7.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Param7);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SubNoteSkill other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			scores_.Add(other.scores_);
			effectId_.Add(other.effectId_);
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.BriefDesc.Length != 0)
			{
				BriefDesc = other.BriefDesc;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.Param1.Length != 0)
			{
				Param1 = other.Param1;
			}
			if (other.Param2.Length != 0)
			{
				Param2 = other.Param2;
			}
			if (other.Param3.Length != 0)
			{
				Param3 = other.Param3;
			}
			if (other.Param4.Length != 0)
			{
				Param4 = other.Param4;
			}
			if (other.Param5.Length != 0)
			{
				Param5 = other.Param5;
			}
			if (other.Param6.Length != 0)
			{
				Param6 = other.Param6;
			}
			if (other.Param7.Length != 0)
			{
				Param7 = other.Param7;
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
			case 18u:
				scores_.AddEntriesFrom(input, _repeated_scores_codec);
				break;
			case 24u:
			case 26u:
				effectId_.AddEntriesFrom(input, _repeated_effectId_codec);
				break;
			case 34u:
				Name = input.ReadString();
				break;
			case 42u:
				Icon = input.ReadString();
				break;
			case 50u:
				BriefDesc = input.ReadString();
				break;
			case 58u:
				Desc = input.ReadString();
				break;
			case 66u:
				Param1 = input.ReadString();
				break;
			case 74u:
				Param2 = input.ReadString();
				break;
			case 82u:
				Param3 = input.ReadString();
				break;
			case 90u:
				Param4 = input.ReadString();
				break;
			case 98u:
				Param5 = input.ReadString();
				break;
			case 106u:
				Param6 = input.ReadString();
				break;
			case 114u:
				Param7 = input.ReadString();
				break;
			}
		}
	}
}
