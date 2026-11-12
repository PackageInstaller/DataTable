using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StarTowerBookFateCardQuest : IMessage<StarTowerBookFateCardQuest>, IMessage, IEquatable<StarTowerBookFateCardQuest>, IDeepCloneable<StarTowerBookFateCardQuest>
{
	private static readonly MessageParser<StarTowerBookFateCardQuest> _parser = new MessageParser<StarTowerBookFateCardQuest>(() => new StarTowerBookFateCardQuest());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int BundleIdFieldNumber = 2;

	private int bundleId_;

	public const int DescFieldNumber = 3;

	private string desc_ = "";

	public const int FinishTypeFieldNumber = 4;

	private int finishType_;

	public const int FinishParamsFieldNumber = 5;

	private string finishParams_ = "";

	public const int Tid1FieldNumber = 6;

	private int tid1_;

	public const int Qty1FieldNumber = 7;

	private int qty1_;

	public const int Tid2FieldNumber = 8;

	private int tid2_;

	public const int Qty2FieldNumber = 9;

	private int qty2_;

	public const int Tid3FieldNumber = 10;

	private int tid3_;

	public const int Qty3FieldNumber = 11;

	private int qty3_;

	public const int Param1FieldNumber = 12;

	private string param1_ = "";

	public const int Param2FieldNumber = 13;

	private string param2_ = "";

	public const int Param3FieldNumber = 14;

	private string param3_ = "";

	public const int Param4FieldNumber = 15;

	private string param4_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<StarTowerBookFateCardQuest> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(826);

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
	public int BundleId
	{
		get
		{
			return bundleId_;
		}
		set
		{
			bundleId_ = value;
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
	public int FinishType
	{
		get
		{
			return finishType_;
		}
		set
		{
			finishType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string FinishParams
	{
		get
		{
			return finishParams_;
		}
		set
		{
			finishParams_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

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
	public StarTowerBookFateCardQuest()
	{
	}

	[DebuggerNonUserCode]
	public StarTowerBookFateCardQuest(StarTowerBookFateCardQuest other)
		: this()
	{
		id_ = other.id_;
		bundleId_ = other.bundleId_;
		desc_ = other.desc_;
		finishType_ = other.finishType_;
		finishParams_ = other.finishParams_;
		tid1_ = other.tid1_;
		qty1_ = other.qty1_;
		tid2_ = other.tid2_;
		qty2_ = other.qty2_;
		tid3_ = other.tid3_;
		qty3_ = other.qty3_;
		param1_ = other.param1_;
		param2_ = other.param2_;
		param3_ = other.param3_;
		param4_ = other.param4_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StarTowerBookFateCardQuest Clone()
	{
		return new StarTowerBookFateCardQuest(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StarTowerBookFateCardQuest);
	}

	[DebuggerNonUserCode]
	public bool Equals(StarTowerBookFateCardQuest other)
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
		if (BundleId != other.BundleId)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (FinishType != other.FinishType)
		{
			return false;
		}
		if (FinishParams != other.FinishParams)
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
		if (BundleId != 0)
		{
			num ^= BundleId.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (FinishType != 0)
		{
			num ^= FinishType.GetHashCode();
		}
		if (FinishParams.Length != 0)
		{
			num ^= FinishParams.GetHashCode();
		}
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
		if (BundleId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(BundleId);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Desc);
		}
		if (FinishType != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(FinishType);
		}
		if (FinishParams.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(FinishParams);
		}
		if (Tid1 != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Tid1);
		}
		if (Qty1 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Qty1);
		}
		if (Tid2 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Tid2);
		}
		if (Qty2 != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Qty2);
		}
		if (Tid3 != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(Tid3);
		}
		if (Qty3 != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(Qty3);
		}
		if (Param1.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(Param1);
		}
		if (Param2.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(Param2);
		}
		if (Param3.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(Param3);
		}
		if (Param4.Length != 0)
		{
			output.WriteRawTag(122);
			output.WriteString(Param4);
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
		if (BundleId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BundleId);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (FinishType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FinishType);
		}
		if (FinishParams.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(FinishParams);
		}
		if (Tid1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Tid1);
		}
		if (Qty1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Qty1);
		}
		if (Tid2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Tid2);
		}
		if (Qty2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Qty2);
		}
		if (Tid3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Tid3);
		}
		if (Qty3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Qty3);
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
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StarTowerBookFateCardQuest other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.BundleId != 0)
			{
				BundleId = other.BundleId;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.FinishType != 0)
			{
				FinishType = other.FinishType;
			}
			if (other.FinishParams.Length != 0)
			{
				FinishParams = other.FinishParams;
			}
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
				BundleId = input.ReadInt32();
				break;
			case 26u:
				Desc = input.ReadString();
				break;
			case 32u:
				FinishType = input.ReadInt32();
				break;
			case 42u:
				FinishParams = input.ReadString();
				break;
			case 48u:
				Tid1 = input.ReadInt32();
				break;
			case 56u:
				Qty1 = input.ReadInt32();
				break;
			case 64u:
				Tid2 = input.ReadInt32();
				break;
			case 72u:
				Qty2 = input.ReadInt32();
				break;
			case 80u:
				Tid3 = input.ReadInt32();
				break;
			case 88u:
				Qty3 = input.ReadInt32();
				break;
			case 98u:
				Param1 = input.ReadString();
				break;
			case 106u:
				Param2 = input.ReadString();
				break;
			case 114u:
				Param3 = input.ReadString();
				break;
			case 122u:
				Param4 = input.ReadString();
				break;
			}
		}
	}
}
