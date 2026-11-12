using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StarTowerBookFateCard : IMessage<StarTowerBookFateCard>, IMessage, IEquatable<StarTowerBookFateCard>, IDeepCloneable<StarTowerBookFateCard>
{
	private static readonly MessageParser<StarTowerBookFateCard> _parser = new MessageParser<StarTowerBookFateCard>(() => new StarTowerBookFateCard());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int BundleIdFieldNumber = 2;

	private int bundleId_;

	public const int SortIdFieldNumber = 3;

	private int sortId_;

	public const int SourceFieldNumber = 4;

	private string source_ = "";

	public const int UnlockTipFieldNumber = 5;

	private string unlockTip_ = "";

	public const int WorldClassFieldNumber = 6;

	private int worldClass_;

	public const int StarTowerIdFieldNumber = 7;

	private int starTowerId_;

	public const int CollectCardsFieldNumber = 8;

	private static readonly FieldCodec<int> _repeated_collectCards_codec = FieldCodec.ForInt32(66u);

	private readonly RepeatedField<int> collectCards_ = new RepeatedField<int>();

	public const int UnlockCardsFieldNumber = 9;

	private static readonly FieldCodec<int> _repeated_unlockCards_codec = FieldCodec.ForInt32(74u);

	private readonly RepeatedField<int> unlockCards_ = new RepeatedField<int>();

	public const int IsBannedFieldNumber = 10;

	private bool isBanned_;

	[DebuggerNonUserCode]
	public static MessageParser<StarTowerBookFateCard> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(822);

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
	public string Source
	{
		get
		{
			return source_;
		}
		set
		{
			source_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string UnlockTip
	{
		get
		{
			return unlockTip_;
		}
		set
		{
			unlockTip_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int WorldClass
	{
		get
		{
			return worldClass_;
		}
		set
		{
			worldClass_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int StarTowerId
	{
		get
		{
			return starTowerId_;
		}
		set
		{
			starTowerId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> CollectCards => collectCards_;

	[DebuggerNonUserCode]
	public RepeatedField<int> UnlockCards => unlockCards_;

	[DebuggerNonUserCode]
	public bool IsBanned
	{
		get
		{
			return isBanned_;
		}
		set
		{
			isBanned_ = value;
		}
	}

	[DebuggerNonUserCode]
	public StarTowerBookFateCard()
	{
	}

	[DebuggerNonUserCode]
	public StarTowerBookFateCard(StarTowerBookFateCard other)
		: this()
	{
		id_ = other.id_;
		bundleId_ = other.bundleId_;
		sortId_ = other.sortId_;
		source_ = other.source_;
		unlockTip_ = other.unlockTip_;
		worldClass_ = other.worldClass_;
		starTowerId_ = other.starTowerId_;
		collectCards_ = other.collectCards_.Clone();
		unlockCards_ = other.unlockCards_.Clone();
		isBanned_ = other.isBanned_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StarTowerBookFateCard Clone()
	{
		return new StarTowerBookFateCard(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StarTowerBookFateCard);
	}

	[DebuggerNonUserCode]
	public bool Equals(StarTowerBookFateCard other)
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
		if (SortId != other.SortId)
		{
			return false;
		}
		if (Source != other.Source)
		{
			return false;
		}
		if (UnlockTip != other.UnlockTip)
		{
			return false;
		}
		if (WorldClass != other.WorldClass)
		{
			return false;
		}
		if (StarTowerId != other.StarTowerId)
		{
			return false;
		}
		if (!collectCards_.Equals(other.collectCards_))
		{
			return false;
		}
		if (!unlockCards_.Equals(other.unlockCards_))
		{
			return false;
		}
		if (IsBanned != other.IsBanned)
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
		if (SortId != 0)
		{
			num ^= SortId.GetHashCode();
		}
		if (Source.Length != 0)
		{
			num ^= Source.GetHashCode();
		}
		if (UnlockTip.Length != 0)
		{
			num ^= UnlockTip.GetHashCode();
		}
		if (WorldClass != 0)
		{
			num ^= WorldClass.GetHashCode();
		}
		if (StarTowerId != 0)
		{
			num ^= StarTowerId.GetHashCode();
		}
		num ^= collectCards_.GetHashCode();
		num ^= unlockCards_.GetHashCode();
		if (IsBanned)
		{
			num ^= IsBanned.GetHashCode();
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
		if (SortId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(SortId);
		}
		if (Source.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Source);
		}
		if (UnlockTip.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(UnlockTip);
		}
		if (WorldClass != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(WorldClass);
		}
		if (StarTowerId != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(StarTowerId);
		}
		collectCards_.WriteTo(output, _repeated_collectCards_codec);
		unlockCards_.WriteTo(output, _repeated_unlockCards_codec);
		if (IsBanned)
		{
			output.WriteRawTag(80);
			output.WriteBool(IsBanned);
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
		if (SortId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SortId);
		}
		if (Source.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Source);
		}
		if (UnlockTip.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(UnlockTip);
		}
		if (WorldClass != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WorldClass);
		}
		if (StarTowerId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StarTowerId);
		}
		num += collectCards_.CalculateSize(_repeated_collectCards_codec);
		num += unlockCards_.CalculateSize(_repeated_unlockCards_codec);
		if (IsBanned)
		{
			num += 2;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StarTowerBookFateCard other)
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
			if (other.SortId != 0)
			{
				SortId = other.SortId;
			}
			if (other.Source.Length != 0)
			{
				Source = other.Source;
			}
			if (other.UnlockTip.Length != 0)
			{
				UnlockTip = other.UnlockTip;
			}
			if (other.WorldClass != 0)
			{
				WorldClass = other.WorldClass;
			}
			if (other.StarTowerId != 0)
			{
				StarTowerId = other.StarTowerId;
			}
			collectCards_.Add(other.collectCards_);
			unlockCards_.Add(other.unlockCards_);
			if (other.IsBanned)
			{
				IsBanned = other.IsBanned;
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
			case 24u:
				SortId = input.ReadInt32();
				break;
			case 34u:
				Source = input.ReadString();
				break;
			case 42u:
				UnlockTip = input.ReadString();
				break;
			case 48u:
				WorldClass = input.ReadInt32();
				break;
			case 56u:
				StarTowerId = input.ReadInt32();
				break;
			case 64u:
			case 66u:
				collectCards_.AddEntriesFrom(input, _repeated_collectCards_codec);
				break;
			case 72u:
			case 74u:
				unlockCards_.AddEntriesFrom(input, _repeated_unlockCards_codec);
				break;
			case 80u:
				IsBanned = input.ReadBool();
				break;
			}
		}
	}
}
