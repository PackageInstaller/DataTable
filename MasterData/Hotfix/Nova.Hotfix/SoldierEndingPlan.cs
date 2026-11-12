using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierEndingPlan : IMessage<SoldierEndingPlan>, IMessage, IEquatable<SoldierEndingPlan>, IDeepCloneable<SoldierEndingPlan>
{
	private static readonly MessageParser<SoldierEndingPlan> _parser = new MessageParser<SoldierEndingPlan>(() => new SoldierEndingPlan());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int SeasonIdFieldNumber = 2;

	private int seasonId_;

	public const int EndingTitleFieldNumber = 3;

	private string endingTitle_ = "";

	public const int DescFieldNumber = 4;

	private string desc_ = "";

	public const int AVGIdFieldNumber = 5;

	private string aVGId_ = "";

	public const int IsBossCGFieldNumber = 6;

	private bool isBossCG_;

	public const int CGFieldNumber = 7;

	private string cG_ = "";

	public const int BossCGFieldNumber = 8;

	private string bossCG_ = "";

	public const int FloorIdFieldNumber = 9;

	private int floorId_;

	public const int EndingCondition1FieldNumber = 10;

	private int endingCondition1_;

	public const int EndingParam1FieldNumber = 11;

	private static readonly FieldCodec<int> _repeated_endingParam1_codec = FieldCodec.ForInt32(90u);

	private readonly RepeatedField<int> endingParam1_ = new RepeatedField<int>();

	public const int EndingCondition2FieldNumber = 12;

	private int endingCondition2_;

	public const int EndingParam2FieldNumber = 13;

	private static readonly FieldCodec<int> _repeated_endingParam2_codec = FieldCodec.ForInt32(106u);

	private readonly RepeatedField<int> endingParam2_ = new RepeatedField<int>();

	public const int EndingCondition3FieldNumber = 14;

	private int endingCondition3_;

	public const int EndingParam3FieldNumber = 15;

	private static readonly FieldCodec<int> _repeated_endingParam3_codec = FieldCodec.ForInt32(122u);

	private readonly RepeatedField<int> endingParam3_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<SoldierEndingPlan> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(756);

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
	public int SeasonId
	{
		get
		{
			return seasonId_;
		}
		set
		{
			seasonId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string EndingTitle
	{
		get
		{
			return endingTitle_;
		}
		set
		{
			endingTitle_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public string AVGId
	{
		get
		{
			return aVGId_;
		}
		set
		{
			aVGId_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public bool IsBossCG
	{
		get
		{
			return isBossCG_;
		}
		set
		{
			isBossCG_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string CG
	{
		get
		{
			return cG_;
		}
		set
		{
			cG_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string BossCG
	{
		get
		{
			return bossCG_;
		}
		set
		{
			bossCG_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public int EndingCondition1
	{
		get
		{
			return endingCondition1_;
		}
		set
		{
			endingCondition1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> EndingParam1 => endingParam1_;

	[DebuggerNonUserCode]
	public int EndingCondition2
	{
		get
		{
			return endingCondition2_;
		}
		set
		{
			endingCondition2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> EndingParam2 => endingParam2_;

	[DebuggerNonUserCode]
	public int EndingCondition3
	{
		get
		{
			return endingCondition3_;
		}
		set
		{
			endingCondition3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> EndingParam3 => endingParam3_;

	[DebuggerNonUserCode]
	public SoldierEndingPlan()
	{
	}

	[DebuggerNonUserCode]
	public SoldierEndingPlan(SoldierEndingPlan other)
		: this()
	{
		id_ = other.id_;
		seasonId_ = other.seasonId_;
		endingTitle_ = other.endingTitle_;
		desc_ = other.desc_;
		aVGId_ = other.aVGId_;
		isBossCG_ = other.isBossCG_;
		cG_ = other.cG_;
		bossCG_ = other.bossCG_;
		floorId_ = other.floorId_;
		endingCondition1_ = other.endingCondition1_;
		endingParam1_ = other.endingParam1_.Clone();
		endingCondition2_ = other.endingCondition2_;
		endingParam2_ = other.endingParam2_.Clone();
		endingCondition3_ = other.endingCondition3_;
		endingParam3_ = other.endingParam3_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierEndingPlan Clone()
	{
		return new SoldierEndingPlan(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierEndingPlan);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierEndingPlan other)
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
		if (SeasonId != other.SeasonId)
		{
			return false;
		}
		if (EndingTitle != other.EndingTitle)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (AVGId != other.AVGId)
		{
			return false;
		}
		if (IsBossCG != other.IsBossCG)
		{
			return false;
		}
		if (CG != other.CG)
		{
			return false;
		}
		if (BossCG != other.BossCG)
		{
			return false;
		}
		if (FloorId != other.FloorId)
		{
			return false;
		}
		if (EndingCondition1 != other.EndingCondition1)
		{
			return false;
		}
		if (!endingParam1_.Equals(other.endingParam1_))
		{
			return false;
		}
		if (EndingCondition2 != other.EndingCondition2)
		{
			return false;
		}
		if (!endingParam2_.Equals(other.endingParam2_))
		{
			return false;
		}
		if (EndingCondition3 != other.EndingCondition3)
		{
			return false;
		}
		if (!endingParam3_.Equals(other.endingParam3_))
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
		if (SeasonId != 0)
		{
			num ^= SeasonId.GetHashCode();
		}
		if (EndingTitle.Length != 0)
		{
			num ^= EndingTitle.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (AVGId.Length != 0)
		{
			num ^= AVGId.GetHashCode();
		}
		if (IsBossCG)
		{
			num ^= IsBossCG.GetHashCode();
		}
		if (CG.Length != 0)
		{
			num ^= CG.GetHashCode();
		}
		if (BossCG.Length != 0)
		{
			num ^= BossCG.GetHashCode();
		}
		if (FloorId != 0)
		{
			num ^= FloorId.GetHashCode();
		}
		if (EndingCondition1 != 0)
		{
			num ^= EndingCondition1.GetHashCode();
		}
		num ^= endingParam1_.GetHashCode();
		if (EndingCondition2 != 0)
		{
			num ^= EndingCondition2.GetHashCode();
		}
		num ^= endingParam2_.GetHashCode();
		if (EndingCondition3 != 0)
		{
			num ^= EndingCondition3.GetHashCode();
		}
		num ^= endingParam3_.GetHashCode();
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
		if (SeasonId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(SeasonId);
		}
		if (EndingTitle.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(EndingTitle);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Desc);
		}
		if (AVGId.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(AVGId);
		}
		if (IsBossCG)
		{
			output.WriteRawTag(48);
			output.WriteBool(IsBossCG);
		}
		if (CG.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(CG);
		}
		if (BossCG.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(BossCG);
		}
		if (FloorId != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(FloorId);
		}
		if (EndingCondition1 != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(EndingCondition1);
		}
		endingParam1_.WriteTo(output, _repeated_endingParam1_codec);
		if (EndingCondition2 != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(EndingCondition2);
		}
		endingParam2_.WriteTo(output, _repeated_endingParam2_codec);
		if (EndingCondition3 != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(EndingCondition3);
		}
		endingParam3_.WriteTo(output, _repeated_endingParam3_codec);
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
		if (SeasonId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SeasonId);
		}
		if (EndingTitle.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(EndingTitle);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (AVGId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AVGId);
		}
		if (IsBossCG)
		{
			num += 2;
		}
		if (CG.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CG);
		}
		if (BossCG.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BossCG);
		}
		if (FloorId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FloorId);
		}
		if (EndingCondition1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EndingCondition1);
		}
		num += endingParam1_.CalculateSize(_repeated_endingParam1_codec);
		if (EndingCondition2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EndingCondition2);
		}
		num += endingParam2_.CalculateSize(_repeated_endingParam2_codec);
		if (EndingCondition3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EndingCondition3);
		}
		num += endingParam3_.CalculateSize(_repeated_endingParam3_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierEndingPlan other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.SeasonId != 0)
			{
				SeasonId = other.SeasonId;
			}
			if (other.EndingTitle.Length != 0)
			{
				EndingTitle = other.EndingTitle;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.AVGId.Length != 0)
			{
				AVGId = other.AVGId;
			}
			if (other.IsBossCG)
			{
				IsBossCG = other.IsBossCG;
			}
			if (other.CG.Length != 0)
			{
				CG = other.CG;
			}
			if (other.BossCG.Length != 0)
			{
				BossCG = other.BossCG;
			}
			if (other.FloorId != 0)
			{
				FloorId = other.FloorId;
			}
			if (other.EndingCondition1 != 0)
			{
				EndingCondition1 = other.EndingCondition1;
			}
			endingParam1_.Add(other.endingParam1_);
			if (other.EndingCondition2 != 0)
			{
				EndingCondition2 = other.EndingCondition2;
			}
			endingParam2_.Add(other.endingParam2_);
			if (other.EndingCondition3 != 0)
			{
				EndingCondition3 = other.EndingCondition3;
			}
			endingParam3_.Add(other.endingParam3_);
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
				SeasonId = input.ReadInt32();
				break;
			case 26u:
				EndingTitle = input.ReadString();
				break;
			case 34u:
				Desc = input.ReadString();
				break;
			case 42u:
				AVGId = input.ReadString();
				break;
			case 48u:
				IsBossCG = input.ReadBool();
				break;
			case 58u:
				CG = input.ReadString();
				break;
			case 66u:
				BossCG = input.ReadString();
				break;
			case 72u:
				FloorId = input.ReadInt32();
				break;
			case 80u:
				EndingCondition1 = input.ReadInt32();
				break;
			case 88u:
			case 90u:
				endingParam1_.AddEntriesFrom(input, _repeated_endingParam1_codec);
				break;
			case 96u:
				EndingCondition2 = input.ReadInt32();
				break;
			case 104u:
			case 106u:
				endingParam2_.AddEntriesFrom(input, _repeated_endingParam2_codec);
				break;
			case 112u:
				EndingCondition3 = input.ReadInt32();
				break;
			case 120u:
			case 122u:
				endingParam3_.AddEntriesFrom(input, _repeated_endingParam3_codec);
				break;
			}
		}
	}
}
