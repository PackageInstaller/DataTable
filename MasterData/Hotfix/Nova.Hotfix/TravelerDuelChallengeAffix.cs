using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TravelerDuelChallengeAffix : IMessage<TravelerDuelChallengeAffix>, IMessage, IEquatable<TravelerDuelChallengeAffix>, IDeepCloneable<TravelerDuelChallengeAffix>
{
	private static readonly MessageParser<TravelerDuelChallengeAffix> _parser = new MessageParser<TravelerDuelChallengeAffix>(() => new TravelerDuelChallengeAffix());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupIdFieldNumber = 2;

	private int groupId_;

	public const int DifficultyFieldNumber = 3;

	private int difficulty_;

	public const int UnlockDifficultyFieldNumber = 4;

	private int unlockDifficulty_;

	public const int UnlockDurationTimeFieldNumber = 5;

	private int unlockDurationTime_;

	public const int NameFieldNumber = 6;

	private string name_ = "";

	public const int DescFieldNumber = 7;

	private string desc_ = "";

	public const int IconFieldNumber = 8;

	private string icon_ = "";

	public const int ElementFieldNumber = 9;

	private int element_;

	public const int AddCampFieldNumber = 10;

	private static readonly FieldCodec<int> _repeated_addCamp_codec = FieldCodec.ForInt32(82u);

	private readonly RepeatedField<int> addCamp_ = new RepeatedField<int>();

	public const int AddClassFieldNumber = 11;

	private static readonly FieldCodec<int> _repeated_addClass_codec = FieldCodec.ForInt32(90u);

	private readonly RepeatedField<int> addClass_ = new RepeatedField<int>();

	public const int SkillIdFieldNumber = 12;

	private static readonly FieldCodec<int> _repeated_skillId_codec = FieldCodec.ForInt32(98u);

	private readonly RepeatedField<int> skillId_ = new RepeatedField<int>();

	public const int BranchIdFieldNumber = 13;

	private int branchId_;

	public const int LogicTagFieldNumber = 14;

	private string logicTag_ = "";

	public const int Param1FieldNumber = 15;

	private string param1_ = "";

	public const int Param2FieldNumber = 16;

	private string param2_ = "";

	public const int Param3FieldNumber = 17;

	private string param3_ = "";

	public const int Param4FieldNumber = 18;

	private string param4_ = "";

	public const int Param5FieldNumber = 19;

	private string param5_ = "";

	public const int Param6FieldNumber = 20;

	private string param6_ = "";

	public const int Param7FieldNumber = 21;

	private string param7_ = "";

	public const int Param8FieldNumber = 22;

	private string param8_ = "";

	public const int Param9FieldNumber = 23;

	private string param9_ = "";

	public const int Param10FieldNumber = 24;

	private string param10_ = "";

	public const int Value1FieldNumber = 25;

	private string value1_ = "";

	public const int Value2FieldNumber = 26;

	private string value2_ = "";

	public const int Value3FieldNumber = 27;

	private string value3_ = "";

	public const int Value4FieldNumber = 28;

	private string value4_ = "";

	public const int Value5FieldNumber = 29;

	private string value5_ = "";

	public const int Value6FieldNumber = 30;

	private string value6_ = "";

	public const int Value7FieldNumber = 31;

	private string value7_ = "";

	public const int Value8FieldNumber = 32;

	private string value8_ = "";

	public const int Value9FieldNumber = 33;

	private string value9_ = "";

	public const int Value10FieldNumber = 34;

	private string value10_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<TravelerDuelChallengeAffix> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1006);

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
	public int GroupId
	{
		get
		{
			return groupId_;
		}
		set
		{
			groupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Difficulty
	{
		get
		{
			return difficulty_;
		}
		set
		{
			difficulty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int UnlockDifficulty
	{
		get
		{
			return unlockDifficulty_;
		}
		set
		{
			unlockDifficulty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int UnlockDurationTime
	{
		get
		{
			return unlockDurationTime_;
		}
		set
		{
			unlockDurationTime_ = value;
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
	public int Element
	{
		get
		{
			return element_;
		}
		set
		{
			element_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> AddCamp => addCamp_;

	[DebuggerNonUserCode]
	public RepeatedField<int> AddClass => addClass_;

	[DebuggerNonUserCode]
	public RepeatedField<int> SkillId => skillId_;

	[DebuggerNonUserCode]
	public int BranchId
	{
		get
		{
			return branchId_;
		}
		set
		{
			branchId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string LogicTag
	{
		get
		{
			return logicTag_;
		}
		set
		{
			logicTag_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public string Param8
	{
		get
		{
			return param8_;
		}
		set
		{
			param8_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param9
	{
		get
		{
			return param9_;
		}
		set
		{
			param9_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param10
	{
		get
		{
			return param10_;
		}
		set
		{
			param10_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Value1
	{
		get
		{
			return value1_;
		}
		set
		{
			value1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Value2
	{
		get
		{
			return value2_;
		}
		set
		{
			value2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Value3
	{
		get
		{
			return value3_;
		}
		set
		{
			value3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Value4
	{
		get
		{
			return value4_;
		}
		set
		{
			value4_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Value5
	{
		get
		{
			return value5_;
		}
		set
		{
			value5_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Value6
	{
		get
		{
			return value6_;
		}
		set
		{
			value6_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Value7
	{
		get
		{
			return value7_;
		}
		set
		{
			value7_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Value8
	{
		get
		{
			return value8_;
		}
		set
		{
			value8_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Value9
	{
		get
		{
			return value9_;
		}
		set
		{
			value9_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Value10
	{
		get
		{
			return value10_;
		}
		set
		{
			value10_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public TravelerDuelChallengeAffix()
	{
	}

	[DebuggerNonUserCode]
	public TravelerDuelChallengeAffix(TravelerDuelChallengeAffix other)
		: this()
	{
		id_ = other.id_;
		groupId_ = other.groupId_;
		difficulty_ = other.difficulty_;
		unlockDifficulty_ = other.unlockDifficulty_;
		unlockDurationTime_ = other.unlockDurationTime_;
		name_ = other.name_;
		desc_ = other.desc_;
		icon_ = other.icon_;
		element_ = other.element_;
		addCamp_ = other.addCamp_.Clone();
		addClass_ = other.addClass_.Clone();
		skillId_ = other.skillId_.Clone();
		branchId_ = other.branchId_;
		logicTag_ = other.logicTag_;
		param1_ = other.param1_;
		param2_ = other.param2_;
		param3_ = other.param3_;
		param4_ = other.param4_;
		param5_ = other.param5_;
		param6_ = other.param6_;
		param7_ = other.param7_;
		param8_ = other.param8_;
		param9_ = other.param9_;
		param10_ = other.param10_;
		value1_ = other.value1_;
		value2_ = other.value2_;
		value3_ = other.value3_;
		value4_ = other.value4_;
		value5_ = other.value5_;
		value6_ = other.value6_;
		value7_ = other.value7_;
		value8_ = other.value8_;
		value9_ = other.value9_;
		value10_ = other.value10_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TravelerDuelChallengeAffix Clone()
	{
		return new TravelerDuelChallengeAffix(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TravelerDuelChallengeAffix);
	}

	[DebuggerNonUserCode]
	public bool Equals(TravelerDuelChallengeAffix other)
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
		if (GroupId != other.GroupId)
		{
			return false;
		}
		if (Difficulty != other.Difficulty)
		{
			return false;
		}
		if (UnlockDifficulty != other.UnlockDifficulty)
		{
			return false;
		}
		if (UnlockDurationTime != other.UnlockDurationTime)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (Element != other.Element)
		{
			return false;
		}
		if (!addCamp_.Equals(other.addCamp_))
		{
			return false;
		}
		if (!addClass_.Equals(other.addClass_))
		{
			return false;
		}
		if (!skillId_.Equals(other.skillId_))
		{
			return false;
		}
		if (BranchId != other.BranchId)
		{
			return false;
		}
		if (LogicTag != other.LogicTag)
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
		if (Param8 != other.Param8)
		{
			return false;
		}
		if (Param9 != other.Param9)
		{
			return false;
		}
		if (Param10 != other.Param10)
		{
			return false;
		}
		if (Value1 != other.Value1)
		{
			return false;
		}
		if (Value2 != other.Value2)
		{
			return false;
		}
		if (Value3 != other.Value3)
		{
			return false;
		}
		if (Value4 != other.Value4)
		{
			return false;
		}
		if (Value5 != other.Value5)
		{
			return false;
		}
		if (Value6 != other.Value6)
		{
			return false;
		}
		if (Value7 != other.Value7)
		{
			return false;
		}
		if (Value8 != other.Value8)
		{
			return false;
		}
		if (Value9 != other.Value9)
		{
			return false;
		}
		if (Value10 != other.Value10)
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
		if (GroupId != 0)
		{
			num ^= GroupId.GetHashCode();
		}
		if (Difficulty != 0)
		{
			num ^= Difficulty.GetHashCode();
		}
		if (UnlockDifficulty != 0)
		{
			num ^= UnlockDifficulty.GetHashCode();
		}
		if (UnlockDurationTime != 0)
		{
			num ^= UnlockDurationTime.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (Element != 0)
		{
			num ^= Element.GetHashCode();
		}
		num ^= addCamp_.GetHashCode();
		num ^= addClass_.GetHashCode();
		num ^= skillId_.GetHashCode();
		if (BranchId != 0)
		{
			num ^= BranchId.GetHashCode();
		}
		if (LogicTag.Length != 0)
		{
			num ^= LogicTag.GetHashCode();
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
		if (Param8.Length != 0)
		{
			num ^= Param8.GetHashCode();
		}
		if (Param9.Length != 0)
		{
			num ^= Param9.GetHashCode();
		}
		if (Param10.Length != 0)
		{
			num ^= Param10.GetHashCode();
		}
		if (Value1.Length != 0)
		{
			num ^= Value1.GetHashCode();
		}
		if (Value2.Length != 0)
		{
			num ^= Value2.GetHashCode();
		}
		if (Value3.Length != 0)
		{
			num ^= Value3.GetHashCode();
		}
		if (Value4.Length != 0)
		{
			num ^= Value4.GetHashCode();
		}
		if (Value5.Length != 0)
		{
			num ^= Value5.GetHashCode();
		}
		if (Value6.Length != 0)
		{
			num ^= Value6.GetHashCode();
		}
		if (Value7.Length != 0)
		{
			num ^= Value7.GetHashCode();
		}
		if (Value8.Length != 0)
		{
			num ^= Value8.GetHashCode();
		}
		if (Value9.Length != 0)
		{
			num ^= Value9.GetHashCode();
		}
		if (Value10.Length != 0)
		{
			num ^= Value10.GetHashCode();
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
		if (GroupId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(GroupId);
		}
		if (Difficulty != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Difficulty);
		}
		if (UnlockDifficulty != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(UnlockDifficulty);
		}
		if (UnlockDurationTime != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(UnlockDurationTime);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Name);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Desc);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(Icon);
		}
		if (Element != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Element);
		}
		addCamp_.WriteTo(output, _repeated_addCamp_codec);
		addClass_.WriteTo(output, _repeated_addClass_codec);
		skillId_.WriteTo(output, _repeated_skillId_codec);
		if (BranchId != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(BranchId);
		}
		if (LogicTag.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(LogicTag);
		}
		if (Param1.Length != 0)
		{
			output.WriteRawTag(122);
			output.WriteString(Param1);
		}
		if (Param2.Length != 0)
		{
			output.WriteRawTag(130, 1);
			output.WriteString(Param2);
		}
		if (Param3.Length != 0)
		{
			output.WriteRawTag(138, 1);
			output.WriteString(Param3);
		}
		if (Param4.Length != 0)
		{
			output.WriteRawTag(146, 1);
			output.WriteString(Param4);
		}
		if (Param5.Length != 0)
		{
			output.WriteRawTag(154, 1);
			output.WriteString(Param5);
		}
		if (Param6.Length != 0)
		{
			output.WriteRawTag(162, 1);
			output.WriteString(Param6);
		}
		if (Param7.Length != 0)
		{
			output.WriteRawTag(170, 1);
			output.WriteString(Param7);
		}
		if (Param8.Length != 0)
		{
			output.WriteRawTag(178, 1);
			output.WriteString(Param8);
		}
		if (Param9.Length != 0)
		{
			output.WriteRawTag(186, 1);
			output.WriteString(Param9);
		}
		if (Param10.Length != 0)
		{
			output.WriteRawTag(194, 1);
			output.WriteString(Param10);
		}
		if (Value1.Length != 0)
		{
			output.WriteRawTag(202, 1);
			output.WriteString(Value1);
		}
		if (Value2.Length != 0)
		{
			output.WriteRawTag(210, 1);
			output.WriteString(Value2);
		}
		if (Value3.Length != 0)
		{
			output.WriteRawTag(218, 1);
			output.WriteString(Value3);
		}
		if (Value4.Length != 0)
		{
			output.WriteRawTag(226, 1);
			output.WriteString(Value4);
		}
		if (Value5.Length != 0)
		{
			output.WriteRawTag(234, 1);
			output.WriteString(Value5);
		}
		if (Value6.Length != 0)
		{
			output.WriteRawTag(242, 1);
			output.WriteString(Value6);
		}
		if (Value7.Length != 0)
		{
			output.WriteRawTag(250, 1);
			output.WriteString(Value7);
		}
		if (Value8.Length != 0)
		{
			output.WriteRawTag(130, 2);
			output.WriteString(Value8);
		}
		if (Value9.Length != 0)
		{
			output.WriteRawTag(138, 2);
			output.WriteString(Value9);
		}
		if (Value10.Length != 0)
		{
			output.WriteRawTag(146, 2);
			output.WriteString(Value10);
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
		if (GroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GroupId);
		}
		if (Difficulty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Difficulty);
		}
		if (UnlockDifficulty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UnlockDifficulty);
		}
		if (UnlockDurationTime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UnlockDurationTime);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (Element != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Element);
		}
		num += addCamp_.CalculateSize(_repeated_addCamp_codec);
		num += addClass_.CalculateSize(_repeated_addClass_codec);
		num += skillId_.CalculateSize(_repeated_skillId_codec);
		if (BranchId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BranchId);
		}
		if (LogicTag.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(LogicTag);
		}
		if (Param1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Param1);
		}
		if (Param2.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param2);
		}
		if (Param3.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param3);
		}
		if (Param4.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param4);
		}
		if (Param5.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param5);
		}
		if (Param6.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param6);
		}
		if (Param7.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param7);
		}
		if (Param8.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param8);
		}
		if (Param9.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param9);
		}
		if (Param10.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param10);
		}
		if (Value1.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Value1);
		}
		if (Value2.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Value2);
		}
		if (Value3.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Value3);
		}
		if (Value4.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Value4);
		}
		if (Value5.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Value5);
		}
		if (Value6.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Value6);
		}
		if (Value7.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Value7);
		}
		if (Value8.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Value8);
		}
		if (Value9.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Value9);
		}
		if (Value10.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Value10);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TravelerDuelChallengeAffix other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.GroupId != 0)
			{
				GroupId = other.GroupId;
			}
			if (other.Difficulty != 0)
			{
				Difficulty = other.Difficulty;
			}
			if (other.UnlockDifficulty != 0)
			{
				UnlockDifficulty = other.UnlockDifficulty;
			}
			if (other.UnlockDurationTime != 0)
			{
				UnlockDurationTime = other.UnlockDurationTime;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.Element != 0)
			{
				Element = other.Element;
			}
			addCamp_.Add(other.addCamp_);
			addClass_.Add(other.addClass_);
			skillId_.Add(other.skillId_);
			if (other.BranchId != 0)
			{
				BranchId = other.BranchId;
			}
			if (other.LogicTag.Length != 0)
			{
				LogicTag = other.LogicTag;
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
			if (other.Param8.Length != 0)
			{
				Param8 = other.Param8;
			}
			if (other.Param9.Length != 0)
			{
				Param9 = other.Param9;
			}
			if (other.Param10.Length != 0)
			{
				Param10 = other.Param10;
			}
			if (other.Value1.Length != 0)
			{
				Value1 = other.Value1;
			}
			if (other.Value2.Length != 0)
			{
				Value2 = other.Value2;
			}
			if (other.Value3.Length != 0)
			{
				Value3 = other.Value3;
			}
			if (other.Value4.Length != 0)
			{
				Value4 = other.Value4;
			}
			if (other.Value5.Length != 0)
			{
				Value5 = other.Value5;
			}
			if (other.Value6.Length != 0)
			{
				Value6 = other.Value6;
			}
			if (other.Value7.Length != 0)
			{
				Value7 = other.Value7;
			}
			if (other.Value8.Length != 0)
			{
				Value8 = other.Value8;
			}
			if (other.Value9.Length != 0)
			{
				Value9 = other.Value9;
			}
			if (other.Value10.Length != 0)
			{
				Value10 = other.Value10;
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
				GroupId = input.ReadInt32();
				break;
			case 24u:
				Difficulty = input.ReadInt32();
				break;
			case 32u:
				UnlockDifficulty = input.ReadInt32();
				break;
			case 40u:
				UnlockDurationTime = input.ReadInt32();
				break;
			case 50u:
				Name = input.ReadString();
				break;
			case 58u:
				Desc = input.ReadString();
				break;
			case 66u:
				Icon = input.ReadString();
				break;
			case 72u:
				Element = input.ReadInt32();
				break;
			case 80u:
			case 82u:
				addCamp_.AddEntriesFrom(input, _repeated_addCamp_codec);
				break;
			case 88u:
			case 90u:
				addClass_.AddEntriesFrom(input, _repeated_addClass_codec);
				break;
			case 96u:
			case 98u:
				skillId_.AddEntriesFrom(input, _repeated_skillId_codec);
				break;
			case 104u:
				BranchId = input.ReadInt32();
				break;
			case 114u:
				LogicTag = input.ReadString();
				break;
			case 122u:
				Param1 = input.ReadString();
				break;
			case 130u:
				Param2 = input.ReadString();
				break;
			case 138u:
				Param3 = input.ReadString();
				break;
			case 146u:
				Param4 = input.ReadString();
				break;
			case 154u:
				Param5 = input.ReadString();
				break;
			case 162u:
				Param6 = input.ReadString();
				break;
			case 170u:
				Param7 = input.ReadString();
				break;
			case 178u:
				Param8 = input.ReadString();
				break;
			case 186u:
				Param9 = input.ReadString();
				break;
			case 194u:
				Param10 = input.ReadString();
				break;
			case 202u:
				Value1 = input.ReadString();
				break;
			case 210u:
				Value2 = input.ReadString();
				break;
			case 218u:
				Value3 = input.ReadString();
				break;
			case 226u:
				Value4 = input.ReadString();
				break;
			case 234u:
				Value5 = input.ReadString();
				break;
			case 242u:
				Value6 = input.ReadString();
				break;
			case 250u:
				Value7 = input.ReadString();
				break;
			case 258u:
				Value8 = input.ReadString();
				break;
			case 266u:
				Value9 = input.ReadString();
				break;
			case 274u:
				Value10 = input.ReadString();
				break;
			}
		}
	}
}
