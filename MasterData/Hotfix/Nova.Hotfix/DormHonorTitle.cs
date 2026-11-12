using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DormHonorTitle : IMessage<DormHonorTitle>, IMessage, IEquatable<DormHonorTitle>, IDeepCloneable<DormHonorTitle>
{
	private static readonly MessageParser<DormHonorTitle> _parser = new MessageParser<DormHonorTitle>(() => new DormHonorTitle());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NeedExpFieldNumber = 2;

	private int needExp_;

	public const int BigBgPathFieldNumber = 3;

	private string bigBgPath_ = "";

	public const int SmallBgPathFieldNumber = 4;

	private string smallBgPath_ = "";

	public const int StarGroupFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_starGroup_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> starGroup_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<DormHonorTitle> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(292);

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
	public int NeedExp
	{
		get
		{
			return needExp_;
		}
		set
		{
			needExp_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string BigBgPath
	{
		get
		{
			return bigBgPath_;
		}
		set
		{
			bigBgPath_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string SmallBgPath
	{
		get
		{
			return smallBgPath_;
		}
		set
		{
			smallBgPath_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> StarGroup => starGroup_;

	[DebuggerNonUserCode]
	public DormHonorTitle()
	{
	}

	[DebuggerNonUserCode]
	public DormHonorTitle(DormHonorTitle other)
		: this()
	{
		id_ = other.id_;
		needExp_ = other.needExp_;
		bigBgPath_ = other.bigBgPath_;
		smallBgPath_ = other.smallBgPath_;
		starGroup_ = other.starGroup_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DormHonorTitle Clone()
	{
		return new DormHonorTitle(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DormHonorTitle);
	}

	[DebuggerNonUserCode]
	public bool Equals(DormHonorTitle other)
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
		if (NeedExp != other.NeedExp)
		{
			return false;
		}
		if (BigBgPath != other.BigBgPath)
		{
			return false;
		}
		if (SmallBgPath != other.SmallBgPath)
		{
			return false;
		}
		if (!starGroup_.Equals(other.starGroup_))
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
		if (NeedExp != 0)
		{
			num ^= NeedExp.GetHashCode();
		}
		if (BigBgPath.Length != 0)
		{
			num ^= BigBgPath.GetHashCode();
		}
		if (SmallBgPath.Length != 0)
		{
			num ^= SmallBgPath.GetHashCode();
		}
		num ^= starGroup_.GetHashCode();
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
		if (NeedExp != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(NeedExp);
		}
		if (BigBgPath.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(BigBgPath);
		}
		if (SmallBgPath.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(SmallBgPath);
		}
		starGroup_.WriteTo(output, _repeated_starGroup_codec);
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
		if (NeedExp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NeedExp);
		}
		if (BigBgPath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BigBgPath);
		}
		if (SmallBgPath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SmallBgPath);
		}
		num += starGroup_.CalculateSize(_repeated_starGroup_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(DormHonorTitle other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.NeedExp != 0)
			{
				NeedExp = other.NeedExp;
			}
			if (other.BigBgPath.Length != 0)
			{
				BigBgPath = other.BigBgPath;
			}
			if (other.SmallBgPath.Length != 0)
			{
				SmallBgPath = other.SmallBgPath;
			}
			starGroup_.Add(other.starGroup_);
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
				NeedExp = input.ReadInt32();
				break;
			case 26u:
				BigBgPath = input.ReadString();
				break;
			case 34u:
				SmallBgPath = input.ReadString();
				break;
			case 40u:
			case 42u:
				starGroup_.AddEntriesFrom(input, _repeated_starGroup_codec);
				break;
			}
		}
	}
}
