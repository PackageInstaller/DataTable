using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TraceHuntBoss : IMessage<TraceHuntBoss>, IMessage, IEquatable<TraceHuntBoss>, IDeepCloneable<TraceHuntBoss>
{
	private static readonly MessageParser<TraceHuntBoss> _parser = new MessageParser<TraceHuntBoss>(() => new TraceHuntBoss());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int MonsterIdFieldNumber = 2;

	private int monsterId_;

	public const int IsSpecialFieldNumber = 3;

	private bool isSpecial_;

	public const int FloorGroupFieldNumber = 4;

	private int floorGroup_;

	public const int ClueIconFieldNumber = 5;

	private string clueIcon_ = "";

	public const int TargetIconFieldNumber = 6;

	private string targetIcon_ = "";

	public const int ProfileIconFieldNumber = 7;

	private string profileIcon_ = "";

	public const int HeadIconFieldNumber = 8;

	private string headIcon_ = "";

	public const int ImageFieldNumber = 9;

	private string image_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<TraceHuntBoss> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(978);

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
	public int MonsterId
	{
		get
		{
			return monsterId_;
		}
		set
		{
			monsterId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsSpecial
	{
		get
		{
			return isSpecial_;
		}
		set
		{
			isSpecial_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FloorGroup
	{
		get
		{
			return floorGroup_;
		}
		set
		{
			floorGroup_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string ClueIcon
	{
		get
		{
			return clueIcon_;
		}
		set
		{
			clueIcon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string TargetIcon
	{
		get
		{
			return targetIcon_;
		}
		set
		{
			targetIcon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string ProfileIcon
	{
		get
		{
			return profileIcon_;
		}
		set
		{
			profileIcon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string HeadIcon
	{
		get
		{
			return headIcon_;
		}
		set
		{
			headIcon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Image
	{
		get
		{
			return image_;
		}
		set
		{
			image_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public TraceHuntBoss()
	{
	}

	[DebuggerNonUserCode]
	public TraceHuntBoss(TraceHuntBoss other)
		: this()
	{
		id_ = other.id_;
		monsterId_ = other.monsterId_;
		isSpecial_ = other.isSpecial_;
		floorGroup_ = other.floorGroup_;
		clueIcon_ = other.clueIcon_;
		targetIcon_ = other.targetIcon_;
		profileIcon_ = other.profileIcon_;
		headIcon_ = other.headIcon_;
		image_ = other.image_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TraceHuntBoss Clone()
	{
		return new TraceHuntBoss(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TraceHuntBoss);
	}

	[DebuggerNonUserCode]
	public bool Equals(TraceHuntBoss other)
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
		if (MonsterId != other.MonsterId)
		{
			return false;
		}
		if (IsSpecial != other.IsSpecial)
		{
			return false;
		}
		if (FloorGroup != other.FloorGroup)
		{
			return false;
		}
		if (ClueIcon != other.ClueIcon)
		{
			return false;
		}
		if (TargetIcon != other.TargetIcon)
		{
			return false;
		}
		if (ProfileIcon != other.ProfileIcon)
		{
			return false;
		}
		if (HeadIcon != other.HeadIcon)
		{
			return false;
		}
		if (Image != other.Image)
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
		if (MonsterId != 0)
		{
			num ^= MonsterId.GetHashCode();
		}
		if (IsSpecial)
		{
			num ^= IsSpecial.GetHashCode();
		}
		if (FloorGroup != 0)
		{
			num ^= FloorGroup.GetHashCode();
		}
		if (ClueIcon.Length != 0)
		{
			num ^= ClueIcon.GetHashCode();
		}
		if (TargetIcon.Length != 0)
		{
			num ^= TargetIcon.GetHashCode();
		}
		if (ProfileIcon.Length != 0)
		{
			num ^= ProfileIcon.GetHashCode();
		}
		if (HeadIcon.Length != 0)
		{
			num ^= HeadIcon.GetHashCode();
		}
		if (Image.Length != 0)
		{
			num ^= Image.GetHashCode();
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
		if (MonsterId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(MonsterId);
		}
		if (IsSpecial)
		{
			output.WriteRawTag(24);
			output.WriteBool(IsSpecial);
		}
		if (FloorGroup != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(FloorGroup);
		}
		if (ClueIcon.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(ClueIcon);
		}
		if (TargetIcon.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(TargetIcon);
		}
		if (ProfileIcon.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(ProfileIcon);
		}
		if (HeadIcon.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(HeadIcon);
		}
		if (Image.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(Image);
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
		if (MonsterId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MonsterId);
		}
		if (IsSpecial)
		{
			num += 2;
		}
		if (FloorGroup != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FloorGroup);
		}
		if (ClueIcon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ClueIcon);
		}
		if (TargetIcon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(TargetIcon);
		}
		if (ProfileIcon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ProfileIcon);
		}
		if (HeadIcon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(HeadIcon);
		}
		if (Image.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Image);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TraceHuntBoss other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.MonsterId != 0)
			{
				MonsterId = other.MonsterId;
			}
			if (other.IsSpecial)
			{
				IsSpecial = other.IsSpecial;
			}
			if (other.FloorGroup != 0)
			{
				FloorGroup = other.FloorGroup;
			}
			if (other.ClueIcon.Length != 0)
			{
				ClueIcon = other.ClueIcon;
			}
			if (other.TargetIcon.Length != 0)
			{
				TargetIcon = other.TargetIcon;
			}
			if (other.ProfileIcon.Length != 0)
			{
				ProfileIcon = other.ProfileIcon;
			}
			if (other.HeadIcon.Length != 0)
			{
				HeadIcon = other.HeadIcon;
			}
			if (other.Image.Length != 0)
			{
				Image = other.Image;
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
				MonsterId = input.ReadInt32();
				break;
			case 24u:
				IsSpecial = input.ReadBool();
				break;
			case 32u:
				FloorGroup = input.ReadInt32();
				break;
			case 42u:
				ClueIcon = input.ReadString();
				break;
			case 50u:
				TargetIcon = input.ReadString();
				break;
			case 58u:
				ProfileIcon = input.ReadString();
				break;
			case 66u:
				HeadIcon = input.ReadString();
				break;
			case 74u:
				Image = input.ReadString();
				break;
			}
		}
	}
}
