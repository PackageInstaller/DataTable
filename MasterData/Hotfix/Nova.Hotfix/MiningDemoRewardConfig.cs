using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class MiningDemoRewardConfig : IMessage<MiningDemoRewardConfig>, IMessage, IEquatable<MiningDemoRewardConfig>, IDeepCloneable<MiningDemoRewardConfig>
{
	private static readonly MessageParser<MiningDemoRewardConfig> _parser = new MessageParser<MiningDemoRewardConfig>(() => new MiningDemoRewardConfig());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int RewardTypeFieldNumber = 2;

	private int rewardType_;

	public const int ImageNameFieldNumber = 3;

	private string imageName_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<MiningDemoRewardConfig> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(554);

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
	public int RewardType
	{
		get
		{
			return rewardType_;
		}
		set
		{
			rewardType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string ImageName
	{
		get
		{
			return imageName_;
		}
		set
		{
			imageName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public MiningDemoRewardConfig()
	{
	}

	[DebuggerNonUserCode]
	public MiningDemoRewardConfig(MiningDemoRewardConfig other)
		: this()
	{
		id_ = other.id_;
		rewardType_ = other.rewardType_;
		imageName_ = other.imageName_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public MiningDemoRewardConfig Clone()
	{
		return new MiningDemoRewardConfig(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MiningDemoRewardConfig);
	}

	[DebuggerNonUserCode]
	public bool Equals(MiningDemoRewardConfig other)
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
		if (RewardType != other.RewardType)
		{
			return false;
		}
		if (ImageName != other.ImageName)
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
		if (RewardType != 0)
		{
			num ^= RewardType.GetHashCode();
		}
		if (ImageName.Length != 0)
		{
			num ^= ImageName.GetHashCode();
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
		if (RewardType != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(RewardType);
		}
		if (ImageName.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(ImageName);
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
		if (RewardType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardType);
		}
		if (ImageName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ImageName);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MiningDemoRewardConfig other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.RewardType != 0)
			{
				RewardType = other.RewardType;
			}
			if (other.ImageName.Length != 0)
			{
				ImageName = other.ImageName;
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
				RewardType = input.ReadInt32();
				break;
			case 26u:
				ImageName = input.ReadString();
				break;
			}
		}
	}
}
