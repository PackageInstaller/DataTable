using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class LevelQuestTarget : IMessage<LevelQuestTarget>, IMessage, IEquatable<LevelQuestTarget>, IDeepCloneable<LevelQuestTarget>
{
	private static readonly MessageParser<LevelQuestTarget> _parser = new MessageParser<LevelQuestTarget>(() => new LevelQuestTarget());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int QuestTypeFieldNumber = 2;

	private int questType_;

	public const int QuestDesFieldNumber = 3;

	private string questDes_ = "";

	public const int Param1FieldNumber = 4;

	private string param1_ = "";

	public const int Param2FieldNumber = 5;

	private string param2_ = "";

	public const int Param3FieldNumber = 6;

	private string param3_ = "";

	public const int Param4FieldNumber = 7;

	private string param4_ = "";

	public const int Param5FieldNumber = 8;

	private static readonly FieldCodec<string> _repeated_param5_codec = FieldCodec.ForString(66u);

	private readonly RepeatedField<string> param5_ = new RepeatedField<string>();

	[DebuggerNonUserCode]
	public static MessageParser<LevelQuestTarget> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(496);

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
	public int QuestType
	{
		get
		{
			return questType_;
		}
		set
		{
			questType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string QuestDes
	{
		get
		{
			return questDes_;
		}
		set
		{
			questDes_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public RepeatedField<string> Param5 => param5_;

	[DebuggerNonUserCode]
	public LevelQuestTarget()
	{
	}

	[DebuggerNonUserCode]
	public LevelQuestTarget(LevelQuestTarget other)
		: this()
	{
		id_ = other.id_;
		questType_ = other.questType_;
		questDes_ = other.questDes_;
		param1_ = other.param1_;
		param2_ = other.param2_;
		param3_ = other.param3_;
		param4_ = other.param4_;
		param5_ = other.param5_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public LevelQuestTarget Clone()
	{
		return new LevelQuestTarget(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as LevelQuestTarget);
	}

	[DebuggerNonUserCode]
	public bool Equals(LevelQuestTarget other)
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
		if (QuestType != other.QuestType)
		{
			return false;
		}
		if (QuestDes != other.QuestDes)
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
		if (!param5_.Equals(other.param5_))
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
		if (QuestType != 0)
		{
			num ^= QuestType.GetHashCode();
		}
		if (QuestDes.Length != 0)
		{
			num ^= QuestDes.GetHashCode();
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
		num ^= param5_.GetHashCode();
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
		if (QuestType != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(QuestType);
		}
		if (QuestDes.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(QuestDes);
		}
		if (Param1.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Param1);
		}
		if (Param2.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Param2);
		}
		if (Param3.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Param3);
		}
		if (Param4.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Param4);
		}
		param5_.WriteTo(output, _repeated_param5_codec);
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
		if (QuestType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(QuestType);
		}
		if (QuestDes.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(QuestDes);
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
		num += param5_.CalculateSize(_repeated_param5_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(LevelQuestTarget other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.QuestType != 0)
			{
				QuestType = other.QuestType;
			}
			if (other.QuestDes.Length != 0)
			{
				QuestDes = other.QuestDes;
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
			param5_.Add(other.param5_);
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
				QuestType = input.ReadInt32();
				break;
			case 26u:
				QuestDes = input.ReadString();
				break;
			case 34u:
				Param1 = input.ReadString();
				break;
			case 42u:
				Param2 = input.ReadString();
				break;
			case 50u:
				Param3 = input.ReadString();
				break;
			case 58u:
				Param4 = input.ReadString();
				break;
			case 66u:
				param5_.AddEntriesFrom(input, _repeated_param5_codec);
				break;
			}
		}
	}
}
