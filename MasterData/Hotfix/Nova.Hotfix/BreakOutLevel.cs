using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class BreakOutLevel : IMessage<BreakOutLevel>, IMessage, IEquatable<BreakOutLevel>, IDeepCloneable<BreakOutLevel>
{
	private static readonly MessageParser<BreakOutLevel> _parser = new MessageParser<BreakOutLevel>(() => new BreakOutLevel());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ActivityIdFieldNumber = 2;

	private int activityId_;

	public const int DayOpenFieldNumber = 3;

	private int dayOpen_;

	public const int NameFieldNumber = 4;

	private string name_ = "";

	public const int IconResFieldNumber = 5;

	private string iconRes_ = "";

	public const int TypeFieldNumber = 6;

	private int type_;

	public const int DifficultyFieldNumber = 7;

	private int difficulty_;

	public const int PreLevelIdFieldNumber = 8;

	private int preLevelId_;

	public const int FloorIdFieldNumber = 9;

	private int floorId_;

	public const int PreviewMonsterGroupIdFieldNumber = 10;

	private int previewMonsterGroupId_;

	public const int FirstCompleteReward1TidFieldNumber = 11;

	private int firstCompleteReward1Tid_;

	public const int FirstCompleteReward1QtyFieldNumber = 12;

	private int firstCompleteReward1Qty_;

	public const int FirstCompleteReward2TidFieldNumber = 13;

	private int firstCompleteReward2Tid_;

	public const int FirstCompleteReward2QtyFieldNumber = 14;

	private int firstCompleteReward2Qty_;

	public const int CharactersFieldNumber = 15;

	private static readonly FieldCodec<int> _repeated_characters_codec = FieldCodec.ForInt32(122u);

	private readonly RepeatedField<int> characters_ = new RepeatedField<int>();

	public const int DescFieldNumber = 16;

	private string desc_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<BreakOutLevel> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(140);

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
	public int ActivityId
	{
		get
		{
			return activityId_;
		}
		set
		{
			activityId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DayOpen
	{
		get
		{
			return dayOpen_;
		}
		set
		{
			dayOpen_ = value;
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
	public string IconRes
	{
		get
		{
			return iconRes_;
		}
		set
		{
			iconRes_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public int PreLevelId
	{
		get
		{
			return preLevelId_;
		}
		set
		{
			preLevelId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FloorId
	{
		get
		{
			return floorId_;
		}
		set
		{
			floorId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PreviewMonsterGroupId
	{
		get
		{
			return previewMonsterGroupId_;
		}
		set
		{
			previewMonsterGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FirstCompleteReward1Tid
	{
		get
		{
			return firstCompleteReward1Tid_;
		}
		set
		{
			firstCompleteReward1Tid_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FirstCompleteReward1Qty
	{
		get
		{
			return firstCompleteReward1Qty_;
		}
		set
		{
			firstCompleteReward1Qty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FirstCompleteReward2Tid
	{
		get
		{
			return firstCompleteReward2Tid_;
		}
		set
		{
			firstCompleteReward2Tid_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FirstCompleteReward2Qty
	{
		get
		{
			return firstCompleteReward2Qty_;
		}
		set
		{
			firstCompleteReward2Qty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Characters => characters_;

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
	public BreakOutLevel()
	{
	}

	[DebuggerNonUserCode]
	public BreakOutLevel(BreakOutLevel other)
		: this()
	{
		id_ = other.id_;
		activityId_ = other.activityId_;
		dayOpen_ = other.dayOpen_;
		name_ = other.name_;
		iconRes_ = other.iconRes_;
		type_ = other.type_;
		difficulty_ = other.difficulty_;
		preLevelId_ = other.preLevelId_;
		floorId_ = other.floorId_;
		previewMonsterGroupId_ = other.previewMonsterGroupId_;
		firstCompleteReward1Tid_ = other.firstCompleteReward1Tid_;
		firstCompleteReward1Qty_ = other.firstCompleteReward1Qty_;
		firstCompleteReward2Tid_ = other.firstCompleteReward2Tid_;
		firstCompleteReward2Qty_ = other.firstCompleteReward2Qty_;
		characters_ = other.characters_.Clone();
		desc_ = other.desc_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public BreakOutLevel Clone()
	{
		return new BreakOutLevel(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as BreakOutLevel);
	}

	[DebuggerNonUserCode]
	public bool Equals(BreakOutLevel other)
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
		if (ActivityId != other.ActivityId)
		{
			return false;
		}
		if (DayOpen != other.DayOpen)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (IconRes != other.IconRes)
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (Difficulty != other.Difficulty)
		{
			return false;
		}
		if (PreLevelId != other.PreLevelId)
		{
			return false;
		}
		if (FloorId != other.FloorId)
		{
			return false;
		}
		if (PreviewMonsterGroupId != other.PreviewMonsterGroupId)
		{
			return false;
		}
		if (FirstCompleteReward1Tid != other.FirstCompleteReward1Tid)
		{
			return false;
		}
		if (FirstCompleteReward1Qty != other.FirstCompleteReward1Qty)
		{
			return false;
		}
		if (FirstCompleteReward2Tid != other.FirstCompleteReward2Tid)
		{
			return false;
		}
		if (FirstCompleteReward2Qty != other.FirstCompleteReward2Qty)
		{
			return false;
		}
		if (!characters_.Equals(other.characters_))
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
		if (ActivityId != 0)
		{
			num ^= ActivityId.GetHashCode();
		}
		if (DayOpen != 0)
		{
			num ^= DayOpen.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (IconRes.Length != 0)
		{
			num ^= IconRes.GetHashCode();
		}
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (Difficulty != 0)
		{
			num ^= Difficulty.GetHashCode();
		}
		if (PreLevelId != 0)
		{
			num ^= PreLevelId.GetHashCode();
		}
		if (FloorId != 0)
		{
			num ^= FloorId.GetHashCode();
		}
		if (PreviewMonsterGroupId != 0)
		{
			num ^= PreviewMonsterGroupId.GetHashCode();
		}
		if (FirstCompleteReward1Tid != 0)
		{
			num ^= FirstCompleteReward1Tid.GetHashCode();
		}
		if (FirstCompleteReward1Qty != 0)
		{
			num ^= FirstCompleteReward1Qty.GetHashCode();
		}
		if (FirstCompleteReward2Tid != 0)
		{
			num ^= FirstCompleteReward2Tid.GetHashCode();
		}
		if (FirstCompleteReward2Qty != 0)
		{
			num ^= FirstCompleteReward2Qty.GetHashCode();
		}
		num ^= characters_.GetHashCode();
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
		if (ActivityId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ActivityId);
		}
		if (DayOpen != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(DayOpen);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Name);
		}
		if (IconRes.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(IconRes);
		}
		if (Type != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Type);
		}
		if (Difficulty != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Difficulty);
		}
		if (PreLevelId != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(PreLevelId);
		}
		if (FloorId != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(FloorId);
		}
		if (PreviewMonsterGroupId != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(PreviewMonsterGroupId);
		}
		if (FirstCompleteReward1Tid != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(FirstCompleteReward1Tid);
		}
		if (FirstCompleteReward1Qty != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(FirstCompleteReward1Qty);
		}
		if (FirstCompleteReward2Tid != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(FirstCompleteReward2Tid);
		}
		if (FirstCompleteReward2Qty != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(FirstCompleteReward2Qty);
		}
		characters_.WriteTo(output, _repeated_characters_codec);
		if (Desc.Length != 0)
		{
			output.WriteRawTag(130, 1);
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
		if (ActivityId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActivityId);
		}
		if (DayOpen != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DayOpen);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (IconRes.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(IconRes);
		}
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (Difficulty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Difficulty);
		}
		if (PreLevelId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreLevelId);
		}
		if (FloorId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FloorId);
		}
		if (PreviewMonsterGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreviewMonsterGroupId);
		}
		if (FirstCompleteReward1Tid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FirstCompleteReward1Tid);
		}
		if (FirstCompleteReward1Qty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FirstCompleteReward1Qty);
		}
		if (FirstCompleteReward2Tid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FirstCompleteReward2Tid);
		}
		if (FirstCompleteReward2Qty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FirstCompleteReward2Qty);
		}
		num += characters_.CalculateSize(_repeated_characters_codec);
		if (Desc.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(BreakOutLevel other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.ActivityId != 0)
			{
				ActivityId = other.ActivityId;
			}
			if (other.DayOpen != 0)
			{
				DayOpen = other.DayOpen;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.IconRes.Length != 0)
			{
				IconRes = other.IconRes;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.Difficulty != 0)
			{
				Difficulty = other.Difficulty;
			}
			if (other.PreLevelId != 0)
			{
				PreLevelId = other.PreLevelId;
			}
			if (other.FloorId != 0)
			{
				FloorId = other.FloorId;
			}
			if (other.PreviewMonsterGroupId != 0)
			{
				PreviewMonsterGroupId = other.PreviewMonsterGroupId;
			}
			if (other.FirstCompleteReward1Tid != 0)
			{
				FirstCompleteReward1Tid = other.FirstCompleteReward1Tid;
			}
			if (other.FirstCompleteReward1Qty != 0)
			{
				FirstCompleteReward1Qty = other.FirstCompleteReward1Qty;
			}
			if (other.FirstCompleteReward2Tid != 0)
			{
				FirstCompleteReward2Tid = other.FirstCompleteReward2Tid;
			}
			if (other.FirstCompleteReward2Qty != 0)
			{
				FirstCompleteReward2Qty = other.FirstCompleteReward2Qty;
			}
			characters_.Add(other.characters_);
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
			case 16u:
				ActivityId = input.ReadInt32();
				break;
			case 24u:
				DayOpen = input.ReadInt32();
				break;
			case 34u:
				Name = input.ReadString();
				break;
			case 42u:
				IconRes = input.ReadString();
				break;
			case 48u:
				Type = input.ReadInt32();
				break;
			case 56u:
				Difficulty = input.ReadInt32();
				break;
			case 64u:
				PreLevelId = input.ReadInt32();
				break;
			case 72u:
				FloorId = input.ReadInt32();
				break;
			case 80u:
				PreviewMonsterGroupId = input.ReadInt32();
				break;
			case 88u:
				FirstCompleteReward1Tid = input.ReadInt32();
				break;
			case 96u:
				FirstCompleteReward1Qty = input.ReadInt32();
				break;
			case 104u:
				FirstCompleteReward2Tid = input.ReadInt32();
				break;
			case 112u:
				FirstCompleteReward2Qty = input.ReadInt32();
				break;
			case 120u:
			case 122u:
				characters_.AddEntriesFrom(input, _repeated_characters_codec);
				break;
			case 130u:
				Desc = input.ReadString();
				break;
			}
		}
	}
}
