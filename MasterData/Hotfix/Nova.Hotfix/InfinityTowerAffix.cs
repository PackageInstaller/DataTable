using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class InfinityTowerAffix : IMessage<InfinityTowerAffix>, IMessage, IEquatable<InfinityTowerAffix>, IDeepCloneable<InfinityTowerAffix>
{
	private static readonly MessageParser<InfinityTowerAffix> _parser = new MessageParser<InfinityTowerAffix>(() => new InfinityTowerAffix());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int DescFieldNumber = 3;

	private string desc_ = "";

	public const int AddCampFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_addCamp_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> addCamp_ = new RepeatedField<int>();

	public const int TriggerConditionFieldNumber = 5;

	private int triggerCondition_;

	public const int TriggerParamFieldNumber = 6;

	private string triggerParam_ = "";

	public const int Param1FieldNumber = 7;

	private string param1_ = "";

	public const int Param2FieldNumber = 8;

	private string param2_ = "";

	public const int Param3FieldNumber = 9;

	private string param3_ = "";

	public const int Param4FieldNumber = 10;

	private string param4_ = "";

	public const int Param5FieldNumber = 11;

	private string param5_ = "";

	public const int Param6FieldNumber = 12;

	private string param6_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<InfinityTowerAffix> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(446);

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
	public RepeatedField<int> AddCamp => addCamp_;

	[DebuggerNonUserCode]
	public int TriggerCondition
	{
		get
		{
			return triggerCondition_;
		}
		set
		{
			triggerCondition_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string TriggerParam
	{
		get
		{
			return triggerParam_;
		}
		set
		{
			triggerParam_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public InfinityTowerAffix()
	{
	}

	[DebuggerNonUserCode]
	public InfinityTowerAffix(InfinityTowerAffix other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		desc_ = other.desc_;
		addCamp_ = other.addCamp_.Clone();
		triggerCondition_ = other.triggerCondition_;
		triggerParam_ = other.triggerParam_;
		param1_ = other.param1_;
		param2_ = other.param2_;
		param3_ = other.param3_;
		param4_ = other.param4_;
		param5_ = other.param5_;
		param6_ = other.param6_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public InfinityTowerAffix Clone()
	{
		return new InfinityTowerAffix(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as InfinityTowerAffix);
	}

	[DebuggerNonUserCode]
	public bool Equals(InfinityTowerAffix other)
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
		if (Desc != other.Desc)
		{
			return false;
		}
		if (!addCamp_.Equals(other.addCamp_))
		{
			return false;
		}
		if (TriggerCondition != other.TriggerCondition)
		{
			return false;
		}
		if (TriggerParam != other.TriggerParam)
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
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		num ^= addCamp_.GetHashCode();
		if (TriggerCondition != 0)
		{
			num ^= TriggerCondition.GetHashCode();
		}
		if (TriggerParam.Length != 0)
		{
			num ^= TriggerParam.GetHashCode();
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
		if (Name.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Name);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Desc);
		}
		addCamp_.WriteTo(output, _repeated_addCamp_codec);
		if (TriggerCondition != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(TriggerCondition);
		}
		if (TriggerParam.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(TriggerParam);
		}
		if (Param1.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Param1);
		}
		if (Param2.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(Param2);
		}
		if (Param3.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(Param3);
		}
		if (Param4.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(Param4);
		}
		if (Param5.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(Param5);
		}
		if (Param6.Length != 0)
		{
			output.WriteRawTag(98);
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
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		num += addCamp_.CalculateSize(_repeated_addCamp_codec);
		if (TriggerCondition != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TriggerCondition);
		}
		if (TriggerParam.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(TriggerParam);
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
	public void MergeFrom(InfinityTowerAffix other)
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
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			addCamp_.Add(other.addCamp_);
			if (other.TriggerCondition != 0)
			{
				TriggerCondition = other.TriggerCondition;
			}
			if (other.TriggerParam.Length != 0)
			{
				TriggerParam = other.TriggerParam;
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
				Name = input.ReadString();
				break;
			case 26u:
				Desc = input.ReadString();
				break;
			case 32u:
			case 34u:
				addCamp_.AddEntriesFrom(input, _repeated_addCamp_codec);
				break;
			case 40u:
				TriggerCondition = input.ReadInt32();
				break;
			case 50u:
				TriggerParam = input.ReadString();
				break;
			case 58u:
				Param1 = input.ReadString();
				break;
			case 66u:
				Param2 = input.ReadString();
				break;
			case 74u:
				Param3 = input.ReadString();
				break;
			case 82u:
				Param4 = input.ReadString();
				break;
			case 90u:
				Param5 = input.ReadString();
				break;
			case 98u:
				Param6 = input.ReadString();
				break;
			}
		}
	}
}
