using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class Buff : IMessage<Buff>, IMessage, IEquatable<Buff>, IDeepCloneable<Buff>
{
	private static readonly MessageParser<Buff> _parser = new MessageParser<Buff>(() => new Buff());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int LevelTypeDataFieldNumber = 3;

	private int levelTypeData_;

	public const int LevelDataFieldNumber = 4;

	private int levelData_;

	public const int MainOrSupportFieldNumber = 5;

	private int mainOrSupport_;

	public const int GroupIdFieldNumber = 6;

	private int groupId_;

	public const int ReduceTimeFieldNumber = 7;

	private int reduceTime_;

	public const int BuffTag1FieldNumber = 8;

	private int buffTag1_;

	public const int BuffTag2FieldNumber = 9;

	private int buffTag2_;

	public const int BuffTag3FieldNumber = 10;

	private int buffTag3_;

	public const int BuffTag4FieldNumber = 11;

	private int buffTag4_;

	public const int BuffTag5FieldNumber = 12;

	private int buffTag5_;

	public const int BindEffectFieldNumber = 13;

	private string bindEffect_ = "";

	public const int IconFieldNumber = 14;

	private string icon_ = "";

	public const int IsShowFieldNumber = 15;

	private bool isShow_;

	public const int TopofHeadEffectFieldNumber = 16;

	private string topofHeadEffect_ = "";

	public const int BuffNumEffectLevelFieldNumber = 17;

	private static readonly FieldCodec<int> _repeated_buffNumEffectLevel_codec = FieldCodec.ForInt32(138u);

	private readonly RepeatedField<int> buffNumEffectLevel_ = new RepeatedField<int>();

	public const int NotRemoveFieldNumber = 18;

	private bool notRemove_;

	public const int ChangeTeamNotRemoveFieldNumber = 19;

	private bool changeTeamNotRemove_;

	[DebuggerNonUserCode]
	public static MessageParser<Buff> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(142);

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
	public int LevelTypeData
	{
		get
		{
			return levelTypeData_;
		}
		set
		{
			levelTypeData_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LevelData
	{
		get
		{
			return levelData_;
		}
		set
		{
			levelData_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MainOrSupport
	{
		get
		{
			return mainOrSupport_;
		}
		set
		{
			mainOrSupport_ = value;
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
	public int ReduceTime
	{
		get
		{
			return reduceTime_;
		}
		set
		{
			reduceTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BuffTag1
	{
		get
		{
			return buffTag1_;
		}
		set
		{
			buffTag1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BuffTag2
	{
		get
		{
			return buffTag2_;
		}
		set
		{
			buffTag2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BuffTag3
	{
		get
		{
			return buffTag3_;
		}
		set
		{
			buffTag3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BuffTag4
	{
		get
		{
			return buffTag4_;
		}
		set
		{
			buffTag4_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BuffTag5
	{
		get
		{
			return buffTag5_;
		}
		set
		{
			buffTag5_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string BindEffect
	{
		get
		{
			return bindEffect_;
		}
		set
		{
			bindEffect_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public bool IsShow
	{
		get
		{
			return isShow_;
		}
		set
		{
			isShow_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string TopofHeadEffect
	{
		get
		{
			return topofHeadEffect_;
		}
		set
		{
			topofHeadEffect_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> BuffNumEffectLevel => buffNumEffectLevel_;

	[DebuggerNonUserCode]
	public bool NotRemove
	{
		get
		{
			return notRemove_;
		}
		set
		{
			notRemove_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool ChangeTeamNotRemove
	{
		get
		{
			return changeTeamNotRemove_;
		}
		set
		{
			changeTeamNotRemove_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Buff()
	{
	}

	[DebuggerNonUserCode]
	public Buff(Buff other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		levelTypeData_ = other.levelTypeData_;
		levelData_ = other.levelData_;
		mainOrSupport_ = other.mainOrSupport_;
		groupId_ = other.groupId_;
		reduceTime_ = other.reduceTime_;
		buffTag1_ = other.buffTag1_;
		buffTag2_ = other.buffTag2_;
		buffTag3_ = other.buffTag3_;
		buffTag4_ = other.buffTag4_;
		buffTag5_ = other.buffTag5_;
		bindEffect_ = other.bindEffect_;
		icon_ = other.icon_;
		isShow_ = other.isShow_;
		topofHeadEffect_ = other.topofHeadEffect_;
		buffNumEffectLevel_ = other.buffNumEffectLevel_.Clone();
		notRemove_ = other.notRemove_;
		changeTeamNotRemove_ = other.changeTeamNotRemove_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public Buff Clone()
	{
		return new Buff(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Buff);
	}

	[DebuggerNonUserCode]
	public bool Equals(Buff other)
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
		if (LevelTypeData != other.LevelTypeData)
		{
			return false;
		}
		if (LevelData != other.LevelData)
		{
			return false;
		}
		if (MainOrSupport != other.MainOrSupport)
		{
			return false;
		}
		if (GroupId != other.GroupId)
		{
			return false;
		}
		if (ReduceTime != other.ReduceTime)
		{
			return false;
		}
		if (BuffTag1 != other.BuffTag1)
		{
			return false;
		}
		if (BuffTag2 != other.BuffTag2)
		{
			return false;
		}
		if (BuffTag3 != other.BuffTag3)
		{
			return false;
		}
		if (BuffTag4 != other.BuffTag4)
		{
			return false;
		}
		if (BuffTag5 != other.BuffTag5)
		{
			return false;
		}
		if (BindEffect != other.BindEffect)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (IsShow != other.IsShow)
		{
			return false;
		}
		if (TopofHeadEffect != other.TopofHeadEffect)
		{
			return false;
		}
		if (!buffNumEffectLevel_.Equals(other.buffNumEffectLevel_))
		{
			return false;
		}
		if (NotRemove != other.NotRemove)
		{
			return false;
		}
		if (ChangeTeamNotRemove != other.ChangeTeamNotRemove)
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
		if (LevelTypeData != 0)
		{
			num ^= LevelTypeData.GetHashCode();
		}
		if (LevelData != 0)
		{
			num ^= LevelData.GetHashCode();
		}
		if (MainOrSupport != 0)
		{
			num ^= MainOrSupport.GetHashCode();
		}
		if (GroupId != 0)
		{
			num ^= GroupId.GetHashCode();
		}
		if (ReduceTime != 0)
		{
			num ^= ReduceTime.GetHashCode();
		}
		if (BuffTag1 != 0)
		{
			num ^= BuffTag1.GetHashCode();
		}
		if (BuffTag2 != 0)
		{
			num ^= BuffTag2.GetHashCode();
		}
		if (BuffTag3 != 0)
		{
			num ^= BuffTag3.GetHashCode();
		}
		if (BuffTag4 != 0)
		{
			num ^= BuffTag4.GetHashCode();
		}
		if (BuffTag5 != 0)
		{
			num ^= BuffTag5.GetHashCode();
		}
		if (BindEffect.Length != 0)
		{
			num ^= BindEffect.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (IsShow)
		{
			num ^= IsShow.GetHashCode();
		}
		if (TopofHeadEffect.Length != 0)
		{
			num ^= TopofHeadEffect.GetHashCode();
		}
		num ^= buffNumEffectLevel_.GetHashCode();
		if (NotRemove)
		{
			num ^= NotRemove.GetHashCode();
		}
		if (ChangeTeamNotRemove)
		{
			num ^= ChangeTeamNotRemove.GetHashCode();
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
		if (LevelTypeData != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(LevelTypeData);
		}
		if (LevelData != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(LevelData);
		}
		if (MainOrSupport != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(MainOrSupport);
		}
		if (GroupId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(GroupId);
		}
		if (ReduceTime != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(ReduceTime);
		}
		if (BuffTag1 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(BuffTag1);
		}
		if (BuffTag2 != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(BuffTag2);
		}
		if (BuffTag3 != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(BuffTag3);
		}
		if (BuffTag4 != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(BuffTag4);
		}
		if (BuffTag5 != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(BuffTag5);
		}
		if (BindEffect.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(BindEffect);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(Icon);
		}
		if (IsShow)
		{
			output.WriteRawTag(120);
			output.WriteBool(IsShow);
		}
		if (TopofHeadEffect.Length != 0)
		{
			output.WriteRawTag(130, 1);
			output.WriteString(TopofHeadEffect);
		}
		buffNumEffectLevel_.WriteTo(output, _repeated_buffNumEffectLevel_codec);
		if (NotRemove)
		{
			output.WriteRawTag(144, 1);
			output.WriteBool(NotRemove);
		}
		if (ChangeTeamNotRemove)
		{
			output.WriteRawTag(152, 1);
			output.WriteBool(ChangeTeamNotRemove);
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
		if (LevelTypeData != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LevelTypeData);
		}
		if (LevelData != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LevelData);
		}
		if (MainOrSupport != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MainOrSupport);
		}
		if (GroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GroupId);
		}
		if (ReduceTime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ReduceTime);
		}
		if (BuffTag1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BuffTag1);
		}
		if (BuffTag2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BuffTag2);
		}
		if (BuffTag3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BuffTag3);
		}
		if (BuffTag4 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BuffTag4);
		}
		if (BuffTag5 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BuffTag5);
		}
		if (BindEffect.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BindEffect);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (IsShow)
		{
			num += 2;
		}
		if (TopofHeadEffect.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(TopofHeadEffect);
		}
		num += buffNumEffectLevel_.CalculateSize(_repeated_buffNumEffectLevel_codec);
		if (NotRemove)
		{
			num += 3;
		}
		if (ChangeTeamNotRemove)
		{
			num += 3;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Buff other)
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
			if (other.LevelTypeData != 0)
			{
				LevelTypeData = other.LevelTypeData;
			}
			if (other.LevelData != 0)
			{
				LevelData = other.LevelData;
			}
			if (other.MainOrSupport != 0)
			{
				MainOrSupport = other.MainOrSupport;
			}
			if (other.GroupId != 0)
			{
				GroupId = other.GroupId;
			}
			if (other.ReduceTime != 0)
			{
				ReduceTime = other.ReduceTime;
			}
			if (other.BuffTag1 != 0)
			{
				BuffTag1 = other.BuffTag1;
			}
			if (other.BuffTag2 != 0)
			{
				BuffTag2 = other.BuffTag2;
			}
			if (other.BuffTag3 != 0)
			{
				BuffTag3 = other.BuffTag3;
			}
			if (other.BuffTag4 != 0)
			{
				BuffTag4 = other.BuffTag4;
			}
			if (other.BuffTag5 != 0)
			{
				BuffTag5 = other.BuffTag5;
			}
			if (other.BindEffect.Length != 0)
			{
				BindEffect = other.BindEffect;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.IsShow)
			{
				IsShow = other.IsShow;
			}
			if (other.TopofHeadEffect.Length != 0)
			{
				TopofHeadEffect = other.TopofHeadEffect;
			}
			buffNumEffectLevel_.Add(other.buffNumEffectLevel_);
			if (other.NotRemove)
			{
				NotRemove = other.NotRemove;
			}
			if (other.ChangeTeamNotRemove)
			{
				ChangeTeamNotRemove = other.ChangeTeamNotRemove;
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
			case 24u:
				LevelTypeData = input.ReadInt32();
				break;
			case 32u:
				LevelData = input.ReadInt32();
				break;
			case 40u:
				MainOrSupport = input.ReadInt32();
				break;
			case 48u:
				GroupId = input.ReadInt32();
				break;
			case 56u:
				ReduceTime = input.ReadInt32();
				break;
			case 64u:
				BuffTag1 = input.ReadInt32();
				break;
			case 72u:
				BuffTag2 = input.ReadInt32();
				break;
			case 80u:
				BuffTag3 = input.ReadInt32();
				break;
			case 88u:
				BuffTag4 = input.ReadInt32();
				break;
			case 96u:
				BuffTag5 = input.ReadInt32();
				break;
			case 106u:
				BindEffect = input.ReadString();
				break;
			case 114u:
				Icon = input.ReadString();
				break;
			case 120u:
				IsShow = input.ReadBool();
				break;
			case 130u:
				TopofHeadEffect = input.ReadString();
				break;
			case 136u:
			case 138u:
				buffNumEffectLevel_.AddEntriesFrom(input, _repeated_buffNumEffectLevel_codec);
				break;
			case 144u:
				NotRemove = input.ReadBool();
				break;
			case 152u:
				ChangeTeamNotRemove = input.ReadBool();
				break;
			}
		}
	}
}
