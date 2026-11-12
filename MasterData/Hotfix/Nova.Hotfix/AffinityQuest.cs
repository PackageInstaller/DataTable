using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class AffinityQuest : IMessage<AffinityQuest>, IMessage, IEquatable<AffinityQuest>, IDeepCloneable<AffinityQuest>
{
	private static readonly MessageParser<AffinityQuest> _parser = new MessageParser<AffinityQuest>(() => new AffinityQuest());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int DescFieldNumber = 2;

	private string desc_ = "";

	public const int SortIdFieldNumber = 3;

	private int sortId_;

	public const int CharIdFieldNumber = 4;

	private int charId_;

	public const int CompleteCondFieldNumber = 5;

	private int completeCond_;

	public const int CompleteCondParamsFieldNumber = 6;

	private string completeCondParams_ = "";

	public const int RewardFieldNumber = 7;

	private static readonly FieldCodec<int> _repeated_reward_codec = FieldCodec.ForInt32(58u);

	private readonly RepeatedField<int> reward_ = new RepeatedField<int>();

	public const int AffinityExpFieldNumber = 8;

	private int affinityExp_;

	public const int Param1FieldNumber = 9;

	private string param1_ = "";

	public const int Param2FieldNumber = 10;

	private string param2_ = "";

	public const int Param3FieldNumber = 11;

	private string param3_ = "";

	public const int Param4FieldNumber = 12;

	private string param4_ = "";

	public const int Param5FieldNumber = 13;

	private string param5_ = "";

	public const int Param6FieldNumber = 14;

	private string param6_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<AffinityQuest> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(82);

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
	public int SortId
	{
		get
		{
			return sortId_;
		}
		set
		{
			sortId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CharId
	{
		get
		{
			return charId_;
		}
		set
		{
			charId_ = value;
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
	public string CompleteCondParams
	{
		get
		{
			return completeCondParams_;
		}
		set
		{
			completeCondParams_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Reward => reward_;

	[DebuggerNonUserCode]
	public int AffinityExp
	{
		get
		{
			return affinityExp_;
		}
		set
		{
			affinityExp_ = value;
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
	public AffinityQuest()
	{
	}

	[DebuggerNonUserCode]
	public AffinityQuest(AffinityQuest other)
		: this()
	{
		id_ = other.id_;
		desc_ = other.desc_;
		sortId_ = other.sortId_;
		charId_ = other.charId_;
		completeCond_ = other.completeCond_;
		completeCondParams_ = other.completeCondParams_;
		reward_ = other.reward_.Clone();
		affinityExp_ = other.affinityExp_;
		param1_ = other.param1_;
		param2_ = other.param2_;
		param3_ = other.param3_;
		param4_ = other.param4_;
		param5_ = other.param5_;
		param6_ = other.param6_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public AffinityQuest Clone()
	{
		return new AffinityQuest(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as AffinityQuest);
	}

	[DebuggerNonUserCode]
	public bool Equals(AffinityQuest other)
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
		if (Desc != other.Desc)
		{
			return false;
		}
		if (SortId != other.SortId)
		{
			return false;
		}
		if (CharId != other.CharId)
		{
			return false;
		}
		if (CompleteCond != other.CompleteCond)
		{
			return false;
		}
		if (CompleteCondParams != other.CompleteCondParams)
		{
			return false;
		}
		if (!reward_.Equals(other.reward_))
		{
			return false;
		}
		if (AffinityExp != other.AffinityExp)
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
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (SortId != 0)
		{
			num ^= SortId.GetHashCode();
		}
		if (CharId != 0)
		{
			num ^= CharId.GetHashCode();
		}
		if (CompleteCond != 0)
		{
			num ^= CompleteCond.GetHashCode();
		}
		if (CompleteCondParams.Length != 0)
		{
			num ^= CompleteCondParams.GetHashCode();
		}
		num ^= reward_.GetHashCode();
		if (AffinityExp != 0)
		{
			num ^= AffinityExp.GetHashCode();
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
		if (Desc.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Desc);
		}
		if (SortId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(SortId);
		}
		if (CharId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(CharId);
		}
		if (CompleteCond != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(CompleteCond);
		}
		if (CompleteCondParams.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(CompleteCondParams);
		}
		reward_.WriteTo(output, _repeated_reward_codec);
		if (AffinityExp != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(AffinityExp);
		}
		if (Param1.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(Param1);
		}
		if (Param2.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(Param2);
		}
		if (Param3.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(Param3);
		}
		if (Param4.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(Param4);
		}
		if (Param5.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(Param5);
		}
		if (Param6.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(Param6);
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
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (SortId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SortId);
		}
		if (CharId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CharId);
		}
		if (CompleteCond != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CompleteCond);
		}
		if (CompleteCondParams.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CompleteCondParams);
		}
		num += reward_.CalculateSize(_repeated_reward_codec);
		if (AffinityExp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AffinityExp);
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
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(AffinityQuest other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.SortId != 0)
			{
				SortId = other.SortId;
			}
			if (other.CharId != 0)
			{
				CharId = other.CharId;
			}
			if (other.CompleteCond != 0)
			{
				CompleteCond = other.CompleteCond;
			}
			if (other.CompleteCondParams.Length != 0)
			{
				CompleteCondParams = other.CompleteCondParams;
			}
			reward_.Add(other.reward_);
			if (other.AffinityExp != 0)
			{
				AffinityExp = other.AffinityExp;
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
				Desc = input.ReadString();
				break;
			case 24u:
				SortId = input.ReadInt32();
				break;
			case 32u:
				CharId = input.ReadInt32();
				break;
			case 40u:
				CompleteCond = input.ReadInt32();
				break;
			case 50u:
				CompleteCondParams = input.ReadString();
				break;
			case 56u:
			case 58u:
				reward_.AddEntriesFrom(input, _repeated_reward_codec);
				break;
			case 64u:
				AffinityExp = input.ReadInt32();
				break;
			case 74u:
				Param1 = input.ReadString();
				break;
			case 82u:
				Param2 = input.ReadString();
				break;
			case 90u:
				Param3 = input.ReadString();
				break;
			case 98u:
				Param4 = input.ReadString();
				break;
			case 106u:
				Param5 = input.ReadString();
				break;
			case 114u:
				Param6 = input.ReadString();
				break;
			}
		}
	}
}
