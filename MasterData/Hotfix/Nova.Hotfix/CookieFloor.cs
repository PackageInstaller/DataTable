using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class CookieFloor : IMessage<CookieFloor>, IMessage, IEquatable<CookieFloor>, IDeepCloneable<CookieFloor>
{
	private static readonly MessageParser<CookieFloor> _parser = new MessageParser<CookieFloor>(() => new CookieFloor());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int FloorIdFieldNumber = 2;

	private int floorId_;

	public const int PackageNumFieldNumber = 3;

	private int packageNum_;

	public const int SizeFieldNumber = 4;

	private int size_;

	public const int PackagePathsGroupIdFieldNumber = 5;

	private int packagePathsGroupId_;

	public const int RhythmlTimeFieldNumber = 6;

	private int rhythmlTime_;

	public const int PreRangeFieldNumber = 7;

	private int preRange_;

	public const int PostRangeFieldNumber = 8;

	private int postRange_;

	public const int CookieTypeNumFieldNumber = 9;

	private static readonly FieldCodec<int> _repeated_cookieTypeNum_codec = FieldCodec.ForInt32(74u);

	private readonly RepeatedField<int> cookieTypeNum_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<CookieFloor> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(218);

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
	public int PackageNum
	{
		get
		{
			return packageNum_;
		}
		set
		{
			packageNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Size
	{
		get
		{
			return size_;
		}
		set
		{
			size_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PackagePathsGroupId
	{
		get
		{
			return packagePathsGroupId_;
		}
		set
		{
			packagePathsGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RhythmlTime
	{
		get
		{
			return rhythmlTime_;
		}
		set
		{
			rhythmlTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PreRange
	{
		get
		{
			return preRange_;
		}
		set
		{
			preRange_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PostRange
	{
		get
		{
			return postRange_;
		}
		set
		{
			postRange_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> CookieTypeNum => cookieTypeNum_;

	[DebuggerNonUserCode]
	public CookieFloor()
	{
	}

	[DebuggerNonUserCode]
	public CookieFloor(CookieFloor other)
		: this()
	{
		id_ = other.id_;
		floorId_ = other.floorId_;
		packageNum_ = other.packageNum_;
		size_ = other.size_;
		packagePathsGroupId_ = other.packagePathsGroupId_;
		rhythmlTime_ = other.rhythmlTime_;
		preRange_ = other.preRange_;
		postRange_ = other.postRange_;
		cookieTypeNum_ = other.cookieTypeNum_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public CookieFloor Clone()
	{
		return new CookieFloor(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CookieFloor);
	}

	[DebuggerNonUserCode]
	public bool Equals(CookieFloor other)
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
		if (FloorId != other.FloorId)
		{
			return false;
		}
		if (PackageNum != other.PackageNum)
		{
			return false;
		}
		if (Size != other.Size)
		{
			return false;
		}
		if (PackagePathsGroupId != other.PackagePathsGroupId)
		{
			return false;
		}
		if (RhythmlTime != other.RhythmlTime)
		{
			return false;
		}
		if (PreRange != other.PreRange)
		{
			return false;
		}
		if (PostRange != other.PostRange)
		{
			return false;
		}
		if (!cookieTypeNum_.Equals(other.cookieTypeNum_))
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
		if (FloorId != 0)
		{
			num ^= FloorId.GetHashCode();
		}
		if (PackageNum != 0)
		{
			num ^= PackageNum.GetHashCode();
		}
		if (Size != 0)
		{
			num ^= Size.GetHashCode();
		}
		if (PackagePathsGroupId != 0)
		{
			num ^= PackagePathsGroupId.GetHashCode();
		}
		if (RhythmlTime != 0)
		{
			num ^= RhythmlTime.GetHashCode();
		}
		if (PreRange != 0)
		{
			num ^= PreRange.GetHashCode();
		}
		if (PostRange != 0)
		{
			num ^= PostRange.GetHashCode();
		}
		num ^= cookieTypeNum_.GetHashCode();
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
		if (FloorId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(FloorId);
		}
		if (PackageNum != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(PackageNum);
		}
		if (Size != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Size);
		}
		if (PackagePathsGroupId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(PackagePathsGroupId);
		}
		if (RhythmlTime != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(RhythmlTime);
		}
		if (PreRange != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(PreRange);
		}
		if (PostRange != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(PostRange);
		}
		cookieTypeNum_.WriteTo(output, _repeated_cookieTypeNum_codec);
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
		if (FloorId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FloorId);
		}
		if (PackageNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PackageNum);
		}
		if (Size != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Size);
		}
		if (PackagePathsGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PackagePathsGroupId);
		}
		if (RhythmlTime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RhythmlTime);
		}
		if (PreRange != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreRange);
		}
		if (PostRange != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PostRange);
		}
		num += cookieTypeNum_.CalculateSize(_repeated_cookieTypeNum_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CookieFloor other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.FloorId != 0)
			{
				FloorId = other.FloorId;
			}
			if (other.PackageNum != 0)
			{
				PackageNum = other.PackageNum;
			}
			if (other.Size != 0)
			{
				Size = other.Size;
			}
			if (other.PackagePathsGroupId != 0)
			{
				PackagePathsGroupId = other.PackagePathsGroupId;
			}
			if (other.RhythmlTime != 0)
			{
				RhythmlTime = other.RhythmlTime;
			}
			if (other.PreRange != 0)
			{
				PreRange = other.PreRange;
			}
			if (other.PostRange != 0)
			{
				PostRange = other.PostRange;
			}
			cookieTypeNum_.Add(other.cookieTypeNum_);
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
				FloorId = input.ReadInt32();
				break;
			case 24u:
				PackageNum = input.ReadInt32();
				break;
			case 32u:
				Size = input.ReadInt32();
				break;
			case 40u:
				PackagePathsGroupId = input.ReadInt32();
				break;
			case 48u:
				RhythmlTime = input.ReadInt32();
				break;
			case 56u:
				PreRange = input.ReadInt32();
				break;
			case 64u:
				PostRange = input.ReadInt32();
				break;
			case 72u:
			case 74u:
				cookieTypeNum_.AddEntriesFrom(input, _repeated_cookieTypeNum_codec);
				break;
			}
		}
	}
}
