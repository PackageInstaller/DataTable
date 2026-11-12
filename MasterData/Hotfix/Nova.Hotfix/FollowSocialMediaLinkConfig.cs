using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class FollowSocialMediaLinkConfig : IMessage<FollowSocialMediaLinkConfig>, IMessage, IEquatable<FollowSocialMediaLinkConfig>, IDeepCloneable<FollowSocialMediaLinkConfig>
{
	private static readonly MessageParser<FollowSocialMediaLinkConfig> _parser = new MessageParser<FollowSocialMediaLinkConfig>(() => new FollowSocialMediaLinkConfig());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int IconFieldNumber = 2;

	private string icon_ = "";

	public const int NameFieldNumber = 3;

	private string name_ = "";

	public const int URLFieldNumber = 4;

	private string uRL_ = "";

	public const int DeepLinkFieldNumber = 5;

	private string deepLink_ = "";

	public const int RewardIdFieldNumber = 6;

	private int rewardId_;

	public const int RewardCountFieldNumber = 7;

	private int rewardCount_;

	[DebuggerNonUserCode]
	public static MessageParser<FollowSocialMediaLinkConfig> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(356);

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
	public string URL
	{
		get
		{
			return uRL_;
		}
		set
		{
			uRL_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string DeepLink
	{
		get
		{
			return deepLink_;
		}
		set
		{
			deepLink_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int RewardId
	{
		get
		{
			return rewardId_;
		}
		set
		{
			rewardId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RewardCount
	{
		get
		{
			return rewardCount_;
		}
		set
		{
			rewardCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	public FollowSocialMediaLinkConfig()
	{
	}

	[DebuggerNonUserCode]
	public FollowSocialMediaLinkConfig(FollowSocialMediaLinkConfig other)
		: this()
	{
		id_ = other.id_;
		icon_ = other.icon_;
		name_ = other.name_;
		uRL_ = other.uRL_;
		deepLink_ = other.deepLink_;
		rewardId_ = other.rewardId_;
		rewardCount_ = other.rewardCount_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public FollowSocialMediaLinkConfig Clone()
	{
		return new FollowSocialMediaLinkConfig(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as FollowSocialMediaLinkConfig);
	}

	[DebuggerNonUserCode]
	public bool Equals(FollowSocialMediaLinkConfig other)
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
		if (Icon != other.Icon)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (URL != other.URL)
		{
			return false;
		}
		if (DeepLink != other.DeepLink)
		{
			return false;
		}
		if (RewardId != other.RewardId)
		{
			return false;
		}
		if (RewardCount != other.RewardCount)
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
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (URL.Length != 0)
		{
			num ^= URL.GetHashCode();
		}
		if (DeepLink.Length != 0)
		{
			num ^= DeepLink.GetHashCode();
		}
		if (RewardId != 0)
		{
			num ^= RewardId.GetHashCode();
		}
		if (RewardCount != 0)
		{
			num ^= RewardCount.GetHashCode();
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
		if (Icon.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Icon);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Name);
		}
		if (URL.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(URL);
		}
		if (DeepLink.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(DeepLink);
		}
		if (RewardId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(RewardId);
		}
		if (RewardCount != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(RewardCount);
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
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (URL.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(URL);
		}
		if (DeepLink.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DeepLink);
		}
		if (RewardId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardId);
		}
		if (RewardCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardCount);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(FollowSocialMediaLinkConfig other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.URL.Length != 0)
			{
				URL = other.URL;
			}
			if (other.DeepLink.Length != 0)
			{
				DeepLink = other.DeepLink;
			}
			if (other.RewardId != 0)
			{
				RewardId = other.RewardId;
			}
			if (other.RewardCount != 0)
			{
				RewardCount = other.RewardCount;
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
				Icon = input.ReadString();
				break;
			case 26u:
				Name = input.ReadString();
				break;
			case 34u:
				URL = input.ReadString();
				break;
			case 42u:
				DeepLink = input.ReadString();
				break;
			case 48u:
				RewardId = input.ReadInt32();
				break;
			case 56u:
				RewardCount = input.ReadInt32();
				break;
			}
		}
	}
}
