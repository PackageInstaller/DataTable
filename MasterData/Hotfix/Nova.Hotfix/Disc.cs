using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class Disc : IMessage<Disc>, IMessage, IEquatable<Disc>, IDeepCloneable<Disc>
{
	private static readonly MessageParser<Disc> _parser = new MessageParser<Disc>(() => new Disc());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int EETFieldNumber = 2;

	private int eET_;

	public const int TagsFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_tags_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> tags_ = new RepeatedField<int>();

	public const int VisibleFieldNumber = 4;

	private bool visible_;

	public const int AvailableFieldNumber = 5;

	private bool available_;

	public const int DiscBgFieldNumber = 6;

	private string discBg_ = "";

	public const int StrengthenGroupIdFieldNumber = 7;

	private int strengthenGroupId_;

	public const int AttrBaseGroupIdFieldNumber = 8;

	private int attrBaseGroupId_;

	public const int AttrExtraGroupIdFieldNumber = 9;

	private int attrExtraGroupId_;

	public const int PromoteGroupIdFieldNumber = 10;

	private int promoteGroupId_;

	public const int TransformItemIdFieldNumber = 11;

	private int transformItemId_;

	public const int MaxStarTransformItemFieldNumber = 12;

	private static readonly FieldCodec<int> _repeated_maxStarTransformItem_codec = FieldCodec.ForInt32(98u);

	private readonly RepeatedField<int> maxStarTransformItem_ = new RepeatedField<int>();

	public const int ReadRewardFieldNumber = 13;

	private static readonly FieldCodec<int> _repeated_readReward_codec = FieldCodec.ForInt32(106u);

	private readonly RepeatedField<int> readReward_ = new RepeatedField<int>();

	public const int AVGReadRewardFieldNumber = 14;

	private static readonly FieldCodec<int> _repeated_aVGReadReward_codec = FieldCodec.ForInt32(114u);

	private readonly RepeatedField<int> aVGReadReward_ = new RepeatedField<int>();

	public const int MainSkillGroupIdFieldNumber = 15;

	private int mainSkillGroupId_;

	public const int SecondarySkillGroupId1FieldNumber = 16;

	private int secondarySkillGroupId1_;

	public const int SecondarySkillGroupId2FieldNumber = 17;

	private int secondarySkillGroupId2_;

	public const int SubNoteSkillGroupIdFieldNumber = 18;

	private int subNoteSkillGroupId_;

	public const int SkillScriptFieldNumber = 19;

	private string skillScript_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<Disc> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(272);

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
	public int EET
	{
		get
		{
			return eET_;
		}
		set
		{
			eET_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Tags => tags_;

	[DebuggerNonUserCode]
	public bool Visible
	{
		get
		{
			return visible_;
		}
		set
		{
			visible_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool Available
	{
		get
		{
			return available_;
		}
		set
		{
			available_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string DiscBg
	{
		get
		{
			return discBg_;
		}
		set
		{
			discBg_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int StrengthenGroupId
	{
		get
		{
			return strengthenGroupId_;
		}
		set
		{
			strengthenGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AttrBaseGroupId
	{
		get
		{
			return attrBaseGroupId_;
		}
		set
		{
			attrBaseGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AttrExtraGroupId
	{
		get
		{
			return attrExtraGroupId_;
		}
		set
		{
			attrExtraGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PromoteGroupId
	{
		get
		{
			return promoteGroupId_;
		}
		set
		{
			promoteGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TransformItemId
	{
		get
		{
			return transformItemId_;
		}
		set
		{
			transformItemId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> MaxStarTransformItem => maxStarTransformItem_;

	[DebuggerNonUserCode]
	public RepeatedField<int> ReadReward => readReward_;

	[DebuggerNonUserCode]
	public RepeatedField<int> AVGReadReward => aVGReadReward_;

	[DebuggerNonUserCode]
	public int MainSkillGroupId
	{
		get
		{
			return mainSkillGroupId_;
		}
		set
		{
			mainSkillGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SecondarySkillGroupId1
	{
		get
		{
			return secondarySkillGroupId1_;
		}
		set
		{
			secondarySkillGroupId1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SecondarySkillGroupId2
	{
		get
		{
			return secondarySkillGroupId2_;
		}
		set
		{
			secondarySkillGroupId2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SubNoteSkillGroupId
	{
		get
		{
			return subNoteSkillGroupId_;
		}
		set
		{
			subNoteSkillGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string SkillScript
	{
		get
		{
			return skillScript_;
		}
		set
		{
			skillScript_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public Disc()
	{
	}

	[DebuggerNonUserCode]
	public Disc(Disc other)
		: this()
	{
		id_ = other.id_;
		eET_ = other.eET_;
		tags_ = other.tags_.Clone();
		visible_ = other.visible_;
		available_ = other.available_;
		discBg_ = other.discBg_;
		strengthenGroupId_ = other.strengthenGroupId_;
		attrBaseGroupId_ = other.attrBaseGroupId_;
		attrExtraGroupId_ = other.attrExtraGroupId_;
		promoteGroupId_ = other.promoteGroupId_;
		transformItemId_ = other.transformItemId_;
		maxStarTransformItem_ = other.maxStarTransformItem_.Clone();
		readReward_ = other.readReward_.Clone();
		aVGReadReward_ = other.aVGReadReward_.Clone();
		mainSkillGroupId_ = other.mainSkillGroupId_;
		secondarySkillGroupId1_ = other.secondarySkillGroupId1_;
		secondarySkillGroupId2_ = other.secondarySkillGroupId2_;
		subNoteSkillGroupId_ = other.subNoteSkillGroupId_;
		skillScript_ = other.skillScript_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public Disc Clone()
	{
		return new Disc(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Disc);
	}

	[DebuggerNonUserCode]
	public bool Equals(Disc other)
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
		if (EET != other.EET)
		{
			return false;
		}
		if (!tags_.Equals(other.tags_))
		{
			return false;
		}
		if (Visible != other.Visible)
		{
			return false;
		}
		if (Available != other.Available)
		{
			return false;
		}
		if (DiscBg != other.DiscBg)
		{
			return false;
		}
		if (StrengthenGroupId != other.StrengthenGroupId)
		{
			return false;
		}
		if (AttrBaseGroupId != other.AttrBaseGroupId)
		{
			return false;
		}
		if (AttrExtraGroupId != other.AttrExtraGroupId)
		{
			return false;
		}
		if (PromoteGroupId != other.PromoteGroupId)
		{
			return false;
		}
		if (TransformItemId != other.TransformItemId)
		{
			return false;
		}
		if (!maxStarTransformItem_.Equals(other.maxStarTransformItem_))
		{
			return false;
		}
		if (!readReward_.Equals(other.readReward_))
		{
			return false;
		}
		if (!aVGReadReward_.Equals(other.aVGReadReward_))
		{
			return false;
		}
		if (MainSkillGroupId != other.MainSkillGroupId)
		{
			return false;
		}
		if (SecondarySkillGroupId1 != other.SecondarySkillGroupId1)
		{
			return false;
		}
		if (SecondarySkillGroupId2 != other.SecondarySkillGroupId2)
		{
			return false;
		}
		if (SubNoteSkillGroupId != other.SubNoteSkillGroupId)
		{
			return false;
		}
		if (SkillScript != other.SkillScript)
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
		if (EET != 0)
		{
			num ^= EET.GetHashCode();
		}
		num ^= tags_.GetHashCode();
		if (Visible)
		{
			num ^= Visible.GetHashCode();
		}
		if (Available)
		{
			num ^= Available.GetHashCode();
		}
		if (DiscBg.Length != 0)
		{
			num ^= DiscBg.GetHashCode();
		}
		if (StrengthenGroupId != 0)
		{
			num ^= StrengthenGroupId.GetHashCode();
		}
		if (AttrBaseGroupId != 0)
		{
			num ^= AttrBaseGroupId.GetHashCode();
		}
		if (AttrExtraGroupId != 0)
		{
			num ^= AttrExtraGroupId.GetHashCode();
		}
		if (PromoteGroupId != 0)
		{
			num ^= PromoteGroupId.GetHashCode();
		}
		if (TransformItemId != 0)
		{
			num ^= TransformItemId.GetHashCode();
		}
		num ^= maxStarTransformItem_.GetHashCode();
		num ^= readReward_.GetHashCode();
		num ^= aVGReadReward_.GetHashCode();
		if (MainSkillGroupId != 0)
		{
			num ^= MainSkillGroupId.GetHashCode();
		}
		if (SecondarySkillGroupId1 != 0)
		{
			num ^= SecondarySkillGroupId1.GetHashCode();
		}
		if (SecondarySkillGroupId2 != 0)
		{
			num ^= SecondarySkillGroupId2.GetHashCode();
		}
		if (SubNoteSkillGroupId != 0)
		{
			num ^= SubNoteSkillGroupId.GetHashCode();
		}
		if (SkillScript.Length != 0)
		{
			num ^= SkillScript.GetHashCode();
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
		if (EET != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(EET);
		}
		tags_.WriteTo(output, _repeated_tags_codec);
		if (Visible)
		{
			output.WriteRawTag(32);
			output.WriteBool(Visible);
		}
		if (Available)
		{
			output.WriteRawTag(40);
			output.WriteBool(Available);
		}
		if (DiscBg.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(DiscBg);
		}
		if (StrengthenGroupId != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(StrengthenGroupId);
		}
		if (AttrBaseGroupId != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(AttrBaseGroupId);
		}
		if (AttrExtraGroupId != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(AttrExtraGroupId);
		}
		if (PromoteGroupId != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(PromoteGroupId);
		}
		if (TransformItemId != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(TransformItemId);
		}
		maxStarTransformItem_.WriteTo(output, _repeated_maxStarTransformItem_codec);
		readReward_.WriteTo(output, _repeated_readReward_codec);
		aVGReadReward_.WriteTo(output, _repeated_aVGReadReward_codec);
		if (MainSkillGroupId != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(MainSkillGroupId);
		}
		if (SecondarySkillGroupId1 != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(SecondarySkillGroupId1);
		}
		if (SecondarySkillGroupId2 != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(SecondarySkillGroupId2);
		}
		if (SubNoteSkillGroupId != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(SubNoteSkillGroupId);
		}
		if (SkillScript.Length != 0)
		{
			output.WriteRawTag(154, 1);
			output.WriteString(SkillScript);
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
		if (EET != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EET);
		}
		num += tags_.CalculateSize(_repeated_tags_codec);
		if (Visible)
		{
			num += 2;
		}
		if (Available)
		{
			num += 2;
		}
		if (DiscBg.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DiscBg);
		}
		if (StrengthenGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StrengthenGroupId);
		}
		if (AttrBaseGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AttrBaseGroupId);
		}
		if (AttrExtraGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AttrExtraGroupId);
		}
		if (PromoteGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PromoteGroupId);
		}
		if (TransformItemId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TransformItemId);
		}
		num += maxStarTransformItem_.CalculateSize(_repeated_maxStarTransformItem_codec);
		num += readReward_.CalculateSize(_repeated_readReward_codec);
		num += aVGReadReward_.CalculateSize(_repeated_aVGReadReward_codec);
		if (MainSkillGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MainSkillGroupId);
		}
		if (SecondarySkillGroupId1 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SecondarySkillGroupId1);
		}
		if (SecondarySkillGroupId2 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SecondarySkillGroupId2);
		}
		if (SubNoteSkillGroupId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SubNoteSkillGroupId);
		}
		if (SkillScript.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(SkillScript);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Disc other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.EET != 0)
			{
				EET = other.EET;
			}
			tags_.Add(other.tags_);
			if (other.Visible)
			{
				Visible = other.Visible;
			}
			if (other.Available)
			{
				Available = other.Available;
			}
			if (other.DiscBg.Length != 0)
			{
				DiscBg = other.DiscBg;
			}
			if (other.StrengthenGroupId != 0)
			{
				StrengthenGroupId = other.StrengthenGroupId;
			}
			if (other.AttrBaseGroupId != 0)
			{
				AttrBaseGroupId = other.AttrBaseGroupId;
			}
			if (other.AttrExtraGroupId != 0)
			{
				AttrExtraGroupId = other.AttrExtraGroupId;
			}
			if (other.PromoteGroupId != 0)
			{
				PromoteGroupId = other.PromoteGroupId;
			}
			if (other.TransformItemId != 0)
			{
				TransformItemId = other.TransformItemId;
			}
			maxStarTransformItem_.Add(other.maxStarTransformItem_);
			readReward_.Add(other.readReward_);
			aVGReadReward_.Add(other.aVGReadReward_);
			if (other.MainSkillGroupId != 0)
			{
				MainSkillGroupId = other.MainSkillGroupId;
			}
			if (other.SecondarySkillGroupId1 != 0)
			{
				SecondarySkillGroupId1 = other.SecondarySkillGroupId1;
			}
			if (other.SecondarySkillGroupId2 != 0)
			{
				SecondarySkillGroupId2 = other.SecondarySkillGroupId2;
			}
			if (other.SubNoteSkillGroupId != 0)
			{
				SubNoteSkillGroupId = other.SubNoteSkillGroupId;
			}
			if (other.SkillScript.Length != 0)
			{
				SkillScript = other.SkillScript;
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
				EET = input.ReadInt32();
				break;
			case 24u:
			case 26u:
				tags_.AddEntriesFrom(input, _repeated_tags_codec);
				break;
			case 32u:
				Visible = input.ReadBool();
				break;
			case 40u:
				Available = input.ReadBool();
				break;
			case 50u:
				DiscBg = input.ReadString();
				break;
			case 56u:
				StrengthenGroupId = input.ReadInt32();
				break;
			case 64u:
				AttrBaseGroupId = input.ReadInt32();
				break;
			case 72u:
				AttrExtraGroupId = input.ReadInt32();
				break;
			case 80u:
				PromoteGroupId = input.ReadInt32();
				break;
			case 88u:
				TransformItemId = input.ReadInt32();
				break;
			case 96u:
			case 98u:
				maxStarTransformItem_.AddEntriesFrom(input, _repeated_maxStarTransformItem_codec);
				break;
			case 104u:
			case 106u:
				readReward_.AddEntriesFrom(input, _repeated_readReward_codec);
				break;
			case 112u:
			case 114u:
				aVGReadReward_.AddEntriesFrom(input, _repeated_aVGReadReward_codec);
				break;
			case 120u:
				MainSkillGroupId = input.ReadInt32();
				break;
			case 128u:
				SecondarySkillGroupId1 = input.ReadInt32();
				break;
			case 136u:
				SecondarySkillGroupId2 = input.ReadInt32();
				break;
			case 144u:
				SubNoteSkillGroupId = input.ReadInt32();
				break;
			case 154u:
				SkillScript = input.ReadString();
				break;
			}
		}
	}
}
