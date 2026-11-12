using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DatingCharacterEvent : IMessage<DatingCharacterEvent>, IMessage, IEquatable<DatingCharacterEvent>, IDeepCloneable<DatingCharacterEvent>
{
	private static readonly MessageParser<DatingCharacterEvent> _parser = new MessageParser<DatingCharacterEvent>(() => new DatingCharacterEvent());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int DatingEventTypeFieldNumber = 2;

	private int datingEventType_;

	public const int DatingEventParamsFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_datingEventParams_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> datingEventParams_ = new RepeatedField<int>();

	public const int DatingEventExcludeFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_datingEventExclude_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> datingEventExclude_ = new RepeatedField<int>();

	public const int BranchTagFieldNumber = 5;

	private int branchTag_;

	public const int AffinityFieldNumber = 6;

	private int affinity_;

	public const int RewardFieldNumber = 7;

	private static readonly FieldCodec<int> _repeated_reward_codec = FieldCodec.ForInt32(58u);

	private readonly RepeatedField<int> reward_ = new RepeatedField<int>();

	public const int Desc1FieldNumber = 8;

	private string desc1_ = "";

	public const int Desc2FieldNumber = 9;

	private string desc2_ = "";

	public const int Desc3FieldNumber = 10;

	private string desc3_ = "";

	public const int ResponseFieldNumber = 11;

	private string response_ = "";

	public const int CGFieldNumber = 12;

	private string cG_ = "";

	public const int NameFieldNumber = 13;

	private string name_ = "";

	public const int ClueFieldNumber = 14;

	private string clue_ = "";

	public const int MemoryFieldNumber = 15;

	private string memory_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<DatingCharacterEvent> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(244);

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
	public int DatingEventType
	{
		get
		{
			return datingEventType_;
		}
		set
		{
			datingEventType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> DatingEventParams => datingEventParams_;

	[DebuggerNonUserCode]
	public RepeatedField<int> DatingEventExclude => datingEventExclude_;

	[DebuggerNonUserCode]
	public int BranchTag
	{
		get
		{
			return branchTag_;
		}
		set
		{
			branchTag_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Affinity
	{
		get
		{
			return affinity_;
		}
		set
		{
			affinity_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Reward => reward_;

	[DebuggerNonUserCode]
	public string Desc1
	{
		get
		{
			return desc1_;
		}
		set
		{
			desc1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Desc2
	{
		get
		{
			return desc2_;
		}
		set
		{
			desc2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Desc3
	{
		get
		{
			return desc3_;
		}
		set
		{
			desc3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Response
	{
		get
		{
			return response_;
		}
		set
		{
			response_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public string Clue
	{
		get
		{
			return clue_;
		}
		set
		{
			clue_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Memory
	{
		get
		{
			return memory_;
		}
		set
		{
			memory_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public DatingCharacterEvent()
	{
	}

	[DebuggerNonUserCode]
	public DatingCharacterEvent(DatingCharacterEvent other)
		: this()
	{
		id_ = other.id_;
		datingEventType_ = other.datingEventType_;
		datingEventParams_ = other.datingEventParams_.Clone();
		datingEventExclude_ = other.datingEventExclude_.Clone();
		branchTag_ = other.branchTag_;
		affinity_ = other.affinity_;
		reward_ = other.reward_.Clone();
		desc1_ = other.desc1_;
		desc2_ = other.desc2_;
		desc3_ = other.desc3_;
		response_ = other.response_;
		cG_ = other.cG_;
		name_ = other.name_;
		clue_ = other.clue_;
		memory_ = other.memory_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DatingCharacterEvent Clone()
	{
		return new DatingCharacterEvent(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DatingCharacterEvent);
	}

	[DebuggerNonUserCode]
	public bool Equals(DatingCharacterEvent other)
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
		if (DatingEventType != other.DatingEventType)
		{
			return false;
		}
		if (!datingEventParams_.Equals(other.datingEventParams_))
		{
			return false;
		}
		if (!datingEventExclude_.Equals(other.datingEventExclude_))
		{
			return false;
		}
		if (BranchTag != other.BranchTag)
		{
			return false;
		}
		if (Affinity != other.Affinity)
		{
			return false;
		}
		if (!reward_.Equals(other.reward_))
		{
			return false;
		}
		if (Desc1 != other.Desc1)
		{
			return false;
		}
		if (Desc2 != other.Desc2)
		{
			return false;
		}
		if (Desc3 != other.Desc3)
		{
			return false;
		}
		if (Response != other.Response)
		{
			return false;
		}
		if (CG != other.CG)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (Clue != other.Clue)
		{
			return false;
		}
		if (Memory != other.Memory)
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
		if (DatingEventType != 0)
		{
			num ^= DatingEventType.GetHashCode();
		}
		num ^= datingEventParams_.GetHashCode();
		num ^= datingEventExclude_.GetHashCode();
		if (BranchTag != 0)
		{
			num ^= BranchTag.GetHashCode();
		}
		if (Affinity != 0)
		{
			num ^= Affinity.GetHashCode();
		}
		num ^= reward_.GetHashCode();
		if (Desc1.Length != 0)
		{
			num ^= Desc1.GetHashCode();
		}
		if (Desc2.Length != 0)
		{
			num ^= Desc2.GetHashCode();
		}
		if (Desc3.Length != 0)
		{
			num ^= Desc3.GetHashCode();
		}
		if (Response.Length != 0)
		{
			num ^= Response.GetHashCode();
		}
		if (CG.Length != 0)
		{
			num ^= CG.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Clue.Length != 0)
		{
			num ^= Clue.GetHashCode();
		}
		if (Memory.Length != 0)
		{
			num ^= Memory.GetHashCode();
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
		if (DatingEventType != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(DatingEventType);
		}
		datingEventParams_.WriteTo(output, _repeated_datingEventParams_codec);
		datingEventExclude_.WriteTo(output, _repeated_datingEventExclude_codec);
		if (BranchTag != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(BranchTag);
		}
		if (Affinity != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Affinity);
		}
		reward_.WriteTo(output, _repeated_reward_codec);
		if (Desc1.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(Desc1);
		}
		if (Desc2.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(Desc2);
		}
		if (Desc3.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(Desc3);
		}
		if (Response.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(Response);
		}
		if (CG.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(CG);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(Name);
		}
		if (Clue.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(Clue);
		}
		if (Memory.Length != 0)
		{
			output.WriteRawTag(122);
			output.WriteString(Memory);
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
		if (DatingEventType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DatingEventType);
		}
		num += datingEventParams_.CalculateSize(_repeated_datingEventParams_codec);
		num += datingEventExclude_.CalculateSize(_repeated_datingEventExclude_codec);
		if (BranchTag != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BranchTag);
		}
		if (Affinity != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Affinity);
		}
		num += reward_.CalculateSize(_repeated_reward_codec);
		if (Desc1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc1);
		}
		if (Desc2.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc2);
		}
		if (Desc3.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc3);
		}
		if (Response.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Response);
		}
		if (CG.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CG);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Clue.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Clue);
		}
		if (Memory.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Memory);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(DatingCharacterEvent other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.DatingEventType != 0)
			{
				DatingEventType = other.DatingEventType;
			}
			datingEventParams_.Add(other.datingEventParams_);
			datingEventExclude_.Add(other.datingEventExclude_);
			if (other.BranchTag != 0)
			{
				BranchTag = other.BranchTag;
			}
			if (other.Affinity != 0)
			{
				Affinity = other.Affinity;
			}
			reward_.Add(other.reward_);
			if (other.Desc1.Length != 0)
			{
				Desc1 = other.Desc1;
			}
			if (other.Desc2.Length != 0)
			{
				Desc2 = other.Desc2;
			}
			if (other.Desc3.Length != 0)
			{
				Desc3 = other.Desc3;
			}
			if (other.Response.Length != 0)
			{
				Response = other.Response;
			}
			if (other.CG.Length != 0)
			{
				CG = other.CG;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Clue.Length != 0)
			{
				Clue = other.Clue;
			}
			if (other.Memory.Length != 0)
			{
				Memory = other.Memory;
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
				DatingEventType = input.ReadInt32();
				break;
			case 24u:
			case 26u:
				datingEventParams_.AddEntriesFrom(input, _repeated_datingEventParams_codec);
				break;
			case 32u:
			case 34u:
				datingEventExclude_.AddEntriesFrom(input, _repeated_datingEventExclude_codec);
				break;
			case 40u:
				BranchTag = input.ReadInt32();
				break;
			case 48u:
				Affinity = input.ReadInt32();
				break;
			case 56u:
			case 58u:
				reward_.AddEntriesFrom(input, _repeated_reward_codec);
				break;
			case 66u:
				Desc1 = input.ReadString();
				break;
			case 74u:
				Desc2 = input.ReadString();
				break;
			case 82u:
				Desc3 = input.ReadString();
				break;
			case 90u:
				Response = input.ReadString();
				break;
			case 98u:
				CG = input.ReadString();
				break;
			case 106u:
				Name = input.ReadString();
				break;
			case 114u:
				Clue = input.ReadString();
				break;
			case 122u:
				Memory = input.ReadString();
				break;
			}
		}
	}
}
