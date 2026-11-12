using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ActivityTask : IMessage<ActivityTask>, IMessage, IEquatable<ActivityTask>, IDeepCloneable<ActivityTask>
{
	private static readonly MessageParser<ActivityTask> _parser = new MessageParser<ActivityTask>(() => new ActivityTask());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TitleFieldNumber = 2;

	private string title_ = "";

	public const int DescFieldNumber = 3;

	private string desc_ = "";

	public const int RarityFieldNumber = 4;

	private int rarity_;

	public const int HideFieldNumber = 5;

	private bool hide_;

	public const int JumpToFieldNumber = 6;

	private static readonly FieldCodec<int> _repeated_jumpTo_codec = FieldCodec.ForInt32(50u);

	private readonly RepeatedField<int> jumpTo_ = new RepeatedField<int>();

	public const int ActivityTaskGroupIdFieldNumber = 7;

	private int activityTaskGroupId_;

	public const int ActivityGroupNameFieldNumber = 8;

	private string activityGroupName_ = "";

	public const int CompleteCondFieldNumber = 9;

	private int completeCond_;

	public const int CompleteCondClientFieldNumber = 10;

	private int completeCondClient_;

	public const int AimNumShowFieldNumber = 11;

	private int aimNumShow_;

	public const int PrerequisitesFieldNumber = 12;

	private static readonly FieldCodec<int> _repeated_prerequisites_codec = FieldCodec.ForInt32(98u);

	private readonly RepeatedField<int> prerequisites_ = new RepeatedField<int>();

	public const int LevelTypeFieldNumber = 13;

	private int levelType_;

	public const int ClientCompleteParams1FieldNumber = 14;

	private static readonly FieldCodec<int> _repeated_clientCompleteParams1_codec = FieldCodec.ForInt32(114u);

	private readonly RepeatedField<int> clientCompleteParams1_ = new RepeatedField<int>();

	public const int ClientCompleteParams2FieldNumber = 15;

	private static readonly FieldCodec<int> _repeated_clientCompleteParams2_codec = FieldCodec.ForInt32(122u);

	private readonly RepeatedField<int> clientCompleteParams2_ = new RepeatedField<int>();

	public const int Tid1FieldNumber = 16;

	private int tid1_;

	public const int Qty1FieldNumber = 17;

	private int qty1_;

	public const int Tid2FieldNumber = 18;

	private int tid2_;

	public const int Qty2FieldNumber = 19;

	private int qty2_;

	public const int Tid3FieldNumber = 20;

	private int tid3_;

	public const int Qty3FieldNumber = 21;

	private int qty3_;

	[DebuggerNonUserCode]
	public static MessageParser<ActivityTask> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(68);

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
	public string Title
	{
		get
		{
			return title_;
		}
		set
		{
			title_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public int Rarity
	{
		get
		{
			return rarity_;
		}
		set
		{
			rarity_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool Hide
	{
		get
		{
			return hide_;
		}
		set
		{
			hide_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> JumpTo => jumpTo_;

	[DebuggerNonUserCode]
	public int ActivityTaskGroupId
	{
		get
		{
			return activityTaskGroupId_;
		}
		set
		{
			activityTaskGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string ActivityGroupName
	{
		get
		{
			return activityGroupName_;
		}
		set
		{
			activityGroupName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int CompleteCond
	{
		get
		{
			return completeCond_;
		}
		set
		{
			completeCond_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CompleteCondClient
	{
		get
		{
			return completeCondClient_;
		}
		set
		{
			completeCondClient_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AimNumShow
	{
		get
		{
			return aimNumShow_;
		}
		set
		{
			aimNumShow_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Prerequisites => prerequisites_;

	[DebuggerNonUserCode]
	public int LevelType
	{
		get
		{
			return levelType_;
		}
		set
		{
			levelType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> ClientCompleteParams1 => clientCompleteParams1_;

	[DebuggerNonUserCode]
	public RepeatedField<int> ClientCompleteParams2 => clientCompleteParams2_;

	[DebuggerNonUserCode]
	public int Tid1
	{
		get
		{
			return tid1_;
		}
		set
		{
			tid1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Qty1
	{
		get
		{
			return qty1_;
		}
		set
		{
			qty1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Tid2
	{
		get
		{
			return tid2_;
		}
		set
		{
			tid2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Qty2
	{
		get
		{
			return qty2_;
		}
		set
		{
			qty2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Tid3
	{
		get
		{
			return tid3_;
		}
		set
		{
			tid3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Qty3
	{
		get
		{
			return qty3_;
		}
		set
		{
			qty3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ActivityTask()
	{
	}

	[DebuggerNonUserCode]
	public ActivityTask(ActivityTask other)
		: this()
	{
		id_ = other.id_;
		title_ = other.title_;
		desc_ = other.desc_;
		rarity_ = other.rarity_;
		hide_ = other.hide_;
		jumpTo_ = other.jumpTo_.Clone();
		activityTaskGroupId_ = other.activityTaskGroupId_;
		activityGroupName_ = other.activityGroupName_;
		completeCond_ = other.completeCond_;
		completeCondClient_ = other.completeCondClient_;
		aimNumShow_ = other.aimNumShow_;
		prerequisites_ = other.prerequisites_.Clone();
		levelType_ = other.levelType_;
		clientCompleteParams1_ = other.clientCompleteParams1_.Clone();
		clientCompleteParams2_ = other.clientCompleteParams2_.Clone();
		tid1_ = other.tid1_;
		qty1_ = other.qty1_;
		tid2_ = other.tid2_;
		qty2_ = other.qty2_;
		tid3_ = other.tid3_;
		qty3_ = other.qty3_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ActivityTask Clone()
	{
		return new ActivityTask(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityTask);
	}

	[DebuggerNonUserCode]
	public bool Equals(ActivityTask other)
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
		if (Title != other.Title)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (Rarity != other.Rarity)
		{
			return false;
		}
		if (Hide != other.Hide)
		{
			return false;
		}
		if (!jumpTo_.Equals(other.jumpTo_))
		{
			return false;
		}
		if (ActivityTaskGroupId != other.ActivityTaskGroupId)
		{
			return false;
		}
		if (ActivityGroupName != other.ActivityGroupName)
		{
			return false;
		}
		if (CompleteCond != other.CompleteCond)
		{
			return false;
		}
		if (CompleteCondClient != other.CompleteCondClient)
		{
			return false;
		}
		if (AimNumShow != other.AimNumShow)
		{
			return false;
		}
		if (!prerequisites_.Equals(other.prerequisites_))
		{
			return false;
		}
		if (LevelType != other.LevelType)
		{
			return false;
		}
		if (!clientCompleteParams1_.Equals(other.clientCompleteParams1_))
		{
			return false;
		}
		if (!clientCompleteParams2_.Equals(other.clientCompleteParams2_))
		{
			return false;
		}
		if (Tid1 != other.Tid1)
		{
			return false;
		}
		if (Qty1 != other.Qty1)
		{
			return false;
		}
		if (Tid2 != other.Tid2)
		{
			return false;
		}
		if (Qty2 != other.Qty2)
		{
			return false;
		}
		if (Tid3 != other.Tid3)
		{
			return false;
		}
		if (Qty3 != other.Qty3)
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
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Rarity != 0)
		{
			num ^= Rarity.GetHashCode();
		}
		if (Hide)
		{
			num ^= Hide.GetHashCode();
		}
		num ^= jumpTo_.GetHashCode();
		if (ActivityTaskGroupId != 0)
		{
			num ^= ActivityTaskGroupId.GetHashCode();
		}
		if (ActivityGroupName.Length != 0)
		{
			num ^= ActivityGroupName.GetHashCode();
		}
		if (CompleteCond != 0)
		{
			num ^= CompleteCond.GetHashCode();
		}
		if (CompleteCondClient != 0)
		{
			num ^= CompleteCondClient.GetHashCode();
		}
		if (AimNumShow != 0)
		{
			num ^= AimNumShow.GetHashCode();
		}
		num ^= prerequisites_.GetHashCode();
		if (LevelType != 0)
		{
			num ^= LevelType.GetHashCode();
		}
		num ^= clientCompleteParams1_.GetHashCode();
		num ^= clientCompleteParams2_.GetHashCode();
		if (Tid1 != 0)
		{
			num ^= Tid1.GetHashCode();
		}
		if (Qty1 != 0)
		{
			num ^= Qty1.GetHashCode();
		}
		if (Tid2 != 0)
		{
			num ^= Tid2.GetHashCode();
		}
		if (Qty2 != 0)
		{
			num ^= Qty2.GetHashCode();
		}
		if (Tid3 != 0)
		{
			num ^= Tid3.GetHashCode();
		}
		if (Qty3 != 0)
		{
			num ^= Qty3.GetHashCode();
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
		if (Title.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Title);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Desc);
		}
		if (Rarity != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Rarity);
		}
		if (Hide)
		{
			output.WriteRawTag(40);
			output.WriteBool(Hide);
		}
		jumpTo_.WriteTo(output, _repeated_jumpTo_codec);
		if (ActivityTaskGroupId != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(ActivityTaskGroupId);
		}
		if (ActivityGroupName.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(ActivityGroupName);
		}
		if (CompleteCond != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(CompleteCond);
		}
		if (CompleteCondClient != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(CompleteCondClient);
		}
		if (AimNumShow != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(AimNumShow);
		}
		prerequisites_.WriteTo(output, _repeated_prerequisites_codec);
		if (LevelType != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(LevelType);
		}
		clientCompleteParams1_.WriteTo(output, _repeated_clientCompleteParams1_codec);
		clientCompleteParams2_.WriteTo(output, _repeated_clientCompleteParams2_codec);
		if (Tid1 != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(Tid1);
		}
		if (Qty1 != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(Qty1);
		}
		if (Tid2 != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(Tid2);
		}
		if (Qty2 != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(Qty2);
		}
		if (Tid3 != 0)
		{
			output.WriteRawTag(160, 1);
			output.WriteInt32(Tid3);
		}
		if (Qty3 != 0)
		{
			output.WriteRawTag(168, 1);
			output.WriteInt32(Qty3);
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
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Rarity != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Rarity);
		}
		if (Hide)
		{
			num += 2;
		}
		num += jumpTo_.CalculateSize(_repeated_jumpTo_codec);
		if (ActivityTaskGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActivityTaskGroupId);
		}
		if (ActivityGroupName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ActivityGroupName);
		}
		if (CompleteCond != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CompleteCond);
		}
		if (CompleteCondClient != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CompleteCondClient);
		}
		if (AimNumShow != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AimNumShow);
		}
		num += prerequisites_.CalculateSize(_repeated_prerequisites_codec);
		if (LevelType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LevelType);
		}
		num += clientCompleteParams1_.CalculateSize(_repeated_clientCompleteParams1_codec);
		num += clientCompleteParams2_.CalculateSize(_repeated_clientCompleteParams2_codec);
		if (Tid1 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Tid1);
		}
		if (Qty1 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Qty1);
		}
		if (Tid2 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Tid2);
		}
		if (Qty2 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Qty2);
		}
		if (Tid3 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Tid3);
		}
		if (Qty3 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Qty3);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ActivityTask other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.Rarity != 0)
			{
				Rarity = other.Rarity;
			}
			if (other.Hide)
			{
				Hide = other.Hide;
			}
			jumpTo_.Add(other.jumpTo_);
			if (other.ActivityTaskGroupId != 0)
			{
				ActivityTaskGroupId = other.ActivityTaskGroupId;
			}
			if (other.ActivityGroupName.Length != 0)
			{
				ActivityGroupName = other.ActivityGroupName;
			}
			if (other.CompleteCond != 0)
			{
				CompleteCond = other.CompleteCond;
			}
			if (other.CompleteCondClient != 0)
			{
				CompleteCondClient = other.CompleteCondClient;
			}
			if (other.AimNumShow != 0)
			{
				AimNumShow = other.AimNumShow;
			}
			prerequisites_.Add(other.prerequisites_);
			if (other.LevelType != 0)
			{
				LevelType = other.LevelType;
			}
			clientCompleteParams1_.Add(other.clientCompleteParams1_);
			clientCompleteParams2_.Add(other.clientCompleteParams2_);
			if (other.Tid1 != 0)
			{
				Tid1 = other.Tid1;
			}
			if (other.Qty1 != 0)
			{
				Qty1 = other.Qty1;
			}
			if (other.Tid2 != 0)
			{
				Tid2 = other.Tid2;
			}
			if (other.Qty2 != 0)
			{
				Qty2 = other.Qty2;
			}
			if (other.Tid3 != 0)
			{
				Tid3 = other.Tid3;
			}
			if (other.Qty3 != 0)
			{
				Qty3 = other.Qty3;
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
				Title = input.ReadString();
				break;
			case 26u:
				Desc = input.ReadString();
				break;
			case 32u:
				Rarity = input.ReadInt32();
				break;
			case 40u:
				Hide = input.ReadBool();
				break;
			case 48u:
			case 50u:
				jumpTo_.AddEntriesFrom(input, _repeated_jumpTo_codec);
				break;
			case 56u:
				ActivityTaskGroupId = input.ReadInt32();
				break;
			case 66u:
				ActivityGroupName = input.ReadString();
				break;
			case 72u:
				CompleteCond = input.ReadInt32();
				break;
			case 80u:
				CompleteCondClient = input.ReadInt32();
				break;
			case 88u:
				AimNumShow = input.ReadInt32();
				break;
			case 96u:
			case 98u:
				prerequisites_.AddEntriesFrom(input, _repeated_prerequisites_codec);
				break;
			case 104u:
				LevelType = input.ReadInt32();
				break;
			case 112u:
			case 114u:
				clientCompleteParams1_.AddEntriesFrom(input, _repeated_clientCompleteParams1_codec);
				break;
			case 120u:
			case 122u:
				clientCompleteParams2_.AddEntriesFrom(input, _repeated_clientCompleteParams2_codec);
				break;
			case 128u:
				Tid1 = input.ReadInt32();
				break;
			case 136u:
				Qty1 = input.ReadInt32();
				break;
			case 144u:
				Tid2 = input.ReadInt32();
				break;
			case 152u:
				Qty2 = input.ReadInt32();
				break;
			case 160u:
				Tid3 = input.ReadInt32();
				break;
			case 168u:
				Qty3 = input.ReadInt32();
				break;
			}
		}
	}
}
