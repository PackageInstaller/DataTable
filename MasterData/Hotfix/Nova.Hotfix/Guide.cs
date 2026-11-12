using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class Guide : IMessage<Guide>, IMessage, IEquatable<Guide>, IDeepCloneable<Guide>
{
	private static readonly MessageParser<Guide> _parser = new MessageParser<Guide>(() => new Guide());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupIdFieldNumber = 2;

	private int groupId_;

	public const int StepFieldNumber = 3;

	private int step_;

	public const int TypeFieldNumber = 4;

	private int type_;

	public const int GuidePreposeFieldNumber = 5;

	private int guidePrepose_;

	public const int PreposeParamsFieldNumber = 6;

	private string preposeParams_ = "";

	public const int GuideTriggerFieldNumber = 7;

	private int guideTrigger_;

	public const int TriggerParamsFieldNumber = 8;

	private string triggerParams_ = "";

	public const int EndTypeFieldNumber = 9;

	private int endType_;

	public const int CenterOffsetFieldNumber = 10;

	private float centerOffset_;

	public const int BindIconFieldNumber = 11;

	private static readonly FieldCodec<string> _repeated_bindIcon_codec = FieldCodec.ForString(90u);

	private readonly RepeatedField<string> bindIcon_ = new RepeatedField<string>();

	public const int BindIconChildCountFieldNumber = 12;

	private int bindIconChildCount_;

	public const int SizeFieldNumber = 13;

	private static readonly FieldCodec<int> _repeated_size_codec = FieldCodec.ForInt32(106u);

	private readonly RepeatedField<int> size_ = new RepeatedField<int>();

	public const int DeviationFieldNumber = 14;

	private static readonly FieldCodec<int> _repeated_deviation_codec = FieldCodec.ForInt32(114u);

	private readonly RepeatedField<int> deviation_ = new RepeatedField<int>();

	public const int DelayFieldNumber = 15;

	private int delay_;

	public const int HeadFieldNumber = 16;

	private string head_ = "";

	public const int DescFieldNumber = 17;

	private string desc_ = "";

	public const int DescDeviationFieldNumber = 18;

	private static readonly FieldCodec<int> _repeated_descDeviation_codec = FieldCodec.ForInt32(146u);

	private readonly RepeatedField<int> descDeviation_ = new RepeatedField<int>();

	public const int HandDeviationFieldNumber = 19;

	private static readonly FieldCodec<int> _repeated_handDeviation_codec = FieldCodec.ForInt32(154u);

	private readonly RepeatedField<int> handDeviation_ = new RepeatedField<int>();

	public const int HandRotationFieldNumber = 20;

	private int handRotation_;

	public const int DictionaryFieldNumber = 21;

	private int dictionary_;

	public const int AvgIdFieldNumber = 22;

	private string avgId_ = "";

	public const int IsActiveFieldNumber = 23;

	private bool isActive_;

	[DebuggerNonUserCode]
	public static MessageParser<Guide> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(410);

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
	public int Step
	{
		get
		{
			return step_;
		}
		set
		{
			step_ = value;
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
	public int GuidePrepose
	{
		get
		{
			return guidePrepose_;
		}
		set
		{
			guidePrepose_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string PreposeParams
	{
		get
		{
			return preposeParams_;
		}
		set
		{
			preposeParams_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int GuideTrigger
	{
		get
		{
			return guideTrigger_;
		}
		set
		{
			guideTrigger_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string TriggerParams
	{
		get
		{
			return triggerParams_;
		}
		set
		{
			triggerParams_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int EndType
	{
		get
		{
			return endType_;
		}
		set
		{
			endType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float CenterOffset
	{
		get
		{
			return centerOffset_;
		}
		set
		{
			centerOffset_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<string> BindIcon => bindIcon_;

	[DebuggerNonUserCode]
	public int BindIconChildCount
	{
		get
		{
			return bindIconChildCount_;
		}
		set
		{
			bindIconChildCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Size => size_;

	[DebuggerNonUserCode]
	public RepeatedField<int> Deviation => deviation_;

	[DebuggerNonUserCode]
	public int Delay
	{
		get
		{
			return delay_;
		}
		set
		{
			delay_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Head
	{
		get
		{
			return head_;
		}
		set
		{
			head_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public RepeatedField<int> DescDeviation => descDeviation_;

	[DebuggerNonUserCode]
	public RepeatedField<int> HandDeviation => handDeviation_;

	[DebuggerNonUserCode]
	public int HandRotation
	{
		get
		{
			return handRotation_;
		}
		set
		{
			handRotation_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Dictionary
	{
		get
		{
			return dictionary_;
		}
		set
		{
			dictionary_ = value;
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
	public bool IsActive
	{
		get
		{
			return isActive_;
		}
		set
		{
			isActive_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Guide()
	{
	}

	[DebuggerNonUserCode]
	public Guide(Guide other)
		: this()
	{
		id_ = other.id_;
		groupId_ = other.groupId_;
		step_ = other.step_;
		type_ = other.type_;
		guidePrepose_ = other.guidePrepose_;
		preposeParams_ = other.preposeParams_;
		guideTrigger_ = other.guideTrigger_;
		triggerParams_ = other.triggerParams_;
		endType_ = other.endType_;
		centerOffset_ = other.centerOffset_;
		bindIcon_ = other.bindIcon_.Clone();
		bindIconChildCount_ = other.bindIconChildCount_;
		size_ = other.size_.Clone();
		deviation_ = other.deviation_.Clone();
		delay_ = other.delay_;
		head_ = other.head_;
		desc_ = other.desc_;
		descDeviation_ = other.descDeviation_.Clone();
		handDeviation_ = other.handDeviation_.Clone();
		handRotation_ = other.handRotation_;
		dictionary_ = other.dictionary_;
		avgId_ = other.avgId_;
		isActive_ = other.isActive_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public Guide Clone()
	{
		return new Guide(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Guide);
	}

	[DebuggerNonUserCode]
	public bool Equals(Guide other)
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
		if (Step != other.Step)
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (GuidePrepose != other.GuidePrepose)
		{
			return false;
		}
		if (PreposeParams != other.PreposeParams)
		{
			return false;
		}
		if (GuideTrigger != other.GuideTrigger)
		{
			return false;
		}
		if (TriggerParams != other.TriggerParams)
		{
			return false;
		}
		if (EndType != other.EndType)
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(CenterOffset, other.CenterOffset))
		{
			return false;
		}
		if (!bindIcon_.Equals(other.bindIcon_))
		{
			return false;
		}
		if (BindIconChildCount != other.BindIconChildCount)
		{
			return false;
		}
		if (!size_.Equals(other.size_))
		{
			return false;
		}
		if (!deviation_.Equals(other.deviation_))
		{
			return false;
		}
		if (Delay != other.Delay)
		{
			return false;
		}
		if (Head != other.Head)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (!descDeviation_.Equals(other.descDeviation_))
		{
			return false;
		}
		if (!handDeviation_.Equals(other.handDeviation_))
		{
			return false;
		}
		if (HandRotation != other.HandRotation)
		{
			return false;
		}
		if (Dictionary != other.Dictionary)
		{
			return false;
		}
		if (AvgId != other.AvgId)
		{
			return false;
		}
		if (IsActive != other.IsActive)
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
		if (Step != 0)
		{
			num ^= Step.GetHashCode();
		}
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (GuidePrepose != 0)
		{
			num ^= GuidePrepose.GetHashCode();
		}
		if (PreposeParams.Length != 0)
		{
			num ^= PreposeParams.GetHashCode();
		}
		if (GuideTrigger != 0)
		{
			num ^= GuideTrigger.GetHashCode();
		}
		if (TriggerParams.Length != 0)
		{
			num ^= TriggerParams.GetHashCode();
		}
		if (EndType != 0)
		{
			num ^= EndType.GetHashCode();
		}
		if (CenterOffset != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(CenterOffset);
		}
		num ^= bindIcon_.GetHashCode();
		if (BindIconChildCount != 0)
		{
			num ^= BindIconChildCount.GetHashCode();
		}
		num ^= size_.GetHashCode();
		num ^= deviation_.GetHashCode();
		if (Delay != 0)
		{
			num ^= Delay.GetHashCode();
		}
		if (Head.Length != 0)
		{
			num ^= Head.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		num ^= descDeviation_.GetHashCode();
		num ^= handDeviation_.GetHashCode();
		if (HandRotation != 0)
		{
			num ^= HandRotation.GetHashCode();
		}
		if (Dictionary != 0)
		{
			num ^= Dictionary.GetHashCode();
		}
		if (AvgId.Length != 0)
		{
			num ^= AvgId.GetHashCode();
		}
		if (IsActive)
		{
			num ^= IsActive.GetHashCode();
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
		if (Step != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Step);
		}
		if (Type != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Type);
		}
		if (GuidePrepose != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(GuidePrepose);
		}
		if (PreposeParams.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(PreposeParams);
		}
		if (GuideTrigger != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(GuideTrigger);
		}
		if (TriggerParams.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(TriggerParams);
		}
		if (EndType != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(EndType);
		}
		if (CenterOffset != 0f)
		{
			output.WriteRawTag(85);
			output.WriteFloat(CenterOffset);
		}
		bindIcon_.WriteTo(output, _repeated_bindIcon_codec);
		if (BindIconChildCount != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(BindIconChildCount);
		}
		size_.WriteTo(output, _repeated_size_codec);
		deviation_.WriteTo(output, _repeated_deviation_codec);
		if (Delay != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(Delay);
		}
		if (Head.Length != 0)
		{
			output.WriteRawTag(130, 1);
			output.WriteString(Head);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(138, 1);
			output.WriteString(Desc);
		}
		descDeviation_.WriteTo(output, _repeated_descDeviation_codec);
		handDeviation_.WriteTo(output, _repeated_handDeviation_codec);
		if (HandRotation != 0)
		{
			output.WriteRawTag(160, 1);
			output.WriteInt32(HandRotation);
		}
		if (Dictionary != 0)
		{
			output.WriteRawTag(168, 1);
			output.WriteInt32(Dictionary);
		}
		if (AvgId.Length != 0)
		{
			output.WriteRawTag(178, 1);
			output.WriteString(AvgId);
		}
		if (IsActive)
		{
			output.WriteRawTag(184, 1);
			output.WriteBool(IsActive);
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
		if (Step != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Step);
		}
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (GuidePrepose != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GuidePrepose);
		}
		if (PreposeParams.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PreposeParams);
		}
		if (GuideTrigger != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GuideTrigger);
		}
		if (TriggerParams.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(TriggerParams);
		}
		if (EndType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EndType);
		}
		if (CenterOffset != 0f)
		{
			num += 5;
		}
		num += bindIcon_.CalculateSize(_repeated_bindIcon_codec);
		if (BindIconChildCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BindIconChildCount);
		}
		num += size_.CalculateSize(_repeated_size_codec);
		num += deviation_.CalculateSize(_repeated_deviation_codec);
		if (Delay != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Delay);
		}
		if (Head.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Head);
		}
		if (Desc.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Desc);
		}
		num += descDeviation_.CalculateSize(_repeated_descDeviation_codec);
		num += handDeviation_.CalculateSize(_repeated_handDeviation_codec);
		if (HandRotation != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(HandRotation);
		}
		if (Dictionary != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Dictionary);
		}
		if (AvgId.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(AvgId);
		}
		if (IsActive)
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
	public void MergeFrom(Guide other)
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
			if (other.Step != 0)
			{
				Step = other.Step;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.GuidePrepose != 0)
			{
				GuidePrepose = other.GuidePrepose;
			}
			if (other.PreposeParams.Length != 0)
			{
				PreposeParams = other.PreposeParams;
			}
			if (other.GuideTrigger != 0)
			{
				GuideTrigger = other.GuideTrigger;
			}
			if (other.TriggerParams.Length != 0)
			{
				TriggerParams = other.TriggerParams;
			}
			if (other.EndType != 0)
			{
				EndType = other.EndType;
			}
			if (other.CenterOffset != 0f)
			{
				CenterOffset = other.CenterOffset;
			}
			bindIcon_.Add(other.bindIcon_);
			if (other.BindIconChildCount != 0)
			{
				BindIconChildCount = other.BindIconChildCount;
			}
			size_.Add(other.size_);
			deviation_.Add(other.deviation_);
			if (other.Delay != 0)
			{
				Delay = other.Delay;
			}
			if (other.Head.Length != 0)
			{
				Head = other.Head;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			descDeviation_.Add(other.descDeviation_);
			handDeviation_.Add(other.handDeviation_);
			if (other.HandRotation != 0)
			{
				HandRotation = other.HandRotation;
			}
			if (other.Dictionary != 0)
			{
				Dictionary = other.Dictionary;
			}
			if (other.AvgId.Length != 0)
			{
				AvgId = other.AvgId;
			}
			if (other.IsActive)
			{
				IsActive = other.IsActive;
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
				Step = input.ReadInt32();
				break;
			case 32u:
				Type = input.ReadInt32();
				break;
			case 40u:
				GuidePrepose = input.ReadInt32();
				break;
			case 50u:
				PreposeParams = input.ReadString();
				break;
			case 56u:
				GuideTrigger = input.ReadInt32();
				break;
			case 66u:
				TriggerParams = input.ReadString();
				break;
			case 72u:
				EndType = input.ReadInt32();
				break;
			case 85u:
				CenterOffset = input.ReadFloat();
				break;
			case 90u:
				bindIcon_.AddEntriesFrom(input, _repeated_bindIcon_codec);
				break;
			case 96u:
				BindIconChildCount = input.ReadInt32();
				break;
			case 104u:
			case 106u:
				size_.AddEntriesFrom(input, _repeated_size_codec);
				break;
			case 112u:
			case 114u:
				deviation_.AddEntriesFrom(input, _repeated_deviation_codec);
				break;
			case 120u:
				Delay = input.ReadInt32();
				break;
			case 130u:
				Head = input.ReadString();
				break;
			case 138u:
				Desc = input.ReadString();
				break;
			case 144u:
			case 146u:
				descDeviation_.AddEntriesFrom(input, _repeated_descDeviation_codec);
				break;
			case 152u:
			case 154u:
				handDeviation_.AddEntriesFrom(input, _repeated_handDeviation_codec);
				break;
			case 160u:
				HandRotation = input.ReadInt32();
				break;
			case 168u:
				Dictionary = input.ReadInt32();
				break;
			case 178u:
				AvgId = input.ReadString();
				break;
			case 184u:
				IsActive = input.ReadBool();
				break;
			}
		}
	}
}
