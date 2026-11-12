using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class WeekBossType : IMessage<WeekBossType>, IMessage, IEquatable<WeekBossType>, IDeepCloneable<WeekBossType>
{
	private static readonly MessageParser<WeekBossType> _parser = new MessageParser<WeekBossType>(() => new WeekBossType());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int IconFieldNumber = 3;

	private string icon_ = "";

	public const int SortFieldNumber = 4;

	private int sort_;

	public const int EETFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_eET_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> eET_ = new RepeatedField<int>();

	public const int AntiEETFieldNumber = 6;

	private static readonly FieldCodec<int> _repeated_antiEET_codec = FieldCodec.ForInt32(50u);

	private readonly RepeatedField<int> antiEET_ = new RepeatedField<int>();

	public const int EpisodeFieldNumber = 7;

	private string episode_ = "";

	public const int BossBgFieldNumber = 8;

	private string bossBg_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<WeekBossType> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1080);

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
	public int Sort
	{
		get
		{
			return sort_;
		}
		set
		{
			sort_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> EET => eET_;

	[DebuggerNonUserCode]
	public RepeatedField<int> AntiEET => antiEET_;

	[DebuggerNonUserCode]
	public string Episode
	{
		get
		{
			return episode_;
		}
		set
		{
			episode_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string BossBg
	{
		get
		{
			return bossBg_;
		}
		set
		{
			bossBg_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public WeekBossType()
	{
	}

	[DebuggerNonUserCode]
	public WeekBossType(WeekBossType other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		icon_ = other.icon_;
		sort_ = other.sort_;
		eET_ = other.eET_.Clone();
		antiEET_ = other.antiEET_.Clone();
		episode_ = other.episode_;
		bossBg_ = other.bossBg_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public WeekBossType Clone()
	{
		return new WeekBossType(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as WeekBossType);
	}

	[DebuggerNonUserCode]
	public bool Equals(WeekBossType other)
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
		if (Icon != other.Icon)
		{
			return false;
		}
		if (Sort != other.Sort)
		{
			return false;
		}
		if (!eET_.Equals(other.eET_))
		{
			return false;
		}
		if (!antiEET_.Equals(other.antiEET_))
		{
			return false;
		}
		if (Episode != other.Episode)
		{
			return false;
		}
		if (BossBg != other.BossBg)
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
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (Sort != 0)
		{
			num ^= Sort.GetHashCode();
		}
		num ^= eET_.GetHashCode();
		num ^= antiEET_.GetHashCode();
		if (Episode.Length != 0)
		{
			num ^= Episode.GetHashCode();
		}
		if (BossBg.Length != 0)
		{
			num ^= BossBg.GetHashCode();
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
		if (Icon.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Icon);
		}
		if (Sort != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Sort);
		}
		eET_.WriteTo(output, _repeated_eET_codec);
		antiEET_.WriteTo(output, _repeated_antiEET_codec);
		if (Episode.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Episode);
		}
		if (BossBg.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(BossBg);
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
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (Sort != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Sort);
		}
		num += eET_.CalculateSize(_repeated_eET_codec);
		num += antiEET_.CalculateSize(_repeated_antiEET_codec);
		if (Episode.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Episode);
		}
		if (BossBg.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BossBg);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(WeekBossType other)
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
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.Sort != 0)
			{
				Sort = other.Sort;
			}
			eET_.Add(other.eET_);
			antiEET_.Add(other.antiEET_);
			if (other.Episode.Length != 0)
			{
				Episode = other.Episode;
			}
			if (other.BossBg.Length != 0)
			{
				BossBg = other.BossBg;
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
				Icon = input.ReadString();
				break;
			case 32u:
				Sort = input.ReadInt32();
				break;
			case 40u:
			case 42u:
				eET_.AddEntriesFrom(input, _repeated_eET_codec);
				break;
			case 48u:
			case 50u:
				antiEET_.AddEntriesFrom(input, _repeated_antiEET_codec);
				break;
			case 58u:
				Episode = input.ReadString();
				break;
			case 66u:
				BossBg = input.ReadString();
				break;
			}
		}
	}
}
